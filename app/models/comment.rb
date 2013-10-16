class Comment
	include Mongoid::Document
  	include Mongoid::Timestamps

	field :body, type: String
  	field :up_votes, type: Integer, default: 0
  	field :down_votes, type: Integer, default: 0

  	validates_presence_of :body

  	belongs_to :post
  	belongs_to :user

	def votes
		up_votes - down_votes
	end
end
