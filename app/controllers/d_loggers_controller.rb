class DLoggersController < ApplicationController
  # GET /d_loggers
  # GET /d_loggers.json
  def index
    @d_loggers = DLogger.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @d_loggers }
    end
  end

  # GET /d_loggers/1
  # GET /d_loggers/1.json
  def show
    @d_logger = DLogger.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @d_logger }
    end
  end

  # GET /d_loggers/new
  # GET /d_loggers/new.json
  def new
    @d_logger = DLogger.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @d_logger }
    end
  end

  # GET /d_loggers/1/edit
  def edit
    @d_logger = DLogger.find(params[:id])
  end

  # POST /d_loggers
  # POST /d_loggers.json
  def create
    @d_logger = DLogger.new(params[:d_logger])

    respond_to do |format|
      if @d_logger.save
        format.html { redirect_to @d_logger, notice: 'D logger was successfully created.' }
        format.json { render json: @d_logger, status: :created, location: @d_logger }
      else
        format.html { render action: "new" }
        format.json { render json: @d_logger.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /d_loggers/1
  # PUT /d_loggers/1.json
  def update
    @d_logger = DLogger.find(params[:id])

    respond_to do |format|
      if @d_logger.update_attributes(params[:d_logger])
        format.html { redirect_to @d_logger, notice: 'D logger was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @d_logger.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /d_loggers/1
  # DELETE /d_loggers/1.json
  def destroy
    @d_logger = DLogger.find(params[:id])
    @d_logger.destroy

    respond_to do |format|
      format.html { redirect_to d_loggers_url }
      format.json { head :no_content }
    end
  end
end
