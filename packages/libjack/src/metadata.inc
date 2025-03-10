(*
  Copyright (C) 2011-2014 David Robillard
  Copyright (C) 2013 Paul Davis

  This program is free software; you can redistribute it and/or modify it
  under the terms of the GNU Lesser General Public License as published by
  the Free Software Foundation; either version 2.1 of the License, or (at
  your option) any later version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public
  License for more details.

  You should have received a copy of the GNU Lesser General Public License
  along with this program; if not, write to the Free Software Foundation,
  Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
*)

(**
 * @file   jack/metadata.h
 * @ingroup publicheader
 * @brief  JACK Metadata API
 *
 *)

{$ifndef __jack_metadata_h__}
{$define __jack_metadata_h__}

//#include <jack/types.h>

//#ifdef __cplusplus
//extern "C" {
//#endif

(**
 * @defgroup Metadata Metadata API.
 * @{
 *)

(**
 * A single property (key:value pair).
 *
 * Although there is no semantics imposed on metadata keys and values, it is
 * much less useful to use it to associate highly structured data with a port
 * (or client), since this then implies the need for some (presumably
 * library-based) code to parse the structure and be able to use it.
 *
 * The real goal of the metadata API is to be able to tag ports (and clients)
 * with small amounts of data that is outside of the core JACK API but
 * nevertheless useful.
 *)
type
  PPjack_property_t = ^Pjack_property_t;
  Pjack_property_t = ^jack_property_t;
  jack_property_t = record
    (** The key of this property (URI string). *)
    key: PChar;

    (** The property value (null-terminated string). *)
    data: PChar;

    (**
     * Type of data, either a MIME type or URI.
     *
     * If type is NULL or empty, the data is assumed to be a UTF-8 encoded
     * string (text/plain). The data is a null-terminated string regardless of
     * type, so values can always be copied, but clients should not try to
     * interpret values of an unknown type.
     *
     * Example values:
     * - image/png;base64 (base64 encoded PNG image)
     * - http://www.w3.org/2001/XMLSchema#int (integer)
     *
     * Official types are preferred, but clients may use any syntactically
     * valid MIME type (which start with a type and slash, like "text/...").
     * If a URI type is used, it must be a complete absolute URI
     * (which start with a scheme and colon, like "http:").
     *)
    _type: PChar;
  end;

(**
 * Set a property on @p subject.
 *
 * See the above documentation for rules about @p subject and @p key.
 * @param subject The subject to set the property on.
 * @param key The key of the property.
 * @param value The value of the property.
 * @param type The type of the property. See the discussion of
 *             types in the definition of jack_property_t above.
 * @return 0 on success.
 *)
function
jack_set_property(client: Pjack_client_t;
                  subject: jack_uuid_t;
                  const key: PChar;
                  const value: PChar;
                  const _type: PChar): cint; cdecl; external libjack;

(**
 * Get a property on @p subject.
 *
 * @param subject The subject to get the property from.
 * @param key The key of the property.
 * @param value Set to the value of the property if found, or NULL otherwise.
 *              The caller must free this value with jack_free().
 * @param type The type of the property if set, or NULL. See the discussion
 *             of types in the definition of jack_property_t above.
 *             If non-null, the caller must free this value with jack_free().
 *
 * @return 0 on success, -1 if the @p subject has no @p key property.
 *)
function
jack_get_property(subject: jack_uuid_t;
                  const key: PChar;
                  value: PPChar;
                  _type: PPChar): cint; cdecl; external libjack;

(**
 * A description of a subject (a set of properties).
 *)
type
  PPjack_description_t = ^Pjack_description_t;
  Pjack_description_t = ^jack_description_t;
  jack_description_t = record
    subject: jack_uuid_t;         (**< Subject being described. *)
    property_cnt: uint32_t;       (**< Number of elements in "properties". *)
    properties: Pjack_property_t; (**< Array of properties. *)
    property_size: uint32_t;      (**< Private, do not use. *)
  end;

(**
 * Free a description.
 *
 * @param desc a jack_description_t whose associated memory will all be released
 * @param free_description_itself if non-zero, then @param desc will also be passed to free()
 *)
procedure
jack_free_description (desc: Pjack_description_t; free_description_itself: cint); cdecl; external libjack;

(**
 * Get a description of @p subject.
 * @param subject The subject to get all properties of.
 * @param desc Set to the description of subject if found, or NULL otherwise.
 *             The caller must free this value with jack_free_description().
 * @return the number of properties, -1 if no @p subject with any properties exists.
 *)
function
jack_get_properties (subject: jack_uuid_t;
                     desc: Pjack_description_t): cint; cdecl; external libjack;

(**
 * Get descriptions for all subjects with metadata.
 * @param descs Set to an array of descriptions.
 *              The caller must free each of these with jack_free_description(),
 *              and the array itself with jack_free().
 * @return the number of descriptions, or -1 on error.
 *)
function
jack_get_all_properties (descs: PPjack_description_t): cint; cdecl; external libjack;

(**
 * Remove a single property on a subject.
 *
 * @param client The JACK client making the request to remove the property.
 * @param subject The subject to remove the property from.
 * @param key The key of the property to be removed.
 *
 * @return 0 on success, -1 otherwise
 *)
function jack_remove_property (client: Pjack_client_t; subject: jack_uuid_t; const key: PChar): cint; cdecl; external libjack;

(**
 * Remove all properties on a subject.
 *
 * @param client The JACK client making the request to remove some properties.
 * @param subject The subject to remove all properties from.
 *
 * @return a count of the number of properties removed, or -1 on error.
 *)
function jack_remove_properties (client: Pjack_client_t; subject: jack_uuid_t): cint; cdecl; external libjack;

(**
 * Remove all properties.
 *
 * WARNING!! This deletes all metadata managed by a running JACK server.
 * Data lost cannot be recovered (though it can be recreated by new calls
 * to jack_set_property()).
 *
 * @param client The JACK client making the request to remove all properties
 *
 * @return 0 on success, -1 otherwise
 *)
function jack_remove_all_properties (client: Pjack_client_t): cint; cdecl; external libjack;

type
  PPjack_property_change_t = ^Pjack_property_change_t;
  Pjack_property_change_t = ^jack_property_change_t;
  jack_property_change_t = (
        PropertyCreated,
        PropertyChanged,
        PropertyDeleted
  );

(**
 * Prototype for the client supplied function that is called by the
 * engine anytime a property or properties have been modified.
 *
 * Note that when the key is empty, it means all properties have been
 * modified. This is often used to indicate that the removal of all keys.
 *
 * @param subject The subject the change relates to, this can be either a client or port
 * @param key The key of the modified property (URI string)
 * @param change Wherever the key has been created, changed or deleted
 * @param arg pointer to a client supplied structure
 *)
type
  TJackPropertyChangeCallback = procedure(subject: jack_uuid_t;
                                          const key: PChar;
                                          change: jack_property_change_t;
                                          arg: Pointer); cdecl;

(**
 * Arrange for @p client to call @p callback whenever a property is created,
 * changed or deleted.
 *
 * @param client the JACK client making the request
 * @param callback the function to be invoked when a property change occurs
 * @param arg the argument to be passed to @param callback when it is invoked
 *
 * @return 0 success, -1 otherwise.
 *)
function jack_set_property_change_callback (client: Pjack_client_t;
                                            callback: TJackPropertyChangeCallback;
                                            arg: Pointer): cint; cdecl; external libjack;

(**
 * A value that identifies what the hardware port is connected to (an external
 * device of some kind). Possible values might be "E-Piano" or "Master 2 Track".
 *)
var
  JACK_METADATA_CONNECTED: PChar; external libjack;

(**
 * The supported event types of an event port.
 *
 * This is a kludge around Jack only supporting MIDI, particularly for OSC.
 * This property is a comma-separated list of event types, currently "MIDI" or
 * "OSC".  If this contains "OSC", the port may carry OSC bundles (first byte
 * '#') or OSC messages (first byte '/').  Note that the "status byte" of both
 * OSC events is not a valid MIDI status byte, so MIDI clients that check the
 * status byte will gracefully ignore OSC messages if the user makes an
 * inappropriate connection.
 *)
  JACK_METADATA_EVENT_TYPES: PChar; external libjack;

(**
 * A value that should be shown when attempting to identify the
 * specific hardware outputs of a client. Typical values might be
 * "ADAT1", "S/PDIF L" or "MADI 43".
 *)
  JACK_METADATA_HARDWARE: PChar; external libjack;

(**
 * A value with a MIME type of "image/png;base64" that is an encoding of an
 * NxN (with 32 < N <= 128) image to be used when displaying a visual
 * representation of that client or port.
 *)
 JACK_METADATA_ICON_LARGE: PChar; external libjack;

(**
 * The name of the icon for the subject (typically client).
 *
 * This is used for looking up icons on the system, possibly with many sizes or
 * themes.  Icons should be searched for according to the freedesktop Icon
 *
 * Theme Specification:
 * https://specifications.freedesktop.org/icon-theme-spec/icon-theme-spec-latest.html
 *)
  JACK_METADATA_ICON_NAME: PChar; external libjack;

(**
 * A value with a MIME type of "image/png;base64" that is an encoding of an
 * NxN (with N <=32) image to be used when displaying a visual representation
 * of that client or port.
 *)
  JACK_METADATA_ICON_SMALL: PChar; external libjack;

(**
 * Order for a port.
 *
 * This is used to specify the best order to show ports in user interfaces.
 * The value MUST be an integer.  There are no other requirements, so there may
 * be gaps in the orders for several ports.  Applications should compare the
 * orders of ports to determine their relative order, but must not assign any
 * other relevance to order values.
 *
 * It is encouraged to use http://www.w3.org/2001/XMLSchema#int as the type.
 *)
  JACK_METADATA_ORDER: PChar; external libjack;

(**
 * A value that should be shown to the user when displaying a port to the user,
 * unless the user has explicitly overridden that a request to show the port
 * name, or some other key value.
 *)
  JACK_METADATA_PRETTY_NAME: PChar; external libjack;

(**
 *)
  JACK_METADATA_PORT_GROUP: PChar; external libjack;

(**
 * The type of an audio signal.
 *
 * This property allows audio ports to be tagged with a "meaning".  The value
 * is a simple string.  Currently, the only type is "CV", for "control voltage"
 * ports.  Hosts SHOULD be take care to not treat CV ports as audibile and send
 * their output directly to speakers.  In particular, CV ports are not
 * necessarily periodic at all and may have very high DC.
 *)
  JACK_METADATA_SIGNAL_TYPE: PChar; external libjack;

///**
// * @}
// */

//#ifdef __cplusplus
//} /* namespace */
//#endif

{$endif  __jack_metadata_h__}
