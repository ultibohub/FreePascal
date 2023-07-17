{$MACRO ON}

(******************************************************************************
 *
 * Copyright (c) 1998-2000 Palm, Inc. or its subsidiaries.
 * All rights reserved.
 *
 * File: TextMgr.h
 *
 * Release: Palm OS SDK 4.0 (63220)
 *
 * Description:
 *    Header file for Text Manager.
 *
 * History:
 *    03/05/98 kwk   Created by Ken Krugler.
 *    02/02/99 kwk   Added charEncodingPalmLatin & charEncodingPalmSJIS,
 *                   since we've extended the CP1252 & CP932 encodings.
 *                   Added TxtUpperStr, TxtLowerStr, TxtUpperChar, and
 *                   TxtLowerChar macros.
 *    03/11/99 kwk   Changed TxtTruncate to TxtGetTruncationOffset.
 *    04/24/99 kwk   Moved string & character upper/lower casing macros
 *                   to IntlGlue library.
 *    04/28/99 kwk   Changed kMaxCharSize to maxCharBytes, as per Roger's request.
 *    05/15/99 kwk   Changed TxtIsValidChar to TxtCharIsValid.
 *    05/29/99 kwk   Removed include of CharAttr.h.
 *    07/13/99 kwk   Moved TxtPrepFindString into TextPrv.h
 *    09/22/99 kwk   Added TxtParamString (OS 3.5).
 *    10/28/99 kwk   Added the TxtCharIsVirtual macro.
 *    03/01/00 kwk   Added the TxtConvertEncoding routine (OS 4.0), and the
 *                   txtErrUnknownEncoding and txtErrConvertOverflow errors.
 *    05/12/00 kwk   Deprecated the TxtCharWidth routine.
 *    05/26/00 kwk   Added TxtGetWordWrapOffset (OS 4.0). Convert CharEncodingType
 *                   to #define format versus enums. Re-ordered into logical
 *                   groups, and fixed up names to match existing convention.
 *    05/30/00 kwk   Added txtErrTranslitUnderflow.
 *    06/02/00 CS    Moved character encoding constants to PalmLocale.h so that
 *                   Rez has access to them.
 *    07/13/00 kwk   Added TxtNameToEncoding (OS 4.0).
 *    07/23/00 kwk   Updated TxtConvertEncoding to match new API.
 *    10/05/00 kwk   Added charAttr_<whatever> as substitutes for the old
 *                   character attribute flags in CharAttr.h (e.g. _XA, _LO).
 *             kwk   Moved sizeOf7BitChar here from CharAttr.h
 *    11/21/00 kwk   Undeprecated TxtCharWidth, in anticipation of future,
 *                   proper deprecation.
 *    11/24/00 kwk   Reverted maxCharBytes to 3 (was 4). You only need more than
 *                   three bytes for surrogate Unicode characters, which we don't
 *                   support, as this would require a 32 bit WChar variable to
 *                   hold the result (potentially 21 bits of data). Since we
 *                   never use more than 3 bytes, it's OK to shrink this back down.
 *
 *****************************************************************************)

unit textmgr;

interface

uses palmos, coretraps, errorbase, intlmgr;

(***********************************************************************
 * Public types & constants
 ***********************************************************************)

// See PalmLocale.h for encoding constants of type CharEncodingType, and
// character encoding names.
type
  CharEncodingType = UInt8;

// Transliteration operations for the TxtTransliterate call. We don't use
// an enum, since each character encoding contains its own set of special
// transliteration operations (which begin at translitOpCustomBase).
type
  TranslitOpType = UInt16;

// Standard transliteration operations.
const
  translitOpStandardBase  = 0; // Beginning of standard operations.

  translitOpUpperCase     = 0;
  translitOpLowerCase     = 1;
  translitOpReserved2     = 2;
  translitOpReserved3     = 3;

