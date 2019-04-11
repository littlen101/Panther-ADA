--  Author: Nick Lewis, nlewis2016@my.fit.edu
--  Course: CSE 4250, Spring 2019
--  Project: Proj3, Panther Party
--  'gnat --version':  GNAT Community 2018 (20180523-73)

with Ada.Text_IO;
with Ada.Integer_Text_IO; 
with Ada.Containers.Synchronized_Queue_Interfaces;
with Ada.Containers.Unbounded_Priority_Queues;
 
package body Dijkstra is
   use Ada.Containers;
   
   -- Priority Queue Function Interface Implementations
   function Get_Priority (Element : Node) return Natural is
   begin
      return Element.Priority;
   end Get_Priority;
   
   function Before (Left, Right : Natural) return Boolean is
   begin
      return Left < Right;
   end Before;
   
  -- Instantionations of packages
   package Panther_Queues is new Synchronized_Queue_Interfaces
     (Element_Type => Node);
     
   package Panther_Priority_Queues is new Unbounded_Priority_Queues
     (Queue_Interfaces => Panther_Queues,
      Queue_Priority => Natural);
 
   -- The Instantitation of Queue
   PQ : Panther_Priority_Queues.Queue;
   
   -- Populates an array of the shortest distance starting from Start to each node it encounters
   procedure ShortestPath (Start : Natural; Distance : in out Int_Array) is
   CurrentNode : Node;
   Visited : array(Positive range 1 .. Graph'Length) of Boolean;
   begin 
      PQ.Enqueue(New_Item => (Priority => 0, Lair => Start));
      for I in Visited'Range loop
         Visited(I) := False;
      end loop;
   
      while PQ.Current_Use > 0 loop
         PQ.Dequeue (Element => CurrentNode);
         if not Visited(CurrentNode.Lair) then
             Distance(CurrentNode.Lair) := CurrentNode.Priority;
             Visited(CurrentNode.Lair) := True;
             
             for I in 1 .. Graph'Length loop
                if not Visited(I) then
                    if Graph(CurrentNode.Lair, I) /= 0 then
                        PQ.Enqueue(New_Item => (Priority => 
                                (CurrentNode.Priority + Graph(CurrentNode.Lair, I)), Lair => I));
                    end if;
                end if;
             end loop;
         end if;
      end loop;
   end shortestPath;
end Dijkstra;