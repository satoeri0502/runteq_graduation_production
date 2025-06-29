module MedicinesWizardHelper
  def time_label_jp(key)
    case key
    when "after_wakeup" then "起床"
    when "morning" then "朝"
    when "noon"    then "昼"
    when "evening" then "夕"
    when "before_sleep" then "寝前"
    else key
    end
  end
end
