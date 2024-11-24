document.addEventListener("turbolinks:load", () => {
  // 詳細画面とフォーム画面で分けるためのセレクター
  const commentElem = document.querySelector("#comment_raty");
  const postElem = document.querySelector("#post_raty");
  const averageElem = document.querySelector("#average-rating");

  // 詳細画面の場合
  if (commentElem && commentElem.hasAttribute("data-score")) {
    const score = commentElem.getAttribute("data-score");

    $(commentElem).raty({
      readOnly: true,  // 評価の編集を禁止
      starOn: "/assets/star-on.png",  // 星のオン画像
      starOff: "/assets/star-off.png",  // 星のオフ画像
      starHalf: "/assets/star-half.png",  // 半星の画像
      score: score,  // コメントの評価スコアを設定
    });
  }

  // 平均評価が存在する場合（詳細画面の平均星評価）
  if (averageElem) {
    const averageScore = parseFloat(averageElem.getAttribute("data-average"));

    // 平均評価を表示するためのセレクターに対して評価を設定
    $(averageElem).raty({
      readOnly: true,  // 評価の編集を禁止
      starOn: "/assets/star-on.png",  // 星のオン画像
      starOff: "/assets/star-off.png",  // 星のオフ画像
      starHalf: "/assets/star-half.png",  // 半星の画像
      score: averageScore,  // 平均評価スコアを設定
    });
  }

  // フォーム画面の場合
  if (postElem) {
    $(postElem).raty({
      starOn: "/assets/star-on.png", // asset_pathの代わりにパスを直接指定
      starOff: "/assets/star-off.png",
      starHalf: "/assets/star-half.png",
      scoreName: "post_comment[star]",  // フォームのフィールド名
    });
  }
});
