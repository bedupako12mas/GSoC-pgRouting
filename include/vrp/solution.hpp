/*PGR-GNU*****************************************************************
File: solution.hpp

Copyright (c) 2015 pgRouting developers
Mail: project@pgrouting.org

------

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

 ********************************************************************PGR-GNU*/

/*! @file */

#ifndef INCLUDE_VRP_SOLUTION_HPP_
#define INCLUDE_VRP_SOLUTION_HPP_
#pragma once

#include <deque>
#include <tuple>
#include <string>
#include <vector>

#include "vrp/vehicle_pickDeliver.hpp"
#include "vrp/fleet.hpp"

using Schedule_rt = struct Schedule_rt;

namespace pgrouting {
namespace vrp {


class Solution {
    friend class Optimize;
    friend class PD_problem;
 protected:
     double EPSILON;
     std::deque<Vehicle_pickDeliver> fleet;

     /* this solution belongs to this problem*/
     Fleet trucks;

 public:
     std::vector<Schedule_rt>
         get_postgres_result() const;


     /* @brief constructor
      *
      */
     Solution();



     /* @brief copy constructor */
     Solution(const Solution &sol) :
         EPSILON(0.0001),
         fleet(sol.fleet),
         trucks(sol.trucks)
    {};

     /* @brief copy assignment */
     Solution& operator = (const Solution& sol) {
         EPSILON = 0.0001,
         fleet = sol.fleet;
         trucks = sol.trucks;
         return *this;
     };


     Initials_code get_kind() const;

     std::string cost_str() const;
     std::string tau(const std::string &title = "Tau") const;
     friend std::ostream& operator<<(
             std::ostream &log,
             const Solution &solution);
     bool operator <(const Solution &s_rhs) const;

     bool is_feasable() const;
     double duration() const;
     double wait_time() const;
     double total_travel_time() const;
     double total_service_time() const;
     int twvTot() const;
     int cvTot() const;

     /*
      * Cost in terms of a tuple
      * <0> time window violations
      * <1> capacity violations
      * <2> fleet size TODO
      * <3> wait_time
      * <4> duration
      */
     Vehicle::Cost cost() const;

     /** The problem's message */
     static Pgr_messages& msg();

 private:
     /** this solution belongs to this problem */
     static Pgr_pickDeliver* problem;
};


}  //  namespace vrp
}  //  namespace pgrouting

#endif  // INCLUDE_VRP_SOLUTION_HPP_
