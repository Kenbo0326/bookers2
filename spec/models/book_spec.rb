require 'rails_helper'

RSpec.describe Book, type: :model do
  describe 'バリデーションのテスト' do
    let(:book) { Book.new(title: title, body: body) }

    context 'title が存在する場合' do
      let(:title) { 'テストタイトル' }
      let(:body)  { 'テスト本文' }

      it '有効である' do
        expect(book).to be_valid
      end
    end

    context 'title が空の場合' do
      let(:title) { '' }
      let(:body)  { 'テスト本文' }

      it '無効である' do
        expect(book).not_to be_valid
      end
    end

    context 'body が空の場合' do
      let(:title) { 'テストタイトル' }
      let(:body)  { '' }

      it '無効である' do
        expect(book).not_to be_valid
      end
    end
  end
end
