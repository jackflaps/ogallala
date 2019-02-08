module FormHelper
  def ogallala_form_for(name, *args, &block)
    options = args.extract_options!
    args << options.merge(builder: OgallalaFormBuilder)
    form_for(name, *args, &block)
  end

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
end
