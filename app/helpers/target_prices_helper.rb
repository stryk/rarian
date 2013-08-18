module TargetPricesHelper

  def get_target_price_year_select
    [Date.today.year, Date.today.year+1]
  end
end
