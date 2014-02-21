class HomeController < ApplicationController
  def index
    @code = Promo::Promocode.generate
  end
end
