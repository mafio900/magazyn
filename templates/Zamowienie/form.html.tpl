<div class="form-control-* form-row mb-2">
  <label class="col-12 col-md-6 col-form-label text-center text-md-left">Zamawiający</label>
  <input class="col-12 col-md-6" value="{$users[$data['IdUzytkownik']]['Imie']} {$users[$data['IdUzytkownik']]['Nazwisko']}" type="text" disabled>
  <div class="col-12 text-center text-md-left"></div>
</div>
<div class="form-control-* form-row mb-2">
    <label class="col-12 col-md-6 col-form-label text-center text-md-left">Data zamówienia</label>
    <input id="DataZamowienia" class="col-12 col-md-6" value="{$data['DataZamowienia']}" type="text" disabled>
    <div class="col-12 text-center text-md-left"></div>
</div>
{if ($data['IdStatus']>='4')}
<div class="form-control-* form-row mb-2">
    <label class="col-12 col-md-6 col-form-label text-center text-md-left" for="DataWydania">Data wydania</label>
    <input class="date col-12 col-md-6" name="DataWydania" value="{if ($data['IdStatus']=='4')}{$currentData}{else}{$data['DataWydania']}{/if}" type="text" required {if ($data['IdStatus']>'4')}disabled{/if}>
    <div class="col-12 text-center text-md-left"></div>
</div>
{/if}
<div class="form-control-* form-row mb-2">
    <label class="col-12 col-md-6 col-form-label text-center text-md-left" for="IdStatus">Status</label>
    <select class="col-12 col-md-6 js-select2" name="IdStatus" {if $data['IdStatus']=='5'}disabled{/if}>
        {foreach $statusy as $id => $status}
            <option value="{$id}" {if isset($data['IdStatus']) && $data['IdStatus']==$id}selected{/if}>{$status['NazwaStatusu']}</option>
        {/foreach}
    </select>
    <div class="col-12 text-center text-md-left"></div>
</div>
<input name="id" value="{if isset($data['id'])}{$data['id']}{/if}" type="hidden" required>
