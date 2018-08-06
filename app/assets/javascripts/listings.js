//google maps logic
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

//Loading Reviews via AJAX
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
    $.get(this.href).success(function(json) {
      //clear the OL html (in case there were stale reviews)
      var $ol = $("div.reviews ol");
      $ol.html(""); //emptied the OL

      // iterate over each review within json
      json.forEach(function(review) {
        //with each review data, append an LI to the OL with the review content
        $ol.append("<li>" + review.content + "<li>");
      });
    });
    //load response into the html of the page
    e.preventDefault();
  });
});

//Submiting Reviews via AJAX
$(function() {
  $("#new_review").on("submit", function(e) {
    url = this.action;
    console.log(url);
    data = {
      authenticity_token: $("input[name='authenticity_token']").val(),
      review: {
        content: $("#review_content").val()
      }
    };

$.ajax({
  type: "POST"
  url:url,
  data: data,
  success: function(response){
    var $ol = $("div.reviews ol")
    $ol.append(response);
  }
})



    e.preventDefault();
  });
});
