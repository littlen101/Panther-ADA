--  Author: Nick Lewis, nlewis2016@my.fit.edu
--  Course: CSE 4250, Spring 2019
--  Project: Proj3, Panther Party
--  'gnat --version':  GNAT Community 2018 (20180523-73)
generic 
   type Two_Dimensional_Int_Array is
           array (Integer range <>, Integer range <>) of Natural;
           
   type Int_Array is array(Positive range <>) of Natural;
   
   Graph : Two_Dimensional_Int_Array;

package Dijkstra is

   type Node is record
         Priority : Natural;
         Lair  : Natural;
      end record;

   function Get_Priority (Element : Node) return Natural;
   function Before (Left, Right : Natural) return Boolean;
   procedure ShortestPath (Start : Natural; Distance : in out Int_Array);
end Dijkstra;