/**
 * main_framework
 * @authors jonnyF (fuhuixiang@jonnyf.com)
 * @date    2015-05-16 10:42:05
 * @version $Id$
 */

$(function(){
    //从cookie中取得用户名
    var cookie = $.cookie();
    var username = cookie.username;
    var uid = cookie.userid;

    if(username!='null' && uid!='null'){
        $.post('../ajax/loginTag',{
            username:username,
            uid:uid
        },function(data){
            if(data['ret']=='online'){
                $('#loginTags').attr('href','../users.html?id='+data['id']).text('['+data['username']+']');
                $('#loginTags').next().attr('href','javascript:logout()').text('[退出登录]');
            }else{
                window.location.href = '../login.html';
            }
        },"json");
    }
});


function logout() {

    //从cookie中取得用户名
    var cookie = $.cookie();
    var uid = cookie.userid;

    $.post('../ajax/logout',{uid:uid},function (data) {
        if(data.ret == 'outline'){
            $('#loginTags').attr('href','login.html').text('[登陆]');
            $('#loginTags').next().attr('href','register.html').text(' [免费注册]');
            $.cookie('userid',null,{path:'/'});
            $.cookie('username',null,{path:'/'});
            window.location.href = '../index.html';
        }
    }, 'json');
}

function add_proudctlike() {
    $('a[name=pdname]').click(function (event) {
        var events = event.target.parentElement;
        var pid = $(events).attr('pid');

        $.post('../add/proudctlike',{pid:pid},function (data) {
            if(data.ret == 'success'){
                $(events).children('span').text(data['num']);
                $(events).children('b').css('background-color','#ccc');
            }
        }, 'json');
    });
}

//返回顶部的函数
function retunTop(){
    $('body,html').animate({scrollTop:0},1000);
    return false;
}