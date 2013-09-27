module BlipsHelper
  def date_formate(datetime = nil)
    datetime.strftime("%m/%d/%Y")
  end

  def show_title(obj)
    obj.get_full_title
  end

  def show_multimedia_content(obj)
      obj.get_multimedia_content
  end

end
