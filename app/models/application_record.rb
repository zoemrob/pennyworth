class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def date = created_at.strftime('%F')
end
