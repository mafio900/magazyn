{extends file="../modals/formBlock.html.tpl"}
{block name=action}zamowienie/edytuj/{/block}
{block name=title}Zmiana statusu zamowienia{/block}
{block name=body}
  {include file="../Zamowienie/form.html.tpl"}
{/block}
{if !($data['IdStatus'] == 5 || $data['IdStatus'] == 6)}
{block name=cancelButton}
    <a class="btn btn-danger" href="{$protocol}{$smarty.server.HTTP_HOST}{$subdir}{block name=footUrlName}{/block}zamowienie/anuluj/{$data['id']}">Anuluj zamówienie</a>
{/block}
{block name=acceptButton}<button type="submit" class="btn btn-success">Zmień status</button>{/block}
{/if}
