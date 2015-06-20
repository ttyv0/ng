module PostsHelper
  def format_time(timeobj)
    timeobj.localtime.strftime("%T %d-%m-%y")
  end
end
