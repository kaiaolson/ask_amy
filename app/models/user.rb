class User < ActiveRecord::Base

  has_many :questions, dependent: :nullify
  has_many :answers, dependent: :nullify

  has_many :likes, dependent: :destroy
  # if just used "questions", it would confuse Rails, so change it to liked_questions
  # to use unconventional naming, add source so it knows where it's coming from
  has_many :liked_questions, through: :likes, source: :question

  has_many :favorites, dependent: :destroy
  has_many :favorite_questions, through: :favorites, source: :question

  has_many :votes, dependent: :destroy
  has_many :voted_questions, through: :votes, source: :question

  # attr_accessor :password
  # attr_accessor :password_confirmation

  # more info about has_secure_password can be found here:
  # http://api.rubyonrails.org/classes/ActiveModel/SecurePassword/ClassMethods.html
  has_secure_password

  validates :password, length: {minimum: 6}, on: :create
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true,
                    uniqueness: true,
                    format:  /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  def full_name
    "#{first_name} #{last_name}".titleize
  end
end
