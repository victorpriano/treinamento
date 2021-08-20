function estadoInicial() {
    var els = document.form1.querySelectorAll("input");
    if (els != null) {
        els.forEach(function (item) {
            var type = item.type;
            var tag = item.tagName.toLowerCase();

            if (type == 'text' || type == 'hidden' || type == 'password' || tag == 'textarea') {
                item.value = "";
            } else if (type == 'checkbox' || type == 'radio') {
                item.checked = false;
            } else if (tag == 'select') {
                item.selectedIndex = -1;
            }
        });
    }
    document.form1.submit();
}

function executarAcao(acao) {
    document.form1.acao.value = acao;
    document.form1.submit();
}