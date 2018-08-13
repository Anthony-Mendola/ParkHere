$(function() {
  $("a.load_listings").on("click", function(e) {
    //AJAX
    $.ajax({
      method: "GET",
      url: this.href
    }).done(function(data) {
      //Response
      $("div.listings").html(data);
    });

    //Load to DOM
    e.preventDefault();
  });
});
