{ -*- mode: C; c-file-style: "gnu" -*- }
{ dbus-address.h  Server address parser.
 *
 * Copyright (C) 2003  CodeFactory AB
 *
 * Licensed under the Academic Free License version 2.1
 * 
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
 * MA 02110-1301, USA
 *
 }

//#include <dbus/dbus-types.h>
//#include <dbus/dbus-errors.h>

type

  DBusAddressEntry = record end;

  PDBusAddressEntry = ^DBusAddressEntry;

  PPDBusAddressEntry = ^PDBusAddressEntry;

  PPPDBusAddressEntry = ^PPDBusAddressEntry;

function dbus_parse_address(const address: PAnsiChar; entry: PPPDBusAddressEntry;
 array_len: PInteger; error: PDBusError): dbus_bool_t; cdecl; external LibDBus;
function dbus_address_entry_get_value(entry: PDBusAddressEntry; const key: PAnsiChar): PAnsiChar; cdecl; external LibDBus;
function dbus_address_entry_get_method(entry: PDBusAddressEntry): PAnsiChar; cdecl; external LibDBus;
procedure dbus_address_entries_free(entries: PPDBusAddressEntry); cdecl; external LibDBus;

function dbus_address_escape_value(const value: PAnsiChar): PAnsiChar; cdecl; external LibDBus;
function dbus_address_unescape_value(const value: PAnsiChar; error: PDBusError): PAnsiChar; cdecl; external LibDBus;

