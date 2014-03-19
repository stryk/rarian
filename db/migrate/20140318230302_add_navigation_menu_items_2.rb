class AddNavigationMenuItems2 < ActiveRecord::Migration
  def up
  	size_navigation = Navigation.create(name: 'Index')
  	size_navigation.children.create(name: 'S&P 500', :url => '/companies/index/snp500')
  	size_navigation.children.create(name: 'S&P 400', :url => '/companies/index/snp400')
  	size_navigation.children.create(name: 'S&P 600', :url => '/companies/index/snp600')
  	size_navigation.children.create(name: 'Nasdaq 100', :url => '/companies/index/nasdaq100')

  	size_navigation = Navigation.create(name: 'Style')
  	size_navigation.children.create(name: 'Value', :url => '/companies/style/value')
  	size_navigation.children.create(name: 'Growth', :url => '/companies/style/growth')
  	size_navigation.children.create(name: 'Momentum', :url => '/companies/style/momentum')
  	size_navigation.children.create(name: 'Dividend > 4%', :url => '/companies/style/dividend')
  	

  	Navigation.find_by_name('Industries').destroy
  end
  def down
    Navigation.find_by_name('Index').destroy
    Navigation.find_by_name('Style').destroy

    size_navigation = Navigation.create(name: 'Industries', model_name: 'Company', :url => '/companies/industry/:industry')
  	size_navigation.query_hashs[:group] = 'sector, industry'
  	size_navigation.query_hashs[:select] = 'sector, industry as name'
  	size_navigation.save
  end

end
