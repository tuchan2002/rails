require 'rails_helper'

describe 'Books API', type: :request do
  describe 'GET /books' do
    it 'returns all books' do
      FactoryBot.create(:book, title: 'hello1', author: 'tuchan')
      FactoryBot.create(:book, title: 'hello2', author: 'trantu')
  
      get '/api/v1/books'
  
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(2)
    end
  end

  describe 'POST /books' do
    it 'create a new book' do
      expect {
        post '/api/v1/books', params: { book: { title: 'hello world', author: 'tran anh tu' } }
      }.to change { Book.count }.from(1).to(2)
  
      expect(response).to have_http_status(:created)
    end
  end

  describe 'DELETE /books/:id' do
    it 'deletes a book' do
      book = FactoryBot.create(:book, title: 'hello1', author: 'tuchan')

      delete "/api/v1/books/#{book.id}"
  
      expect(response).to have_http_status(:no_content)
    end
  end
end