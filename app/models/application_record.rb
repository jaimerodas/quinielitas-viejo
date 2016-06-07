class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def helpers
    ApplicationController.helpers
  end
end
