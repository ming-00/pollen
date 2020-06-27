module ApplicationHelper
  def full_title(page_title = '')
      base_title = "Pollen - Plant a Wish"
      if page_title.empty?
        base_title
      else
        page_title + " | " + base_title
      end
    end

    def flash_class(level)
      case level
        when 'notice' then "alert alert-info"
        when 'success' then "alert alert-success"
        when 'danger' then "alert alert-danger"
        when 'error' then "alert alert-danger"
        when 'alert' then "alert alert-warning"
      end
    end
  end
