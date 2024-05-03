create_nvm() {
    if [[ -s "$HOME/.nvm" || -d "$HOME/.nvm" ]];then
        echo -e "you had have nvm"
    else
       read -r -p "Do you decide to install nvm in this computer" dec
       if [[ $dec != "no" && $dec != "N" && $dec != "n" ]];then
           code="curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash"
          if [[ $code == 0 ]];then
              echo "success"
          else
              echo "fail"
          fi
      fi
    fi
}
