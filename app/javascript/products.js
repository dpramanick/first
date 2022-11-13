$(function() {
    $("show-tel").on("click",function(){
        var $this = $(this)
        $this.text($this.data("telephone"));
    })

});

$('#contact-modal').on('show.bs.modal', function (event) {
    var button = $(event.relatedTarget)
    
    var modal = $(this)
});
