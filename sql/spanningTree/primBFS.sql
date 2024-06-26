/*PGR-GNU*****************************************************************
File: primBFS.sql

Copyright (c) 2018 Vicky Vergara
Mail: vicky at erosion dot dev

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


-----------------
-- pgr_primBFS
-----------------


-- SINGLE VERTEX
--v3.7
CREATE FUNCTION pgr_primBFS(
    TEXT,   -- Edge sql
    BIGINT, -- root vertex

    max_depth BIGINT DEFAULT 9223372036854775807,

    OUT seq BIGINT,
    OUT depth BIGINT,
    OUT start_vid BIGINT,
    OUT pred BIGINT,
    OUT node BIGINT,
    OUT edge BIGINT,
    OUT cost FLOAT,
    OUT agg_cost FLOAT)
RETURNS SETOF RECORD AS
$BODY$
    SELECT seq, depth, start_vid, pred, node, edge, cost, agg_cost
    FROM _pgr_primv4(_pgr_get_statement($1), ARRAY[$2]::BIGINT[], 'BFS', $3, -1);
$BODY$
LANGUAGE SQL VOLATILE STRICT;


--v3.7
CREATE FUNCTION pgr_primBFS(
    TEXT,     -- Edge sql
    ANYARRAY, -- root vertices

    max_depth BIGINT DEFAULT 9223372036854775807,

    OUT seq BIGINT,
    OUT depth BIGINT,
    OUT start_vid BIGINT,
    OUT pred BIGINT,
    OUT node BIGINT,
    OUT edge BIGINT,
    OUT cost FLOAT,
    OUT agg_cost FLOAT)
RETURNS SETOF RECORD AS
$BODY$
    SELECT seq, depth, start_vid, pred, node, edge, cost, agg_cost
    FROM _pgr_primv4(_pgr_get_statement($1), $2, 'BFS', $3, -1);
$BODY$
LANGUAGE SQL VOLATILE STRICT;


-- COMMENTS


COMMENT ON FUNCTION pgr_primBFS(TEXT, BIGINT, BIGINT)
IS 'pgr_primBFS(Single Vertex)
- Undirected graph
- Parameters:
    - Edges SQL with columns: id, source, target, cost [,reverse_cost]
    - From root vertex identifier
- Optional parameters
    - max_depth := 9223372036854775807
- Documentation:
    - ${PROJECT_DOC_LINK}/pgr_primBFS.html
';


COMMENT ON FUNCTION pgr_primBFS(TEXT, ANYARRAY, BIGINT)
IS 'pgr_primBFS(multiple Vertices)
- Undirected graph
- Parameters:
    - Edges SQL with columns: id, source, target, cost [,reverse_cost]
    - From ARRAY[root vertices identifiers]
- Optional parameters
    - max_depth := 9223372036854775807
- Documentation:
    - ${PROJECT_DOC_LINK}/pgr_primBFS.html
';
