
  <form id="{block name=id}modal{/block}-form"
        action="{$protocol}{$smarty.server.HTTP_HOST}{$subdir}{block name=action}{/block}" method="POST">
    <div class="modal-header">
        <h4 class="modal-title pull-left" id="{block name=id}modal-id{/block}-title">{block name=title}Tytuł{/block}</h4>
      <button type="button" class="close" data-dismiss="modal" aria-label="Close">
      <span aria-hidden="true">&times;</span></button>

    </div>
    <div class="modal-body">
        {block name=body}{/block}
    </div>
    <div class="modal-footer">
        <button type="button" class="btn btn-light" data-dismiss="modal">Anuluj</button>
        {block name=acceptButton}{/block}
    </div>
  </form>
