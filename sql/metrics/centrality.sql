/*PGR-GNU*****************************************************************

File: centrality.sql

Template:
Copyright (c) 2015 pgRouting developers
Mail: project@pgrouting.org

Function developer:
Copyright (c) 2024 Arun Thakur
bedupako12mas@gmail.com

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

--v3.7
CREATE FUNCTION pgr_centrality(
    TEXT,    -- edges_sql (required)
    directed BOOLEAN DEFAULT true,

    OUT start_vid BIGINT,
    OUT end_vid BIGINT,
    OUT agg_cost FLOAT)
RETURNS SETOF RECORD AS
$BODY$

    SELECT start_vid, end_vid, agg_cost
    FROM _pgr_centrality(_pgr_get_statement($1), $2);

$BODY$
LANGUAGE SQL VOLATILE STRICT;

-- COMMENTS

COMMENT ON FUNCTION pgr_centrality(TEXT, BOOLEAN)
IS 'pgr_centrality
- Parameters:
    - edges SQL with columns: source, target, cost [,reverse_cost])
- Optional Parameters:
    - directed := true
- Documentation:
    - ${PROJECT_DOC_LINK}/pgr_centrality.html
';
