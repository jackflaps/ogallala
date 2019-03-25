module Response
  def json_response(obj, status = 200)
    render json: obj, status: status
  end
end
