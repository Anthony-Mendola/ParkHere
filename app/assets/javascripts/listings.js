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

//Listing js
$(function() {
  var listingArray = [];
  var id = parseInt($(".js-next").attr("data-id"));

  if ($("#listingsInfo").length) {
    loadAllListings();
  }

  function loadAllListings() {
    $.ajax({
      url: "/listings.json",
      method: "GET"
    })
      // promise
      .then(function(data) {
        listingArray = data;
        $.each(listingArray, function(index, listing) {
          var listingData =
            "<p><a href='/listings/" +
            listing.id +
            "'>" +
            listing.title +
            "</a><div id='content-" +
            listing.id +
            "'>" +
            listing.content.substring(0, 250) +
            "..." +
            "<a href='#' data-id='" +
            listing.id +
            "' class='js-more'>Read More</a></div><br>";
          $("#listingsInfo").append(listingData);
        });
      });
  }

  // For the listings index page

  $("#listingsInfo").on("click", ".js-more", function(e) {
    e.preventDefault();
    var id = this.dataset.id;
    $.get("/listings/" + id + ".json", function(data) {
      $("#content-" + id).html(data.content);
    });
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

  // Listings Show Page
  function loadListing(data) {
    history.pushState({}, "", "/listings/" + data.id);
    var listingReviewPath = "/listings/" + data.id + "/reviews/";
    $("#new_review").attr("action", listingReviewPath);
    //$(".listingImage").text(data["image"]);
    $(".listingName").text(data["title"]);
    $(".listingDescription").text(data["description"]);
    $(".listingCategory").text(data["categories"]["name"]);
    $(".listingContact").text(data["contact"]);
    $(".listingUserName").text(data["user"]["email"]);
    $(".listingAddress").text(data["address"]);
    $(".listingType").text(data["types"]["name"]);
    $(".listingCost").text(data["cost"]);
    $(".listingLength").text(data["listing_types"]["length"]);
    $(".listingLongitude").text(data["longitude"]);
    $(".listingLatitude").text(data["latitude"]);
    $(".js-next").attr("data-id", data["id"]);
    $(".js-previous").attr("data-id", data["id"]);
    //$("#submitted-reviews").empty();
    data["review_list"].forEach(function(element) {
      var review = new Review(element);
      review.postReview();
    });
  }

  $(".js-next").on("click", function(e) {
    var id = $(".js-next").attr("data-id");
    $.get("/listings/" + id + "/next", function(data) {
      console.log(data);
      loadListing(data);
    });
    e.preventDefault();
  });

  $(".js-previous").on("click", function(e) {
    var id = $(".js-previous").attr("data-id");
    $.get("/listings/" + id + "/previous", function(data) {
      console.log(data);
      loadListing(data);
    });
    e.preventDefault();
  });
});

// Creates Review model object
function Review(data) {
  this.id = data.id;
  this.content = data.content;
  this.user = data.user;
}

Review.prototype.postReview = function() {
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
  $("form#new_review").on("submit", function(event) {
    event.preventDefault();
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
      review.postReview();
    });
  });
});
