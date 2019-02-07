//= require subrecord

$(function() {
  $(document).ready(function() {
    if ($("#form_entity").length) {
      $(document).triggerHandler("loadedrecordform", [$("#form_entity")] );
      $(document).triggerHandler("loadedrecordsubforms", [$("#form_entity")] );
    }
  });
});
