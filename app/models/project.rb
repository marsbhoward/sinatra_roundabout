class Project < ActiveRecord::Base
  extend Slugifiable::ClassMethods
  include Slugifiable::InstanceMethods
  belongs_to :user
  has_many :users

end
