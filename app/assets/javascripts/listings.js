$(document).ready(function() {
  function initialize() {
    var myLatlng = new google.maps.LatLng(latitude, longitude);

    var mapOptions = {
      zoom: 15,
      center: myLatlng,
      scrollwheel: false
    };

    var map = new google.maps.Map(
      document.getElementById("map-canvas"),
      mapOptions
    );

    var marker = new google.maps.Marker({
      position: myLatlng,
      map: map,
      animation: google.maps.Animation.DROP
    });

    var contentString =
      "<h1>" +
      title +
      "</h1>" +
      "<p>" +
      cost +
      "</p>" +
      "<p>" +
      address +
      "</p>";

    var infowindow = new google.maps.InfoWindow({
      content: contentString
    });

    marker.addListener("click", function() {
      infowindow.open(map, marker);
    });
  }

  google.maps.event.addDomListener(window, "load", initialize);
});

//Passed anonymous function so only loads when doc is ready
$(function() {
  $("a.load_reviews").on("click", function(e) {
    //fire ajax
    //$.ajax({
    // method: "GET",
    // url: this.href
    //   }).done(function(response) {
    //get a response (it's the variable of the data)
    //   $("div.reviews").html(response);

    //Load that data into the DOM (adds it to the current page)
    //  });
    $.get(this.href).success(function(response) {
      $("div.reviews").html(response);
    });
    //load response into the html of the page
    e.preventDefault();
  });
});
