class City
  attr_reader :id 
  attr_accessor :name

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end


  def self.list 
    return_cities = DB.exec('SELECT * FROM cities')
    cities = []
    return_cities.each() do |city|
      name = city.fetch("name")
      id = city.fetch("id").to_i
      cities.push(City.new({ name: name , id: id }))
    end
    cities
  end


  def save
    result = DB.exec("INSERT INTO cities (name) VALUES ('#{name}) RETURNING id;")
    @id = result.first().fetch("id").to_i
  end
  


end