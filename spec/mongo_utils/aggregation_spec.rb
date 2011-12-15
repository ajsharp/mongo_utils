require 'spec_helper'
require 'mongo_utils/aggregation'

describe MongoUtils::Aggregation do
  class Person
    include MongoUtils::Aggregation
  end

  before { Person.collection.drop }

  describe ".group_by_created_at" do
    it 'adds a method' do
      Person.should respond_to :group_by_created_at
    end

    it "groups by the created_at date" do
      Time.stub!(:now => Time.new(2011, 11))
      Person.create! :created_at => Time.now

      Person.group_by_created_at(60).should == [{'bucket' => Time.utc(2011, 11, 1, 7, 1), 'count' => 1.0}]
    end
  end
end
