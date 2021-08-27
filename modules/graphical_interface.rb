require_relative 'text_interface'

module GraphicalInterface
  include TextInterface 
  
  def show(dealer, player, bank, is_visible)
    system 'clear'
    
    print_cards(dealer.cards, is_visible)
    print_cards(player.cards)

    hud(player, bank)
  end

  private

  def print_cards(cards, visible = true)
    count = cards.length

    print_heads(count)
    print_bodies(cards, visible, :suit)
    print_bodies(cards, visible, :value)
    print_foots(count)

    print "\n\n"
  end

  def print_heads(count)
    count.times{print '┌───┐ '}
    print "\n"
  end

  def print_bodies(cards, visible = true, part = :value)
    cards.each { |card| print "│ #{visible ? card[part] : '*'} │ " }
    puts
  end

  def print_foots(count)
    count.times{print '└───┘ '}
    print "\n"
  end

  def hud(player, bank)
    puts "| #{player.name} | credit: $#{player.credit} | points: #{player.points} |          Bank: $#{bank}"
  end
end