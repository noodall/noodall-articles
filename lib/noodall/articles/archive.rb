module Noodall
  module Articles
    module Archive
      def archive
        result = self.collection.map_reduce(archive_map, archive_reduce, {:finalize => archive_finalize, :out => "tmp_archives"})
        years = result.find.to_a.map{ |hash| Year.new(hash['_id'],hash['value']) }.sort{ |a,b| b.year <=> a.year }
        years
      end

      private

      def archive_map(field = 'created_at')
        %{
          function(){
            emit(new Date(this.#{field}).getFullYear(), { months: [new Date(this.#{field}).getMonth()]} )
          };
        }
      end

      def archive_reduce
        "function( key , values ){" +
          "var months = [];" +
          "for ( var i=0; i<values.length; i++ ){" +
          "months = months.concat(values[i].months);" +
          "}" +
          "return { months: months };" +
          "}"
      end

      def archive_finalize
        "function( key , value ){" +
          "var month_array = [0,0,0,0,0,0,0,0,0,0,0,0];" +
          "for ( var i=0; i<value.months.length; i++ ){" +
          "month_array[value.months[i]] += 1;" +
          "}" +
          "return month_array;" +
          "}"
      end

      class Year
        attr_reader :year, :months, :total

        def initialize(year, value)
          @year = year.to_i
          if value.is_a?( Enumerable )
            @months = value.map{ |m| m.to_i  }
          else
            @months = [0,0,0,0,0,0,0,0,0,0,0,0]
            @months[value.to_i] = 1
          end
          @total = @months.inject {|sum, n| (sum + n).to_i }
        end
      end
    end
  end
end
