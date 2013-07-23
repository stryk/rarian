module BlipsHelper
  def date_formate(datetime = nil)
    datetime.strftime("%m/%d/%Y")
  end

  def blip_show_title(blip)
    blip.company.ticker+": "+date_formate(blip.created_at)+": "+blip.action+": "+blip.content
  end
end
