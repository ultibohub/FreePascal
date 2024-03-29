// included by gt_demo.pas

(* Text Widget
 *
 * The GtkTextView widget displays a GtkTextBuffer. One GtkTextBuffer
 * can be displayed by multiple GtkTextViews. This demo has two views
 * displaying a single buffer, and shows off the widget's text
 * formatting features.
 *
 *)

var
  text_window,
  text_egg_window : PGtkWidget;

procedure easter_egg_callback (button  : PGtkWidget;
                               data    : gpointer); forward; cdecl;

const
  gray50_width  = 2;
  gray50_height = 2;

  gray50_bits: array [0..1] of AnsiChar = (#2, #1);

procedure create_tags (buffer : PGtkTextBuffer);
var
  stipple : PGdkBitmap;

begin
  (* Create a bunch of tags. Note that it's also possible to
   * create tags with gtk_text_tag_new() then add them to the
   * tag table for the buffer, gtk_text_buffer_create_tag() is
   * just a convenience function. Also note that you don't have
   * to give tags a name; pass NULL for the name to create an
   * anonymous tag.
   *
   * In any real app, another useful optimization would be to create
   * a GtkTextTagTable in advance, and reuse the same tag table for
   * all the buffers with the same tag set, instead of creating
   * new copies of the same tags for every buffer.
   *
   * Tags are assigned default priorities in order of addition to the
   * tag table.  That is, tags created later that affect the same text
   * property affected by an earlier tag will override the earlier
   * tag.  You can modify tag priorities with
   * gtk_text_tag_set_priority().
   *)

  gtk_text_buffer_create_tag (buffer, 'heading',
                              'weight', [ PANGO_WEIGHT_BOLD,
                              'size', 15 * PANGO_SCALE,
                              NULL] );

  gtk_text_buffer_create_tag (buffer, 'italic',
                              'style', [PANGO_STYLE_ITALIC, NULL]);

  gtk_text_buffer_create_tag (buffer, 'bold',
                              'weight', [ PANGO_WEIGHT_BOLD, NULL] );

  gtk_text_buffer_create_tag (buffer, 'big',
                              (* points times the PANGO_SCALE factor *)
                              'size', [ 20 * PANGO_SCALE, NULL] );

  gtk_text_buffer_create_tag (buffer, 'xx-small',
                              'scale',[ PANGO_SCALE_XX_SMALL, NULL] );

  gtk_text_buffer_create_tag (buffer, 'x-large',
                              'scale', [ PANGO_SCALE_X_LARGE, NULL] );

  gtk_text_buffer_create_tag (buffer, 'monospace',
                              'family', [ 'monospace', NULL]);

  gtk_text_buffer_create_tag (buffer, 'blue_foreground',
                              'foreground', [ 'blue', NULL] );

  gtk_text_buffer_create_tag (buffer, 'red_background',
                              'background', [ 'red', NULL] );

  stipple := gdk_bitmap_create_from_data (NULL,
                                         gray50_bits, gray50_width,
                                         gray50_height);

  gtk_text_buffer_create_tag (buffer, 'background_stipple',
                              'background_stipple',[  stipple, NULL] );

  gtk_text_buffer_create_tag (buffer, 'foreground_stipple',
                              'foreground_stipple', [stipple, NULL]);

  g_object_unref (pGObject(stipple));

  gtk_text_buffer_create_tag (buffer, 'big_gap_before_line',
                              'pixels_above_lines', [30, NULL]);

  gtk_text_buffer_create_tag (buffer, 'big_gap_after_line',
                              'pixels_below_lines', [30, NULL]);

  gtk_text_buffer_create_tag (buffer, 'double_spaced_line',
                              'pixels_inside_wrap', [10, NULL]);

  gtk_text_buffer_create_tag (buffer, 'not_editable',
                              'editable', [FALSE, NULL]);

  gtk_text_buffer_create_tag (buffer, 'word_wrap',
                              'wrap_mode', [GTK_WRAP_WORD, NULL]);

  gtk_text_buffer_create_tag (buffer, 'char_wrap',
                              'wrap_mode', [GTK_WRAP_CHAR, NULL]);

  gtk_text_buffer_create_tag (buffer, 'no_wrap',
                              'wrap_mode', [GTK_WRAP_NONE, NULL]);

  gtk_text_buffer_create_tag (buffer, 'center',
                              'justification', [GTK_JUSTIFY_CENTER, NULL]);

  gtk_text_buffer_create_tag (buffer, 'right_justify',
                              'justification', [GTK_JUSTIFY_RIGHT, NULL]);

  gtk_text_buffer_create_tag (buffer, 'wide_margins',
                              'left_margin', [50, 'right_margin', 50,
                              NULL]);

  gtk_text_buffer_create_tag (buffer, 'strikethrough',
                              'strikethrough', [TRUE, NULL]);

  gtk_text_buffer_create_tag (buffer, 'underline',
                              'underline', [PANGO_UNDERLINE_SINGLE, NULL]);

  gtk_text_buffer_create_tag (buffer, 'double_underline',
                              'underline', [PANGO_UNDERLINE_DOUBLE, NULL]);

  gtk_text_buffer_create_tag (buffer, 'superscript',
                              'rise', [10 * PANGO_SCALE,          (* 10 pixels *)
                              'size',   8 * PANGO_SCALE,          (* 8 points *)
                              NULL]);

  gtk_text_buffer_create_tag (buffer, 'subscript',
                              'rise', [-10 * PANGO_SCALE,   (* 10 pixels *)
                              'size',    8 * PANGO_SCALE,   (* 8 points *)
                              NULL]);

  gtk_text_buffer_create_tag (buffer, 'rtl_quote',
                              'wrap_mode', [ GTK_WRAP_WORD,
                              'direction',   GTK_TEXT_DIR_RTL,
                              'indent', 30,
                              'left_margin', 20,
                              'right_margin', 20,
                              NULL]);
end;

procedure insert_text (buffer : PGtkTextBuffer);
var
  iter,
  text_start,
  text_end     : TGtkTextIter;
  pixbuf,
  scaled       : PGdkPixbuf;
  filename     : PAnsiChar;

begin
  (* demo_find_file() looks in the the current directory first,
   * so you can run gtk-demo without installing GTK, then looks
   * in the location where the file is installed.
   *)
  pixbuf := NULL;
  filename := demo_find_file ('gtk-logo-rgb.gif', NULL);

  if filename <> NULL then
    begin
      pixbuf := gdk_pixbuf_new_from_file (filename, NULL);
      g_free (filename);
    end;

  if pixbuf = NULL then
  begin
    g_error ('Failed to load image file gtk-logo-rgb.gif'#13#10);
    exit;
  end;

  scaled := gdk_pixbuf_scale_simple (pixbuf, 32, 32, GDK_INTERP_BILINEAR);
  g_object_unref (pGObject(pixbuf));
  pixbuf := scaled;

  (* get start of buffer; each insertion will revalidate the
   * iterator to point to just after the inserted text.
   *)
  gtk_text_buffer_get_iter_at_offset (buffer, @iter, 0);

  gtk_text_buffer_insert (buffer, @iter,
      'The text widget can display text with all kinds of nifty attributes. '
    + 'It also supports multiple views of the same buffer; '
    + 'this demo is showing the same buffer in two places.'#13#10#13#10, -1);

  gtk_text_buffer_insert_with_tags_by_name (buffer, @iter, 'Font styles. ', -1,
                                            'heading');

  gtk_text_buffer_insert (buffer, @iter, 'For example, you can have ', -1);

  gtk_text_buffer_insert_with_tags_by_name (buffer, @iter,
                                            'italic', -1,
                                            'italic');     // test: left out last argument " NULL "
  gtk_text_buffer_insert (buffer, @iter, ', ', -1);
  gtk_text_buffer_insert_with_tags_by_name (buffer, @iter,
                                            'bold', -1,
                                            'bold');
  gtk_text_buffer_insert (buffer, @iter, ', or ', -1);
  gtk_text_buffer_insert_with_tags_by_name (buffer, @iter,
                                            'monospace (typewriter)', -1,
                                            'monospace');
  gtk_text_buffer_insert (buffer, @iter, ', or ', -1);
  gtk_text_buffer_insert_with_tags_by_name (buffer, @iter,
                                            'big', -1,
                                            'big');
  gtk_text_buffer_insert (buffer, @iter, ' text. ', -1);
  gtk_text_buffer_insert (buffer, @iter,
      'It''s best not to hardcode specific text sizes; '
    + 'you can use relative sizes as with CSS, such as ', -1);

  gtk_text_buffer_insert_with_tags_by_name (buffer, @iter,
                                            'xx-small', -1,
                                            'xx-small');
  gtk_text_buffer_insert (buffer, @iter, ' or ', -1);
  gtk_text_buffer_insert_with_tags_by_name (buffer, @iter,
                                            'x-large', -1,
                                            'x-large');
  gtk_text_buffer_insert (buffer, @iter,
      ' to ensure that your program properly adapts if the user '
    + ' changes the default font size.'#13#10#13#10, -1);

  gtk_text_buffer_insert_with_tags_by_name (buffer, @iter, 'Colors. ', -1,
                                            'heading');

  gtk_text_buffer_insert (buffer, @iter, 'Colors such as ', -1);
  gtk_text_buffer_insert_with_tags_by_name (buffer, @iter,
                                            'a blue foreground', -1,
                                            'blue_foreground');
  gtk_text_buffer_insert (buffer, @iter, ' or ', -1);
  gtk_text_buffer_insert_with_tags_by_name (buffer, @iter,
                                            'a red background', -1,
                                            'red_background');
  gtk_text_buffer_insert (buffer, @iter, ' or even ', -1);
  gtk_text_buffer_insert_with_tags_by_name (buffer, @iter,
                                            'a stippled red background', -1,
                                            'red_background',
                                            ['background_stipple',
                                            NULL]);

  gtk_text_buffer_insert (buffer, @iter, ' or ', -1);
  gtk_text_buffer_insert_with_tags_by_name (buffer, @iter,
                                            'a stippled blue foreground on solid red background', -1,
                                            'blue_foreground',
                       ['red_background',
                                            'foreground_stipple',
                                            NULL]);
  gtk_text_buffer_insert (buffer, @iter, ' (select that to read it) can be used.'#13#10#13#10, -1);

  gtk_text_buffer_insert_with_tags_by_name (buffer, @iter, 'Underline, strikethrough, and rise. ', -1,
                                            'heading');

  gtk_text_buffer_insert_with_tags_by_name (buffer, @iter,
                                            'Strikethrough', -1,
                                            'strikethrough');
  gtk_text_buffer_insert (buffer, @iter, ', ', -1);
  gtk_text_buffer_insert_with_tags_by_name (buffer, @iter,
                                            'underline', -1,
                                            'underline');
  gtk_text_buffer_insert (buffer, @iter, ', ', -1);
  gtk_text_buffer_insert_with_tags_by_name (buffer, @iter,
                                            'double underline', -1,
                                            'double_underline');
  gtk_text_buffer_insert (buffer, @iter, ', ', -1);
  gtk_text_buffer_insert_with_tags_by_name (buffer, @iter,
                                            'superscript', -1,
                                            'superscript');
  gtk_text_buffer_insert (buffer, @iter, ', and ', -1);
  gtk_text_buffer_insert_with_tags_by_name (buffer, @iter,
                                            'subscript', -1,
                                            'subscript');
  gtk_text_buffer_insert (buffer, @iter, ' are all supported.'#13#10#13#10, -1);

  gtk_text_buffer_insert_with_tags_by_name (buffer, @iter, 'Images. ', -1,
                                            'heading');

  gtk_text_buffer_insert (buffer, @iter, 'The buffer can have images in it: ', -1);
  gtk_text_buffer_insert_pixbuf (buffer, @iter, pixbuf);
  gtk_text_buffer_insert_pixbuf (buffer, @iter, pixbuf);
  gtk_text_buffer_insert_pixbuf (buffer, @iter, pixbuf);
  gtk_text_buffer_insert (buffer, @iter, ' for example.'#13#10, -1);

  gtk_text_buffer_insert_with_tags_by_name (buffer, @iter, 'Spacing. ', -1,
                                            'heading', [NULL]);

  gtk_text_buffer_insert (buffer, @iter, 'You can adjust the amount of space before each line.'#13#10, -1);

  gtk_text_buffer_insert_with_tags_by_name (buffer, @iter,
                                            'This line has a whole lot of space before it.'#13#10, -1,
                                            'big_gap_before_line', ['wide_margins', NULL]);
  gtk_text_buffer_insert_with_tags_by_name (buffer, @iter,
                                            'You can also adjust the amount of space after each line; '
                      + 'this line has a whole lot of space after it.'#13#10, -1,
                                            'big_gap_after_line', ['wide_margins', NULL]);

  gtk_text_buffer_insert_with_tags_by_name (buffer, @iter,
                                            'You can also adjust the amount of space between wrapped lines; '
                      + 'this line has extra space between each wrapped line in the same paragraph. '
                      + 'To show off wrapping, some filler text: the quick brown fox jumped over '
                      + 'the lazy dog. Blah blah blah blah blah blah blah blah blah.'#13#10, -1,
                                            'double_spaced_line', ['wide_margins', NULL]);

  gtk_text_buffer_insert (buffer, @iter, 'Also note that those lines have extra-wide margins.'#13#10#13#10, -1);

  gtk_text_buffer_insert_with_tags_by_name (buffer, @iter, 'Editability. ', -1,
                                            'heading', [NULL]);

  gtk_text_buffer_insert_with_tags_by_name (buffer, @iter,
                                            'This line is ''locked down'' and can''t be edited by the user - '
                      + 'just try it! You can''t delete this line.'#13#10#13#10, -1,
                                            'not_editable', [NULL]);

  gtk_text_buffer_insert_with_tags_by_name (buffer, @iter, 'Wrapping. ', -1,
                                            'heading', [NULL]);

  gtk_text_buffer_insert (buffer, @iter,
                          'This line (and most of the others in this buffer) is word-wrapped, '
            + 'using the proper Unicode algorithm. Word wrap should work in all '
            + 'scripts and languages that GTK+ supports. Let''s make this a long '
            + 'paragraph to demonstrate: blah blah blah blah blah blah blah blah '
            + 'blah blah blah blah blah blah blah blah blah blah blah'#13#10#13#10, -1);

  gtk_text_buffer_insert_with_tags_by_name (buffer, @iter,
              'This line has character-based wrapping, and can wrap between '
            + 'any two character glyphs. Let''s make this a long paragraph to '
            + 'demonstrate: blah blah blah blah blah blah blah blah blah blah '
            + 'blah blah blah blah blah blah blah blah blah'#13#10#13#10, -1,
                                            'char_wrap', [NULL]);

  gtk_text_buffer_insert_with_tags_by_name (buffer, @iter, PAnsiChar(
              'This line has all wrapping turned off, so it makes the horizontal '
            + 'scrollbar appear.'#13#10#13#10#13#10), -1,
                                            'no_wrap', [NULL]);

  gtk_text_buffer_insert_with_tags_by_name (buffer, @iter, 'Justification. ', -1,
                                            'heading', [NULL]);

  gtk_text_buffer_insert_with_tags_by_name (buffer, @iter,
                                            #13#10'This line has center justification.'#13#10, -1,
                                            'center', [NULL]);

  gtk_text_buffer_insert_with_tags_by_name (buffer, @iter,
                                            'This line has right justification.'#13#10, -1,
                                            'right_justify', [NULL]);

  gtk_text_buffer_insert_with_tags_by_name (buffer, @iter,
                    #13#10'This line has big wide margins. Text text text text text text '
        + 'text text text text text text text text text text text text text text '
        + 'text text text text text text text text text text text text text text '
        + 'text text.'#13#10, -1,'wide_margins', [NULL]);

  gtk_text_buffer_insert_with_tags_by_name (buffer, @iter, 'Internationalization. ', -1,
                                            'heading', [NULL]);

  gtk_text_buffer_insert (buffer, @iter,
                  'You can put all sorts of Unicode text in the buffer.'#13#10#13#10
        + 'German (Deutsch Süd) Grüß Gott'#13#10
        + 'Greek (Ελληνικά) Γειά σας'#13#10
        + 'Hebrew       שלום'#13#10
        + 'Japanese (日本語)'#13#10#13#10
        + 'The widget properly handles bidirectional text, word wrapping, '
        + 'DOS/UNIX/Unicode paragraph separators, grapheme boundaries, '
        + 'and so on using the Pango internationalization framework.'#13#10, -1);

  gtk_text_buffer_insert (buffer, @iter, 'Here''s a word-wrapped quote in a right-to-left language:'#13#10, -1);
  gtk_text_buffer_insert_with_tags_by_name (buffer, @iter,
          'وقد بدأ ثلاث من أكثر المؤسسات تقدما في '
        + 'شبكة اكسيون برامجها كمنظمات لا تسعى للربح، '
        + 'ثم تحولت في السنوات الخمس الماضية إلى مؤسسات '
        + 'مالية منظمة، وباتت جزءا من النظام المالي في '
        + 'بلدانها، ولكنها تتخصص في خدمة قطاع المشروعات الصغيرة. '
        + 'وأحد أكثر هذه المؤسسات نجاحا هو »بانكوسول« '
        + 'في بوليفيا.'#13#10#13#10, -1,
                                                'rtl_quote', [NULL]);

  gtk_text_buffer_insert (buffer, @iter, 'You can put widgets in the buffer: Here''s a button: ', -1);
  gtk_text_buffer_create_child_anchor (buffer, @iter);
  gtk_text_buffer_insert (buffer, @iter, ' and a menu: ', -1);
  gtk_text_buffer_create_child_anchor (buffer, @iter);
  gtk_text_buffer_insert (buffer, @iter, ' and a scale: ', -1);
  gtk_text_buffer_create_child_anchor (buffer, @iter);
  gtk_text_buffer_insert (buffer, @iter, ' and an animation: ', -1);
  gtk_text_buffer_create_child_anchor (buffer, @iter);
  gtk_text_buffer_insert (buffer, @iter, ' finally a text entry: ', -1);
  gtk_text_buffer_create_child_anchor (buffer, @iter);
  gtk_text_buffer_insert (buffer, @iter, '.'#13#10, -1);

  gtk_text_buffer_insert (buffer, @iter,
       #13#10#13#10'This demo doesn''t demonstrate all the GtkTextBuffer features; '
     + 'it leaves out, for example: invisible/hidden text (doesn''t work in GTK 2, but planned), '
     + 'tab stops, application-drawn areas on the sides of the widget for displaying breakpoints and such...', -1);

  (* Apply word_wrap tag to whole buffer *)
  gtk_text_buffer_get_bounds (buffer, @text_start, @text_end);
  gtk_text_buffer_apply_tag_by_name (buffer, 'word_wrap', @text_start, @text_end);

  g_object_unref (pGObject(pixbuf));
end;

function find_anchor (iter : PGtkTextIter): gboolean; cdecl;

begin
  while gtk_text_iter_forward_char (iter) do
  begin
    if gtk_text_iter_get_child_anchor (iter)<> NULL then
      exit (TRUE);
  end;
end;

procedure attach_widgets (text_view : PGtkWidget);
var
  iter       : TGtkTextIter;
  buffer     : PGtkTextBuffer;
  i          : integer;

  anchor     : PGtkTextChildAnchor;
  widget,
  menu,
  menu_item  : PGtkWidget;

  filename   : pgchar;

begin
  buffer := gtk_text_view_get_buffer (pGtkTextView(text_view));

  gtk_text_buffer_get_start_iter (buffer, @iter);

  i := 0;
  while find_anchor (@iter) do
  begin
    anchor := gtk_text_iter_get_child_anchor (@iter);

    case i of
      0: begin
           widget := gtk_button_new_with_label ('Click Me');

           g_signal_connect (pGObject(widget), 'clicked',
                        TGCallback(@easter_egg_callback),
                        NULL);
         end;
      1: begin
           menu := gtk_menu_new ();

           widget := gtk_option_menu_new ();

           menu_item := gtk_menu_item_new_with_label ('Option 1');
           gtk_menu_shell_append (pGtkMenuShell(menu), menu_item);

           menu_item := gtk_menu_item_new_with_label ('Option 2');
           gtk_menu_shell_append (pGtkMenuShell(menu), menu_item);

           menu_item := gtk_menu_item_new_with_label ('Option 3');
           gtk_menu_shell_append (pGtkMenuShell(menu), menu_item);

           gtk_option_menu_set_menu (pGtkOptionMenu(widget), menu);
         end;
      2: begin
           widget := gtk_hscale_new (NULL);
           gtk_range_set_range (pGtkRange(widget), 0, 100);
           gtk_widget_set_size_request (widget, 70, -1);
         end;
      3: begin
               filename := demo_find_file ('floppybuddy.gif', NULL);
               widget := gtk_image_new_from_file (filename);
               g_free (filename);
         end;
      4: begin
          widget := gtk_entry_new ();
         end;
      else begin
          widget := NULL; (* avoids a compiler warning *)
          exit;
         end;
    end; {of case}

    if widget <> NULL then
    begin
      gtk_text_view_add_child_at_anchor (pGtkTextView(text_view), widget, anchor);
      gtk_widget_show_all (widget);
    end;

    inc(i);
  end; {of while}
end;


function do_textview       : PGtkWidget;
var
  vpaned,
  view1,
  view2,
  sw       : PGtkWidget;
  buffer   : PGtkTextBuffer;

begin
  if text_window = NULL then
  begin
    text_window := gtk_window_new (GTK_WINDOW_TOPLEVEL);
    gtk_window_set_default_size (pGtkWindow(text_window), 450, 450);

    g_signal_connect (text_window, 'destroy',
                        TGCallback(@gtk_widget_destroyed), @text_window);

    gtk_window_set_title (pGtkWindow(text_window), 'TextView');
    gtk_container_set_border_width (pGtkContainer(text_window), 0);

    vpaned := gtk_vpaned_new ();
    gtk_container_set_border_width (pGtkContainer(vpaned), 5);
    gtk_container_add (pGtkContainer(text_window), vpaned);

    (* For convenience, we just use the autocreated buffer from
     * the first text view; you could also create the buffer
     * by itself with gtk_text_buffer_new(), then later create
     * a view widget.
     *)
    view1  := gtk_text_view_new ();
    buffer := gtk_text_view_get_buffer (pGtkTextView(view1));
    view2  := gtk_text_view_new_with_buffer (buffer);

    sw := gtk_scrolled_window_new (NULL, NULL);
    gtk_scrolled_window_set_policy (pGtkScrolledWindow(sw),
                      GTK_POLICY_AUTOMATIC,
                                      GTK_POLICY_AUTOMATIC);

    gtk_paned_add1 (pGtkPaned(vpaned), sw);

    gtk_container_add (pGtkContainer(sw), view1);

    sw := gtk_scrolled_window_new (NULL, NULL);
    gtk_scrolled_window_set_policy (pGtkScrolledWindow(sw),
                      GTK_POLICY_AUTOMATIC,
                                      GTK_POLICY_AUTOMATIC);
    gtk_paned_add2 (pGtkPaned(vpaned), sw);

    gtk_container_add (pGtkContainer(sw), view2);

    create_tags (buffer);
    insert_text (buffer);

    attach_widgets (view1);
    attach_widgets (view2);

    gtk_widget_show_all (vpaned);
  end;

  if not GTK_WIDGET_VISIBLE (text_window) then
    gtk_widget_show (text_window)
  else begin
    gtk_widget_destroy (text_window);
    text_window := NULL;
  end;

  do_textview := text_window;
end;

procedure recursive_attach_view (depth  : integer;
                                 view   : PGtkTextView;
                                 anchor : PGtkTextChildAnchor);
var
  child_view,
  event_box,
  align       : PGtkWidget;
  color       : TGdkColor;

begin
  if depth > 4 then
    exit;

  child_view := gtk_text_view_new_with_buffer (gtk_text_view_get_buffer (view));

  (* Event box is to add a black border around each child view *)
  event_box := gtk_event_box_new ();
  gdk_color_parse ('black', @color);
  gtk_widget_modify_bg (event_box, GTK_STATE_NORMAL, @color);

  align := gtk_alignment_new (0.5, 0.5, 1.0, 1.0);
  gtk_container_set_border_width (pGtkContainer(align), 1);

  gtk_container_add (pGtkContainer(event_box), align);
  gtk_container_add (pGtkContainer(align), child_view);

  gtk_text_view_add_child_at_anchor (view, event_box, anchor);

  recursive_attach_view (depth + 1, pGtkTextView(child_view), anchor);
end;

procedure easter_egg_callback(button : PGtkWidget;
                              data   : gpointer); cdecl;
var
  sw,
  view   : PGtkWidget;
  buffer : PGtkTextBuffer;
  iter   : TGtkTextIter;
  anchor : PGtkTextChildAnchor;

begin
  if text_egg_window <> NULL then
  begin
    gtk_window_present (pGtkWindow(text_egg_window));
    exit;
  end;

  buffer := gtk_text_buffer_new (NULL);

  gtk_text_buffer_get_start_iter (buffer, @iter);

  gtk_text_buffer_insert (buffer, @iter,
                          'This buffer is shared by a set of nested text views.'#13#10'Nested view:'#13#10, -1);
  anchor := gtk_text_buffer_create_child_anchor (buffer, @iter);
  gtk_text_buffer_insert (buffer, @iter,
                          #13#10'Don''t do this in real applications, please.'#13#10, -1);

  view := gtk_text_view_new_with_buffer (buffer);

  recursive_attach_view (0, pGtkTextView(view), anchor);

  g_object_unref (pGObject(buffer));

  text_egg_window := gtk_window_new (GTK_WINDOW_TOPLEVEL);
  sw := gtk_scrolled_window_new (NULL, NULL);
  gtk_scrolled_window_set_policy (pGtkScrolledWindow(sw),
                                  GTK_POLICY_AUTOMATIC,
                                  GTK_POLICY_AUTOMATIC);

  gtk_container_add (pGtkContainer(text_egg_window), sw);
  gtk_container_add (pGtkContainer(sw), view);

  g_object_add_weak_pointer (pGObject(text_egg_window),
                             gpointer (@text_egg_window));

  gtk_window_set_default_size (pGtkWindow(text_egg_window), 300, 400);

  gtk_widget_show_all (text_egg_window);
end;

// included by gt_demo.pas

