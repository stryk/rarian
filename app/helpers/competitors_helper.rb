module CompetitorsHelper
  def show_link(obj)
    if obj.is_a?(Competitor)
      company_path(obj.competitor_company)
    else
      "#"
    end
  end
end
