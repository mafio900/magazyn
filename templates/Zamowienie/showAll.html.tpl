{extends file="../tableTemplate.html.tpl"}

{block name=title}Lista zamówień{/block}

{block name=thead}
	<th>Zamawiający</th>
    <th>Data zamówienia</th>
    <th>Data wydania</th>
    <th>Status</th>
    <th>Kwota łączna (zł)</th>
{/block}
{block name=tbody}
    <td>{$users[$row['IdUzytkownik']]['Imie']} {$users[$row['IdUzytkownik']]['Nazwisko']}</td>
    <td>{$row['DataZamowienia']}</td>
    <td>{$row['DataWydania']}</td>
    <td>{$statusy[$row['IdStatus']]['NazwaStatusu']}</td>
    <td>{$row['KwotaLaczna']}</td>
{/block}
{block name=tfoot}
{/block}
{block name=footUrlName}zamowienie{/block}

{*}Wyłącznie różnych rzeczy w table{*}
{block name=addButton}{/block}
{block name=deleteButton}{/block}
{block name=deleteSelected}{/block}
