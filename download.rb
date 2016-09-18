require 'open-uri'
require 'fileutils'

def dl(z, x, y)
  dir = "#{z}/#{x}"
  path = "#{dir}/#{y}.csv"
  url = "http://earthexplorer.usgs.gov/wms/wmts/EPSG3857/srtm/#{path}"
  print "Downloading #{path}.\n"
  return if File.exist?(path)
  FileUtils.mkdir_p(dir) unless File.directory?(dir)
  File.write(path, open(url).read)
end

def go(z, x, y)
  dl(z, x, y)
  return if z == 12
  2.times {|dx|
    2.times {|dy|
      go(z + 1, x * 2 + dx, y * 2 + dy)
    }
  }
end

[[7, 29, 46], [7, 26, 48], [7, 113, 50]].each {|v| go(*v)}
