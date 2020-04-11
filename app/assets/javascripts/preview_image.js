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

  var onAddFile;
  onAddFile = function(event) {
    var file, thumbContainer, url;
    file = event.target.files[0];
    url = URL.createObjectURL(file);
    thumbContainer = $(this).parent().siblings('div.thumb');
    if (thumbContainer.find('img').length === 0) {
      return thumbContainer.append('<img src="' + url + '" />');
    } else {
      return thumbContainer.find('img').attr('src', url);
    }

  };
  $('input[type=file]').each(function() {
    return $(this).change(onAddFile);
  });
  $('body').on('cocoon:after-insert', function(e, addedPartial) {
    return $('input[type=file]', addedPartial).change(onAddFile);
  });
  $('a.add_fields').data('association-insertion-method', 'append');
  return $('a.add_fields').data('association-insertion-node', 'div.image-form');

});
