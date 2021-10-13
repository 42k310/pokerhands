class Card
  include Const

  def initialize(input)
    @cards = cards(input)
  end

  def valid
    @err_msgs = []
    card_size_check
    card_duplicate_check
    suit_format_check
    number_format_check
    @err_msgs
  end

  def judge
    @suit_set = suit_set
    @number_set = number_set
    @dup_counts = @number_set.group_by(&:itself).map { |_k, v| v.size }.sort # ef. ['S1', 'A1', 'C1', 'S12', 'A12'] => [2, 3]

    hand_masters = HandMaster.all.map { |hand_master| [hand_master.hand_name, hand_master.strength] }
    # => ef. [["ストレート・フラッシュ", 80], ["フォーカード", 70], ["フルハウス", 60], ["フラッシュ", 50], ["ストレート", 40], ["スリーカード", 30], ["ツーペア", 20], ["ワンペア", 10], ["ノーハンド", 0]]

    return hand_masters[0][0] if straight_flash?
    return hand_masters[1][0] if four_card?
    return hand_masters[2][0] if full_house?
    return hand_masters[3][0] if flash?
    return hand_masters[4][0] if straight?
    return hand_masters[5][0] if three_card?
    return hand_masters[6][0] if two_pair?
    return hand_masters[7][0] if one_pair?

    hand_masters[8][0]
  end

  private

    #########################
    # 準備系
    #########################
    def cards(input)
      input.split(' ')
    end

    #########################
    # valid
    #########################
    def card_size_check
      unless @cards.size == 5
        @err_msgs.push(ERR_CARDS_NUMBER)
      end
    end

    def card_duplicate_check
      unless @cards.uniq.size == @cards.size
        @err_msgs.push(ERR_CARDS_DUPLICATE)
      end
    end

    def suit_format_check
      @cards.each do |card|
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
      suit_set
    end

    def number_set
      number_set = []
      @cards.each do |card|
        number = card.split(REG_SUIT)[1].to_i
        number_set.push(number)
      end
      number_set
    end

    #########################
    # 役判定
    #########################
    def straight_flash?
      return true if straight? && flash?
    end

    def four_card?
      return true if @dup_counts == [1, 4]
    end

    def full_house?
      return true if @dup_counts == [2, 3]
    end

    def flash?
      return true if @suit_set.uniq.size == 1
    end

    def straight?
      @number_set.sort!
      return true if @number_set == [1, 10, 11, 12, 13]

      diffs = []
      i = 1
      number_set_size = @number_set.size

      while i < number_set_size
        diff = @number_set[i] - @number_set[i - 1]
        diffs.push(diff)
        i += 1
      end
      return true if diffs == [1, 1, 1, 1]
    end

    def three_card?
      return true if @dup_counts == [1, 1, 3]
    end

    def two_pair?
      return true if @dup_counts == [1, 2, 2]
    end

    def one_pair?
      return true if @dup_counts == [1, 1, 1, 2]
    end
end
