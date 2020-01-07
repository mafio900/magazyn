{extends file="../modals/formBlock.html.tpl"}
{block name=action}pztowar/edytuj/{/block}
{block name=title}Edycja towaru w PZ{/block}
{block name=body}
  {include file="../PZTowar/form.html.tpl"}
{/block}
{block name=acceptButton}<button type="submit" class="btn btn-success">Edytuj</button>{/block}
