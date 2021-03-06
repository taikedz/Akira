/*
* Copyright (c) 2018 Alecaddd (http://alecaddd.com)
*
* This program is free software; you can redistribute it and/or
* modify it under the terms of the GNU General Public
* License as published by the Free Software Foundation; either
* version 2 of the License, or (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
* General Public License for more details.
*
* You should have received a copy of the GNU General Public
* License along with this program; if not, write to the
* Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
* Boston, MA 02110-1301 USA
*
* Authored by: Alessandro "Alecaddd" Castellani <castellani.ale@gmail.com>
*/

public class Akira.Layouts.HeaderBar : Gtk.HeaderBar {
	public weak Akira.Window window { get; construct; }

	public Akira.Partials.HeaderBarButton new_document;
	public Akira.Partials.HeaderBarButton save_file;
	public Akira.Partials.HeaderBarButton save_file_as;

	public Akira.Partials.MenuButton menu;
	public Akira.Partials.MenuButton toolset;
	public Akira.Partials.HeaderBarButton preferences;
	public Akira.Partials.HeaderBarButton layout;
	public Akira.Partials.HeaderBarButton grid;
	public Akira.Partials.HeaderBarButton pixel_grid;

	public bool toggled {
		get {
			return visible;
		} set {
			visible = value;
			no_show_all = !value;
		}
	}

	public HeaderBar (Akira.Window main_window) {
		Object (
			toggled: true,
			window: main_window
		);
	}

	construct {
		set_title (APP_NAME);
		set_show_close_button (true);
		get_style_context ().add_class ("default-decoration");

		var menu_items = new Gtk.Menu ();

		var new_window = new Gtk.MenuItem.with_label (_("New Window"));
		new_window.action_name = Akira.Services.ActionManager.ACTION_PREFIX + Akira.Services.ActionManager.ACTION_NEW_WINDOW;
		menu_items.add (new_window);
		menu_items.add (new Gtk.SeparatorMenuItem ());

		var open = new Gtk.MenuItem.with_label (_("Open"));
		open.action_name = Akira.Services.ActionManager.ACTION_PREFIX + Akira.Services.ActionManager.ACTION_OPEN;
		menu_items.add (open);

		var save = new Gtk.MenuItem.with_label (_("Save"));
		save.action_name = Akira.Services.ActionManager.ACTION_PREFIX + Akira.Services.ActionManager.ACTION_SAVE;
		menu_items.add (save);

		var save_as = new Gtk.MenuItem.with_label (_("Save As"));
		save_as.action_name = Akira.Services.ActionManager.ACTION_PREFIX + Akira.Services.ActionManager.ACTION_SAVE_AS;
		menu_items.add (save_as);

		menu_items.add (new Gtk.SeparatorMenuItem ());

		var quit = new Gtk.MenuItem.with_label(_("Quit"));
		quit.action_name = Akira.Services.ActionManager.ACTION_PREFIX + Akira.Services.ActionManager.ACTION_QUIT;
		menu_items.add (quit);

		menu_items.show_all ();

		menu = new Akira.Partials.MenuButton ("document-open", _("Menu"), _("Open Menu"));
		menu.popup = menu_items;

		var tools = new Gtk.Menu ();
		tools.add (new Gtk.MenuItem.with_label(_("Artboard")));
		tools.add (new Gtk.SeparatorMenuItem ());
		tools.add (new Gtk.MenuItem.with_label(_("Vector")));
		tools.add (new Gtk.MenuItem.with_label(_("Pencil")));
		tools.add (new Gtk.MenuItem.with_label(_("Shapes")));
		tools.add (new Gtk.SeparatorMenuItem ());
		tools.add (new Gtk.MenuItem.with_label(_("Text")));
		tools.add (new Gtk.MenuItem.with_label(_("Image")));
		tools.show_all ();

		toolset = new Akira.Partials.MenuButton ("insert-object", _("Insert"), _("Insert a New Object"));
		toolset.popup = tools;

		var application_instance = (Gtk.Application) GLib.Application.get_default ();

		preferences = new Akira.Partials.HeaderBarButton ("system-settings-%s".printf (settings.icon_style), _("Settings"));
		preferences.button.action_name = Akira.Services.ActionManager.ACTION_PREFIX + Akira.Services.ActionManager.ACTION_PREFERENCES;
		preferences.tooltip_markup = Granite.markup_accel_tooltip (
			application_instance.get_accels_for_action (preferences.button.action_name),
			_("Open Settings")
		);

		layout = new Akira.Partials.HeaderBarButton ("layout-panels-%s".printf (settings.icon_style), _("Layout"));
		layout.button.action_name = Akira.Services.ActionManager.ACTION_PREFIX + Akira.Services.ActionManager.ACTION_PRESENTATION;
		layout.tooltip_markup = Granite.markup_accel_tooltip (
			application_instance.get_accels_for_action (layout.button.action_name),
			_("Toggle Layout")
		);

		grid = new Akira.Partials.HeaderBarButton ("layout-grid-%s".printf (settings.icon_style), _("UI Grid"));
		grid.button.action_name = Akira.Services.ActionManager.ACTION_PREFIX + Akira.Services.ActionManager.ACTION_SHOW_UI_GRID;
		grid.tooltip_markup = Granite.markup_accel_tooltip (
			application_instance.get_accels_for_action (grid.button.action_name),
			_("UI Grid")
		);

		pixel_grid = new Akira.Partials.HeaderBarButton ("layout-pixels-%s".printf (settings.icon_style), _("Pixel Grid"));
		pixel_grid.button.action_name = Akira.Services.ActionManager.ACTION_PREFIX + Akira.Services.ActionManager.ACTION_SHOW_PIXEL_GRID;
		pixel_grid.tooltip_markup = Granite.markup_accel_tooltip (
			application_instance.get_accels_for_action (pixel_grid.button.action_name),
			_("Pixel Grid")
		);

		add (menu);
		add (new Gtk.Separator (Gtk.Orientation.VERTICAL));
		add (toolset);
		add (new Gtk.Separator (Gtk.Orientation.VERTICAL));
		pack_end (preferences);
		pack_end (new Gtk.Separator (Gtk.Orientation.VERTICAL));
		pack_end (layout);
		pack_end (grid);
		pack_end (pixel_grid);

		build_signals ();
	}

	private void build_signals () {
		// deal with signals not part of accelerators
	}

	public void button_sensitivity () {
		// dinamically toggle button sensitivity based on document status or actor selected.
	}

	public void update_icons_style () {
		layout.update_image ("layout-panels-%s".printf (settings.icon_style));
		grid.update_image ("layout-grid-%s".printf (settings.icon_style));
		pixel_grid.update_image ("layout-pixels-%s".printf (settings.icon_style));
		preferences.update_image ("system-settings-%s".printf (settings.icon_style));
	}

	public void toggle () {
		toggled = !toggled;
	}
}
