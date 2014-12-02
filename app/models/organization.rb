class Organization < ActiveRecord::Base
    has_one :organization_settings, :dependent => :destroy
    has_many :users
    has_many :properties
    #has_many :app_payments
    #has_many :notices
    validates_presence_of :name,
                          :phone,
                          :state,
                          :street_address,
                          :zip,
                          :email

    attr_accessible :name
    attr_accessible :phone
    attr_accessible :state
    attr_accessible :street_address
    attr_accessible :zip
    attr_accessible :email
    attr_accessible :is_enabled

    def self.demo_id
      return 3
    end

    def change_id(new)
      Organization.where(id: self.id).update_all(id: new)
      self.id = new
    end
end
