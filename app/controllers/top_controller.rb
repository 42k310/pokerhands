class TopController < ApplicationController
  require_relative '../sevices/cards'
  include Const

  def index; end

  def judge
    input = params['input']
    cards = Card.new(input)

    err_msgs = cards.valid
    if err_msgs.present?
      redirect_to root_path flash: { alert: err_msgs, input: input } and return
    else
      result = cards.judge
      redirect_to root_path flash: { result: result, input: input } and return
    end
  end
end
