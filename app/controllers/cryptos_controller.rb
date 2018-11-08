class CryptosController < ApplicationController
  before_action :set_crypto, only: [:show, :edit, :update, :destroy]

 def scraper
    conn = ActiveRecord::Base.connection
  tables = ActiveRecord::Base.connection.tables
  tables.each { |t| conn.execute("TRUNCATE #{t}") }
  Rails.application.load_seed
    Scraper.new.perform
    redirect_to index_path
 end

  def index
    @cryptos = Crypto.all
  end


  def search
  @crypto = Crypto.find_by(name: params[:crypto][:name])
  end

  def show
  @crypto = Crypto.find(params[:id])
  end


  def new
    @crypto = Crypto.new
  end


  def destroy
    @crypto.destroy
    respond_to do |format|
      format.html { redirect_to cryptos_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_crypto
      @crypto = Crypto.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def crypto_params
      params.require(:crypto).permit(:name, :price)
    end
end
