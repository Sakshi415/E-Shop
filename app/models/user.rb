# frozen_string_literal: true

class User < ActiveRecord::Base
  has_many :orders
  rolify 
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User
  

  def make_admin
    self.admin = true
    add_role(:admin)
  end
end
