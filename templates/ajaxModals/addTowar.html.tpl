{extends file="../modals/formBlock.html.tpl"}
{block name=action}towar/dodaj/{/block}
{block name=title}Nowy towar{/block}
{block name=body}{include file="../Towar/form.html.tpl"}{/block}
{block name=acceptButton}<button type="submit" class="btn btn-success">Dodaj</button>{/block}
