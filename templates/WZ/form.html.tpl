<div class="form-control-* form-row mb-2">
  <label class="col-12 col-md-6 col-form-label text-center text-md-left">Numer dokumentu</label>
  <input class="col-12 col-md-6" value="{$data['NumerWZ']}" type="text" disabled>
</div>
<div class="form-control-* form-row mb-2">
  <label class="col-12 col-md-6 col-form-label text-center text-md-left">Id zamówienia</label>
  <input class="col-12 col-md-6" value="{$data['IdZamowienie']}" type="text" disabled>
</div>
<div class="form-control-* form-row mb-2">
  <label class="col-12 col-md-6 col-form-label text-center text-md-left">Zamawiający</label>
  <input class="col-12 col-md-6" value="{$users[$zamowienia[$data['IdZamowienie']]['IdUzytkownik']]['Imie']} {$users[$zamowienia[$data['IdZamowienie']]['IdUzytkownik']]['Nazwisko']}" type="text" disabled>
</div>
<div class="form-control-* form-row mb-2">
  <label class="col-12 col-md-6 col-form-label text-center text-md-left">Data wydania</label>
  <input class="col-12 col-md-6" value="{$data['DataWydania']}" type="text" disabled>
</div>
<h3>Wystawione towary:</h3>
<table id="mainTable" class="table table-borderless text-center responsive-table border-spacing">
    <thead>
        <tr class="text-left">
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
