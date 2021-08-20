using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.SqlClient;
using System.Linq;
using System.Reflection;
using System.Web;

/// <summary>
/// Descrição resumida de Dao
/// </summary>
public class Dao
{

    private readonly string connectionString = "Server=192.168.0.1;Database=dbTreinamento;Trusted_Connection=True";

	public void ExecutarProcedure(string procedure, Dictionary<string, object> parametros)
    {

        SqlConnection connection = new SqlConnection(connectionString);

        connection.Open();

        SqlCommand cmd = NovoCmmd(procedure, connection);

        AdicionarParametros(cmd, parametros);

        cmd.ExecuteNonQuery();

        connection.Dispose();
        connection.Close();
        connection.Dispose();
    }
    
    public List<T> ExecutarProcedureList<T>(string procedure, Dictionary<string, object> parametros)
    {
        List<T> list = null;
        
        SqlConnection connection = new SqlConnection(connectionString);

        connection.Open();

        SqlCommand cmd = NovoCmmd(procedure, connection);

        AdicionarParametros(cmd, parametros);

        SqlDataReader dr = cmd.ExecuteReader();

        list = CriaLista<T>(dr);

        cmd.Dispose();

        connection.Close();
        connection.Dispose();

        return list;

    }

    private List<T> CriaLista<T>(SqlDataReader dr)
    {
        List<T> list = null;

        if (dr.HasRows)
        {
            list = new List<T>();
            while (dr.Read())
            {
                var item = Activator.CreateInstance<T>();
                foreach (var property in typeof(T).GetProperties())
                {
                    string nomecoluna;

                    if (property.GetCustomAttribute<ColumnAttribute>() != null)
                    {
                        nomecoluna = property.GetCustomAttribute<ColumnAttribute>().Name;
                    }
                    else
                    {
                        nomecoluna = property.Name;
                    }

                    int i = GetColumnOrdinal(dr, nomecoluna);

                    if (i < 0) continue;

                    if (dr[nomecoluna] == DBNull.Value) continue;

                    if (property.PropertyType.IsEnum)
                    {
                        property.SetValue(item, Enum.Parse(property.PropertyType, dr[nomecoluna].ToString()));
                    }
                    else
                    {
                        Type convertTo = Nullable.GetUnderlyingType(property.PropertyType) ?? property.PropertyType;
                        property.SetValue(item, Convert.ChangeType(dr[nomecoluna], convertTo), null);
                    }
                }
                list.Add(item);
            }
        }
        return list;
    }

    private int GetColumnOrdinal(SqlDataReader dr, string nomecoluna)
    {
        int ordinal = -1;

        for (int i = 0; i < dr.FieldCount; i++)
        {
            if (string.Equals(dr.GetName(i), nomecoluna, StringComparison.OrdinalIgnoreCase))
            {
                ordinal = i;
                break;
            }
        }

        return ordinal;
    }

    private void AdicionarParametros(SqlCommand cmd, Dictionary<string, object> parametros)
    {
        if(parametros != null)
        {
            foreach(var item in parametros)
            {
                cmd.Parameters.AddWithValue(item.Key, item.Value);
            }
        }
    }

    private SqlCommand NovoCmmd(string procedure, SqlConnection connection)
    {
        return new SqlCommand(procedure, connection)
        {
            CommandType = System.Data.CommandType.StoredProcedure,
            CommandTimeout = 60
        };
    }
}