//= require utils

templateCache = [];

renderTemplate = function(templateId, data, cb) {
  if (!templateCache[templateId]) {
    var templateNode = $("#"+templateId).get(0);
    if (templateNode) {
      var firstNode = templateNode.firstChild;
      var template = null;
      // Check whether the template is wrapped in <!-- -->
      if (firstNode && (firstNode.nodeType === 8 || firstNode.nodeType === 4)) {
        template = firstNode.data.toString();
      } else {
        template = templateNode.innerHTML.toString();
      }
      console.log("Add template to the template cache");
      //templateCache[templateId] = TrimPath.parseTemplate(template, templateId);
    }
  }
  return templateCache[templateId].process(data);
};

quickTemplate = function(templateHTML, data) {
  //return TrimPath.parseTemplate(templateHTML).process(data);
};

$(function() {
  $.fn.init_subrecord_form = function() {
    $(this).each(function() {
      var $this = $(this);

      if ( ( $this.hasClass("initialised") && $this.is(":visible") ) )  {
        return;
      }

      $this.data("form_index", $("> .subrecord-form-container .subrecord-form-fields", $this).length);

      var init = function(callback) {
        $(document).on("subrecordcreated", function(e, object_name, formel) {
          formel.triggerHandler(e);
        });

        var init_subform = function() {
          var $subform = $(this);
          if($subform.hasClass("initialised")) {
            return;
          }
          $subform.addClass("initialised");

          var addRemoveButton = function() {
            var removeBtn = $("<a href='javascript:void(0)' class='btn btn-default btn-xs btn-pull-right subrecord-form-remove' title='Remove sub-record' aria-label='Remove sub-record'><span class='fas fa-times'></span></a>");
            $subform.prepend(removeBtn);
            removeBtn.on("click", function() {
              console.log("I'm trying to remove this!");
              $subform.hide();
              $("> .subrecord-form-fields > input[type=hidden]", $subform).attr('value', true);
            });
          }

          if ($subform.closest(".subrecord-form").data("remove") != "disabled") {
            addRemoveButton();
          }

          $(document).triggerHandler("subrecordcreated", [$subform.data("object-name") || $this.data("object-name"), $subform]);
        };

        callback();

        $("> .subrecord-form-container > .subrecord-form-list > .subrecord-form-wrapper:not(.initialised):visible", $this).each(init_subform);
      }

      $this.addClass("initialised");
      init(function() {
        $(document).trigger("loadedrecordsubforms", $this);
      });
    })
  };

  $(document).ready(function() {
    $(document).on("loadedrecordform", function(event, $container) {
      $("#basic_information:not(.initialised)", $container).init_subrecord_form();
      // now go through all the subrecord-form
      $(".subrecord-form[data-subrecord-form]:not(.initialised)", $container).init_subrecord_form();
    });

    // this just makes sure we're initalizing the subforms.
    $(".subrecord-form[data-subrecord-form]:not(.initialised)").init_subrecord_form();
  });
});
