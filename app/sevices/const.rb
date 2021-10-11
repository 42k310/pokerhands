module Const
  # エラーメッセージ
  ERR_CARDS_NUMBER = 'カードの枚数は5枚にしてください'
  ERR_CARD_FORMAT = 'カードの形式に誤りがあります。カード：'
  ERR_SUIT_FORMAT = 'スートの形式に誤りがあります。カード：'
  ERR_NUMBER_FORMAT = '数字の形式に誤りがあります。カード：'

  # 正規表現
  REG_SUIT = /S|H|D|C/
  REG_NUMBER = /^1[0-3]|[0-9]/
end
