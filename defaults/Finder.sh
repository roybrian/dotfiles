#!/bin/sh

sidebar() {
	# https://stackoverflow.com/questions/4852516/add-item-to-finder-sidebar
	# https://stackoverflow.com/questions/26475008/swift-getting-a-mac-app-to-launch-on-startup
	# https://github.com/mosen/mysides/blob/master/src/main.m

	d="$HOME/Library/Application Support/com.roeybiran.dotfiles"
	o="$d/sidebartool"

	if [ ! -f "$o" ]; then
		mkdir -p "$d" 2>/dev/null
		f="$(mktemp)"
		printf "%s\n" '
	#import <Foundation/Foundation.h>

	int main(int argc, const char * argv[]) {
		@autoreleasepool {
			NSString * itemPath = [@"~" stringByExpandingTildeInPath];
			NSURL * itemURL = [NSURL fileURLWithPath:itemPath];
			LSSharedFileListRef list = LSSharedFileListCreate(NULL, kLSSharedFileListFavoriteItems, NULL);

			if (!list) {
				return 0;
			}

			LSSharedFileListItemRef item = LSSharedFileListInsertItemURL(list, kLSSharedFileListItemLast, NULL, NULL, (__bridge CFURLRef)itemURL, NULL, NULL);
			if (item) {
				CFRelease(item);
			};
		}
		return 0;
	}
	' >"$f"

		mv -f "$f" "$f.m" && f="$f.m"

		clang -framework CoreServices -framework Foundation -Wno-deprecated "$f" -o "$o"
		chmod +x "$o"
	fi

	"$o"
}

sidebar

# Show the ~/Library folder
sudo xattr -d com.apple.FinderInfo ~/Library 2>/dev/null
sudo chflags nohidden ~/Library
# Show the /Volumes folder
sudo chflags nohidden /Volumes

# Enable spring loading for directories
defaults write -g com.apple.springing.enabled -bool true
# Remove the spring loading delay for directories
defaults write -g com.apple.springing.delay -float 0
# Disable disk image verification
defaults write com.apple.frameworks.diskimages skip-verify -bool true
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true
# Automatically open a new Finder window when a volume is mounted
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

# Finder Preferences (⌘+,)
# dont show hard disks on desktop
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
# dont show external disks on desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool false
# dont show cds, dvds, and ipods on desktop
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool false
# new finder windows show ~/Desktop
defaults write com.apple.finder NewWindowTarget -string PfDe
defaults write com.apple.finder NewWindowTargetPath -string "file://$HOME/Desktop/"
# show all filename extensions
defaults write -g AppleShowAllExtensions -bool true
# dont show warning before changing an extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
# dont show warning before removing from iCloud Drive
defaults write com.apple.finder FXEnableRemoveFromICloudDriveWarning -bool false
# remove old trash items
defaults write com.apple.finder FXRemoveOldTrashItems -bool true
# keep folders on top in windows when sorting by name and on the desktop
defaults write com.apple.finder _FXSortFoldersFirst -bool true
defaults write com.apple.finder _FXSortFoldersFirstOnDesktop -bool true
# when performing a search, search the current folder
defaults write com.apple.finder FXDefaultSearchScope -string SCcf

# General/Misc settings
# Always ‘Show More‘ in the preview pane
defaults write com.apple.finder PreviewPaneInfoExpanded -bool true
# Remove Remote Disc
sudo defaults write /Library/Preferences/com.apple.NetworkBrowser EnableODiskBrowsing -bool false

# Menu Bar Settings
# view > ✓ show path bar
defaults write com.apple.finder ShowPathbar -bool true
# view > ✓ show status bar
defaults write com.apple.finder ShowStatusBar -bool true
# view > ✓ show preview
defaults write com.apple.finder ShowPreviewPane -bool true

