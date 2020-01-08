<div class="form-control-* form-row mb-2">
  <label class="col-12 col-md-6 col-form-label text-center text-md-left">Zamawiający</label>
  <input class="col-12 col-md-6" value="{$users[$data['IdUzytkownik']]['Imie']} {$users[$data['IdUzytkownik']]['Nazwisko']}" type="text" disabled>
  <div class="col-12 text-center text-md-left"></div>
</div>
<div class="form-control-* form-row mb-2">
    <label class="col-12 col-md-6 col-form-label text-center text-md-left">Data zamówienia</label>
    <input id="DataZamowienia" class="date col-12 col-md-6" value="{$data['DataZamowienia']}" type="text" disabled>
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
    <label class="col-12 col-md-6 col-form-label text-center text-md-left">Obecny status</label>
    <input class="col-12 col-md-6" value="{$statusObecny['NazwaStatusu']}" type="text" disabled>
    <div class="col-12 text-center text-md-left"></div>
</div>
{if ($data['IdStatus']<'5')}
<div class="form-control-* form-row mb-2">
    <label class="col-12 col-md-6 col-form-label text-center text-md-left">Następny status</label>
    <input class="col-12 col-md-6" value="{$statusNastepny['NazwaStatusu']}" type="text" disabled>
    <div class="col-12 text-center text-md-left"></div>
</div>
{/if}
<input name="id" value="{if isset($data['id'])}{$data['id']}{/if}" type="hidden" required>

<h3>Zamówione towary:</h3>
<table id="mainTable" class="table table-borderless text-center responsive-table border-spacing">
    <thead>
        <tr>
            <th>Nazwa</th>
            <th>Cena sprzedaży</th>
            <th>Ilość</th>
            <th>Jednostka miary</th>
        </tr>
    </thead>
    <tbody>
        {foreach $zamowienietowary as $id => $zamowienietowar}
            <tr>
                <td>{$towary[$zamowienietowar['IdTowar']]['Nazwa']}</td>
                <td>{$zamowienietowar['CenaSprzedazy']}</td>
                <td>{$zamowienietowar['Ilosc']}</td>
                <td>{$jednostki[$towary[$zamowienietowar['IdTowar']]['IdJednostkaMiary']]['Nazwa']}</td>
            </tr>
        {/foreach}
    </tbody>
    <tfoot>
    </tfoot>
</table>