// Custom transliteration operations (defined in CharXXXX.h encoding-specific
// header files.
  translitOpCustomBase    = 1000;  // Beginning of AnsiChar-encoding specific ops.

  translitOpPreprocess    = $8000; // Mask for pre-process option, where
                                   // no transliteration actually is done.

// Structure used to maintain state across calls to TxtConvertEncoding, for
// proper handling of source or destination encodings with have modes.
  kTxtConvertStateSize    = 32;

type
  TxtConvertStateType = record
    ioSrcState: array [0..kTxtConvertStateSize - 1] of UInt8;
    ioDstState: array [0..kTxtConvertStateSize - 1] of UInt8;
  end;

// Flags available in the sysFtrNumCharEncodingFlags feature attribute.
const
  charEncodingOnlySingleByte = $00000001;
  charEncodingHasDoubleByte  = $00000002;
  charEncodingHasLigatures   = $00000004;
  charEncodingLeftToRight    = $00000008;

// Various byte attribute flags. Note that multiple flags can be
// set, thus a byte could be both a single-byte character, or the first
// byte of a multi-byte character.
  byteAttrFirst  = $80; // First byte of multi-byte AnsiChar.
  byteAttrLast   = $40; // Last byte of multi-byte AnsiChar.
  byteAttrMiddle = $20; // Middle byte of muli-byte AnsiChar.
  byteAttrSingle = $01; // Single byte.

// Character attribute flags. These replace the old flags defined in
// CharAttr.h, but are bit-compatible.
  charAttr_XA   = $0200; // extra alphabetic
  charAttr_XS   = $0100; // extra space
  charAttr_BB   = $0080; // BEL, BS, etc.
  charAttr_CN   = $0040; // CR, FF, HT, NL, VT
  charAttr_DI   = $0020; // '0'-'9'
  charAttr_LO   = $0010; // 'a'-'z' and lowercase extended chars.
  charAttr_PU   = $0008; // punctuation
  charAttr_SP   = $0004; // space
  charAttr_UP   = $0002; // 'A'-'Z' and uppercase extended chars.
  charAttr_XD   = $0001; // '0'-'9', 'A'-'F', 'a'-'f'

// Various sets of character attribute flags.
  charAttrPrint = charAttr_DI or charAttr_LO or charAttr_PU or charAttr_SP or charAttr_UP or charAttr_XA;
  charAttrSpace = charAttr_CN or charAttr_SP or charAttr_XS;
  charAttrAlNum = charAttr_DI or charAttr_LO or charAttr_UP or charAttr_XA;
  charAttrAlpha = charAttr_LO or charAttr_UP or charAttr_XA;
  charAttrCntrl = charAttr_BB or charAttr_CN;
  charAttrGraph = charAttr_DI or charAttr_LO or charAttr_PU or charAttr_UP or charAttr_XA;
  charAttrDelim = charAttr_SP or charAttr_PU;

// Remember that sizeof(0x0D) == 2 because 0x0D is treated like an int. The
// same is true of sizeof('a'), sizeof('\0'), and sizeof(chrNull). For this
// reason it's safest to use the sizeOf7BitChar macro to document buffer size
// and string length calcs. Note that this can only be used with low-ascii
// characters, as anything else might be the high byte of a double-byte AnsiChar.

//!!! sizeOf7BitChar(c) = 1;

// Maximum size a single WChar character will occupy in a text string.
  maxCharBytes = 3;

// Text manager error codes.
  txtErrUknownTranslitOp  = txtErrorClass or 1;
  txtErrTranslitOverrun   = txtErrorClass or 2;
  txtErrTranslitOverflow  = txtErrorClass or 3;
  txtErrConvertOverflow   = txtErrorClass or 4;
  txtErrConvertUnderflow  = txtErrorClass or 5;
  txtErrUnknownEncoding   = txtErrorClass or 6;
  txtErrNoCharMapping     = txtErrorClass or 7;
  txtErrTranslitUnderflow = txtErrorClass or 8;

(***********************************************************************
 * Public macros
 ***********************************************************************)

