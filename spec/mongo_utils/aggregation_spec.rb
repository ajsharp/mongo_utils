require 'spec_helper'
require 'mongo_utils/aggregation'

describe MongoUtils::Aggregation do
  class Person
    include MongoUtils::Aggregation
  end

  before { Person.collection.drop }

  describe ".group_by_created_at" do
    before do
      Time.stub!(:now => Time.new(2011, 11))
      Person.create! :created_at => Time.now
    end

    subject { Person.group_by_created_at.first }

    it 'adds a method' do
      Person.should respond_to :group_by_created_at
    end

    its(['month']) { should == 11.0 }
    its(['count']) { should == 1.0 }
    its(['timestamp']) { should == Time.now.iso8601 }
  end
end
