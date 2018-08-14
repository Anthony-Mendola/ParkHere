$(function() {
  $("a.load_listings").on("click", function(e) {
    $.get(this.href).success(function(response) {
      //Response
      $("div.listings").html(response);
    });

    //Load to DOM
    e.preventDefault();
    $("html,body").animate({ scrollTop: $("div.listings").offset().top }, 1000);
  });
});
