require "active_support/inflector"

class CodewordsSolver
  class Dictionary
    include ActiveSupport::Inflector

    def initialize
      @words = import_words_by_filepath("./word_list.txt")
    end

    def find_by_regexp(regexp)
      all = @words.filter { |w| w.length > 2 and w.match? regexp }
    end

    private

    def import_words_by_filepath(filepath)
      # puts "Loading words in from #{filepath}"
      file = File.read(filepath)
      file.chomp!

      words = file.split("\n")

      words.map! do |w|
        w.upcase!
        w = transliterate(w, "")
        w.gsub!(/[^A-Z]/, "")
        w
      end

      # puts "Loaded #{words.length} words"

      words
    end
  end
end