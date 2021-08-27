using System.Collections.Generic;

public class BotaoDao
{
    public List<Botao> GetAll()
    {
        Identificacao identificacao = new Identificacao();

        return Get(identificacao.IdOperador, identificacao.Sistema, identificacao.Modulo, identificacao.Pagina);
    }

    public List<Botao> GetAll(string sistema, string modulo, string pagina)
    {
        Identificacao identificacao = new Identificacao();

        if (sistema == null)
        {
            sistema = identificacao.Sistema;
        }

        if (modulo == null)
        {
            modulo = identificacao.Modulo;
        }

        return Get(identificacao.IdOperador, sistema, modulo, pagina);
    }

    
    private List<Botao> Get(string idOperador, string sistema, string modulo, string pagina)
    {
        try
        {
            Dictionary<string, object> parametros = new Dictionary<string, object>()
            {
                {"@TipoConsulta", 1},
                {"@IdOperador", idOperador},
                {"@Sistema", sistema},
                {"@Modulo", modulo},
                {"@Pagina", pagina}
            };

            return new Dao().ExecutarProcedureList<Botao>("stp_sys_MontaMenu", parametros);
        }
        catch
        {
            return new List<Botao>();
        }
    }
}