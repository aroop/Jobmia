class Section < ActiveRecord::Base
	belongs_to :resume
	acts_as_list :scope => :resume
	has_many :entries, :order => "position", :dependent => :destroy
end