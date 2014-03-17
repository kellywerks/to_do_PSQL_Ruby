require 'tasks'
require 'pg'

DB = PG.connect(:dbname => 'to_do_test')

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM tasks *;")
  end
end

describe Task do
  it 'is initialized with a name' do
    task = Task.new('do stuff')
    task.should be_an_instance_of Task
  end

  it 'returns the name' do
    task = Task.new('nap')
    task.name.should eq 'nap'
  end

  it 'starts with an empty array' do
    Task.all.should eq []
  end

  it 'saves a task to the database' do
    task = Task.new('get free stuff')
    task.save
    Task.all.should eq [task]
  end

  it 'is the same task if it has the same name' do
    task1 =  Task.new('learn SQL')
    task2 = Task.new('learn SQL')
    task1.should eq task2
  end
end
