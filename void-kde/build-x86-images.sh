#!/bin/sh

ARCH=x86_64
IMAGE=kde

while getopts "a:b:hr:" opt; do
case $opt in
	a) ARCH="$OPTARG";;
	b) IMAGE="$OPTARG";;
	h) echo "${0#/*}: [-a arch] [-b base|e|xfce|mate|cinnamon|gnome|kde|lxde|lxqt] [-r repo]" >&2; exit 1;;
	r) REPO="-r $OPTARG $REPO";;
esac
done
shift $((OPTIND - 1))

: ${ARCH:=$(uname -m)}

readonly DATE=$(date +%Y%m%d)
readonly BASE_IMG=void-live-${ARCH}-${DATE}.iso
readonly E_IMG=void-live-${ARCH}-${DATE}-enlightenment.iso
readonly XFCE_IMG=void-live-${ARCH}-${DATE}-xfce.iso
readonly MATE_IMG=void-live-${ARCH}-${DATE}-mate.iso
readonly CINNAMON_IMG=void-live-${ARCH}-${DATE}-cinnamon.iso
readonly GNOME_IMG=void-live-${ARCH}-${DATE}-gnome.iso
readonly KDE_IMG=void-live-${ARCH}-${DATE}-kde.iso
readonly LXDE_IMG=void-live-${ARCH}-${DATE}-lxde.iso
readonly LXQT_IMG=void-live-${ARCH}-${DATE}-lxqt.iso

readonly GRUB="grub-i386-efi grub-x86_64-efi"

readonly BASE_PKGS="dialog cryptsetup lvm2 mdadm void-docs-browse $GRUB"
readonly X_PKGS="$BASE_PKGS xorg-minimal xorg-input-drivers xorg-video-drivers setxkbmap xauth font-misc-misc terminus-font dejavu-fonts-ttf alsa-plugins-pulseaudio"
readonly E_PKGS="$X_PKGS lxdm enlightenment terminology udisks2 firefox-esr"
readonly XFCE_PKGS="$X_PKGS lxdm xfce4 gnome-themes-standard gnome-keyring network-manager-applet gvfs-afc gvfs-mtp gvfs-smb udisks2 firefox-esr"
readonly MATE_PKGS="$X_PKGS lxdm mate mate-extra gnome-keyring network-manager-applet gvfs-afc gvfs-mtp gvfs-smb udisks2 firefox-esr"
readonly CINNAMON_PKGS="$X_PKGS lxdm cinnamon gnome-keyring colord gnome-terminal gvfs-afc gvfs-mtp gvfs-smb udisks2 firefox-esr"
readonly GNOME_PKGS="$BASE_PKGS gdm gnome-terminal gnome-screenshot nautilus file-roller eog gnome-music totem polkit-gnome gnome-system-log dbus zramen brightnessctl nano flatpak xorg-minimal mesa-dri xdg-user-dirs xdg-utils xdg-desktop-portal glxinfo bash-completion htop neofetch ffmpeg ffmpegthumbs ufw tlp thermald chrony pulseaudio alsa-plugins-pulseaudio font-adobe-source-code-pro fonts-droid-ttf noto-fonts-emoji liberation-fonts-ttf liberation-fonts-ttf noto-fonts-ttf firefox geany geany-plugins"
readonly KDE_PKGS="$BASE_PKGS kde5 kde5-baseapps ark spectacle sddm dbus zramen brightnessctl nano flatpak xorg-minimal mesa-dri xdg-user-dirs xdg-desktop-portal xdg-utils glxinfo firefox pulseaudio bash-completion htop neofetch noto-fonts-ttf dejavu-fonts-ttf liberation-fonts-ttf noto-fonts-emoji fonts-droid-ttf kdegraphics-thumbnailers ffmpeg ffmpegthumbs gwenview okular mpv alsa-plugins-pulseaudio plasma-browser-integration plasma-firewall ufw font-adobe-source-code-pro tlp thermald geany geany-plugins base-devel xtools chrony firefox-i18n-es-ES"
readonly LXDE_PKGS="$X_PKGS lxdm lxde gvfs-afc gvfs-mtp gvfs-smb udisks2 firefox-esr"
readonly LXQT_PKGS="$X_PKGS lxdm lxqt gvfs-afc gvfs-mtp gvfs-smb udisks2 qupzilla"

[ ! -x mklive.sh ] && exit 0

if [ -z "$IMAGE" -o "$IMAGE" = base ]; then
	if [ ! -e $BASE_IMG ]; then
		./mklive.sh -a $ARCH -o $BASE_IMG -p "$BASE_PKGS" ${REPO} "$@"
	fi
fi
if [ -z "$IMAGE" -o "$IMAGE" = e ]; then
	if [ ! -e $E_IMG ]; then
		./mklive.sh -a $ARCH -o $E_IMG -p "$E_PKGS" ${REPO} "$@"
	fi
fi
if [ -z "$IMAGE" -o "$IMAGE" = xfce ]; then
	if [ ! -e $XFCE_IMG ]; then
		./mklive.sh -a $ARCH -o $XFCE_IMG -p "$XFCE_PKGS" ${REPO} "$@"
	fi
fi
if [ -z "$IMAGE" -o "$IMAGE" = mate ]; then
	if [ ! -e $MATE_IMG ]; then
		./mklive.sh -a $ARCH -o $MATE_IMG -p "$MATE_PKGS" ${REPO} "$@"
	fi
fi
if [ -z "$IMAGE" -o "$IMAGE" = cinnamon ]; then
	if [ ! -e $CINNAMON_IMG ]; then
		./mklive.sh -a $ARCH -o $CINNAMON_IMG -p "$CINNAMON_PKGS" ${REPO} "$@"
	fi
fi

if [ -z "$IMAGE" -o "$IMAGE" = gnome ]; then
	if [ ! -e $GNOME_IMG ]; then
		./mklive.sh -a $ARCH -o $GNOME_IMG -p "$GNOME_PKGS" ${REPO} "$@"
	fi
fi

if [ -z "$IMAGE" -o "$IMAGE" = lxde ]; then
	if [ ! -e $LXDE_IMG ]; then
		./mklive.sh -a $ARCH -o $LXDE_IMG -p "$LXDE_PKGS" ${REPO} "$@"
	fi
fi
if [ -z "$IMAGE" -o "$IMAGE" = lxqt ]; then
	if [ ! -e $LXQT_IMG ]; then
		./mklive.sh -a $ARCH -o $LXQT_IMG -p "$LXQT_PKGS" ${REPO} "$@"
	fi
fi
if [ "$IMAGE" = kde ]; then
	if [ ! -e $KDE_IMG ]; then
		./mklive.sh -a $ARCH -o $KDE_IMG -p "$KDE_PKGS" ${REPO} "$@"
	fi
fi
