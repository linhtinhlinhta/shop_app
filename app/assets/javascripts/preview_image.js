$(function() {
  function readURL(input) {
    if (input.files && input.files[0]) {
      var reader = new FileReader();

      reader.onload = function (e) {
        $('#img_prev').attr('src', e.target.result);
      }
      reader.readAsDataURL(input.files[0]);
    }
  }

  $("#avatar-upload").change(function(){
    $('#img_prev').removeClass('hidden');
    readURL(this);
  });

  var names = [];
  $('.picupload').change(function(event) {
    var files = event.target.files;

    for (var i = 0; i < files.length; i++) {
        var file = files[i];
        names.push($(this).get(0).files[i].name);

        var picReader = new FileReader();
        picReader.fileName = file.name
        picReader.addEventListener("load", function(event) {

            var picFile = event.target;

            var div = document.createElement("li");

            div.innerHTML = "<img src='" + picFile.result + "'" +
                "title='" + picFile.name + "'/>";

            $(".media-list").prepend(div);

        });

        picReader.readAsDataURL(file);

    }

  });

});
