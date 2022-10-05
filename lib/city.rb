class City
  attr_reader :id 
  attr_accessor :name

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  def self.list_all
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
    result = DB.exec("INSERT INTO cities (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i
  end
  
  def ==(city_to_compare)
    self.name() == city_to_compare.name()
  end

  def self.clear
    DB.exec("DELETE FROM cities *;")
  end

  def self.find(id)
    cities = DB.exec("SELECT * FROM cities WHERE id = #{:id};")
    binding.pry
    name = cities.fetch("name")
    id = cities.fetch("id").to_i
    City.new({ name: name , id: id })
  end

  def update(name)
    @name = name
    DB.exec("UPDATE cities SET name = '#{name}' WHERE id = #{@id};")
  end

  def delete
    DB.exec("DELETE FROM cities WHERE id = #{@id};")
  end

  def trains 
    Train.find_by_city(self.id)
  end
end