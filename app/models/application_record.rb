class ApplicationRecord < ActiveRecord::Base
  include ActiveStorageSupport::SupportForBase64
  self.strict_loading_by_default = true
  self.abstract_class = true
end
