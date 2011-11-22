module MongoUtils
  module Aggregation
    extend ActiveSupport::Concern

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
          :keyf => "function(d) { return {#{interval}: d.created_at.get#{interval.capitalize}() + 1} }",
          :reduce => "function(doc, out) { out.count++; }"
        )
      end
    end
  end
end
