$(function() {
  $("a.load_listings").on("click", function(e) {
    alert("you clicked this link");
    e.preventDefault();
  });
});
