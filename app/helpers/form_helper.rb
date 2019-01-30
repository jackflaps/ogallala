module FormHelper
  def possible_options_for(name, add_empty_options = false)
    options = []
    options.push(["", ""]) if add_empty_options

    opts = case name
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
      options.push([I18n.t("enums.#{name}.#{opt}"), opt])
    end

    options
  end
end
