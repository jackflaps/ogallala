module FormHelper
  def possible_options_for(property, add_empty_options = false)
    options = []
    options.push(["", ""]) if add_empty_options

    opts = case property
    when "entity_type"
      ["person", "corporate_body", "family"]
    when "cataloging_level"
      ["minimal", "partial", "full"]
    when "record_status"
      ["draft", "finalized", "revised", "deleted"]
    when "name_form"
      ["authorized", "variant", "parallel", "other"]
    end

    opts.each do |opt|
      options.push([I18n.t("enums.#{property}.#{opt}"), opt])
    end

    options
  end

  def define_template(name, definition = nil, &block)
    @templates ||= {}
    @templates[name] = {
      :block => block,
      :definition => definition,
    }
  end
end
