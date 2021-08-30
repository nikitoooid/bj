# frozen_string_literal: true

module TextInterface
  # Alerts message and wait for enter
  def alert(message)
    clear_ask_for("#{message}\nPress enter to continue. ")
  end

  # Ask question and return true or false (yes or no)
  def ask(message)
    result = 0

    loop do
      result = ask_for("#{message}\n1 - Yes | 2 - No\n")

      break if result.between?(1, 2)

      alert 'Please select an existing item!'
    end

    return true if result == 1

    system 'clear'
    false
  end

  # Ask for input anything
  def ask_for(message, type = :int)
    print(message)
    result = gets.chomp

    case type
    when :int
      result.to_i
    when :str
      result
    when :sym
      result.to_sym
    end
  end

  # Ask for input anything after clearing screen (return result as :int, :str, :sym)
  def clear_ask_for(message, type = :int)
    system 'clear'
    ask_for(message, type)
  end
end
