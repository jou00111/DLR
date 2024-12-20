require 'base64'
require 'json'
require 'net/https'

module Vision
  class << self
    def get_image_data(image_files)
      
      return [] if image_files.blank?  # 画像が添付されていない場合は空の配列を返す

      image_files.map do |image_file|
        # APIのURL作成
        api_url = "https://vision.googleapis.com/v1/images:annotate?key=#{ENV['GOOGLE_API_KEY']}"

        # 画像をbase64にエンコード
        base64_image = Base64.encode64(image_file.tempfile.read)

        # APIリクエスト用のJSONパラメータ
        params = {
          requests: [{
            image: {
              content: base64_image
            },
            features: [
              {
                type: 'LABEL_DETECTION'
              }
            ]
          }]
        }.to_json

        # Google Cloud Vision APIにリクエスト
        uri = URI.parse(api_url)
        https = Net::HTTP.new(uri.host, uri.port)
        https.use_ssl = true
        request = Net::HTTP::Post.new(uri.request_uri)
        request['Content-Type'] = 'application/json'
        response = https.request(request, params)
        response_body = JSON.parse(response.body)

        # レスポンス内容をログに出力
        Rails.logger.debug "Vision API Response: #{response_body}"

        # APIレスポンスがnilまたは空でないか確認
        if response_body['responses'].nil? || response_body['responses'].empty?
          raise 'No response data from Vision API.'
        elsif response_body['responses'].first['error'].present?
          raise response_body['responses'].first['error']['message']
        else
          response_body['responses'].first['labelAnnotations'].pluck('description').take(3)
        end
      end
    end
  end
end
