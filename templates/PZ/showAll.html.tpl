{extends file="../tableTemplate.html.tpl"}

{block name=title}Lista dokumentów przyjęcia{/block}

{block name=thead}
    <th></th>
	<th>Numer PZ</th>
    <th>Id dostawcy</th>
    <th>Nazwa dostawcy</th>
    <th>NIP dostawcy</th>
    <th>Data dostawy</th>
    <th>Kwota łączna(zł)</th>
{/block}
{block name=tbody}
    <td></td>
	<td>{$row['NumerPZ']}</td>
    <td>{$row['IdDostawca']}</td>
    <td>{$row['NazwaDostawcy']}</td>
    <td>{$row['NIP']}</td>
    <td>{$row['DataDostawy']}</td>
    <td>{$row['KwotaLaczna']}</td>
    <td class="buttons"><span class="btn-group">
    {if ($row['IsDone']=='0')}
    <a href="{$protocol}{$smarty.server.HTTP_HOST}{$subdir}pz/editform/{$row['id']}"
    role="button" type="button" class="edit-button btn btn-primary btn-sm ml-2" title="Pokaż szczegółowe informacje"><i class="fa fa-pencil-square-o" aria-hidden="true"></i></a>
    <a href="{$protocol}{$smarty.server.HTTP_HOST}{$subdir}pz/usun/{$row['id']}"
    role="button" class="btn btn-danger btn-sm"><i class="fa fa-times" aria-hidden="true"></i></a>
    {else}
    <button data-url="{$protocol}{$smarty.server.HTTP_HOST}{$subdir}pz/{$row['id']}"
    role="button" type="button" class="edit-button btn btn-primary btn-sm ml-2" title="Pokaż szczegółowe informacje"><i class="fa fa-pencil-square-o" aria-hidden="true"></i></button>
    {/if}
    </span></td>
{/block}
{block name=tfoot}
{/block}
{block name=footUrlName}pz{/block}
{block name=footButtonName}Dodaj PZ{/block}

{block name=editDeleteButtons}{/block}
{block name=deleteSelected}{/block}
