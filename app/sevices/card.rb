class Card
  include Const

  def initialize(input)
    @cards = cards(input)
  end

  def valid
    @err_msgs = []
    card_size_check
    suit_format_check
    number_format_check
    @err_msgs
  end

  def judge
    @suit_set = suit_set
    @number_set = number_set

    straight_flash?
    four_card?
    full_house?
    flash?
    straight?
    three_card?
    two_pair?
    one_pair?
  end

  private

    def cards(input)
      input.split(' ')
    end

    def card_size_check
      unless @cards.size == 5
        @err_msgs.push(ERR_CARDS_NUMBER)
      end
    end

    def suit_format_check
      @cards.each do |card|
        if card.size > 3
          @err_msgs.push(ERR_CARD_FORMAT + card)
        end

        suit = card.split(REG_NUMBER)[0]

        unless REG_SUIT.match?(suit)
          @err_msgs.push(ERR_SUIT_FORMAT + card)
        end
      end
    end

    def number_format_check
      @cards.each do |card|
        number = card.split(REG_SUIT)[1]

        unless /^1[0-3]/.match?(number) || /^[1-9]/.match?(number)
          @err_msgs.push(ERR_NUMBER_FORMAT + card)
        end
      end
    end

    def suit_set
      suit_set = []
      @cards.each do |card|
        suit = card.split(REG_NUMBER)[0]
        suit_set.push(suit)
      end
    end

    def number_set
      number_set = []
      @cards.each do |card|
        number = card.split(REG_SUIT)[1]
        number_set.push(number)
      end
    end

    def straight_flash?
      straight? && flash?
    end

    def four_card?

    end

    def full_house?

    end

    def flash?
      return true if @suit_set.uniq.size == 1
    end

    def straight?
      @number_set.sort!
    end

    def three_card?

    end

    def two_pair?

    end

    def one_pair?

    end

end
