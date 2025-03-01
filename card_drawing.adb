-- Drawing PragmARC.Cards.US cards with Ada GUI
--
-- Copyright (C) by PragmAda Software Engineering
--
-- Released under the terms of the 3-Clause BSD License. See https://opensource.org/licenses/BSD-3-Clause

package body Card_Drawing is
   Spacing : constant := Font_Height;

   Table    : Ada_GUI.Widget_ID;
   No_Card  : Ada_GUI.Widget_ID; -- Card-sized green rectangle without border
   Empty    : Ada_GUI.Widget_ID; -- Card without text (white rectangle with black border)
   Backside : Ada_GUI.Widget_ID; -- Card back (blue rectangle with black border)
   Outline  : Ada_GUI.Widget_ID; -- Card-sized green rectangle with black border

   Created : Boolean := False;

   function Set_Up return Boolean is
      (Created);

   procedure Set_Up (Row          : in     Positive := 1;
                     Column       : in     Positive := 1;
                     Width        : in     Positive;
                     Height       : in     Positive;
                     Break_Before : in     Boolean := False;
                     ID           :    out Ada_GUI.Widget_ID)
   is
      -- Empty
   begin -- Set_Up
      Table := Ada_GUI.New_Graphic_Area
         (Row => Row, Column => Column, Width => Width, Height => Height, Break_Before => Break_Before);
      ID := Table;
      Created := True;
      Blank;

      No_Card := Ada_GUI.New_Graphic_Area
         (Row => Row, Column => Column, Width => Card_Width, Height => Card_Height, Break_Before => True);
      No_Card.Set_Hidden;
      No_Card.Draw_Rectangle (From_X     => 0,
                              From_Y     => 0,
                              To_X       => Card_Width - 1,
                              To_Y       => Card_Height - 1,
                              Line_Color => (None => True),
                              Fill_Color => (None => False, Color => Table_Green) );

      Empty := Ada_GUI.New_Graphic_Area
         (Row => Row, Column => Column, Width => Card_Width, Height => Card_Height, Break_Before => True);
      Empty.Set_Hidden;
      Empty.Draw_Rectangle (From_X     => 0,
                            From_Y     => 0,
                            To_X       => Card_Width - 1,
                            To_Y       => Card_Height - 1,
                            Fill_Color => (None => False, Color => White) );

      Backside := Ada_GUI.New_Graphic_Area
         (Row => Row, Column => Column, Width => Card_Width, Height => Card_Height, Break_Before => True);
      Backside.Set_Hidden;
      Backside.Draw_Rectangle (From_X     => 0,
                               From_Y     => 0,
                               To_X       => Card_Width - 1,
                               To_Y       => Card_Height - 1,
                               Fill_Color => (None => False, Color => Blue) );

      Outline := Ada_GUI.New_Graphic_Area
         (Row => Row, Column => Column, Width => Card_Width, Height => Card_Height, Break_Before => True);
      Outline.Set_Hidden;
      Outline.Draw_Rectangle (From_X     => 0,
                              From_Y     => 0,
                              To_X       => Card_Width - 1,
                              To_Y       => Card_Height - 1,
                              Fill_Color => (None => False, Color => Table_Green) );
   end Set_Up;

   procedure Blank is
      -- Empty
   begin -- Blank
      Table.Draw_Rectangle (From_X     => 0,
                            From_Y     => 0,
                            To_X       => Table.Width - 1,
                            To_Y       => Table.Height - 1,
                            Line_Color => (None => False, Color => White),
                            Fill_Color => (None => False, Color => Table_Green) );
   end Blank;

   procedure Draw (Card : in PragmARC.Cards.US.Card_Info; X : in Natural; Y : in Natural) is
      Color : Ada_GUI.Color_Info;

      use PragmARC;
   begin -- Draw
      Table.Replace_Pixels (Image => Empty, X => X, Y => Y);

      case Card.Suit is
      when Cards.US.Diamond | Cards.US.Heart =>
         Color := Red;
      when others =>
         Color := Black;
      end case;

      Table.Draw_Text (X          => X + Spacing / 3,
                       Y          => Y + Spacing - Spacing / 10,
                       Text       => Cards.US.Image (Card),
                       Height     => Font_Height,
                       Fill_Color => (None => False, Color => Color) );
   end Draw;

   procedure Erase (X : in Natural; Y : in Natural) is
      -- Empty
   begin -- Erase
      Table.Replace_Pixels (Image => No_Card, X => X, Y => Y);
   end Erase;

   procedure Draw_Back (X : in Natural; Y : in Natural; Label : in PragmARC.Cards.US.Image_String := "  ") is
      -- Empty
   begin -- Draw_Back
      Table.Replace_Pixels (Image => Backside, X => X, Y => Y);
      Table.Draw_Text (X => X + Spacing / 3, Y => Y + (3 * Spacing) / 2, Text => Label, Height => Font_Height);
   end Draw_Back;

   procedure Draw_Outline (X : in Natural; Y : in Natural; Label : in PragmARC.Cards.US.Image_String := "  ") is
      -- Empty
   begin -- Draw_Outline
      Table.Replace_Pixels (Image => Outline, X => X, Y => Y);
      Table.Draw_Text (X => X + Spacing / 3, Y => Y + (3 * Spacing) / 2, Text => Label, Height => Font_Height);
   end Draw_Outline;

   procedure Draw_Text (X      : in Natural;
                        Y      : in Natural;
                        Text   : in String;
                        Height : in Positive           := Font_Height;
                        Color  : in Ada_GUI.Color_Info := Black)
   is
      -- Empty
   begin -- Draw_Text
      Table.Draw_Text (X          => X + Spacing / 3,
                       Y          => Y + Spacing - Spacing / 10,
                       Text       => Text,
                       Height     => Height,
                       Fill_Color => (None => False, Color => Color) );
   end Draw_Text;
end Card_Drawing;
