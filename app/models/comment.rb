class Comment
	include Mongoid::Document
	include Mongoid::Timestamps

  field :body, type: String
	field :abusive, type: Boolean, default: false

	validates_presence_of :body

	belongs_to :post
	belongs_to :user
  has_many :votes

	scope :not_abusive, lambda { where(abusive: false) }

  def mark_as_not_abusive!
    update_attribute :abusive, false
  end

  def abuse_check
  end
end
