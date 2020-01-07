{extends file="./baseTemplate.html.tpl"}
{block name=body}
{if isset($data)}
    <!-- BEGIN TABLE WITH DATA -->
<div class="table-responsive tlo">
    <div class="tlo2" style="padding-bottom: 15px;">
{block name=deleteSelected}<form action="{$protocol}{$smarty.server.HTTP_HOST}{$subdir}{block name=footUrlName}{/block}/usunwiele/" method="post">{/block}
<table id="mainTable" class="table table-borderless text-center responsive-table border-spacing">
    <thead>
    <tr class="table-header">
            {block name=deleteSelected}<th></th>{/block}
            {block name=thead}
            {/block}
            <th class="hidden-print"></th>
        </tr>
    </thead>
    <tbody>
        {foreach $data as $key => $row}
        <tr class="table-row">
            {block name=deleteSelected}<td class="text-center"><input type="checkbox" value="{$row['id']}" name="ids[]" /></td>{/block}
            {block name=tbody}
            <th></th>
            {/block}
            {block name=editDeleteButtons}<td class="buttons"><span class="btn-group">{block name=editButton}<button data-url="{$protocol}{$smarty.server.HTTP_HOST}{$subdir}{block name=footUrlName}{/block}/{$row['id']}"
            role="button" type="button" class="edit-button btn btn-primary btn-sm ml-2" title="Pokaż szczegółowe informacje"><i class="fa fa-pencil-square-o" aria-hidden="true"></i></button>{/block}
            {block name=deleteButton}<a href="{$protocol}{$smarty.server.HTTP_HOST}{$subdir}{block name=footUrlName}{/block}/usun/{$row['id']}"
            role="button" class="btn btn-danger btn-sm"><i class="fa fa-times" aria-hidden="true"></i></a>{/block}</span></td>{/block}
        </tr>
        {/foreach}
    </tbody>
    <tfoot>
        <tr>
            {block name=tfoot}{/block}
        </tr>
    </tfoot>
</table><!-- END TABLE WITH DATA -->
{block name=deleteSelected}<button type="submit" class="btn btn-danger btn-sm" title="Usuń zaznaczone"><i class="fa fa-times" aria-hidden="true"></i> Usuń zaznaczone</button></br>
</form>{/block}
{block name=addButton}<button data-url="{$protocol}{$smarty.server.HTTP_HOST}{$subdir}{block name=footUrlName}{/block}/formularz"
role="button" class="add-button btn btn-primary btn-sm mt-2"><i class="fa fa-plus" aria-hidden="true"></i> {block name=footButtonName}{/block}</button>{/block}
</div>
</div>
    {/if}
{include file="./modals/base.html.tpl"}
{/block}
