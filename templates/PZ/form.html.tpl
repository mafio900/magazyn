{if !isset($data)}
<div class="form-control-* form-row mb-2">
    <label class="col-12 col-md-6 col-form-label text-center text-md-left" for="NumerPZ">Numer PZ</label>
    <input class="col-12 col-md-6" name="NumerPZ" type="text" required>
    <div class="col-12 text-center text-md-left"></div>
</div>
<div class="form-control-* form-row mb-2">
    <label class="col-12 col-md-6 col-form-label text-center text-md-left" for="IdDostawca">Wybierz dostawcę</label>
    <select class="col-12 col-md-6 js-select2" name="IdDostawca">
        {if !isset($data)}<option value="def">Wybierz dostawcę...</option>{/if}
        {foreach $dostawcy as $id => $dostawca}
            <option value="{$id}">{$dostawca['NazwaDostawcy']}</option>
        {/foreach}
    </select>
    <div class="col-12 text-center text-md-left"></div>
</div>
<div class="form-control-* form-row mb-2">
    <label class="col-12 col-md-6 col-form-label text-center text-md-left" for="DataDostawy">Data dostawy</label>
    <input class="date col-12 col-md-6" name="DataDostawy" type="text" required>
    <div class="col-12 text-center text-md-left"></div>
</div>


{else}


<div class="form-control-* form-row mb-2">
    <label class="col-12 col-md-6 col-form-label text-center text-md-left">Numer PZ</label>
    <input class="col-12 col-md-6" type="text" value="{$data['NumerPZ']}" disabled>
    <div class="col-12 text-center text-md-left"></div>
</div>
<div class="form-control-* form-row mb-2">
    <label class="col-12 col-md-6 col-form-label text-center text-md-left">Nazwa dostawcy</label>
    <input class="col-12 col-md-6" type="text" value="{$data['NazwaDostawcy']}" disabled>
    <div class="col-12 text-center text-md-left"></div>
</div>
<div class="form-control-* form-row mb-2">
    <label class="col-12 col-md-6 col-form-label text-center text-md-left">Miasto</label>
    <input class="col-12 col-md-6" type="text" value="{$data['Miasto']}" disabled>
    <div class="col-12 text-center text-md-left"></div>
</div>
<div class="form-control-* form-row mb-2">
    <label class="col-12 col-md-6 col-form-label text-center text-md-left">Ulica</label>
    <input class="col-12 col-md-6" type="text" value="{$data['Ulica']}" disabled>
    <div class="col-12 text-center text-md-left"></div>
</div>
<div class="form-control-* form-row mb-2">
    <label class="col-12 col-md-6 col-form-label text-center text-md-left">Nr budynku</label>
    <input class="col-12 col-md-6" type="text" value="{$data['NrBudynku']}" disabled>
    <div class="col-12 text-center text-md-left"></div>
</div>
<div class="form-control-* form-row mb-2">
    <label class="col-12 col-md-6 col-form-label text-center text-md-left">Kod pocztowy</label>
    <input class="col-12 col-md-6" type="text" value="{$data['KodPocztowy']}" disabled>
    <div class="col-12 text-center text-md-left"></div>
</div>
<div class="form-control-* form-row mb-2">
    <label class="col-12 col-md-6 col-form-label text-center text-md-left">NIP</label>
    <input class="col-12 col-md-6" type="text" value="{$data['NIP']}" disabled>
    <div class="col-12 text-center text-md-left"></div>
</div>
<div class="form-control-* form-row mb-2">
    <label class="col-12 col-md-6 col-form-label text-center text-md-left">Data dostawy</label>
    <input class="date col-12 col-md-6" value="{$data['DataDostawy']}" type="text" disabled>
    <div class="col-12 text-center text-md-left"></div>
</div>
<h2 class="mt-5">Towary</h2>
<table id="mainTable" class="table table-borderless text-center responsive-table border-spacing">
    <thead>
        <tr>
            <th></th>
            <th>Nazwa towaru</th>
            <th>Ilość</th>
            <th>Cena kupna</th>
            <th></th>
        </tr>
    </thead>
    <tbody>
        {foreach $pztowary as $id => $pztowar}
            <tr>
                <td></td>
                <td>{$towary[$pztowar['IdTowar']]['Nazwa']}</td>
                <td>{$pztowar['Ilosc']}</td>
                <td>{$pztowar['CenaKupna']}</td>
                <td></td>
            </tr>
        {/foreach}
    </tbody>
    <tfoot>
    </tfoot>
</table>
{/if}
