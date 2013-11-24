class StaffController < ApplicationController
  layout "staff"

  def index
  	'menu'
  end

  def login
  end

  def menu
  	render('menu')
  end

  def logout
  end
end
