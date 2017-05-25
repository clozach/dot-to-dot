function toggle_vi_in_fish --description 'For visitors, who may be tripped up by vi bindings.'
  if [ $fish_key_bindings = "fish_vi_key_bindings" ]
    echo "vi-mode off"
    fish_default_key_bindings
  else
    echo "vi-mode on"
    fish_vi_key_bindings
  end
end