# View settings (⌘+J), Big Sur+
# Sort by Kind in all Finder windows by default
defaults write com.apple.finder FXArrangeGroupViewBy -string Kind
# Group by ‘None‘, so folder disclosure arrows are visible
defaults write com.apple.finder FXPreferredGroupBy -string None
# Use list view in all Finder windows by default
defaults write com.apple.finder FXPreferredViewStyle -string Nlsv
# Use List View in Search
defaults write com.apple.finder FXPreferredSearchViewStyle -string Nlsv
# Recents: Use List View
defaults write com.apple.finder SearchRecentsSavedViewStyle -string Nlsv
# Recents: Sort by Date Last Opened
defaults write com.apple.finder RecentsArrangeGroupViewBy -string "Date Last Opened"

#************************************************#
# FinderKit - Open/Save Dialogs                  #
#************************************************#
# Show the Sidebar
defaults write com.apple.finder FK_AppCentricShowSidebar -bool true
# Group by ‘None‘, so folder disclosure arrows are visible
defaults write com.apple.finder FK_ArrangeBy -string None
defaults write com.apple.finder FK_RecentsArrangeBy -string None
defaults write com.apple.finder FK_SearchArrangeBy -string None
# Column View for file open dialogs
defaults write -g NSNavPanelFileLastListModeForOpenModeKey -int 1
defaults write -g NSNavPanelFileListModeForOpenMode2 -int 1
defaults write -g NavPanelFileListModeForOpenMode -int 1
# Column View for file save dialogs
defaults write -g NSNavPanelFileLastListModeForSaveModeKey -int 1
defaults write -g NSNavPanelFileListModeForSaveMode2 -int 1
defaults write -g NavPanelFileListModeForSaveMode -int 1
# Expand save panel by default
defaults write -g NSNavPanelExpandedStateForSaveMode -bool true
defaults write -g NSNavPanelExpandedStateForSaveMode2 -bool true

#################
# View Settings #
#################

extended_list_view_settings() {
	sort_column="${1:-kind}"
	icloud_column_visible="${2:-0}"
	date_last_opened_column_visible="${3:-0}"
	# calculateAllSizes=
	printf "%s\n" "
	calculateAllSizes = 1;
		columns = (
			{ ascending = 1; identifier = name; visible = 1; width = 300; },
			{ ascending = 0; identifier = ubiquity; visible = $icloud_column_visible; width = 35; },
			{ ascending = 0; identifier = dateModified; visible = 1; width = 181; },
			{ ascending = 0; identifier = dateCreated; visible = 0; width = 181; },
			{ ascending = 0; identifier = size; visible = 1; width = 97; },
			{ ascending = 1; identifier = kind; visible = 1; width = 115; },
			{ ascending = 1; identifier = label; visible = 1; width = 100; },
			{ ascending = 1; identifier = version; visible = 0; width = 75; },
			{ ascending = 1; identifier = comments; visible = 0; width = 300; },
			{ ascending = 0; identifier = dateLastOpened; visible = $date_last_opened_column_visible; width = 200; },
			{ ascending = 0; identifier = dateAdded; visible = 1; width = 181; },
			{ ascending = 0; identifier = shareOwner; visible = 0; width = 210; },
			{ ascending = 0; identifier = shareLastEditor; visible = 0; width = 210; },
			{ ascending = 0; identifier = invitationStatus; visible = 0; width = 210; }
		);
		iconSize = 16;
		showIconPreview = 1;
		sortColumn = $sort_column;
		textSize = 13;
		useRelativeDates = 1;
		viewOptionsVersion = 1;"
}

gallery_view_settings() {
	arrange_by="${1:-6}"
	printf "%s\n" "
	GalleryViewSettings = {
		arrangeBy = $arrange_by;
		iconSize = 48;
		showIconPreview = 1;
		viewOptionsVersion = 1;
	};"
}

icon_view_settings() {
	arrange_by="${1:-kind}"
	printf "%s\n" "
	arrangeBy = $arrange_by;
	backgroundColorBlue = 1;
	backgroundColorGreen = 1;
	backgroundColorRed = 1;
	backgroundType = 0;
	gridOffsetX = 0;
	gridOffsetY = 0;
	gridSpacing = 54;
	iconSize = 64;
	labelOnBottom = 1;
	showIconPreview = 1;
	showItemInfo = 0;
	textSize = 12;
	viewOptionsVersion = 1;"
}

