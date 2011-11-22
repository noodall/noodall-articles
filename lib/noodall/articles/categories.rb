module Noodall
  module Articles
    module Categories

      def all_categories(query = {})
        result = self.collection.map_reduce(category_map, category_reduce, {:query => query, :out => "tmp_categories"})
        categories = result.find.to_a.map{|c| c['_id']}
        categories.sort
      end

      private

      def category_map
        <<-JS
          function(){
            if (this.categories) {
              this.categories.forEach(function(category){
                emit(category, 1);
              });
            }
          }
        JS
      end

      def category_reduce
        <<-JS
          function(prev, current) {
            var count = 0;
            for (index in current) {
                count += current[index];
            }
            return count;
          }
        JS
      end

    end
  end
end
