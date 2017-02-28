$(document).ready(function() {
  $("#the_only_button").on('click', function(event) {

    event.preventDefault();

    // encodeURIComponent converts text field params for GET
    var club_name = encodeURIComponent($("#the_only_text_field").val());

    $.ajax({

      method: "GET",
      url: "http://localhost:3000/clubs?name="+club_name,
      dataType: "json",
      success: function(data) {
        for (i=0;i<data.length;i++){
          data[i].radius=2;
          data[i].fillKey='playerFill';
          data[i].latitude=data[i].bp_latitude;
          data[i].longitude=data[i].bp_longitude;
        };

        map.bubbles(data);
      }
      

    });

  });
});
