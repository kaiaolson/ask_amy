class Question < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  # this will establish a has many association with answer. this assumes that your answer model has a question_id integer field
  # that references the question. with has_many, answers must be plural
  # must pass a dependent option to maintain data integrity; pass it :destroy or :nullify
  # destroy: delete all assoc. answers when you delete a question
  # nullify: if delete a question, updates the question_id of answers to NULL
  has_many :answers, dependent: :destroy
  # joins tables - comments has a many to one relationsip with answers
  has_many :comments, through: :answers

  # this will fail validation (so it won't create or save) if the title is not provided and if it is not unique
  validates :title, presence: true, uniqueness: { case_sensitive: false }, length: {minimum: 3, maximum: 255 }
  # set custom message for error
  # DSL: Domain Specific Lanugage
  validates :body, uniqueness: { message: "must be unique"}

  # this validates that the combination of the title and body is unique. Which means that the title doesn't have to be unique by itself, however, the combo of the two fields must be unique
  # validates :title, uniqueness: {scope: :body}

  validates :view_count, numericality: {greater_than_or_equal_to: 0}

  # validates :email,
  #           format: { with: /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i }

  # using custom validation method; must make sure that 'no_monkey' is a method available for our class. The method can be public or private; more likely we'll have it as a private method because we don't need to use it outside this class.
  validate :no_monkey

  # callback method
  after_initialize :set_defaults

  # scope :recent, lambda {order ("created_at DESC").limit(5)}
  # is the same as:
  def self.recent(number = 5)
    order("created_at DESC").limit(number)
  end

  def self.search(term)
    where(["title || body ILIKE ?", "%#{term}%"]).order("view_count DESC")
  end

  def self.call
    view_count += 1
  end

  def category_name
    category.name if category
  end

  # prefix means you call it with user_full_name - prefix it with the model
  # delegate :full_name, to: :user, prefix: true
  def user_full_name
    user.full_name if user
  end

  private

  def set_defaults
    self.view_count ||= 0
  end

  def no_monkey
    if title && title.downcase.include?("monkey")
      errors.add(:title, "No monkey!!!")
    end
  end
end
