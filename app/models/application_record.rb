class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  include RansackerTranslator
  
  ransacker_translate :title, :tags_name, :user_name, :user_nickname
end
