document.addEventListener("turbolinks:load", () => {
  // 詳細画面とフォーム画面で分けるためのセレクター
  const commentElem = document.querySelector("#comment_raty");
  const postElem = document.querySelector("#post_raty");
  const averageElem = document.querySelector("#average-rating");

  // 詳細画面の場合
  if (commentElem && commentElem.hasAttribute("data-score")) {
    const score = commentElem.getAttribute("data-score");
    const starOn = commentElem.getAttribute("data-star-on");
    const starOff = commentElem.getAttribute("data-star-off");
    const starHalf = commentElem.getAttribute("data-star-half");

    $(commentElem).raty({
      readOnly: true,  // 評価の編集を禁止
      starOn: starOn,  // 星のオン画像
      starOff: starOff,  // 星のオフ画像
      starHalf: starHalf,  // 半星の画像
      score: score,  // コメントの評価スコアを設定
    });
  }

  // 平均評価が存在する場合（詳細画面の平均星評価）
  if (averageElem) {
    const averageScore = parseFloat(averageElem.getAttribute("data-average"));
    const starOn = averageElem.getAttribute("data-star-on");
    const starOff = averageElem.getAttribute("data-star-off");
    const starHalf = averageElem.getAttribute("data-star-half");

    $(averageElem).raty({
      readOnly: true,  // 評価の編集を禁止
      starOn: starOn,  // 星のオン画像
      starOff: starOff,  // 星のオフ画像
      starHalf: starHalf,  // 半星の画像
      score: averageScore,  // 平均評価スコアを設定
    });
  }

  // フォーム画面の場合
  if (postElem) {
    const starOn = postElem.getAttribute("data-star-on");
    const starOff = postElem.getAttribute("data-star-off");
    const starHalf = postElem.getAttribute("data-star-half");

    $(postElem).raty({
      starOn: starOn,  // asset_pathで設定したパス
      starOff: starOff,
      starHalf: starHalf,
      scoreName: "post_comment[star]",  // フォームのフィールド名
    });
  }
});
