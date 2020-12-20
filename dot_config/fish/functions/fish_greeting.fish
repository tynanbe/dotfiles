function fish_greeting -d "what's up, fish?"
  if test ! "fish_launcher" = "$fish_history"
    #set_color $fish_color_autosuggestion
    #uname \
    #  --nodename \
    #  --machine \
    #  --kernel-name \
    #  --kernel-release

    #command --quiet --search uptime
    #and uptime

    #set_color normal

    greeting

    #fish_logo red brred yellow
    #echo -e "\n                      "(fish -v)

  else
    echo
  end
end
