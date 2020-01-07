{extends file="../tableTemplate.html.tpl"}

{block name=title}Lista dokumentów wydania towaru{/block}

{block name=thead}
    <th></th>
    <th>Numer dokumentu WZ</th>
	<th>Id zamowienia</th>
    <th>Zamawiający</th>
    <th>Data wydania</th>
{/block}
{block name=tbody}
    <td></td>
	<td>{$row['NumerWZ']}</td>
    <td>{$row['IdZamowienie']}</td>
    <td>{$users[$zamowienia[$row['IdZamowienie']]['IdUzytkownik']]['Imie']} {$users[$zamowienia[$row['IdZamowienie']]['IdUzytkownik']]['Nazwisko']}</td>
    <td>{$row['DataWydania']}</td>
{/block}
{block name=tfoot}
{/block}
{block name=footUrlName}wz{/block}

{block name=addButton}{/block}
{block name=deleteButton}{/block}
{block name=deleteSelected}{/block}
