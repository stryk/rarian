module CompetitorsHelper
  def show_link(obj, company)
    if obj.is_a?(Competitor)
      company_path(obj.competitor_company)
    elsif obj.is_a?(Pitch)
      company_pitch_path(company, obj.id)
    else
      "#"
    end
  end
end
