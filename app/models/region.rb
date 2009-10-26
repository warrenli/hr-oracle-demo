class Region < ActiveRecord::Base
  has_many :countries

  def self.regional_compensation_report
    Department.find_by_sql(
    " SELECT  "+
        "  decode(grp,011,region_name,' ') region_name,    "+
        "  decode(grp,000, ' ', country_name ) country_name,     "+
        "  state_province,   "+
        "  Total_Employees,   "+
        "  Total_Salary  "+
    " FROM ( "+
        " SELECT   "+
            "  grouping(region_name)||grouping(country_name)||grouping(state_province) grp, "+
            "  region_name,    "+
            "  country_name,  "+
            "  nvl (state_province, 'Total') state_province,   "+
            "  count(id) Total_Employees,   "+
            "  sum(salary) Total_Salary   "+
        " FROM  "+
            " (   "+
            "  SELECT "+
            "    r.name region_name,   "+
            "    c.name country_name,   "+
            "    nvl(l.locale, 'N/A') state_province,   "+
            "    d.name department_name, e.id,  e.salary  "+
            "  FROM regions r, countries c, locations l,  "+
            "       departments d, employees e   "+
            "  WHERE r.id = c.region_id   "+
            "  AND c.country_id = l.country_id   "+
            "  AND l.id = d.location_id   "+
            "  AND d.id = e.department_id   "+
            "  ORDER BY 1, 2, 3, 4  "+
            "  )  "+
        "  GROUP BY ROLLUP (region_name, country_name, state_province) "+
    ") "
    )
  end

  def self.schema_report
    Region.find_by_sql(
        " SELECT table_name table_name_ord, "+
        "   DECODE(lag (table_name) over (order by table_name, column_name), table_name,'',  "+
        "          sys_context('USERENV', 'CURRENT_SCHEMA')||'.'||table_name "+
        "   ) table_name,  "+
        "   column_name,  "+
        "   DECODE(data_type,'DATE',data_type, "+
              " data_type||'('||data_length||decode(data_precision,null,'',',')||data_precision||')' "+
        "   ) column_type,  "+
        " DECODE(nullable,'N','NOT NULL') nullable "+
        " FROM user_tab_columns "+
        " ORDER BY table_name_ord, column_name"
    )
  end

end
