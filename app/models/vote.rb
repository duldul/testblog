class Vote
	include Mongoid::Document
  	include Mongoid::Timestamps

	belongs_to :comment
	belongs_to :user
end
