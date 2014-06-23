//var handle_move = function(li, target, droppped, tree, rb) {
var handle_move_post = function(e, data) {
  last_post_rollback = data.rlbk;
  var position = data.rslt.cp;
  var node = data.rslt.o;
  var new_parent = data.rslt.np;

  $.ajax({
    type: "POST",
    dataType: "json",
    url: base_url + node.attr("id"),
    data: ({_method: "put", "taxon_post[parent_id]": new_parent.attr("id"), "taxon_post[position]": position, authenticity_token: AUTH_TOKEN}),
    error: handle_ajax_error
  });

  return true
};

var handle_create_post = function(e, data) {
  last_post_rollback = data.rlbk;
  var node = data.rslt.obj;
  var name = data.rslt.name;
  var position = data.rslt.position;
  var new_parent = data.rslt.parent;

  $.ajax({
    type: "POST",
    dataType: "json",
    url: base_url,
    data: ({"taxon_post[name]": name, "taxon_post[parent_id]": new_parent.attr("id"), "taxon_post[position]": position, authenticity_token: AUTH_TOKEN}),
    error: handle_ajax_error,
    success: function(data,result) {
      node.attr('id', data.taxon.id);
    }
  });

};

var handle_rename_post = function(e, data) {
  last_post_rollback = data.rlbk;
  var node = data.rslt.obj;
  var name = data.rslt.new_name;

  $.ajax({
    type: "POST",
    dataType: "json",
    url: base_url + node.attr("id"),
    data: ({_method: "put", "taxon_post[name]": name, authenticity_token: AUTH_TOKEN}),
    error: handle_ajax_error
  });
 };

var handle_delete_post = function(e, data){
  last_post_rollback = data.rlbk;
  var node = data.rslt.obj;

  jConfirm(Spree.translations.are_you_sure_delete, Spree.translations.confirm_delete, function(r) {
    if(r){
      $.ajax({
        type: "POST",
        dataType: "json",
        url: base_url + node.attr("id"),
        data: ({_method: "delete", authenticity_token: AUTH_TOKEN}),
        error: handle_ajax_error
      });
    }else{
      $.jstree.rollback(last_post_rollback);
      last_post_rollback = null;
    }
  });

};

var taxonomy_post_id; 

$(document).ready(function(){
  if(taxonomy_post_id!=undefined){

    base_post_url = $("#taxonomy_post_tree").data("url").split("?")[0] + "/" ;
    child_post_url = babase_post_urlse_url.replace("/taxon_posts", "/get_children.json");
    
    is_post_cut = false;
    last_post_rollback = null;

    var post_conf = {
      json_data : {
        "data" : initial_post,
        "ajax" : {
          "url" : child_post_url,
          "data" : function (n) {
            return { parent_id : n.attr ? n.attr("id") : 0 };
          }
        }
      },
      "themes" : {
        "theme" : "apple",
        "url" : "/assets/jquery.jstree/themes/apple/style.css"
      },
      "strings" : {
        "new_node" : new_taxon_post,
        "loading" : Spree.translations.loading + "..."
      },
      "crrm" : {
        "move" : {
          "check_move" : function (m) {
            var position = m.cp;
            var node = m.o;
            var new_parent = m.np;

            if(!new_parent) return false; //no parent

            if(node.attr("rel")=="root") return false; //can't drag root

            if(new_parent.attr("id")=="taxonomy_post_tree" && position==0) return false; // can't drop before root

            return true;

          }
        }
      },
      "contextmenu" : {
         "items" : function(obj) {
            var id_of_node = obj.attr("id");
            var type_of_node = obj.attr("rel");
            var menu = {};
            if(type_of_node == "root") {
              menu = {
                "create" : {
                  "label"            : "<i class='icon-plus'></i> " + Spree.translations.add,
                  "action"           : function (obj) { this.create(obj); }
                },
                 "paste" : {
                   "separator_before" : true,
                   "label"            : "<i class='icon-paste'></i> " + Spree.translations.paste,
                   "action"           : function (obj) { is_post_cut = false; this.paste(obj); },
                   "_disabled"        : is_post_cut == false
                },
                "edit" : {
                  "separator_before" : true,
                  "label"            : "<i class='icon-edit'></i> " + Spree.translations.edit,
                  "action"           : function (obj) { window.location = base_post_url + obj.attr("id") + "/edit/"; }
                }
              }
            } else {
              menu =  {
                "create" : {
                  "label"            : "<i class='icon-plus'></i> " + Spree.translations.add,
                  "action"           : function (obj) { this.create(obj); }
                },
                "rename" : {
                  "label"            : "<i class='icon-pencil'></i> " + Spree.translations.rename,
                  "action"           : function (obj) { this.rename(obj); }
                },
                "remove" : {
                  "label"            : "<i class='icon-trash'></i> " + Spree.translations.remove,
                  "action"           : function (obj) { this.remove(obj); }
                },
                "cut" : {
                  "separator_before" : true,
                  "label"            : "<i class='icon-cut'></i> " + Spree.translations.cut,
                  "action"           : function (obj) { is_post_cut = true; this.cut(obj); }
                },
                "paste" : {
                  "label"            : "<i class='icon-paste'></i> " + Spree.translations.paste,
                  "action"           : function (obj) { is_post_cut = false; this.paste(obj); },
                  "_disabled"        : is_post_cut == false
                },
                "edit" : {
                  "separator_before" : true,
                  "label"            : "<i class='icon-edit'></i> " + Spree.translations.edit,
                  "action"           : function (obj) { window.location = base_post_url + obj.attr("id") + "/edit/"; }
                }
                    }
            }
            return menu;
        }
      },

      "plugins" : [ "themes", "json_data", "dnd", "crrm", "contextmenu"]
    }

    $("#taxonomy_post_tree").jstree(post_conf)
      .bind("move_node.jstree", handle_move_post)
      .bind("remove.jstree", handle_delete_post)
      .bind("create.jstree", handle_create_post)
      .bind("rename.jstree", handle_rename_post);

    $("#taxonomy_post_tree a").on("dblclick", function (e) {
     $("#taxonomy_post_tree").jstree("rename", this)
    });


    $(document).keypress(function(e){
      //surpress form submit on enter/return
      if (e.keyCode == 13){
          e.preventDefault();
      }
    });
  }
});
