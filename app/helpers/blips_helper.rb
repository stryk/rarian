module BlipsHelper
  def date_formate(datetime = nil)
    datetime.strftime("%m/%d/%Y")
  end

  def show_title(obj)
    obj.get_full_title
  end

end
