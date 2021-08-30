# frozen_string_literal: true

require_relative 'text_interface'

module GraphicalInterface
  include TextInterface

  def show_table(dealer, player, bank, cards_visibility = :visible)
    system 'clear'

    print_cards(dealer.cards, cards_visibility)
    print_cards(player.cards, :visible)

    hud(player, bank) if cards_visibility == :invisible
  end

  private

  def print_cards(cards, visibility)
    count = cards.length

    print_heads(count)
    print_bodies(cards, visibility, :suit)
    print_bodies(cards, visibility, :value)
    print_foots(count)

    print "\n\n"
  end

  def print_heads(count)
    count.times { print '┌───┐ ' }
    print "\n"
  end

  def print_bodies(cards, visibility, part = :value)
    cards.each { |card| print "│ #{visibility == :visible ? card[part] : '*'} │ " }
    puts
  end

  def print_foots(count)
    count.times { print '└───┘ ' }
    print "\n"
  end

  def hud(player, bank)
    puts "| #{player.name} | credit: $#{player.credit} | points: #{player.points} |          Bank: $#{bank}\n\n"
  end
end
