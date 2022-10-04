require 'rspec'
require 'train'
require 'city'
require'spec_helper'

describe '#City' do 

  describe('.list') do
    it("returns a empty array if there are no cities") do
      expect(City.list).to(eq([]))
    end
  end




end