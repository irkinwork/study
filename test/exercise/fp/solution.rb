module Exercise
  module Fp
    class << self
      # Обратиться к параметрам фильма можно так:
      # film["name"], film["rating_kinopoisk"], film["rating_imdb"],
      # film["genres"], film["year"], film["access_level"], film["country"]

      def rating(array)
        selected_by_country = array.select { |film| film['country'].present? && film['country'].split(',').length >= 2 }
        ratings = selected_by_country.map { |film| film['rating_kinopoisk'].to_f }.select(&:positive?)
        ratings.reduce(:+) / ratings.length
      end

      def chars_count(films, threshold)
        films
          .select { |film| film['rating_kinopoisk'].to_f >= threshold }
          .map { |film| film['name'] }
          .reduce(0) { |acc, name| acc + name.count('и') }
      end
    end
  end
end
