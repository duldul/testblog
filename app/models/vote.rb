class Vote
	include Mongoid::Document
  	include Mongoid::Timestamps

  	after_save :check_abusive

  	field :value, type: Integer, default: 1

  	validates_uniqueness_of :comment_id, scope: :user_id

	belongs_to :comment
	belongs_to :user

	def check_abusive
		self.comment.mark_as_abusive! if self.comment.down_votes == 3
	end
end
