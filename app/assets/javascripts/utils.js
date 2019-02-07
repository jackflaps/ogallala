$(document).on("subrecordcreated", function(event, object_name, newFormEl) {
  newFormEl.parents(".subrecord-form:first").triggerHandler("subrecordcreated");
});
