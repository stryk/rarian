class CompaniesDatatable
  delegate :params, :h, :link_to, :number_to_currency, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Company.count,
      iTotalDisplayRecords: companies.total_entries,
      aaData: data
    }
  end

private

  def data
    companies.map do |company|
      [
        "upside",
        company.name.truncate(10),
        company.ticker,
        company.exchange,
        company.sector,
        company.industry,
        "last price",
        "tgt price",
        "mkt cap"
      ]
    end
  end

  def companies
    @companies ||= fetch_companies
  end

  def fetch_companies
    companies = Company.order("#{sort_column} #{sort_direction}")
    companies = companies.page(page).per_page(per_page)
    if params[:sSearch].present?
      companies = companies.where("name like :search or exchange like :search or sector like :search", search: "%#{params[:sSearch]}%")
    end
    companies
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[name name ticker exchange sector industry ticker ticker ticker]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end