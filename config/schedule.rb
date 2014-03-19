# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
RAILS_ROOT = File.dirname(__FILE__) + '/..'
case @environment
when 'production'
	every 1.day, :at => '4:30 am' do
		rake "ts:index"
	end
	every 1.day, :at => '1:00 am' do
		rake "sitemap:refresh"
	end
	every :reboot do
		rake "ts:start"
	end
	every :saturday, :at => "5:30am" do
	  command "rm -rf #{RAILS_ROOT}/tmp/cache"
	end
when 'development'
	every 1.day, :at => '11:56 am' do
		rake "ts:index"
	end
	every 1.day, :at => '11:57 am' do
		rake "sitemap:refresh"
	end
	every 1.day, :at => "11:58am" do
	  command "rm -rf #{RAILS_ROOT}/tmp/cache"
	end
end
