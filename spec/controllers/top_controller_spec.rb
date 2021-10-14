require 'rails_helper'

describe TopController do
  describe 'index' do
    it 'HTTPステータスが200' do
      get :index
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'judge' do
    context '正常系' do
      it 'HTTPステータスが302' do
        input = 'S1 S4 S3 S2 S5'
        post :judge, params: { input: input }
        expect(response).to have_http_status(:found)
      end

      it 'リダイレクト先URLに「result」を含む' do
        input = 'S1 S4 S3 S2 S5'
        post :judge, params: { input: input }
        expect(response.body).to include('result')
      end

      it 'リダイレクト先URLに「alert」を含まない' do
        input = 'S1 S4 S3 S2 S5'
        post :judge, params: { input: input }
        expect(response.body).not_to include('alert')
      end
    end

    context '異常系' do
      it 'HTTPステータスが302' do
        input = 'S100000'
        post :judge, params: { input: input }
        expect(response).to have_http_status(:found)
      end

      it 'リダイレクト先URLに「result」を含まない' do
        input = 'S100000'
        post :judge, params: { input: input }
        expect(response.body).not_to include('result')
      end

      it 'リダイレクト先URLに「alert」を含む' do
        input = 'S100000'
        post :judge, params: { input: input }
        expect(response.body).to include('alert')
      end
    end
  end
end
