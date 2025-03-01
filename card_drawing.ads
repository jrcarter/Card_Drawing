-- Drawing PragmARC.Cards.US cards with Ada GUI
--
-- Copyright (C) by PragmAda Software Engineering
--
-- Released under the terms of the 3-Clause BSD License. See https://opensource.org/licenses/BSD-3-Clause

with Ada_GUI;
with PragmARC.Cards.US;

package Card_Drawing is
   Card_Width  : constant := 80; -- Cards are drawn this size (in pixels)
   Card_Height : constant := (3 * Card_Width) / 2;
   Font_Height : constant := Card_Width / 2;

   -- Colors used for drawing
   Table_Green : constant Ada_GUI.Color_Info := Ada_GUI.To_Color (Ada_GUI.Light_Green); -- Backgound
   White       : constant Ada_GUI.Color_Info := Ada_GUI.To_Color (Ada_GUI.White);       -- Card front
   Blue        : constant Ada_GUI.Color_Info := Ada_GUI.To_Color (Ada_GUI.Light_Blue);  -- Card back
   Black       : constant Ada_GUI.Color_Info := Ada_GUI.To_Color (Ada_GUI.Black);       -- Black suit labels
   Red         : constant Ada_GUI.Color_Info := Ada_GUI.To_Color (Ada_GUI.Red);         -- Red suit labels

   function Set_Up return Boolean;
   -- Returns False until procedure Set_Up is called; True afterwards

   procedure Set_Up (Row          : in     Positive := 1;
                     Column       : in     Positive := 1;
                     Width        : in     Positive;
                     Height       : in     Positive;
                     Break_Before : in     Boolean := False;
                     ID           :    out Ada_GUI.Widget_ID)
   with
      Pre  => not Set_Up and Ada_GUI.Set_Up,
      Post => Set_Up;
   -- Creates an internal graphic area (the Table) in grid (Row, Column) with dimensions Width x Height, below existing widgets
   -- in that grid if Break_Before
   -- Fills it with Table_Green
   -- ID is the Widget_ID of the Table

   procedure Blank with Pre => Set_Up and Ada_GUI.Set_Up;
   -- Fills the Table with Table_Green

   -- (X, Y) coordinates are in pixels relative to the upper-left corner of the Table

   procedure Draw (Card : in PragmARC.Cards.US.Card_Info; X : in Natural; Y : in Natural) with
      Pre => Set_Up and Ada_GUI.Set_Up;
   -- Draws Card at (X, Y) in White with a Black outline, labeled with the Image of Card
   -- The label is in the top part of the card

   procedure Erase (X : in Natural; Y : in Natural) with
      Pre => Set_Up and Ada_GUI.Set_Up;
   -- Draws a card-sized Table_Green rectangle at (X, Y)

   procedure Draw_Back (X : in Natural; Y : in Natural; Label : in PragmARC.Cards.US.Image_String := "  ") with
      Pre => Set_Up and Ada_GUI.Set_Up;
   -- Draws a card-sized Blue rectangle with a Black outline at (X, Y), labeled with Label
   -- The label is in the middle of the card

   procedure Draw_Outline (X : in Natural; Y : in Natural; Label : in PragmARC.Cards.US.Image_String := "  ") with
      Pre => Set_Up and Ada_GUI.Set_Up;
   -- Draws a card-sized Table_Green rectangle with a Black outline at (X, Y), labeled with Label
   -- The label is in the middle of the card

   procedure Draw_Text (X      : in Natural;
                        Y      : in Natural;
                        Text   : in String;
                        Height : in Positive           := Font_Height;
                        Color  : in Ada_GUI.Color_Info := Black)
   with
      Pre => Set_Up and Ada_GUI.Set_Up;
   -- Draws Text with given Height and Color at (X, Y)
end Card_Drawing;
