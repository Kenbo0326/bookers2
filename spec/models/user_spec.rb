require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーションのテスト' do
    let(:user) { User.new(name: name, email: 'test@example.com', password: 'password') }

    context 'name が存在する場合' do
      let(:name) { 'テストユーザー' }

      it '有効である' do
        expect(user).to be_valid
      end
    end

    context 'name が空の場合' do
      let(:name) { '' }

      it '無効である' do
        expect(user).not_to be_valid
      end
    end
  end
end