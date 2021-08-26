class TextInterface
  def alert(message)
    ask_for("#{message}\nPress enter to continue.")
  end
  
  def ask(message)
    result = 0

    loop do
      result = ask_for("#{message} \n1 - Yes | 2 - No")

      break if result in (1..2)

      alert "Please select an existing item!"
    end

    return true if result == 1
    
    clear_puts
    false
  end

  def ask_for(message, type = :int)
    clear_puts message
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

  def clear_puts(message = nil)
    clear_print "#{message}\n"
  end

  def clear_print(message = nil)
    system 'clear'
    print "#{message}" unless (message.nil? || message.empty?)
  end
end