class Train
  attr_reader :id
  attr_accessor :name, :capacity 

  def initialize(attributes)
    @name =attributes.fetch(:name)
    @id = attributes.fetch(:id)
    @capacity = attributes.fetch(:capacity)
  end

  def self.list_all
    return_trains = DB.exec('SELECT * FROM trains')
    trains = []
    return_trains.each() do |train|
      name = train.fetch("name")
      id = train.fetch("id").to_i
      capacity = train.fetch("capacity")
      trains.push(Train.new({ name: name ,capacity: capacity, id: id }))
    end
    trains
  end

  def save
    result = DB.exec("INSERT INTO trains (name) VALUES ('#{@name}'), (capacity) VALUES ('#{@capacity}') RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

end