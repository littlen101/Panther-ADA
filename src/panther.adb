--  Author: Nick Lewis, nlewis2016@my.fit.edu
--  Course: CSE 4250, Spring 2019
--  Project: Proj3, Panther Party
--  'gnat --version':  GNAT Community 2018 (20180523-73)

with Ada.Text_IO;
with Ada.Integer_Text_IO;
with Ada.Strings.Unbounded;
with Ada.Strings.Unbounded.Text_Io;
with Dijkstra;

use Ada.Text_IO;

procedure Panther is
    -- Case information
    N : Natural; -- Number of Lairs (Nodes)
    M : Natural; -- Number of paths to Lairs (Edges)
    X : Natural; -- Target destination
    
    -- So I am able to use Array'Length and Index
    type Two_Dimensional_Int_Array is
        array (Integer range <>, Integer range <>) of Natural;
        
    -- So I am able to take in an array as a parameter
    type Int_Array is array(Positive range <>) of Natural;
begin
   -- Initialize the Case values
   Ada.Integer_Text_IO.Get(N);
   Ada.Integer_Text_IO.Get(M);
   Ada.Integer_Text_IO.Get(X);

   declare
      Graph_To : Two_Dimensional_Int_Array (Positive range 1 .. N, Positive range 1 .. N);
      Graph_From : Two_Dimensional_Int_Array (Positive range 1 .. N, Positive range 1 .. N);
      A : Natural;
      B : Natural;
      T : Natural;

      -- The inital value to 0 for finding the max of travel distance
      Max : Natural := 0;
      -- Being able to print value without space in front of it
      String_Max : Ada.Strings.Unbounded.Unbounded_String;

      -- The storage of all the travel times to and from the party
      Travel_Time : array (Positive range 1 .. N) of Natural;
      
   begin
      -- Initalize the array values to 0
      for I in 1 .. N loop
         Travel_Time(I) := 0; -- When testing it seemed as if garabge was possible in arrays
      end loop;
      
      -- Initalize the graph array values to 0
      for I in 1 .. N loop
         for J in 1 .. N loop
            Graph_To(I, J) := 0;
            Graph_From(I, J) := 0;
         end loop;
      end loop;
      
      for I in 1 .. M loop     --  Constructs forward and backwards graph from edges
         Ada.Integer_Text_IO.Get(A);
         Ada.Integer_Text_IO.Get(B);
         Ada.Integer_Text_IO.Get(T);

         Graph_To(A, B) := T;
         Graph_From(B, A) := T;
      end loop;
          
      declare
           -- arrays to populate with distances To and From the party
           Distance_To : Int_Array(Positive range 1 .. Graph_To'Length);
           Distance_From : Int_Array(Positive range 1 .. Graph_From'Length);
           
           -- Instantiate Dijkstra package twice with different forms of the graph
           package Panther_To_Dijkstra is new Dijkstra(Two_Dimensional_Int_Array, Int_Array, Graph_To);
           package Panther_From_Dijkstra is new Dijkstra(Two_Dimensional_Int_Array, Int_Array, Graph_From);
         
      begin
          -- Run shortest path starting from X 
          Panther_To_Dijkstra.ShortestPath(Start => X, Distance => Distance_To);
          Panther_From_Dijkstra.ShortestPath(Start => X, Distance =>  Distance_From);
          
          -- Get total travel time from adding to and from
          for I in 1 .. N loop
             Travel_Time(I) := Distance_To(I) + Distance_From(I);
          end loop;
          
          -- Finds the max of the list of Travel time
          for I in 1 .. N loop
             Max := Integer'Max(Max, Travel_Time(I));
          end loop;
    
          -- Strips the space from in front of Integer'Image and print
          String_Max := Ada.Strings.Unbounded.To_Unbounded_String(Integer'Image(Max)(2 .. Integer'Image(Max)'Last));
          Ada.Text_IO.Put_Line(Ada.Strings.Unbounded.To_String(String_Max));
       end;
    end;
end Panther;