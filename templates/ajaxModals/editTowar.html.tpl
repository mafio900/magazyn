{extends file="../modals/formBlock.html.tpl"}
{block name=action}towar/edytuj/{/block}
{block name=title}Edycja towaru{/block}
{block name=body}
  {include file="../Towar/form.html.tpl"}
{/block}
{block name=acceptButton}<button type="submit" class="btn btn-success">Edytuj</button>{/block}
