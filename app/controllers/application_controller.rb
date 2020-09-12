class ApplicationController < ActionController::Base

  before_action :set_current_user
  before_action :authenticate_user!
  before_action :set_search
  include RansackerTranslator::FormatRansackParameters
  before_action :format_ransack_params
  
  
  def set_current_user
    @current_user = User.find_by(id: session[:user_id])
  end
  
  # authenticate_userメソッドを定義してください
  def authenticate_user
    if @current_user == nil
      flash[:notice] = "ログインが必要です"
      redirect_to("/pages/index")
      end
  end


  public function storeIcon(Request $request)
    {
            $file=$params['photo'];

            // s3のuploadsファイルに追加
            $path = Storage::disk('s3')->put('/icon_images',$file, 'public');

            // パスを、ユーザのicon_image_urlというカラムに保存
            $user=\Auth::user();
            $user->icon_image_url = $path;
            $user->save();

            return view('setting.channel');
    }


  def after_sign_in_path_for(resource)
    user_path(resource.id)
  end

  def set_search
    if params[:q].present?
    keywords = params[:q][:title_or_tags_name_or_user_name_or_user_nickname_cont].split(/[\p{blank}\s]+/)

    @search = Post.ransack(
      combinator: 'and',
      groupings: { 'a' => {title_or_tags_name_or_user_name_or_user_nickname_cont: keywords[0]}, 'b' => {title_or_tags_name_or_user_name_or_user_nickname_cont: keywords[1]}}
      )
    @search_posts = @search.result(distinct: true).order(created_at: "DESC").page(params[:page]).per(20) 

  else

    groupings = [] 
      @search = Post.ransack(
      combinator: 'and',
      groupings: groupings
     )
     @search_posts = @search.result(distinct: true).order(created_at: "DESC").page(params[:page]).per(20) 

  end

  end
end