list_view_settings() {
	sort_column="${1:-kind}"
	printf "%s\n" "
	ListViewSettings = {
		calculateAllSizes = 1;
		columns = {
			comments = { ascending = 1; index = 7; visible = 0; width = 300; };
			dateCreated = { ascending = 0; index = 2; visible = 0; width = 181; };
			dateLastOpened = { ascending = 0; index = 8; visible = 0; width = 200; };
			dateModified = { ascending = 0; index = 1; visible = 1; width = 181; };
			kind = { ascending = 1; index = 4; visible = 1; width = 115; };
			label = { ascending = 1; index = 5; visible = 1; width = 100; };
			name = { ascending = 1; index = 0; visible = 1; width = 300; };
			size = { ascending = 0; index = 3; visible = 1; width = 97; };
			version = { ascending = 1; index = 6; visible = 0; width = 75; };
		};
		iconSize = 16;
		showIconPreview = 1;
		sortColumn = $sort_column;
		textSize = 13;
		useRelativeDates = 1;
		viewOptionsVersion = 1;
	};"
}

column_view_options() {
	arrange_by="${1:-kipl}"
	printf "%s\n" "
	ColumnViewOptions = {
		ArrangeBy = $arrange_by;
		ColumnShowFolderArrow = 1;
		ColumnShowIcons = 1;
		ColumnWidth = 245;
		FontSize = 13;
		PreviewDisclosureState = 1;
		SharedArrangeBy = $arrange_by;
		ShowIconThumbnails = 1;
		ShowPreview = 1;
	};"
}

gallery_view_options() {
	printf "%s\n" "
	GalleryViewOptions = {
    ShowPreviewPane = 1;
    ShowTitles = 1;
	};"
}

# columns view + gallery view (they're global)
defaults write com.apple.finder StandardViewOptions "{
	$(column_view_options)
	$(gallery_view_options)
}"

for container in StandardViewSettings ComputerViewSettings DesktopViewSettings; do
	defaults write com.apple.finder "$container" "{
	ExtendedListViewSettingsV2 = { $(extended_list_view_settings) };
	$(gallery_view_settings)
	IconViewSettings = { $(icon_view_settings) };
	$(list_view_settings)
}"
done

defaults write com.apple.finder StandardViewSettings -dict-add SettingsType -string StandardViewSettings

# Search + Trash: arrange by date added in all views
for container in SearchViewSettings TrashViewSettings; do
	defaults write com.apple.finder "$container" "{
		ExtendedListViewSettingsV2 = { $(extended_list_view_settings dateAdded) };
		$(gallery_view_settings 4)
		IconViewSettings = { $(icon_view_settings dateAdded) };
		$(list_view_settings name)
	}"
done

# icloud: show the ‘icloud status‘ column
defaults write com.apple.finder ICloudViewSettings "{
	ExtendedListViewSettingsV2 = { $(extended_list_view_settings kind 1) };
	$(gallery_view_settings)
	IconViewSettings = { $(icon_view_settings) };
	$(list_view_settings)
}"

# recents: restore the date last opened column and sort by date last opened in all views
defaults write com.apple.finder SearchRecentsViewSettings "{
	ExtendedListViewSettingsV2 = { $(extended_list_view_settings dateLastOpened 0 1) };
	$(gallery_view_settings 3)
	IconViewSettings = { $(icon_view_settings dateLastOpened) };
	$(list_view_settings dateLastOpened)
}"

# open/save dialogs column view (ludt = date last oepened)
defaults write com.apple.finder FK_StandardViewOptions2 "{ $(column_view_options ludt) }"
# open/save dialogs icon view
defaults write com.apple.finder FK_DefaultIconViewSettings "{ $(icon_view_settings dateModified) }"
# open/save dialogs list view
defaults write com.apple.finder FK_DefaultListViewSettingsV2 "{ $(extended_list_view_settings dateLastOpened 0 1) }"
