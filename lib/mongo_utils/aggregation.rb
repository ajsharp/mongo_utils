module MongoUtils
  module Aggregation
    extend ActiveSupport::Concern

    # The only requirement of the Aggregation module is that you have a class
    # method defined on the including class called `collection`. Many of the
    # popular ORMs provide this for you. Otherwise, you could do something
    # like the following:
    #
    # @example
    #   class Person
    #     include MongoUtils::Aggregation
    #
    #     def self.collection
    #       @db ||= Mongo::Connection.new.db('my_db')
    #       @collection ||= @db.collection('people')
    #     end
    #   end
    #
    module ClassMethods

      # Groups by the created_at date by the interval passed in
      #
      # @param [Symbol] interval valid values are :month, :day and :year
      # @return [Array] returns an array of Hashes, containing the keys
      #   "count" and the grouping name
      def group_by_created_at(interval = :month)
        interval = interval.to_s

        collection.group(
          :initial => {:count => 0},
          :keyf => "function(d) {
            return {
              #{interval}: d.created_at.get#{interval.capitalize}() + 1,
              timestamp: d.created_at}
           }",
          :reduce => "function(doc, out) { out.count++; }"
        )
      end
    end
  end
end
