class StaticPagesController < ApplicationController
  include StaticPagesHelper

  def home
    if current_user
      find_trends
    end
  end
end
