<nav class="navbar navbar-dark navbar-expand-md bg-secondary sticky-top">
    <div class="container-fluid">
        <a class="navbar-brand" href="{$protocol}{$smarty.server.HTTP_HOST}{$subdir}">Magazyn</a>

        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#mainmenu" aria-controls="mainmenu" aria-expanded="false" aria-label="Przełącznik nawigacji">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="mainmenu">
            <ul class="navbar-nav mr-auto text-center">

                <li class="nav-item {if $active=='Towar'}active{/if}">
                    <a class="nav-link" href="{$protocol}{$smarty.server.HTTP_HOST}{$subdir}towar/"> Towary </a>
                </li>

                <li class="nav-item {if $active=='Zamowienie'}active{/if}">
                    <a class="nav-link" href="{$protocol}{$smarty.server.HTTP_HOST}{$subdir}zamowienie/"> Zamowienia </a>
                </li>

                <li class="nav-item {if $active=='WZ'}active{/if}">
                    <a class="nav-link" href="{$protocol}{$smarty.server.HTTP_HOST}{$subdir}wz/"> Dokumenty wydania </a>
                </li>

                <li class="nav-item {if $active=='PZ'}active{/if}">
                    <a class="nav-link" href="{$protocol}{$smarty.server.HTTP_HOST}{$subdir}pz/"> Dokumenty przyjęcia </a>
                </li>

            </ul>
        </div>
    </div>
</nav>
