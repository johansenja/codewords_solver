require "active_support/inflector"

class CodewordsSolver
  class Dictionary
    include ActiveSupport::Inflector

    DEFAULT_FILEPATH = File.join(__dir__, "..", "..", "word_list.txt")

    def initialize
      load!
    end

    def find_by_regexp(regexp)
      @words.filter { |w| w.length > 2 and w.match? regexp }
    end

    def has?(word)
      @words.include? word
    end

    def load!
      @words = import_words_by_filepath(DEFAULT_FILEPATH)
    end

    alias_method :reload!, :load!

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
