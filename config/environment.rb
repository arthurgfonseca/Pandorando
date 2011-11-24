require 'yaml' 
YAML::ENGINE.yamler= 'syck'
# Load the rails application
require File.expand_path('../application', __FILE__)
# Initialize the rails application
Pandorando::Application.initialize!

# require 'will_paginate'
# WillPaginate::ViewHelpers.pagination_options[:renderer] = 'AjaxWillPaginate'