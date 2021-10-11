require 'rails_helper'

describe TopController do
  context '正常系' do
    before do
      input = 'S1 S2 S3 S4 S5'
      post :judge, params: { input: input }
    end

    it 'HTTPステータス' do
      expect(response).to redirect_to(:root)
    end

    it '役判定' do
      p response.body
      expect(response.body).to include 'ストレート・フラッシュ'
    end
  end
end

# context '異常系' do
#   context 'cards' do
#   end

#   context 'card' do
#   end

#   context 'suit' do
#   end

#   context 'number' do
#   end
# end
