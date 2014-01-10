select replace(sql, ',', ','||X'0A'||'   ') from sqlite_master;
