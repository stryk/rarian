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
    last_two_pricing = company.last_and_previous_closing_price
    latest_price = last_two_pricing.first.price
    previous_price = last_two_pricing.count > 1 ? last_two_pricing.last.price : 0
    {:latest_price => latest_price, :previous_price => previous_price,
     :price_diff => (latest_price.to_f - previous_price.to_f), :percentage_diff => get_percent(latest_price, previous_price)}
  end

  def get_percent(latest_price, previous_price)
    previous_price  > 0 ? (((latest_price- previous_price).to_f/previous_price)*100) : 100.0
  end
end
