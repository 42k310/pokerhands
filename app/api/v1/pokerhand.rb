module V1
  class Pokerhand < Grape::API
    helpers do
      def judge_best
        hand_masters = HandMaster.all
        tmp_strength_arr = []
        @results.each do |r|
          strength = hand_masters.find_by(hand_name: r[:hand])[:strength]
          r[:strength] = strength
          tmp_strength_arr.push(strength)
        end

        max = tmp_strength_arr.max

        @results.each do |r|
          r[:best] = (max == r[:strength])
        end
      end
    end

    resource :pokerhand do
      desc '役&best判定'
      post '/' do
        inputs = params[:input]

        res = {}
        @results = []
        @errors = []

        inputs.each do |input|
          cards = Card.new(input)
          e = cards.valid

          if @errors.present?
            error = {}
            error[:card] = input
            error[:msgs] = e
            @errors.push(error)
          else
            result = {}
            result[:card] = input
            result[:hand] = cards.judge
            @results.push(result)
          end
        end

        judge_best if @results.present?

        res[:results] = @results if @results.present?
        res[:errors] = @errors if @errors.present?
        res
      end
    end
  end
end
