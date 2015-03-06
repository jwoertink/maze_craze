# Load all additional extensions

Dir['config/extensions/*.rb'].each do |extension|
  require extension
end
