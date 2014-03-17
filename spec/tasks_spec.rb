require 'tasks'
require 'pg'

DB = PG.connect(:dbname => 'to_do_test')

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM tasks *;")
  end
end

describe Task do
  it 'saves a task to the database' do
    task = Task.new('get free stuff',1)
    task.save
    Task.all.should eq [task]
  end

  it 'is initialized with a name and list_id' do
    task = Task.new('do stuff',1)
    task.should be_an_instance_of Task
  end

  it 'returns the name' do
    task = Task.new('nap',1)
    task.name.should eq 'nap'
  end

  it 'tells you its list ID' do
    task = Task.new('learn SQL', 1)
    task.list_id.should eq 1
  end

  it 'starts with an empty array' do
    Task.all.should eq []
  end

  it 'is the same task if it has the same name' do
    task1 =  Task.new('learn SQL',1)
    task2 = Task.new('learn SQL',1)
    task1.should eq task2
  end
end
