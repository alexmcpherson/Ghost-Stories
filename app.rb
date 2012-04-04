require 'sinatra'
require 'open-uri'

get '/' do
	erb :bookmarklet
end

get '/to-pdf/:token/:project_id' do
  uri = URI("http://www.pivotaltracker.com/services/v3/projects/#{params[:project_id]}/stories")
  doc = Nori.parse(open(uri, 'X-TrackerToken' => params[:token]))

  @stories = doc['stories']
  @style = File.read("config/views/style.css")

  path = "output/#{params[:project_id]}.html"
  html = erb :sow
  File.open(path,"w") {|f| f.write(html) }

  `phantomjs pdf.js #{path}`

  headers({'Content-Type' => 'application/pdf',
    'Content-Description' => 'File Transfer',
    'Content-Transfer-Encoding' => 'binary',
    'Content-Disposition' => "attachment;filename=\"#{params[:project_id]}.pdf\"",
    'Expires' => '0',
    'Pragma' => 'public'})
  send_file path.gsub('html', 'pdf')
end