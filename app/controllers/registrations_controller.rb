class RegistrationsController < ApplicationController
  def new
    @domains = %w(a.jp b.co.jp c.or.jp d.asia)
  end

  def create
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
end
