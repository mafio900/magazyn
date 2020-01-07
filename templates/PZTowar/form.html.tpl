<div class="form-control-* form-row mb-2">
    <label class="col-12 col-md-6 col-form-label text-center text-md-left" for="IdTowar">Wybierz towar</label>
    <select class="col-12 col-md-6 js-select2" style="width: 50%;" name="IdTowar">
        <option value="def">Wybierz towar...</option>
        {foreach $towary as $id => $towar}
            <option value="{$id}" {if isset($data['IdTowar']) && $data['IdTowar']==$id}selected{/if}>{$towar['Nazwa']}</option>
        {/foreach}
    </select>
    <div class="col-12 text-center text-md-left"></div>
</div>

<div class="form-control-* form-row mb-2">
  <label class="col-12 col-md-6 col-form-label text-center text-md-left" for="Ilosc">Ilość</label>
  <input class="col-12 col-md-6" name="Ilosc" value="{if isset($data['Ilosc'])}{$data['Ilosc']}{/if}" type="text" required>
  <div class="col-12 text-center text-md-left"></div>
</div>

<div class="form-control-* form-row mb-2">
  <label class="col-12 col-md-6 col-form-label text-center text-md-left" for="CenaKupna">Cena</label>
  <input class="col-12 col-md-6" name="CenaKupna" value="{if isset($data['CenaKupna'])}{$data['CenaKupna']}{/if}" type="text" required>
  <div class="col-12 text-center text-md-left"></div>
</div>

<input name="id" value="{if isset($data['id'])}{$data['id']}{/if}" type="hidden" required>
