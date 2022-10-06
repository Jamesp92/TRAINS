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
    cities = DB.exec("SELECT * FROM cities WHERE id = #{id};")
    binding.pry                     #stops            
    name = cities.fetch("name")
    id = cities.fetch("id").to_i
    City.new({ name: name , id: id })
  end

  def update(attributes)
    if (attributes.has_key?(:name)) && (attributes.fetch(:name) != nil)
      @name = attributes.fetch(:name)
      DB.exec("UPDATE cities SET name = '#{@name}' WHERE id = #{@id};")
    end
  end
  

  def join_city_to_train(attributes)
    if (attributes.has_key?(:train_name) && (attributes.fetch(:train_name) != nil)
      train_name = attributes.fetch(:train_name)
      train = DB.exec("SELECT * FROM trains WHERE lower(name)='#{train_name.downcase}';").first
      if train != nil
        DB.exec("INSERT INTO stops (train_id, city_id) VALUES (#{train['id'].to_i}, #{@id});")
      end                                                                         
    end
  end

  def delete
    DB.exec("DELETE FROM cities WHERE id = #{@id};")
  end

  def trains 
    trains = []
    result = DB.exec("SELECT train_id FROM stops WHERE city_id = #{@id};")
    result.each() do |result|
      train_id = result.fetch("train_id").to_i()
      train = DB.exec("SELECT * FROM stops WHERE id = #{train_id};")
      name = train.first().fetch("name")
      trains.push(Train.new({name: name, id: album_id}))
    end
    trains 
  end

end