using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Util
/// </summary>
public static class Util
{
    public static string ChecaNulo(string str)
    {
        return string.IsNullOrEmpty(str) ? null : str;
    }
}