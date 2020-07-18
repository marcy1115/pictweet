require 'rails_helper'
describe User, type: :model do
  before do
    @user = FactoryBot.build( :user )
  end

  describe 'ユーザー新規登録' do
    context '新規登録が上手くいくとき' do
      it "nicknameとemail,passwordとpassword_confirmationが存在すれば登録できる" do
        expect( @user ).to be_valid
      end
      it "nicknameが6文字以下で登録できる" do
        @user.nickname = "aaaaaa"
        expect( @user ).to be_valid
      end
      it "passwordが6文字以上であれば登録できる" do
        @user.password = "000000"
        @user.password_confirmation = "000000"
        expect( @user ).to be_valid
      end
    end

    context '新規登録がうまくいかないとき' do
      it "nicknameが空だと登録できない" do
        @user.nickname = ''
        @user.valid?
        expect( @user.errors.full_messages ).to include( "Nickname can't be blank" )
      end
      it "nicknameが7文字以上であれば登録できない" do
        @user.nickname = '0000000'
        @user.valid?
        expect( @user.errors.full_messages ).to include( "Nickname is too long (maximum is 6 characters)" )
      end
      it "emailが空では登録できない" do
        @user.email = ''
        @user.valid?
        expect( @user.errors.full_messages ).to include( "Email can't be blank" )
      end
      it "重複したemailが存在する場合登録できない" do
        @user.save
        another_user = FactoryBot.build( :user )
        another_user.email = @user.email
        another_user.valid?
        expect( another_user.errors.full_messages ).to include( "Email has already been taken" )
      end
      it "passwordが空では登録できない" do
        
      end
      it "passwordが5文字以下であれば登録できない" do
      end
      it "passwordが存在してもpassword_confirmationが空では登録できない" do
        
      end
    end
  end
end