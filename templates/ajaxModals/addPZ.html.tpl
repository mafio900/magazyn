{extends file="../modals/formBlock.html.tpl"}
{block name=action}pz/dodaj/{/block}
{block name=title}Nowy dokument przyjęcia{/block}
{block name=body}{include file="../PZ/form.html.tpl"}{/block}
{block name=acceptButton}<button type="submit" class="btn btn-success">Dodaj</button>{/block}
