<div class="form-control-* form-row mb-2">
    <label class="col-12 col-md-6 col-form-label text-center text-md-left" for="NumerPZ">Numer PZ</label>
    <input class="col-12 col-md-6" name="NumerPZ" value="{$data['NumerPZ']}" type="text" required>
    <div class="col-12 text-center text-md-left"></div>
</div>
<div class="form-control-* form-row mb-2">
    <label class="col-12 col-md-6 col-form-label text-center text-md-left" for="IdDostawca">Wybierz dostawcę</label>
    <select class="col-12 col-md-6 js-select2" name="IdDostawca">
        {if !isset($data)}<option value="def">Wybierz dostawcę...</option>{/if}
        {foreach $dostawcy as $id => $dostawca}
            <option value="{$id}" {if $data['IdDostawca']==$id}selected{/if}>{$dostawca['NazwaDostawcy']}</option>
        {/foreach}
    </select>
    <div class="col-12 text-center text-md-left"></div>
</div>
<div class="form-control-* form-row mb-2">
    <label class="col-12 col-md-6 col-form-label text-center text-md-left" for="DataDostawy">Data dostawy</label>
    <input class="date col-12 col-md-6" name="DataDostawy" value="{$data['DataDostawy']}" type="text" required>
    <div class="col-12 text-center text-md-left"></div>
</div>
<div class="form-control-* form-row mb-2">
    <label class="col-12 col-md-6 col-form-label text-center text-md-left">Kwota łączna(zł)</label>
    <input class="col-12 col-md-6" value="{$data['KwotaLaczna']}" type="text" disabled>
    <div class="col-12 text-center text-md-left"></div>
</div>
{if isset($data['id'])}<input name="id" value="{$data['id']}" type="hidden" required>{/if}
