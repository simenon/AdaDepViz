with Ada.Text_IO;
with Ada.Command_Line;
with Ada.Directories;
with Ada.Exceptions;

procedure adadepviz is

   package T_IO renames Ada.Text_IO;
   package CL   renames Ada.Command_Line;
   package D    renames Ada.Directories;
   package E    renames Ada.Exceptions;

   procedure parsefile (I_FNAME : String) is
      File : T_IO.File_Type;
   begin
      T_IO.Put_Line ("PARSING FILE : " & I_FNAME);
      T_IO.Open (File, T_IO.In_File, I_FNAME);
      while not T_IO.End_Of_File (File) loop
         declare
	    Line : String := T_IO.Get_Line (File);
	 begin
	    if Line'Length > 0 and then
	       Line(Line'First) = 'W' then

	       T_IO.Put_Line (Line);

            end if;
	 end;
      end loop;
      T_IO.Close (File);
      T_IO.Put_Line ("DONE PARSING");
   end parsefile;

   procedure print (I_DET : D.Directory_Entry_Type) is
   begin
      parsefile(D.Full_Name (I_DET));
   end print;

begin

   if CL.Argument_Count <= 0 then
      T_IO.Put_Line ("No arguments");
      return;
   end if;

   D.Search (CL.Argument (1), "*.ali", (others => True), print'access);

exception

   when E_EXCEPTION : others =>
      T_IO.New_Line;
      T_IO.Put_Line (E.Exception_Information (E_EXCEPTION));

end adadepviz;
