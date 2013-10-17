class Vote
	include Mongoid::Document
  	include Mongoid::Timestamps

  	field :value, type: Integer, default: 1

	belongs_to :comment
	belongs_to :user
end
