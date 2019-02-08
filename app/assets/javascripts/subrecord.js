//= require utils

/*
 * jquery.closestchild 0.1.1
 *
 * Author: Andrey Mikhaylov aka lolmaus
 * Email: lolmaus@gmail.com
 *
 */

 ;(function($){
  $.fn.closestChild = function(selector) {
    var $children, $results;

    $children = this.children();

    if ($children.length === 0)
      return $();

    $results = $children.filter(selector);

    if ($results.length > 0)
      return $results;
    else
      return $children.closestChild(selector);
  };
})(window.jQuery);

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
              $subform.hide();
              $("> .subrecord-form-fields > input[type=hidden]", $subform).attr('value', true);
            });
          }

          if ($subform.closest(".subrecord-form").data("remove") != "disabled") {
            addRemoveButton();
          }

          $(document).triggerHandler("subrecordcreated", [$subform.data("object-name") || $this.data("object-name"), $subform]);
        };

        var addAndInitForm = function(formHtml, $target_subrecord_list) {
          var $parsed_template = $(formHtml);

          // replace child template tags with script tags to avoid submitting templates
          var $child_templates = $parsed_template.closestChild(".form_template");
          $.each($child_templates, function() {
            $child = $(this);
            $child.replaceWith($("<script id=\"" + $child.attr('id')} + "\" type='text/html' />").html($child.html()));
          });

          $target_subrecord_list.append($parsed_template);

          $this.parents("form:first").triggerHandler("formchanged");

          $.proxy(init_subform, $parsed_template)();

          $(":input:first", $parsed_template).focus();

          $this.data("form_index", $this.data("form_index")+1);
        };

        $($this).on("click", "> .subrecord-form-heading > .btn:not(.show-all)", function(event) {
          event.preventDefault();
          var $link = $(this);
          var $object_class = $link.data('object-class');
          var $association_path = $link.data('association-path');
          var $template = $("#" + $association_path + "_template");
          var $target_subrecord_list = $(".subrecord-form-list:first", $(this).parents(".subrecord-form:first"));

          var template_html = $template.html();

          // insert association indices
          var index_placeholder = "__" + $association_path + "_index__";
          template_html = template_html.replace(new RegExp(index_placeholder,"g"), $this.data("form_index"));
          template_html = template_html.replace(new RegExp("__nested_field_for_replace_with_index__","g"), $this.data("form_index"));

          addAndInitForm(template_html, $target_subrecord_list);
        });
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
