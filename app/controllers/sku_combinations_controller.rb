class SkuCombinationsController < ApplicationController
	before_action :authenticate_user!

  def index
  	@sku_combinations = SkuCombination.all
  end

  def show
  end

  def new
  end

  def create
    if params[:upload].content_type=="text/csv"
    	SkuCombinationImport.save_file(params[:upload], params[:sku_no])
      flash[:notice] = 'File was successfully uploaded.' 
      redirect_to sku_combinations_path
    else
      flash[:error]= 'Invalid File was uploaded.' 
      redirect_to sku_combinations_path
    end
  end
end