function TxtCharIsSpace(ch: WChar): Boolean;
function TxtCharIsPrint(ch: WChar): Boolean;
function TxtCharIsDigit(ch: WChar): Boolean;
function TxtCharIsAlNum(ch: WChar): Boolean;
function TxtCharIsAlpha(ch: WChar): Boolean;
function TxtCharIsCntrl(ch: WChar): Boolean;
function TxtCharIsGraph(ch: WChar): Boolean;
function TxtCharIsLower(ch: WChar): Boolean;
function TxtCharIsPunct(ch: WChar): Boolean;
function TxtCharIsUpper(ch: WChar): Boolean;
function TxtCharIsHex(ch: WChar): Boolean;
function TxtCharIsDelim(ch: WChar): Boolean;

// <c> is a hard key if the event modifier <m> has the command bit set
// and <c> is either in the proper range or is the calculator character.

function TxtCharIsHardKey(m, c: UInt16): Boolean;

// <c> is a virtual character if the event modifier <m> has the command
// bit set. WARNING!!! This macro is only safe to use on Palm OS 3.5 or
// later. With earlier versions of the OS, use TxtGlueCharIsVirtual()
// in PalmOSGlue.lib
function TxtCharIsVirtual(m, c: UInt16): Boolean;

function TxtPreviousCharSize(const inText: PAnsiChar; inOffset: UInt32): UInt16;
function TxtNextCharSize(const inText: PAnsiChar; inOffset: UInt32): UInt16;

(***********************************************************************
 * Public routines
 ***********************************************************************)

// DOLATER kwk - fix up parameter names to use i, o versus in, out

// Return back byte attribute (first, last, single, middle) for <inByte>.

function TxtByteAttr(inByte: UInt8): UInt8; syscall sysTrapIntlDispatch, intlTxtByteAttr;

// Return back the standard attribute bits for <inChar>.

function TxtCharAttr(inChar: WChar): UInt16; syscall sysTrapIntlDispatch, intlTxtCharAttr;

// Return back the extended attribute bits for <inChar>.

function TxtCharXAttr(inChar: WChar): UInt16; syscall sysTrapIntlDispatch, intlTxtCharXAttr;

// Return the size (in bytes) of the character <inChar>. This represents
// how many bytes would be required to store the character in a string.

function TxtCharSize(inChar: WChar): UInt16; syscall sysTrapIntlDispatch, intlTxtCharSize;

// Return the width (in pixels) of the character <inChar>. You should
// use FntWCharWidth or FntGlueWCharWidth instead of this routine.

function TxtCharWidth(inChar: WChar): Int16; syscall sysTrapIntlDispatch, intlTxtCharWidth;

// Load the character before offset <inOffset> in the <inText> text. Return
// back the size of the character.

function TxtGetPreviousChar(const inText: PAnsiChar; inOffset: UInt32; outChar: WCharPtr): UInt16; syscall sysTrapIntlDispatch, intlTxtGetPreviousChar;

// Load the character at offset <inOffset> in the <inText> text. Return
// back the size of the character.

function TxtGetNextChar(const inText: PAnsiChar; inOffset: UInt32; outChar: WCharPtr): UInt16; syscall sysTrapIntlDispatch, intlTxtGetNextChar;

// Return the character at offset <inOffset> in the <inText> text.

function TxtGetChar(const inText: PAnsiChar; inOffset: UInt32): WChar; syscall sysTrapIntlDispatch, intlTxtGetChar;

// Set the character at offset <inOffset> in the <inText> text, and
// return back the size of the character.

function TxtSetNextChar(ioText: PAnsiChar; inOffset: UInt32; inChar: WChar): UInt16; syscall sysTrapIntlDispatch, intlTxtSetNextChar;

// Replace the substring "^X" (where X is 0..9, as specified by <inParamNum>)
// with the string <inParamStr>. If <inParamStr> is NULL then don't modify <ioStr>.
// Make sure the resulting string doesn't contain more than <inMaxLen> bytes,
// excluding the terminating null. Return back the number of occurances of
// the substring found in <ioStr>.

