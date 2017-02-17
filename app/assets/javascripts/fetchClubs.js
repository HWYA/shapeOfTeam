$(document).ready(function() {
  $("#the_only_button").on('click', function(event) {

    event.preventDefault();

    // encodeURIComponent converts text field params for GET
    var club_name = encodeURIComponent($("#the_only_text_field").val());

    $.ajax({

      method: "GET",
      url: "http://localhost:3000/clubs?name="+club_name,
      dataType: "json",
      success: function(data) { console.log(data) }

    });

  });
});
