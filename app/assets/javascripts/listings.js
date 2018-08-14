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
/*$(function() {
  $("a.load_reviews").on("click", function(e) {
    //fire ajax
    // $.ajax({
    // method: "GET",
    // url: this.href
    //    }).done(function(response) {
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
*/
//Submiting Reviews via AJAX
/*
  $("#new_review").on("submit", function(e) {
    $.ajax({
      type: "POST",
      url: this.action,
      data: $(this).serialize(),
      success: function(response) {
        $("#review_content").val("");
        var $ol = $("div.reviews ol");
        $ol.append(response);
      }
    });

    e.preventDefault();
  });
});
*/
/* $("#new_review").on("submit", function(e) {
    $.ajax({
      type: "POST",
      url: this.action,
      data: $(this).serialize(),
      success: function(json) {
        $("#review_content").val("");
        var review = new Review(json);
        var reviewLi = review.renderLi()
        var $ol = $("div.reviews ol");
        $ol.append(reviewLi);
      }
    });

    e.preventDefault();


});

Review.prototype.renderLi = function

// Creates Review model object
function Review(attributes) {
  this.id = attributes.id;
  this.content = attributes.content;
  this.user_id = attributes.user_id;
} */

// Creates Review model object
function Review(data) {
  this.id = data.id;
  this.content = data.content;
  this.user = data.user;
}

Review.prototype.renderDisplay = function() {
  var html = "";
  html +=
    "<div class='rev' id='review-' + review.id + ''>" +
    "<strong>" +
    this.user.id +
    "</strong>" +
    " says: " +
    this.content +
    "</div>";
  $("#submitted-reviews").append(html);
};

$(function() {
  $("form#new_review").on("submit", function(e) {
    e.preventDefault();
    var $form = $(this);
    var action = $form.attr("action");
    // Processes the review(form data)to convert from an object to a string.
    var params = $form.serialize();
    $.ajax({
      url: action,
      data: params,
      dataType: "json",
      method: "POST"
    }).success(function(json) {
      $(".reviewBox").val("");
      var review = new Review(json);
      review.renderDisplay();
    });
  });
});
