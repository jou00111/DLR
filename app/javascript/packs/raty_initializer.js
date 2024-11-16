document.addEventListener("turbolinks:load", () => {
  const elem = document.querySelector("#post_raty");
  if (!elem) return;

  $(elem).raty({
    starOn: "/assets/star-on.png", // asset_pathの代わりにパスを直接指定
    starOff: "/assets/star-off.png",
    starHalf: "/assets/star-half.png",
    scoreName: "post_comment[star]",
  });
});
