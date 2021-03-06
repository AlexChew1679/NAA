class User < ApplicationRecord

  has_many :tasks, dependent: :destroy  

  attr_accessor :remember_token

  before_save {self.email = email.downcase}

  validates :first_name, presence: true, length: {minimum: 3, maximum: 20}
  validates :last_name, presence: true, length: {minimum: 3, maximum: 20}

  VALID_EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { minimum: 10, maximun: 50}, format: { with: VALID_EMAIL_REGEX },
      uniqueness: { case_sensitive: false }

    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

    #return a random token
    def User.new_token
      SecureRandom.urlsafe_base64
    end

    #return a digest_token of a given string

    def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # remember a user token in the database for persistent sessions

  def remember
      self.remember_token =  User.new_token
      update_attribute(:remember_digest, User.digest(remember_token))
  end
  #returns true if the given token matches the digest
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def self.search(search)
    where("first_name LIKE ?", "%#{search}%") 
    where("last_name LIKE ?", "%#{search}%")
    where("email LIKE ?", "%#{search}%")
  end

  def self.from_omniauth(auth_hash)    
    user = find_or_create_by(uid: auth_hash['uid'], provider: auth_hash['provider'])
    user.first_name = auth_hash['info']['first_name']
    user.last_name = auth_hash['info']['last_name']
    user.email = auth_hash['info']['email']
    user.password = '123456'      

    user.save!
    user
  end

end