function TxtReplaceStr(ioStr: PAnsiChar; inMaxLen: UInt16; const inParamStr: PAnsiChar; inParamNum: UInt16): UInt16; syscall sysTrapIntlDispatch, intlTxtReplaceStr;

// Allocate a handle containing the result of substituting param0...param3
// for ^0...^3 in <inTemplate>, and return the locked result. If a parameter
// is NULL, replace the corresponding substring in the template with "".

function TxtParamString(const inTemplate, param0, param1, param2, param3: PAnsiChar): PAnsiChar; syscall sysTrapIntlDispatch, intlTxtParamString;

// Return the bounds of the character at <inOffset> in the <inText>
// text, via the <outStart> & <outEnd> offsets, and also return the
// actual value of character at or following <inOffset>.

function TxtCharBounds(const inText: PAnsiChar; inOffset: UInt32; var outStart: UInt32; var outEnd: UInt32): WChar; syscall sysTrapIntlDispatch, intlTxtCharBounds;

// Return the appropriate byte position for truncating <inText> such that it is
// at most <inOffset> bytes long.

function TxtGetTruncationOffset(const inText: PAnsiChar; inOffset: UInt32): UInt32; syscall sysTrapIntlDispatch, intlTxtGetTruncationOffset;

// Search for <inTargetStr> in <inSourceStr>. If found return true and pass back
// the found position (byte offset) in <outPos>, and the length of the matched
// text in <outLength>.

function TxtFindString(const inSourceStr, inTargetStr: PAnsiChar;
                       var outPos: UInt32; var outLength: UInt16): Boolean; syscall sysTrapIntlDispatch, intlTxtFindString;

// Find the bounds of the word that contains the character at <inOffset>.
// Return the offsets in <*outStart> and <*outEnd>. Return true if the
// word we found was not empty & not a delimiter (attribute of first AnsiChar
// in word not equal to space or punct).

function TxtWordBounds(const inText: PAnsiChar; inLength, inOffset: UInt32;
                       var outStart, outEnd: UInt32): Boolean; syscall sysTrapIntlDispatch, intlTxtWordBounds;

// Return the offset of the first break position (for text wrapping) that
// occurs at or before <iOffset> in <iTextP>. Note that this routine will
// also add trailing spaces and a trailing linefeed to the break position,
// thus the result could be greater than <iOffset>.

function TxtGetWordWrapOffset(const iTextP: PAnsiChar; iOffset: UInt32): UInt32; syscall sysTrapIntlDispatch, intlTxtGetWordWrapOffset;

// Return the minimum (lowest) encoding required for <inChar>. If we
// don't know about the character, return encoding_Unknown.

function TxtCharEncoding(inChar: WChar): CharEncodingType; syscall sysTrapIntlDispatch, intlTxtCharEncoding;

// Return the minimum (lowest) encoding required to represent <inStr>.
// This is the maximum encoding of any character in the string, where
// highest is unknown, and lowest is ascii.

function TxtStrEncoding(const inStr: PAnsiChar): CharEncodingType; syscall sysTrapIntlDispatch, intlTxtStrEncoding;

// Return the higher (max) encoding of <a> and <b>.

function TxtMaxEncoding(a, b: CharEncodingType): CharEncodingType; syscall sysTrapIntlDispatch, intlTxtMaxEncoding;

// Return a pointer to the 'standard' name for <inEncoding>. If the
// encoding is unknown, return a pointer to an empty string.

function TxtEncodingName(inEncoding: CharEncodingType): PAnsiChar; syscall sysTrapIntlDispatch, intlTxtEncodingName;

// Map from a character set name <iEncodingName> to a CharEncodingType.
// If the character set name is unknown, return charEncodingUnknown.

function TxtNameToEncoding(const iEncodingName: PAnsiChar): CharEncodingType; syscall sysTrapIntlDispatch, intlTxtNameToEncoding;

