require 'rails_helper'

describe TopController do
  context '正常系' do
    context '役判定' do
      it 'ストレート・フラッシュ' do
        input = 'S1 S4 S3 S2 S5'
        post :judge, params: { input: input }
        expect(response.body).to include 'ストレート・フラッシュ'
      end

      it 'フォーカード' do
        input = 'S1 H1 C1 D1 S5'
        post :judge, params: { input: input }
        expect(response.body).to include 'フォーカード'
      end

      it 'フルハウス' do
        input = 'S1 H1 D1 S2 H2'
        post :judge, params: { input: input }
        expect(response.body).to include 'フルハウス'
      end

      it 'フラッシュ' do
        input = 'S3 S5 S7 S9 S11'
        post :judge, params: { input: input }
        expect(response.body).to include 'フラッシュ'
      end

      it 'ストレート（通常）' do
        input = 'S1 S4 D3 H2 S5'
        post :judge, params: { input: input }
        expect(response.body).to include 'ストレート'
      end

      it 'ストレート（マタギ）' do
        input = 'S10 H11 D13 S12 C1'
        post :judge, params: { input: input }
        expect(response.body).to include 'ストレート'
      end

      it 'スリーカード' do
        input = 'S1 D1 C1 S2 D5'
        post :judge, params: { input: input }
        expect(response.body).to include 'スリーカード'
      end

      it 'ツーペア' do
        input = 'D3 C3 D2 S2 D5'
        post :judge, params: { input: input }
        expect(response.body).to include 'ツーペア'
      end

      it 'ワンペア' do
        input = 'S1 D1 S3 D8 S5'
        post :judge, params: { input: input }
        expect(response.body).to include 'ワンペア'
      end

      it 'ノーハンド' do
        input = 'S1 D4 S10 C13 C5'
        post :judge, params: { input: input }
        expect(response.body).to include 'ノーハンド'
      end
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
