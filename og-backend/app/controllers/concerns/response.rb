module Response
  def json_response(obj, status = 200)
    render json: obj, status: status
  end

  def rdf_response(obj, status = 200)
    eaccpf = RDF::Vocabulary.new("http://archivi.ibc.regione.emilia-romagna.it/ontology/eac-cpf/")
    graph = RDF::Graph.new

    resource = RDF::URI.new("http://rockymountainnames.org/entities/#{obj['id']}")
    graph << RDF::Statement.new(resource, RDF.type, eaccpf.person)

    description_bnode = RDF::Node.new
    graph << RDF::Statement.new(description_bnode, RDF.type, eaccpf.descriptionArea)

    name_bnode = RDF::Node.new
    graph << RDF::Statement.new(name_bnode, RDF.type, eaccpf.nameArea)
    graph << RDF::Statement.new(name_bnode, RDF::Vocab::RDFS.label, RDF::Literal.new(obj['authorized_name']))
    graph << RDF::Statement.new(description_bnode, eaccpf.nameEntry, name_bnode)

    graph << RDF::Statement.new(description_bnode, eaccpf.biogHist, obj['bioghist']) if obj['bioghist']
    graph << RDF::Statement.new(resource, eaccpf.description, description_bnode)

    render plain: graph.dump(:jsonld, prefixes: {rdf: RDF.to_uri, rdfs: RDF::Vocab::RDFS.to_uri, dc: RDF::Vocab::DC.to_uri, eaccpf: eaccpf.to_uri}), status: status
  end
end
