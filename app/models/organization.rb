class Organization < ActiveRecord::Base
    has_one :organization_settings, :dependent => :destroy
    has_many :users, dependent: :destroy
    has_many :scrools, dependent: :destroy
    #has_many :app_payments
    #has_many :notices
    validates_presence_of :name,
                          :phone,
                          :state,
                          :street_address,
                          :zip,
                          :email

    attr_accessor :name, :phone, :state, :street_address, :zip, :email, :is_enabled

    def self.demo_id
      return 1
    end

    def change_id(new)
      Organization.where(id: self.id).update_all(id: new)
      self.id = new
    end
end
