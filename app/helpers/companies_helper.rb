module CompaniesHelper
  def up_voted_by_current_user(obj)
  (current_user && current_user.up_voted?(obj)) ? '<i class="icon-thumbs-up"></i> Upvoted(undo)' :
    (current_user && current_user.voted?(obj) ? '' :'<i class="icon-thumbs-up"></i>Upvote')
  end

  def down_voted_by_current_user(obj)
  (current_user && current_user.down_voted?(obj)) ? '<i class="icon-thumbs-down"></i> Downvoted(undo)' :
    (current_user && current_user.voted?(obj) ? '' :'<i class="icon-thumbs-down"></i>')
  end

  def get_pricing_details(company)
    latest_quote = company.quotes.last
    if latest_quote.blank?
      latest_price = 0
      change = 0
    else
      latest_price = latest_quote.price
      change = latest_quote.change
    end
    last_closing_quote = company.quotes.where("DATE(created_at) = DATE(?) AND closing = true",Time.now - 1.day).order("created_at ASC").last
    if last_closing_quote.blank?
      last_closing_price = 0
    elsif last_closing_quote.price == latest_price
      last_closing_price = latest_price 
    else
      last_closing_price = last_closing_quote.price
    end
    {:latest_price => latest_price, :previous_price => last_closing_price,
     :price_diff => change.round(2), :percentage_diff => get_percent(latest_price, change)}
  end

  def get_percent(latest_price, change)
    if(change == 0)
      return 'NA'
    end
    return ((change/latest_price)*100).round(2)
  end
end
