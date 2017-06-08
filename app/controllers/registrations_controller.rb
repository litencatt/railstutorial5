class RegistrationsController < ApplicationController
  def new
    @domains = %w(a.jp b.jp c.or.jp d.asia)
  end

  def create
    binding.pry
  end
#  def next
#    need_registrations.each do |domain|
#      if domain.domain_name == params[:domain_name]
#
#      end
#    end
#  end
#
#  def prev
#  end
  private

  def create_params
    params.require(:gjp, :ojp, :cojp)
  end
end
