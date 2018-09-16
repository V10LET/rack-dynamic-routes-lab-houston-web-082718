require 'pry'
class Application
  @@items = []

  def self.items
    @@items
  end

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      item_name = req.path.split(/items/).last
      item_name = item_name.delete("/")
      item = @@items.find { |i| i.name == item_name}

      if item == nil
        resp.write "Item not found"
        resp.status = 400
      else
        resp.write item.price
      end
binding.pry
    else
      resp.write "Route not found"
      resp.status = 404
    end

    resp.finish
  end

end
