{extends file="../baseForm.html.tpl"}

{block name=title}Edytowanie dokumentu PZ{/block}

{block name=action}
pz/edytuj/
{/block}
{block name=submitName}Edytuj{/block}
{block name=where}pz{/block}

{block name=formBody}
  {include file="./editForm.html.tpl"}
{/block}

{block name=zamowienietowar}
    {include file="./pztowarTable.html.tpl"}
{/block}
