<div class="form-control-* form-row mb-2">
  <label class="col-12 col-md-6 col-form-label text-center text-md-left" for="Nazwa">Nazwa towaru</label>
  <input class="col-12 col-md-6" name="Nazwa" value="{if isset($data['Nazwa'])}{$data['Nazwa']}{/if}" type="text">
  <div class="col-12 text-center text-md-left"></div>
</div>
<div class="form-control-* form-row mb-2">
  <label class="col-12 col-md-6 col-form-label text-center text-md-left" for="CenaSprzedazy">Cena sprzedaży</label>
  <input class="col-12 col-md-6" name="CenaSprzedazy" value="{if isset($data['CenaSprzedazy'])}{$data['CenaSprzedazy']}{/if}" type="text">
  <div class="col-12 text-center text-md-left"></div>
</div>
<div class="form-control-* form-row mb-2">
    <label class="col-12 col-md-6 col-form-label text-center text-md-left" for="IdJednostkaMiary">Wybierz jednostkę</label>
    <select class="col-12 col-md-6 js-select2" name="IdJednostkaMiary">
        {if !isset($data)}<option value="def">Wybierz jednostkę...</option>{/if}
        {foreach $jednostki as $id => $jednostka}
            <option value="{$id}" {if isset($data['IdJednostkaMiary']) && $data['IdJednostkaMiary']==$id}selected{/if}>{$jednostka['Nazwa']}</option>
        {/foreach}
    </select>
    <div class="col-12 text-center text-md-left"></div>
</div>
<div class="form-control-* form-row mb-2">
  <label class="col-12 col-md-6 col-form-label text-center text-md-left" for="ProcentVat">Procent vat</label>
  <input class="col-12 col-md-6" name="ProcentVat" value="{if isset($data['ProcentVat'])}{$data['ProcentVat']}{/if}" type="text">
  <div class="col-12 text-center text-md-left"></div>
</div>
<div class="form-control-* form-row mb-2">
  <label class="col-12 col-md-6 col-form-label text-center text-md-left" for="Dzial">Dział</label>
  <input class="col-12 col-md-6" name="Dzial" value="{if isset($data['Dzial'])}{$data['Dzial']}{/if}" type="text">
  <div class="col-12 text-center text-md-left"></div>
</div>
<div class="form-control-* form-row mb-2">
  <label class="col-12 col-md-6 col-form-label text-center text-md-left" for="Regal">Regał</label>
  <input class="col-12 col-md-6" name="Regal" value="{if isset($data['Regal'])}{$data['Regal']}{/if}" type="text">
  <div class="col-12 text-center text-md-left"></div>
</div>
<div class="form-control-* form-row mb-2">
  <label class="col-12 col-md-6 col-form-label text-center text-md-left" for="Polka">Półka</label>
  <input class="col-12 col-md-6" name="Polka" value="{if isset($data['Polka'])}{$data['Polka']}{/if}" type="text">
  <div class="col-12 text-center text-md-left"></div>
</div>
<div class="form-control-* form-row mb-2">
  <label class="col-12 col-md-6 col-form-label text-center text-md-left" for="StanMagazynowy">Stan magazynowy</label>
  <input class="col-12 col-md-6" name="StanMagazynowy" value="{if isset($data['StanMagazynowy'])}{$data['StanMagazynowy']}{/if}" type="text">
  <div class="col-12 text-center text-md-left"></div>
</div>
<div class="form-control-* form-row mb-2">
  <label class="col-12 col-md-6 col-form-label text-center text-md-left" for="StanMax">Stan maksymalny</label>
  <input class="col-12 col-md-6" name="StanMax" value="{if isset($data['StanMax'])}{$data['StanMax']}{/if}" type="text">
  <div class="col-12 text-center text-md-left"></div>
</div>
<div class="form-control-* form-row mb-2">
  <label class="col-12 col-md-6 col-form-label text-center text-md-left" for="StanMin">Stan minimalny</label>
  <input class="col-12 col-md-6" name="StanMin" value="{if isset($data['StanMin'])}{$data['StanMin']}{/if}" type="text">
  <div class="col-12 text-center text-md-left"></div>
</div>
<div class="form-control-* form-row mb-2">
  <label class="col-12 col-md-6 col-form-label text-center text-md-left" for="StanDysponowany">Stan dysponowany</label>
  <input class="col-12 col-md-6" name="StanDysponowany" value="{if isset($data['StanDysponowany'])}{$data['StanDysponowany']}{/if}" type="text">
  <div class="col-12 text-center text-md-left"></div>
</div>
<input name="id" value="{if isset($data['id'])}{$data['id']}{/if}" type="hidden" required>
