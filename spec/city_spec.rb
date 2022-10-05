require 'rspec'
# require 'train'
require 'city'
require'spec_helper'

describe '#City' do 

  describe('.list_all') do
    it("returns a empty array if there are no cities") do
      expect(City.list_all).to(eq([]))
    end
  end

  describe('#save') do
    it('saves a city')do
      city1 = City.new(name: "Seattle" , id: nil)
      city1.save
      city2 = City.new(name: "Portland" , id: nil)
      city2.save
      expect(City.list_all).to(eq([city1,city2]))
    end
  end

  describe('.clear') do 
    it("clears all cities") do
      city1 = City.new(name: "Seattle", id: nil)
      city1.save
      city2 = City.new(name:"Portland" , id: nil)
      city2.save
      City.clear
      expect(City.list_all).to(eq([]))
    end
  end

  describe('.find') do
    it("finds city by id")do
      City.clear
      city1 = City.new(name: "Seattle", id: nil)
      city1.save
      city2 = City.new(name:"Portland" , id: nil)
      city2.save
      expect(City.find(city1.id)).to(eq(city1))
    end
  end

  describe('#update') do 
    it("updates a city by id") do 
      city = City.new(name: "Seattle", id: nil)
      city.save
      city.update("Portland")
      expect(city.name).to(eq("Portland"))
    end
  end
  
  describe('#delete') do
    it("deletes all cities by id") do 
      city1 = City.new(name: "Seattle", id: nil)
      city1.save
      city2 = City.new(name:"Portland" , id: nil)
      city2.save
      city1.delete
      expect(City.list_all).to(eq([city2]))
    end
  end

end