// Transliterate <inSrcLength> bytes of text found in <inSrcText>, based
// on the requested <inOp> operation. Place the results in <outDstText>,
// and set the resulting length in <ioDstLength>. On entry <ioDstLength>
// must contain the maximum size of the <outDstText> buffer. If the
// buffer isn't large enough, return an error (note that outDestText
// might have been modified during the operation). Note that if <inOp>
// has the preprocess bit set, then <outDstText> is not modified, and
// <ioDstLength> will contain the total space required in the destination
// buffer in order to perform the operation.

function TxtTransliterate(const inSrcText: PAnsiChar; inSrcLength: UInt16; outDstText: PAnsiChar;
                          var ioDstLength: UInt16; inOp: TranslitOpType): Err; syscall sysTrapIntlDispatch, intlTxtTransliterate;

// Convert <*ioSrcBytes> of text from <srcTextP> between the <srcEncoding>
// and <dstEncoding> character encodings. If <dstTextP> is not NULL, write
// the resulting bytes to the buffer, and always return the number of
// resulting bytes in <*ioDstBytes>. Update <*srcBytes> with the number of
// bytes from the beginning of <*srcTextP> that were successfully converted.
// When the routine is called with <srcTextP> pointing to the beginning of
// a string or text buffer, <newConversion> should be true; if the text is
// processed in multiple chunks, either because errors occurred or due to
// source/destination buffer size constraints, then subsequent calls to
// this routine should pass false for <newConversion>. The TxtConvertStateType
// record maintains state information so that if the source or destination
// character encodings have state or modes (e.g. JIS), processing a single
// sequence of text with multiple calls will work correctly.

// When an error occurs due to an unconvertable character, the behavior of
// the routine will depend on the <substitutionStr> parameter. If it is NULL,
// then <*ioSrcBytes> will be set to the offset of the unconvertable character,
// <ioDstBytes> will be set to the number of successfully converted resulting
// bytes, and <dstTextP>, in not NULL, will contain conversion results up to
// the point of the error. The routine will return an appropriate error code,
// and it is up to the caller to either terminate conversion or skip over the
// unconvertable character and continue the conversion process (passing false
// for the <newConversion> parameter in subsequent calls to TxtConvertEncoding).
// If <substitutionStr> is not NULL, then this string is written to the
// destination buffer when an unconvertable character is encountered in the
// source text, and the source character is skipped. Processing continues, though
// the error code will still be returned when the routine terminates. Note that
// if a more serious error occurs during processing (e.g. buffer overflow) then
// that error will be returned even if there was an earlier unconvertable character.
// Note that the substitution string must use the destination character encoding.

function TxtConvertEncoding(newConversion: Boolean; var ioStateP: TxtConvertStateType;
         const srcTextP: PAnsiChar; var ioSrcBytes: UInt16; srcEncoding: CharEncodingType;
         dstTextP: PAnsiChar; var ioDstBytes: UInt16; dstEncoding: CharEncodingType;
         const substitutionStr: PAnsiChar; substitutionLen: UInt16): Err; syscall sysTrapIntlDispatch, intlTxtConvertEncoding;

// Return true if <inChar> is a valid (drawable) character. Note that we'll
// return false if it is a virtual character code.

function TxtCharIsValid(inChar: WChar): Boolean; syscall sysTrapIntlDispatch, intlTxtCharIsValid;

// Compare the first <s1Len> bytes of <s1> with the first <s2Len> bytes
// of <s2>. Return the results of the comparison: < 0 if <s1> sorts before
// <s2>, > 0 if <s1> sorts after <s2>, and 0 if they are equal. Also return
// the number of bytes that matched in <s1MatchLen> and <s2MatchLen>
// (either one of which can be NULL if the match length is not needed).
// This comparison is "caseless", in the same manner as a find operation,
// thus case, character size, etc. don't matter.

