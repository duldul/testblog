class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Taggable

  field :body, type: String
  field :title, type: String
  field :archived, type: Boolean, default: false

  validates_presence_of :body, :title

  belongs_to :user
  has_many :comments

  default_scope ne(archived: true)

  def archive!
    update_attribute :archived, true
  end

  def hotness
    rating = case (Time.now-created_at)
      when 3.days .. 7.days then 1
      when 24.hours .. 72.hours then 2
      when 0 .. 24.hours then 3
      else 0
    end

    self.comments.count > 3 ? rating+1 : rating
  end
end
