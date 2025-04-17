#!/bin/zsh

echo "Select a Neovim config to install:"
select config in lazyvim nvchad astronvim; do
  case $config in
    lazyvim)
      git clone https://github.com/LazyVim/starter ~/.config/nvim_lazyvim
      break
      ;;
    nvchad)
      git clone https://github.com/NvChad/starter ~/.config/nvim_nvchad
      break
      ;;
    astronvim)
      git clone --depth 1 https://github.com/AstroNvim/template ~/.config/nvim_astronvim
      break
      ;;
    *)
      echo "Invalid selection."
      ;;
  esac
done

