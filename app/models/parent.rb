class Parent < ActiveRecord::Base
  has_one :user, :as => :roleable, :dependent => :destroy
  accepts_nested_attributes_for :user
end
