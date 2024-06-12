class TouristSiteSerializer
  def serialized_json(top_10_tourist_sites)
    {
      "data": top_10_tourist_sites.map do |site|
        {
          "id": nil,
          "type": "tourist_site",
          "attributes": {
            "name": "#{site.name}",
            "address": "#{site.address}",
            "place_id": "#{site.place_id}"
          }
        }
      end
    }
  end
end