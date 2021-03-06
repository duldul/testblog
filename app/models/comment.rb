class Comment
	include Mongoid::Document
	include Mongoid::Timestamps

  	field :body, type: String
	field :abusive, type: Boolean, default: false

	validates_presence_of :body

	belongs_to :post
	belongs_to :user
  	has_many :votes

  	default_scope order_by(created_at: 'DESC')
	scope :not_abusive, lambda { where(abusive: false) }

	def mark_as_abusive!
		update_attribute :abusive, true
	end

	def mark_as_not_abusive!
		update_attribute :abusive, false
	end

	def down_votes
		self.votes.where(value: -1).count
	end

	def up_votes
		self.votes.where(value: 1).count
	end
end
