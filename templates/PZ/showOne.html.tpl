{extends file="../baseForm.html.tpl"}

{block name=title}Edytowanie dokumentu PZ{/block}

{block name=action}
pz/edytuj/
{/block}
{block name=submitName}Edytuj{/block}
{block name=where}pz{/block}
{block name=setIsDone}
    <a href="{$protocol}{$smarty.server.HTTP_HOST}{$subdir}pz/done/{$data['id']}" role="button" class="btn btn-warning">Generuj PZ</a>
    <a href="{$protocol}{$smarty.server.HTTP_HOST}{$subdir}pz/usun/{$data['id']}" role="button" class="btn btn-danger">Usuń PZ</a>
{/block}

{block name=formBody}
  {include file="./editForm.html.tpl"}
{/block}

{block name=zamowienietowar}
    {include file="./pztowarTable.html.tpl"}
{/block}
