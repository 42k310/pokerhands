module V1
  class Pokerhand < Grape::API
    resource :pokerhand do
      desc '役判定'
      post '/' do
        inputs = params[:input]
        results = []
        inputs.each do |input|
          cards = Card.new(input)
          unless cards.valid
            results.push(cards.judge)
          end
        end
        results
      end
    end
  end
end
