require "codewords_solver/dictionary"

class CodewordsSolver
  def self.solve!(coded_words:, starting_letters:)
    new(coded_words, starting_letters).solve!
  end

  MAX_LOOP_ATTEMPTS = 5

  def initialize(coded_words, starting_letters)
    @coded_words = coded_words
    @starting_letters = starting_letters
    @letters_by_number = (1..26).to_h { |n| [n, nil] }.merge(
      starting_letters.transform_values(&:upcase)
    )
    @dictionary = Dictionary.new
  end

  def solve!
    num_attempts = 0

    until complete? || num_attempts == MAX_LOOP_ATTEMPTS
      # puts "Doing a loop (attempts so far: #{num_attempts})"
      do_loop
      num_attempts += 1
    end

    if complete?
      puts "PUZZLE IS COMPLETE:"

      puts

      print_words

      puts
      return
    end

    print_answer

    raise "Could not complete puzzle in #{num_attempts} (max attempts: #{MAX_LOOP_ATTEMPTS})"
  end

  private

  def do_loop
    @coded_words.each_with_index do |coded_word|
      next if coded_word.all? { |num| number_assigned? num }

      regexp = to_regexp(coded_word)
      possibilities = @dictionary.find_by_regexp(regexp)
      # this is a bit of a leak/hack; at this point, we're going a bit beyond regex's capabilities
      possibilities = filter_invalid_possibilities(possibilities, coded_word)

      # puts(
      #   "Found #{possibilities.length > 10 ? possibilities.length : possibilities.join(", ")} for #{coded_word} (regexp: /#{regexp}/)"
      # )

      assign_word(coded_word, possibilities[0]) if possibilities.length == 1

      if possibilities.length <= 10 && !possibilities.empty?
        # if the same letter appears in the same position for all of the possibilities, then it's
        # safe to assign it
        possibilities[0].chars.each_with_index do |char, index|
          if possibilities.all? { |word| word[index] == char } && !number_assigned?(coded_word[index])
            assign_letter(coded_word[index], char)
          end
        end
      end

      break if complete?
    end
  end

  def assign_word(coded_word, word)
    coded_word.each_with_index do |num, index|
      next if number_assigned?(num)

      assign_letter num, word[index]
    end
  end

  def number_assigned?(number)
    !@letters_by_number[number].nil?
  end

  def assign_letter(number, letter)
    raise if number.nil?

    existing_num = @letters_by_number.invert[letter]

    if existing_num && existing_num != number
      raise "#{letter} cannot be assigned to #{number} - it's already assigned to #{existing_num}"
    end

    puts "Assigning #{letter} to #{number}"

    @letters_by_number[number] ||= letter
  end

  def complete?
    @letters_by_number.each_value.all? { |letter| !letter.nil? }
  end

  def filter_invalid_possibilities(possibilities, coded_word)
    possibilities.filter { |poss| poss.chars.uniq.length == coded_word.uniq.length }
  end

  def print_answer
    @letters_by_number.each do |num, letter|
      puts "#{num.to_s.rjust(2, "0")} ==> #{letter}"
    end
  end

  def print_words
    words = @coded_words.map do |code_word|
      code_word.each_with_object("") do |number, word|
        word << @letters_by_number[number]
      end
    end

    max_word_length = words.max_by(&:length).length

    words.each_with_index do |word, i|
      puts "#{word.rjust(max_word_length, " ")} ===> #{@coded_words[i]}"
    end
  end

  def to_regexp(coded_word)
    backreferences_for_unknown_numbers = []

    unassigned_letters = ("A".."Z").to_a.join("").tr @letters_by_number.values.join(""), ""

    regexp_chars = coded_word.map do |number|
      letter = @letters_by_number[number]
      next letter if letter

      backreference_num = backreferences_for_unknown_numbers.index(number)

      if backreference_num.nil?
        backreferences_for_unknown_numbers << number
        "(#{unassigned_letters.split("").join("|")})"
      else
        "\\#{backreference_num + 1}"
      end
    end

    /\A#{regexp_chars.join("")}\z/
  end
end
