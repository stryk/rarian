class Pitch < ActiveRecord::Base

  before_save :sanitize_content, :process_tags
  attr_accessible :title, :multimedia_content, :action, :user_id, :company_id, :net_votes, :points

  module Point
    UP = 5
    DOWN = -5
  end

  validates :title, :multimedia_content, :company_id, :user_id, presence: true
  validates_length_of :multimedia_content, :maximum => 10000, :allow_blank => false
  validates_length_of :title, :maximum => 200, :allow_blank => false
  belongs_to :user
  belongs_to :company

  scope :buy_pitch, -> {where({:action => "buy"})}
  scope :sell_pitch, -> {where({:action => "sell"})}

  make_voteable

  acts_as_commentable


  def get_full_title
    title
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
    if multimedia_content
      ActionController::Base.helpers.sanitize multimedia_content, tags: %w{p strong em u span ol li ul img}, attributes: %w{style color src alt}
    end
  end

  def get_multimedia_content
    multimedia_content
  end

private

  def process_tags
    parse_content = Nokogiri::HTML.fragment(self.multimedia_content)
    parse_content.css("img").each do |image_tag|
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
    self.multimedia_content = parse_content.to_html
  end
end


