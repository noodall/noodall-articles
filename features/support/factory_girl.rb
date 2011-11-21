require 'factory_girl'
require 'fakerama'
FactoryGirl.definition_file_paths = [
  File.expand_path(File.dirname(__FILE__) + '/../../factories')
]
FactoryGirl.find_definitions
