class RequestAccessController < ApplicationController
  before_filter :login_required
end
