$(document).ready(function() {
  $("#the_only_button").on('click', function(event) {
    event.preventDefault();

    var club_name = encodeURI($("#the_only_text_field").val());

    $.ajax({
      method: "GET",
      url: "http://localhost:3000/clubs?name="+club_name,
      dataType: "json",
      success: function(data) { console.log(data) }
    })

  });
});
