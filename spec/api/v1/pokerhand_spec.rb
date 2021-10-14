require 'rails_helper'

context 'best判定' do
  it 'bestが一つ(1/2)' do
    input = ['S1 S2 S3 S4 S5', 'S1 H1 D1 C1 S3']
    post '/api/v1/pokerhand', params: { input: input }

    res = JSON.parse(response.body)
    results = res['results']

    expect(results[0]['hand']).to eq('ストレート・フラッシュ')
    expect(results[0]['best']).to eq(true)
    expect(results[1]['hand']).to eq('フォーカード')
    expect(results[1]['best']).to eq(false)
  end

  it 'bestが複数（2/3）' do
    input = ['S1 S2 S3 S4 S5', 'S1 H1 D1 C1 S3', 'H3 H4 H5 H6 H7']
    post '/api/v1/pokerhand', params: { input: input }

    res = JSON.parse(response.body)
    results = res['results']

    expect(results[0]['hand']).to eq('ストレート・フラッシュ')
    expect(results[0]['best']).to eq(true)
    expect(results[1]['hand']).to eq('フォーカード')
    expect(results[1]['best']).to eq(false)
    expect(results[2]['hand']).to eq('ストレート・フラッシュ')
    expect(results[2]['best']).to eq(true)
  end

  it 'bestが複数（2/2）' do
    input = ['S1 S2 S3 S4 S5', 'H3 H4 H5 H6 H7']
    post '/api/v1/pokerhand', params: { input: input }

    res = JSON.parse(response.body)
    results = res['results']

    expect(results[0]['hand']).to eq('ストレート・フラッシュ')
    expect(results[0]['best']).to eq(true)
    expect(results[1]['hand']).to eq('ストレート・フラッシュ')
    expect(results[1]['best']).to eq(true)
  end
end

context '複数リクエスト' do
  it '正常系' do
    input = ['S1 S2 S3 S4 S5', 'S1 H1 D1 C1 S3']
    post '/api/v1/pokerhand', params: { input: input }

    res = JSON.parse(response.body)
    results = res['results']
    errors = res['errors']
    result_ex = results&.first

    # resultsがある / errorsがnil / resultのkeyが正しい
    expect(results&.size).to eq(2)
    expect(errors&.size).to be nil
    expect(result_ex.keys).to eq(%w[card hand strength best])
  end

  it '正常系・異常系複合' do
    input = ['S1 S2 S3 S4 S5', 'S1 H1 D1 C1 S3 D5', 'ZZ01']
    post '/api/v1/pokerhand', params: { input: input }

    res = JSON.parse(response.body)
    results = res['results']
    errors = res['errors']
    result_ex = results&.first

    # resultsがある / errorsがある / resultのkeyが正しい
    expect(results&.size).to eq(1)
    expect(errors&.size).to eq(2)
  end

  it '異常系' do
    input = ['S1 H1 D1 C1 S3 D5', 'ZZ01']
    post '/api/v1/pokerhand', params: { input: input }

    res = JSON.parse(response.body)
    results = res['results']
    errors = res['errors']
    error_ex = errors&.first

    # resultsがない / errorsがある / errorのkeyが正しい
    expect(results&.size).to be nil
    expect(errors&.size).to eq(2)
    expect(error_ex.keys).to eq(%w[card msgs])
  end
end