function TxtCaselessCompare(const s1: PAnsiChar; s1Len: UInt16; var s1MatchLen: UInt16;
                            const s2: PAnsiChar; s2Len: UInt16; var s2MatchLen: UInt16): Int16; syscall sysTrapIntlDispatch, intlTxtCaselessCompare;

// Compare the first <s1Len> bytes of <s1> with the first <s2Len> bytes
// of <s2>. Return the results of the comparison: < 0 if <s1> sorts before
// <s2>, > 0 if <s1> sorts after <s2>, and 0 if they are equal. Also return
// the number of bytes that matched in <s1MatchLen> and <s2MatchLen>
// (either one of which can be NULL if the match length is not needed).

function TxtCompare(const s1: PAnsiChar; s1Len: UInt16; var s1MatchLen: UInt16;
                    const s2: PAnsiChar; s2Len: UInt16; var s2MatchLen: UInt16): Int16; syscall sysTrapIntlDispatch, intlTxtCompare;

implementation

uses Chars, SysEvent;


function TxtCharIsSpace(ch: WChar): Boolean;
begin
  TxtCharIsSpace := (TxtCharAttr(ch) and charAttrSpace) <> 0;
end;

function TxtCharIsPrint(ch: WChar): Boolean;
begin
  txtCharIsPrint := (TxtCharAttr(ch) and charAttrPrint) <> 0;
end;

function TxtCharIsDigit(ch: WChar): Boolean;
begin
  TxtCharIsDigit := (TxtCharAttr(ch) and charAttr_DI) <> 0;
end;

function TxtCharIsAlNum(ch: WChar): Boolean;
begin
  TxtCharIsAlNum := (TxtCharAttr(ch) and charAttrAlNum) <> 0;
end;

function TxtCharIsAlpha(ch: WChar): Boolean;
begin
  TxtCharIsAlpha := (TxtCharAttr(ch) and charAttrAlpha) <> 0;
end;

function TxtCharIsCntrl(ch: WChar): Boolean;
begin
  txtCharIsCntrl := (TxtCharAttr(ch) and charAttrCntrl) <> 0;
end;

function TxtCharIsGraph(ch: WChar): Boolean;
begin
  TxtCharIsGraph := (TxtCharAttr(ch) and charAttrGraph) <> 0;
end;

function TxtCharIsLower(ch: WChar): Boolean;
begin
  TxtCharIsLower := (TxtCharAttr(ch) and charAttr_LO) <> 0;
end;

function TxtCharIsPunct(ch: WChar): Boolean;
begin
  TxtCharIsPunct := (TxtCharAttr(ch) and charAttr_PU) <> 0;
end;

function TxtCharIsUpper(ch: WChar): Boolean;
begin
  TxtCharIsUpper := (TxtCharAttr(ch) and charAttr_UP) <> 0;
end;

function TxtCharIsHex(ch: WChar): Boolean;
begin
  TxtCharIsHex := (TxtCharAttr(ch) and charAttr_XD) <> 0;
end;

function TxtCharIsDelim(ch: WChar): Boolean;
begin
  TxtCharIsDelim := (TxtCharAttr(ch) and charAttrDelim) <> 0;
end;

function TxtCharIsHardKey(m, c: UInt16): Boolean;
begin
  TxtCharIsHardKey := ((m and commandKeyMask) <> 0) and ((c >= hardKeyMin) and ((c <= hardKeyMax) or (c = calcChr)));
end;

function TxtCharIsVirtual(m, c: UInt16): Boolean;
begin
  TxtCharIsVirtual := (m and commandKeyMask) <> 0;
end;

function TxtPreviousCharSize(const inText: PAnsiChar; inOffset: UInt32): UInt16;
begin
  TxtPreviousCharSize := TxtGetPreviousChar(inText, inOffset, nil);
end;

function TxtNextCharSize(const inText: PAnsiChar; inOffset: UInt32): UInt16;
begin
 TxtNextCharSize := TxtGetNextChar(inText, inOffset, nil);
end;

end.
