using System;
using System.Web;

public class Identificacao
{
    private string _IdOperador;
    private string _Sistema;
    private string _Modulo;
    private string _Pagina;

    public Identificacao()
    {
        _IdOperador = GetIdOperador();

        string caminhoPagina = HttpContext.Current.Request.FilePath;

        string[] vetorcaminho = new string[5];
        char[] splitter = { '/' };

        vetorcaminho = caminhoPagina.Split(splitter);

        int count = vetorcaminho.Length;

        if (count - 3 >= 0)
        {
            _Sistema = vetorcaminho[count - 3];
        }

        if (count - 2 >= 0)
        {
            _Modulo = vetorcaminho[count - 2];
        }

        if (count - 1 >= 0)
        {
            _Pagina = vetorcaminho[count - 1].Split('.')[0];
        }
    }

    private string GetIdOperador()
    {
        if (HttpContext.Current.Session["idOperador"] != null)
        {
            return HttpContext.Current.Session["idOperador"].ToString();
        }

        return null;
    }

    public string IdOperador
    {
        get { return _IdOperador; }
    }

    public string Sistema
    {
        get { return _Sistema; }
    }

    public string Modulo
    {
        get { return _Modulo; }
    }

    public string Pagina
    {
        get { return _Pagina; }
    }
}