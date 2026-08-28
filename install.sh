#!/bin/bash

. scripts/utils.sh
. scripts/prerequisites.sh
. scripts/brew-install-custom.sh
. scripts/osx-defaults.sh
. scripts/symlinks.sh

info "Dotfiles intallation initialized..."
read -p "Install apps? [y/n] " install_apps
read -p "Back up and link conflicting existing dotfiles? [y/n] " backup_dotfiles

if [[ "$install_apps" == "y" ]]; then
    printf "\n"
    info "===================="
    info "Prerequisites"
    info "===================="

    install_xcode
    install_homebrew

    printf "\n"
    info "===================="
    info "Apps"
    info "===================="

    install_custom_formulae
    install_custom_casks
    run_brew_bundle
fi

printf "\n"
info "===================="
info "OSX System Defaults"
info "===================="

register_keyboard_shortcuts
apply_osx_system_defaults

printf "\n"
info "===================="
info "Terminal"
info "===================="

info "Adding .hushlogin file to suppress 'last login' message in terminal..."
touch ~/.hushlogin

printf "\n"
info "===================="
info "Symbolic Links"
info "===================="

if [[ "$backup_dotfiles" == "y" ]]; then
    ./scripts/link-config --apply --backup-existing
else
    ./scripts/link-config --apply
fi

git config --local core.hooksPath .githooks

if [[ -d /Applications/Rectangle.app ]]; then
    ./scripts/configure-rectangle
fi

success "Dotfiles set up successfully."
