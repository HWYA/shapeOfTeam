$(window).ready(function() {
  $("#get_club_name").on('change', function(event) {

    event.preventDefault();

    // encodeURIComponent converts text field params for GET
    var clubName = encodeURIComponent($("#get_club_name").val());

    // to prevent mixed content issues
    var properDomain = function() {
      if (window.location.protocol === "http:") {
        return "http://" + window.location.host;
      } else {
        return "https://" + window.location.host;
      }
    }();

    $.ajax({
      method: "GET",
      url: properDomain + "/clubs?name=" + clubName,
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
