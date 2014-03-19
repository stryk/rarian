class AddNavigationMenuItems < ActiveRecord::Migration
  def up
  	size_navigation = Navigation.create(name: 'Size')
  	size_navigation.children.create(name: 'SmallCap <$1B', :url => '/companies/type/small_cap')
  	size_navigation.children.create(name: 'MidCap <$10B', :url => '/companies/type/mid_cap')
  	size_navigation.children.create(name: 'LargeCap $10+B', :url => '/companies/type/large_cap')

  	size_navigation = Navigation.new(name: 'Sector', model_name: 'Company', :url => '/companies/sector/:sector')
  	size_navigation.query_hashs[:group] = 'sector'
  	size_navigation.query_hashs[:select] = 'sector as name'
  	size_navigation.save

  	size_navigation = Navigation.create(name: 'Industries', model_name: 'Company', :url => '/companies/industry/:industry')
  	size_navigation.query_hashs[:group] = 'sector, industry'
  	size_navigation.query_hashs[:select] = 'sector, industry as name'
  	size_navigation.save
  	
  end
  def down
    Navigation.find_by_name('Size').destroy
    Navigation.find_by_name('Sector').destroy
    Navigation.find_by_name('Industries').destroy
  end

end
