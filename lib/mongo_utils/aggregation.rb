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
      # @param [Symbol] interval interval in seconds
      # @return [Array] returns an array of Hashes, containing the keys
      #   "count" and the grouping name
      def group_by_created_at(interval)
        collection.group(
          :initial => {:count => 0},
          :keyf => "function(d) {
            var millis_since_epoch  = d.created_at.getTime();
            var interval_in_millis  = #{interval} * 1000;
            var time_since_last_interval = millis_since_epoch % interval_in_millis;
            var time_until_next_interval = interval_in_millis - time_since_last_interval;

            var key = new Date(millis_since_epoch + time_until_next_interval)
            return {'bucket': key}
          }",
          :reduce => "function(doc, out) { out.count++; }"
        )
      end
    end
  end
end
