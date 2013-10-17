class Vote
	include Mongoid::Document
  	include Mongoid::Timestamps

  	field :value, type: Integer, default: 1

  	validates_uniqueness_of :comment_id, scope: :user_id

	belongs_to :comment
	belongs_to :user
end
