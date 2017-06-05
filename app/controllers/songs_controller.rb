class SongsController < ApplicationController
  before_action :set_song, only: [:show, :edit, :update, :destroy]
  before_action :signed_in_user, only: [:edit,:update,:destroy]


  # GET /songs
  # GET /songs.json
  def index
    @songs = Song.language_fillter(params[:language]).category_fillter(params[:category]).order(:created_at => :desc).paginate(:page =>params[:page], :per_page => 6)
    @languages = Song.distinct.select(:language)
    @category = Song.distinct.select(:category)
    respond_to do |format|
      format.html{ }
      format.js{}
    end
  end

  def select_fillter
    @songs = Song.language_fillter(params[:language]).category_fillter(params[:category]).order(:created_at => :desc).paginate(:page =>params[:page], :per_page => 6)
    respond_to do |format|
      format.html{ }
      format.js{}
    end
  end

  # GET /songs/1
  # GET /songs/1.json
  def show
    @comment = Comment.new
  end

  # GET /songs/new
  def new
    @song = Song.new
  end

  # GET /songs/1/edit
  def edit
  end

  # POST /songs
  # POST /songs.json
  def create
    params[:song][:song_type] = params[:song][:songs].content_type.chomp
    #params[:song][:song]      = "#{current_user.id}"+params[:song][:title]+".mp3"
    params[:song][:song_in]      = params[:song][:songs].read
    #@dir= "app/assets/songs/"+params[:song][:song]
    #File.open(@dir,'wb'){|f|
    #  f.write(params[:song][:songs].read)
    #}
    @song = current_user.songs.build(song_params)
    respond_to do |format|
      if @song.save
        format.html { redirect_to @song, :flash => {:success => 'Song was successfully created.'} }
        format.json { render :show, status: :created, location: @song }
      else
        #File.delete("app/assets/songs/"+params[:song][:song])
        format.html { render :new,:flash => {:danger => 'Song was failed try upload try again.'} }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /songs/1
  # PATCH/PUT /songs/1.json
  def update
    params[:song][:song_type]    = params[:song][:songs].content_type.chomp
    params[:song][:song_in]      = params[:song][:songs].read
    respond_to do |format|
      if @song.update(song_params)
        format.html { redirect_to @song, :flash => {:success => 'Song was successfully updated.'} }
        format.json { render :show, status: :ok, location: @song }
      else
        format.html { render :edit,:flash => {:danger => 'Song was failed to update.'} }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /songs/1
  # DELETE /songs/1.json
  def destroy
    #File.delete("app/assets/songs/"+@song.song)
    @song.destroy
    respond_to do |format|
      format.html { redirect_to songs_url, :flash => {:success => 'Song was successfully destroyed.'} }
      format.json { head :no_content }
    end
  end

  def like
     @song = Song.find(params[:song_id])
     @song.likes.push(current_user.id) if !@song.likes.find_index(current_user.id)
     if @song.update(like_params)
       respond_to do |format|
         format.html {}
         format.js {}
       end
    else
      render text: "Error"
    end
  end

  def unlike
    @song = Song.find(params[:song_id])
    @song.likes.delete(current_user.id) if @song.likes.find_index(current_user.id)
    if @song.update(like_params)
      respond_to do |format|
        format.html {}
        format.js {}
      end
   else
     render text: "Error"
   end
  end

  def song
    @song = Song.find(params[:id])
    send_data(@song.song_in,:type => @song.song_type,:disposition =>'inline')
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_song
      @song = Song.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def song_params
      params.require(:song).permit(:title,:language,:category,:song_in,:song_type)
    end

    def like_params
      params.permit(:likes)
    end
end
