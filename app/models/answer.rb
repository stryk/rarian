class Answer < ActiveRecord::Base

  before_save :sanitize_content, :process_tags
  after_save :trasfer_to_s3

  attr_accessible :content, :user_id, :company_id, :question_id, :net_votes, :points

  module Point
    UP = 2
    DOWN = -2
  end

  belongs_to :user
  belongs_to :company
  belongs_to :question
  has_many :s3objects, as: :storable, :dependent => :destroy

  validates :content, :company_id, :user_id, :question_id, presence: true
  validates_length_of :content, :maximum => 10000, :allow_blank => false
  make_voteable

  acts_as_commentable
  self.per_page = 10

  def get_full_title
    "<a href='/users/#{user.id}'>"+user.name+'</a>'+' '+content
  end

  def get_reference
    "<a href='/users/#{user.id}'>"+user.name+'</a>'+' | '
  end

  def up_vote
    update_attributes(:net_votes => net_votes.to_i + 1, :points => points.to_i+Point::UP)
  end

  def down_vote
    update_attributes(:net_votes => net_votes.to_i - 1, :points => points.to_i+Point::DOWN)
  end

  def undo_vote(value)
    undo_point = value > 0 ? Point::DOWN : Point::UP
    update_attributes(:net_votes => net_votes.to_i - value.to_i, :points => points.to_i+undo_point)
  end

  def sanitize_content
    if content
      ActionController::Base.helpers.sanitize content, tags: %w{p strong em u span ol li ul img}, attributes: %w{style color src alt}
    end
  end

  private

  def process_tags
    unless self.offloaded
      parse_content = Nokogiri::HTML.fragment(self.content)
      parse_content.css("img").each do |image_tag|
        unless image_tag["src"][0..3] == 'http'
          content_img_link = image_tag["src"]
          # changing the file_name in the path
          image_filename = File.basename(content_img_link)
          image_pathname = File.dirname(content_img_link)
          new_filename = image_filename[8..-1]
          new_img_link = image_pathname + '/' + new_filename

          # creating a new <a href> tag
          image_tag.name = "a"
          image_tag['href'] = new_img_link
          image_tag['class'] = "nModal"
          image_tag['title'] = ""
          image_tag.remove_attribute("src")
          image_tag.remove_attribute("alt")


          child_tag = Nokogiri::XML::Node.new "img", parse_content
          child_tag['src'] = content_img_link
          child_tag['alt'] = "Missing Image"
          child_tag.parent = image_tag
        end
      end
      self.content = parse_content.to_html
    end
  end
  def trasfer_to_s3
    unless self.offloaded
      ContentProcessingWorker.perform_async(self.id,false)
    end
  end
end
