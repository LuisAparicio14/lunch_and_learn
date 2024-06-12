class UserSerializer
  def serialized_json(user)
    {
      "data":
        {
          "type": "user",
          "id": user[:id].to_s,
          "attributes": {
            "name": user[:name],
            "email": user[:email],
            "api_key": user[:api_key]
          }
        }
    }
  end
end