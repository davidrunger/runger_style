# frozen_string_literal: true

Dir[File.expand_path('./monkeypatches/**/*.rb', __dir__)].each do |file|
  require file
end
