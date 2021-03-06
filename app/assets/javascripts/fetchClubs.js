$(window).ready(function() {
  $("#get_club_name").on('change', function(event) {

    event.preventDefault();

    // encodeURIComponent converts text field params for GET
    var club_name = encodeURIComponent($("#get_club_name").val());
    // to prevent mixed content issues
    if (window.location.protocol === "http:") {
      var myDomain = "http://" + window.location.host;
    } else {
      myDomain = "https://" + window.location.host;
    }

    $.ajax({
      method: "GET",
      url: myDomain + "/clubs?name=" + club_name,
      dataType: "json",
      success: function(data) {
        for (i=0; i < data.length; i++) {
          data[i].radius = 2.5;
          data[i].fillKey = 'playerFill';
          data[i].latitude = data[i].bp_latitude;
          data[i].longitude = data[i].bp_longitude;
        };
        map.bubbles(data);
      }
    });
  });
});
