require 'rrd'

class Chart < ActiveRecord::Base
	def self.get_rrd_data(rrd_file)
		rrd = RRD::Base.new(rrd_file)
		d = rrd.fetch("AVERAGE", {:start => Time.now - 20})
		d = d.select{|i| i.last.kind_of?(Float) && !i.last.nan?}
		load = d.last[1] if d.last 
		load || 0.0
	end
end
