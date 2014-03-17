require 'rspec'
require 'list'
require 'pg'

DB = PG.connect({:dbname => 'to_do_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM lists *;")
  end
end

describe List do

  # it 'gives the id from the list table for the name of the list' do
  #   list = List.new('test the database')
  #   list.save
  #   list.id.should eq 58
  # end

  it 'initializes a new list with a name' do
    list = List.new('to_do')
    list.should be_an_instance_of List
  end

  it 'can be initialized with its database ID' do
    list = List.new('Epicodus stuff', 1)
    list.should be_an_instance_of List
  end

  it 'gives you the name' do
    list = List.new('Stuff to do')
    list.name.should eq 'Stuff to do'
  end

  it 'is the same list if the names and ids match' do
    list1 = List.new('Stuff to do',1)
    list2 = List.new('Stuff to do',1)
    list1.should eq list2
  end

  it 'starts off with no lists' do
    List.all.should eq []
  end

  it 'lets you save lists to the database' do
    list = List.new('Things to do',1)
    list.save
    List.all.should eq [list]
  end

  it 'sets its ID when you save it' do
    list = List.new('learn PSQL')
    list.save
    list.id.should be_an_instance_of Fixnum
  end


end
