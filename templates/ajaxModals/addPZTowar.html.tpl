{extends file="../modals/formBlock.html.tpl"}
{block name=action}pztowar/dodaj/{/block}
{block name=title}Nowy towar do PZ{/block}
{block name=body}{include file="../PZTowar/form.html.tpl"}{/block}
{block name=acceptButton}<button type="submit" class="btn btn-success">Dodaj</button>{/block}
