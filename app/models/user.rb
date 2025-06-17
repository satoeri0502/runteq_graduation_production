class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :authentications, :dependent => :destroy
  accepts_nested_attributes_for :authentications

  # バリデーション
  validates :password,  presence: true,
                        format: {
                          with: /\A(?=.*?[a-z])(?=.*?[A-Z])(?=.*?\d)[a-zA-Z\d]{10,16}+\z/,
                          message: "は10〜16文字で、大文字・小文字・数字をすべて含めてください"
                        },
                        if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :reset_password_token, uniqueness: true, allow_nil: true
  validates :email, presence: true, uniqueness: true, if: -> { new_record? || changes[:email] }
end
