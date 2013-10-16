class Comment
	include Mongoid::Document
  	include Mongoid::Timestamps

	field :body, type: String
  	field :abusive, type: Boolean, default: false

  	validates_presence_of :body

  	belongs_to :post
  	belongs_to :user

  	default_scope where(abusive: false)

	def votes
		up_votes - down_votes
	end
end
