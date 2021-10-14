require 'rails_helper'
include Const

describe 'valid' do
  context '単数リクエスト' do # 複数リクエストは「api/v1/pokerhand_spec.rb」で実装
    context '正常系' do
      it 'ストレート・フラッシュ' do
        input = 'S1 S2 S3 S4 S5'
        card = Card.new(input)
        err_msgs = card.valid
        result = card.judge
        expect(result).to eq('ストレート・フラッシュ')
        expect(err_msgs.size).to eq(0)
      end

      it 'フォーカード' do
        input = 'S1 H1 D1 C1 S3'
        card = Card.new(input)
        err_msgs = card.valid
        result = card.judge
        expect(result).to eq('フォーカード')
        expect(err_msgs.size).to eq(0)
      end

      it 'フルハウス' do
        input = 'S1 H1 D1 C3 S3'
        card = Card.new(input)
        err_msgs = card.valid
        result = card.judge
        expect(result).to eq('フルハウス')
        expect(err_msgs.size).to eq(0)
      end

      it 'フラッシュ' do
        input = 'D1 D3 D5 D6 D8'
        card = Card.new(input)
        err_msgs = card.valid
        result = card.judge
        expect(result).to eq('フラッシュ')
        expect(err_msgs.size).to eq(0)
      end

      it 'ストレート' do
        input = 'S1 H2 D3 C4 S5'
        card = Card.new(input)
        err_msgs = card.valid
        result = card.judge
        expect(result).to eq('ストレート')
        expect(err_msgs.size).to eq(0)
      end

      it 'スリーカード' do
        input = 'S1 H1 D1 C4 S5'
        card = Card.new(input)
        err_msgs = card.valid
        result = card.judge
        expect(result).to eq('スリーカード')
        expect(err_msgs.size).to eq(0)
      end

      it 'ツーペア' do
        input = 'S1 D1 D3 C3 S5'
        card = Card.new(input)
        err_msgs = card.valid
        result = card.judge
        expect(result).to eq('ツーペア')
        expect(err_msgs.size).to eq(0)
      end

      it 'ワンペア' do
        input = 'S1 H1 D3 C4 S5'
        card = Card.new(input)
        err_msgs = card.valid
        result = card.judge
        expect(result).to eq('ワンペア')
        expect(err_msgs.size).to eq(0)
      end

      it 'ノーハンド' do
        input = 'S1 H2 D5 C8 S10'
        card = Card.new(input)
        err_msgs = card.valid
        result = card.judge
        expect(result).to eq('ノーハンド')
        expect(err_msgs.size).to eq(0)
      end
    end

    context '異常系' do
      it 'card_size_check（多め）' do
        input = 'S1 H2 D5 C8 S10 S12 S13 H3'
        card = Card.new(input)
        err_msgs = card.valid
        expect(err_msgs).to include(ERR_CARDS_NUMBER)
      end

      it 'card_size_check（少なめ）' do
        input = 'S1 H2 D5'
        card = Card.new(input)
        err_msgs = card.valid
        expect(err_msgs).to include(ERR_CARDS_NUMBER)
      end

      it 'card_duplicate_check' do
        input = 'S1 H2 D5 C8 S1'
        card = Card.new(input)
        err_msgs = card.valid
        expect(err_msgs).to include(ERR_CARDS_DUPLICATE)
      end

      it 'suit_format_check' do
        input = 'Z1 S1 H2 D5 Q12'
        card = Card.new(input)
        err_msgs = card.valid
        expect(err_msgs).to include(ERR_SUIT_FORMAT + 'Z1')
      end

      it 'number_format_check' do
        input = 'S100 H2 D5 S1 H8'
        card = Card.new(input)
        err_msgs = card.valid
        expect(err_msgs).to include(ERR_NUMBER_FORMAT + 'S100')
      end

      it 'number_format_check（エッジ：0）' do
        input = 'S0 H1 D1 S1 H8'
        card = Card.new(input)
        err_msgs = card.valid
        expect(err_msgs).to include(ERR_NUMBER_FORMAT + 'S0')
      end

      it 'number_format_check（エッジ：01）' do
        input = 'S01 H1 D01 S1 H8'
        card = Card.new(input)
        err_msgs = card.valid
        expect(err_msgs).to include(ERR_NUMBER_FORMAT + 'S01')
      end

      it 'number_format_check（エッジ：14）' do
        input = 'S1 H14 D1 S3 H8'
        card = Card.new(input)
        err_msgs = card.valid
        expect(err_msgs).to include(ERR_NUMBER_FORMAT + 'H14')
      end
    end
  end
end
