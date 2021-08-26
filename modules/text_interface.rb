# frozen_string_literal: true

module TextInterface
  # Alerts message and wait for enter
  def alert(message)
    ask_for("#{message}\nPress enter to continue.")
  end

  # Ask question and return true or false (yes or no)
  def ask(message)
    result = 0

    loop do
      result = ask_for("#{message} \n1 - Yes | 2 - No")

      break if result.between?(1, 2)

      alert 'Please select an existing item!'
    end

    return true if result == 1

    clear_puts
    false
  end

  # Ask for input anything (return result as :int, :str, :sym)
  def ask_for(message, type = :int, newline = true)
    newline ? clear_puts(message) : clear_print(message)
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

  private

  # Cleaning screen and puts a message (or empty string)
  def clear_puts(message = nil)
    clear_print "#{message}\n"
  end

  # Cleaning screen and print a message (or only clean the screen)
  def clear_print(message = nil)
    system 'clear'
    print message.to_s unless message.nil? || message.empty?
  end
end
