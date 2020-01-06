{extends file="../modals/formBlock.html.tpl"}
{block name=action}zamowienie/edytuj/{/block}
{block name=title}Edycja zamowienia{/block}
{block name=body}
  {include file="../Zamowienie/form.html.tpl"}
{/block}
{block name=acceptButton}<button type="submit" class="btn btn-success">Edytuj</button>{/block}
