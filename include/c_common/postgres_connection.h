/*PGR-GNU*****************************************************************
File: postgres_connection.h

Copyright (c) 2015 pgRouting developers
Mail: project@pgrouting.org

Copyright (c) 2015 Celia Virginia Vergara Castillo
vicky_vergara@hotmail.com

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
#ifndef INCLUDE_C_COMMON_POSTGRES_CONNECTION_H_
#define INCLUDE_C_COMMON_POSTGRES_CONNECTION_H_
#pragma once

#ifdef __cplusplus
extern "C" {
#endif

#include <postgres.h>
#include <executor/spi.h>
#include <funcapi.h>
#include <utils/builtins.h>
#include <access/htup_details.h>
#include <fmgr.h>
#include <utils/array.h>
#include <catalog/pg_type.h>

#include "cpp_common/undefPostgresDefine.hpp"


void pgr_send_error(int errcode);
void pgr_SPI_finish(void);
void pgr_SPI_connect(void);
SPIPlanPtr pgr_SPI_prepare(const char* sql);
Portal pgr_SPI_cursor_open(SPIPlanPtr SPIplan);

#ifdef __cplusplus
}
#endif

#endif  // INCLUDE_C_COMMON_POSTGRES_CONNECTION_H_
