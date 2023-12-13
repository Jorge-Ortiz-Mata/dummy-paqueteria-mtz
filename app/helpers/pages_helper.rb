module PagesHelper
  def style_to_sidebar_link(path)
    if current_page?(path)
      'rounded p-3 flex gap-2 items-center text-blue-600 font-bold duration-300 bg-gray-200 w-full'
    else
      'rounded p-3 flex gap-2 items-center text-sidebarTextColor font-bold duration-300 hover:text-blue-500 w-full'
    end
  end
end
