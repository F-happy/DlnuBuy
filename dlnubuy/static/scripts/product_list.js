/**
 * Created by Jonny on 3/14/2015.
 */
$(function(){

    //根据下拉判断是否显示隐藏导航
    $(window).scroll(function(){

        //这里我的顶部导航栏的top为116，所以监听的高度就为116了
        if($(window).scrollTop()>116){
            $(".topBox").show();

            //当满足条件时就显示出右侧的信息栏
            $("#sidebar").show();
        }else{
            $(".topBox").hide();

            //当条件不满足的时候就隐藏右侧的信息栏
            $("#sidebar").hide();
            $('.nav-content').removeClass('sidebar-move-left');
        }
    });

    // 首次加载的时候
    var cate = $.query.get('category');
    $.post('ajax/get_Allbuyinfo', {cate:cate}, function (data) {
        if(data.data.length>0){
            $('#loading').hide();
            addpubuliu(data);
            waterfall();
            add_proudctlike();
        }
    }, 'json');

    //自动返回顶端
    $('.returnTop').click(function(){
        retunTop();
    });

    //在滚动的时候动态加载新的瀑布图片
    waterfall();

    //监听滚动条
    window.onscroll=function(){
        if(checkscrollside()){
            var cate = $.query.get('category');
            $.post('ajax/get_Allbuyinfo', {cate:cate}, function (data) {
                if(data.data.length>0){
                    addpubuliu(data);
                    waterfall();
                    add_proudctlike();
                }
            }, 'json');            
        };
    }

    //隐藏的信息栏
    Sidebar();
});

//返回顶部的函数
function retunTop(){
    $('body,html').animate({scrollTop:0},1000);
    return false;
}

//动态添加瀑布图片的功能函数
function waterfall(){

    //取得展示框对象
    var $boxs = $( "#main>div" );

    // 一个块框的宽
    var w = $boxs.eq( 0).outerWidth();

    //每行中能容纳的展示框个数【窗口宽度除以一个块框宽度】
    var cols = Math.floor( ($( window ).width()-30) / w );

    //给最外围的main元素设置宽度和外边距
    $('#main').width(w*cols).css('margin','o auto');

    //用于存储 每列中的所有块框相加的高度。
    var hArr=[];

    $boxs.each( function( index, value ){
        var h = $boxs.eq( index).outerHeight();
        if( index < cols ){
            hArr[ index ] = h; //第一行中的num个块框 先添加进数组HArr
        }else{
            var minH = Math.min.apply( null, hArr );//数组HArr中的最小值minH
            var minHIndex = $.inArray( minH, hArr );
            $( value).css({
                'position':'absolute','top':minH+'px', 'left':minHIndex*w + 'px'
            });
            //数组 最小高元素的高 + 添加上的展示框[i]块框高
            hArr[ minHIndex ] += $boxs.eq( index).outerHeight();//更新添加了块框后的列高
        }
    });
}

//判断是否需要继续加载瀑布流
function checkscrollside(){
    var $lastBox = $('#main>div').last();
    var lastBoxDis = $lastBox.offset().top + Math.floor($lastBox.outerHeight()/2);
    var scrollTop = $(window).scrollTop();
    var documentH = $(window).height();
    return (lastBoxDis<scrollTop+documentH)?true:false;
}

//加载新的瀑布流内容
function addpubuliu(data) {
    $.each(data.data, function (index, value) {
        //第一级
        var Pin = $('<div>').addClass('pin').appendTo($('#main'));

        //第二级
        var Box = $('<div>').addClass('box new_poster').appendTo($(Pin));

        //第三级
        var Pic = $('<div>').addClass('np_pic').appendTo($(Box));
        $('<div>').addClass('price').text($(value).attr('money')).appendTo($(Pic));
        var a_load = $('<a>').addClass('pic_load').attr('target', '_blank').attr('href', $(value).attr('pic_load')).appendTo($(Pic));
        $('<img>').attr('src', $(value).attr('src')).appendTo($(Pic));

        //第三级
        var title = $('<div>').addClass('title').appendTo($(Box));
        var p1 = $('<p>').appendTo($(title));
        $('<a>').attr('target', '_blank').attr('href', 'product.html?pid='+$(value).attr('pdid')).text($(value).attr('title')).appendTo($(p1));

        //第三级
        $('<div>').addClass('clear_f').appendTo($(Box));

        //第三级
        var comm = $('<div>').addClass('comm_num').appendTo($(Box));
        if ($(value).attr('volume') == 1) {
            $('<a>').addClass('fr').text('出售中').appendTo($(comm));
        } else {
            $('<a>').addClass('fr red_f').text('正在交易').appendTo($(comm));
        }
        var likes = $('<a>').addClass('fl poster_likes likes').attr({'pid':$(value).attr('pdid'),'name':'pdname'}).appendTo($(comm));
        $('<b>').addClass('likes_status').text('喜  欢').appendTo($(likes));
        $('<span>').addClass('red_f poster_like_num').text($(value).attr('span')).appendTo($(likes));

        //第三级
        var share = $('<div>').addClass('np_share').appendTo($(Box));
        var user = $('<a>').addClass('avatar32_f trans07').attr('style', 'cursor: pointer;')
            .attr('user_id', $(value).attr('user_id')).appendTo($(share));
        $('<img>').attr('src', $(value).attr('user_img')).appendTo($(user));
        var p2 = $('<p>').attr('style', 'margin-left: 42px;').appendTo($(share));
        $('<a>').attr('style', 'cursor: pointer;').text($(value).attr('user_name')).appendTo($(p2));
        $('<p>').addClass('t_idt').text($(value).attr('user_info')).appendTo($(share));
        $('<div>').addClass('clear_f').appendTo($(share));
    });
}

//右侧信息栏
function Sidebar(){

    //首先先取到每个按钮的对象
    var prof = $('#prof');
    var asset = $('#asset');
    var brand = $('#brand');
    var broadcast = $('#broadcast');
    var foot = $('#foot');
    var calendar = $('#calendar');

    var close = $('.nav-con-close');

    //接下来就是给每个按钮绑定对应的click事件了
    close.click(function(){
        $('.nav-content').removeClass('sidebar-move-left');
        $('#sidebar').css('border-left','');
        $('.nav-content').addClass('sidebar-move-right');
    });

    prof.click(function(){
        var prof_content = $('#prof-content').empty();
        bindClose(prof_content)
        var uid = $.cookie('userid');
        if(uid == undefined){
            var plan = $('<div>').css('margin','40% 0').appendTo($(prof_content));
            $('<div>').css({'text-align': 'center','font-size': '25px','margin-bottom':'50px'}).text('您还没有登陆').appendTo($(plan));
            $('<div>').css({'text-align': 'center','font-size': '25px','margin-bottom':'50px'}).text('p(´⌒｀｡q)').appendTo($(plan));
            $('<div>').css({'text-align': 'center','font-size': '25px','margin-bottom':'50px'}).text('请先去登陆之后查看哦~~').appendTo($(plan));
        }else{
            $.post('ajax/get_user_info_plan', {uid:uid}, function (data) {
                if(data.ret == 'success'){
                    var plan = $('<div>').css('margin','60% 0').appendTo($(prof_content));
                    var div = $('<div>').css('text-align','center').appendTo($(plan))
                    $('<img>').attr('src',data['userimg']).appendTo($(div))
                    $('<div>').css('font-size','40px').addClass('plan').text(data['username']).appendTo($(plan));
                    $('<div>').css('font-size','18px').addClass('plan').text(data['userphone']).appendTo($(plan));
                    $('<div>').css('font-size','25px').addClass('plan').text(data['schoolAddress']).appendTo($(plan));
                }else{
                    $('<div>').text('对不起网络错误，请从新刷新！！！').appendTo($(prof_content));
                }
            }, 'json');
        }        

        if($('.nav-content').is('.sidebar-move-left')){
            $('.nav-content').removeClass('sidebar-move-left');
        }

        prof_content.addClass('sidebar-move-left');
        $('#sidebar').css('border-left','1px dotted #000');

        if(prof_content.is('.sidebar-move-right')){
            prof_content.removeClass('sidebar-move-right');
        }
    });

    asset.click(function(){
        var asset_content = $('#asset-content').empty();
        bindClose(asset_content)
        var uid = $.cookie('userid');

        if (uid == undefined) {
            var plan = $('<div>').css('margin','40% 0').appendTo($(asset_content));
            $('<div>').css({'text-align': 'center','font-size': '25px','margin-bottom':'50px'}).text('您还没有登陆').appendTo($(plan));
            $('<div>').css({'text-align': 'center','font-size': '25px','margin-bottom':'50px'}).text('p(´⌒｀｡q)').appendTo($(plan));
            $('<div>').css({'text-align': 'center','font-size': '25px','margin-bottom':'50px'}).text('请先去登陆之后查看哦~~').appendTo($(plan));
        }else{
            $.post('ajax/get_user_asset_plan', {uid:uid}, function (data) {
            if(data.ret == 'success'){
                var plan = $('<div>').css('margin','40% 0').appendTo($(asset_content));
                $('<div>').css({'text-align': 'center','font-size': '25px','margin-bottom':'50px'}).text('正在交易的宝贝').appendTo($(plan));
                $.each(data.data, function (index, value) {
                    var div = $('<div>').css({'text-align': 'center','font-size': '18px','margin': '20px 0'}).appendTo($(plan));
                    $('<a>').attr('href','#').text($(value).attr('name')).appendTo($(div));
                    $('<span>').css({'color': 'red','display': 'block','font-size': '10px'}).text('还有'+$(value).attr('time')+'个小时结束').appendTo($(div));
                })
            }else{
                var plan = $('<div>').css('margin','40% 0').appendTo($(asset_content));
                $('<div>').css({'text-align': 'center','font-size': '25px','margin-bottom':'50px'}).text('正在交易的宝贝').appendTo($(plan));
                $('<div>').css({'text-align': 'center','font-size': '25px','margin-bottom':'50px'}).text('p(´⌒｀｡q)').appendTo($(plan));
                $('<div>').css({'text-align': 'center','font-size': '25px','margin-bottom':'50px'}).text('你没有宝贝出售哦~~').appendTo($(plan));
            }
        }, 'json');
        }        

        if($('.nav-content').is('.sidebar-move-left')){
            $('.nav-content').removeClass('sidebar-move-left');
        }

        asset_content.addClass('sidebar-move-left');
        $('#sidebar').css('border-left','1px dotted #000');
        if(asset_content.is('.sidebar-move-right')){
            asset_content.removeClass('sidebar-move-right');
        }
    });

    brand.click(function(){
        var brand_content = $('#brand-content').empty();
        bindClose(brand_content)
        var cate = $.query.get('category');

        $.post('ajax/get_user_brand_plan', {cate:cate}, function (data) {
            if(data.ret == 'success'){
                var plan = $('<div>').css('margin','40% 0').appendTo($(brand_content));
                $('<div>').css({'text-align': 'center','font-size': '20px','margin-bottom':'45px'}).text('当前页面有好多分类哦').appendTo($(plan));
                $('<div>').css({'text-align': 'center','font-size': '18px','margin-bottom':'40px'}).text('快来选一个吧~~').appendTo($(plan));
                $('<div>').css({'text-align': 'center','font-size': '15px','margin-bottom':'50px'}).text('╰(*´︶`*)╯').appendTo($(plan));
                $.each(data.data, function (index, value) {
                    var div = $('<div>').css({'text-align': 'center','font-size': '18px','margin': '20px 0'}).appendTo($(plan));
                    $('<a>').attr('href','#').css('color','red').text($(value).attr('name')).appendTo($(div));
                })
            }else{
                var plan = $('<div>').css('margin','40% 0').appendTo($(brand_content));
                $('<div>').css({'text-align': 'center','font-size': '25px','margin-bottom':'50px'}).text('网络错误了...').appendTo($(plan));
                $('<div>').css({'text-align': 'center','font-size': '25px','margin-bottom':'50px'}).text('p(´⌒｀｡q)').appendTo($(plan));
                $('<div>').css({'text-align': 'center','font-size': '25px','margin-bottom':'50px'}).text('请重新刷新页面哦~~').appendTo($(plan));
            }
        }, 'json');

        if($('.nav-content').is('.sidebar-move-left')){
            $('.nav-content').removeClass('sidebar-move-left');
        }

        brand_content.addClass('sidebar-move-left');
        $('#sidebar').css('border-left','1px dotted #000');
        if(brand_content.is('.sidebar-move-right')){
            brand_content.removeClass('sidebar-move-right');
        }
    });

    broadcast.click(function(){
        var broadcast_content = $('#broadcast-content');

        if($('.nav-content').is('.sidebar-move-left')){
            $('.nav-content').removeClass('sidebar-move-left');
        }

        broadcast_content.addClass('sidebar-move-left');
        $('#sidebar').css('border-left','1px dotted #000');
        if(broadcast_content.is('.sidebar-move-right')){
            broadcast_content.removeClass('sidebar-move-right');
        }
    });

    foot.click(function(){
        var foot_content = $('#foot-content').empty();
        bindClose(foot_content)

        var plan = $('<div>').css('margin','60% 0').appendTo($(foot_content));
        $('<div>').css({'text-align': 'center','font-size': '20px','margin-bottom':'45px'}).text('最近的浏览记录哦~').appendTo($(plan));
        $('<div>').css({'text-align': 'center','font-size': '20px','margin':'60px 0'}).text('p(´⌒｀｡q)').appendTo($(plan));
        $('<div>').css({'text-align': 'center','font-size': '20px','margin':'60px 0'}).text('最近好像什么都没有看过哦~~').appendTo($(plan));

        if($('.nav-content').is('.sidebar-move-left')){
            $('.nav-content').removeClass('sidebar-move-left');
        }

        foot_content.addClass('sidebar-move-left');
        $('#sidebar').css('border-left','1px dotted #000');
        if(foot_content.is('.sidebar-move-right')){
            foot_content.removeClass('sidebar-move-right');
        }
    });

    calendar.click(function(){
        var calendar_content = $('#calendar-content').empty();
        bindClose(calendar_content)

        var plan = $('<div>').css('margin','60% 0').appendTo($(calendar_content));
        $('<div>').css({'text-align': 'center','font-size': '20px','margin-bottom':'45px'}).text('日历哦~~').appendTo($(plan));
        $('<div>').css({'text-align': 'center','font-size': '20px','margin-bottom':'45px'}).text('今天是：').appendTo($(plan));
        $('<div>').css({'text-align': 'center','font-size': '20px','margin-bottom':'45px'}).text(GetDateString()).appendTo($(plan));
        $('<div>').css({'text-align': 'center','font-size': '16px','margin-bottom':'45px','color':'#f69'}).text(GetcDateString()).appendTo($(plan));


        if($('.nav-content').is('.sidebar-move-left')){
            $('.nav-content').removeClass('sidebar-move-left');
        }

        calendar_content.addClass('sidebar-move-left');
        $('#sidebar').css('border-left','1px dotted #000');
        if(calendar_content.is('.sidebar-move-right')){
            calendar_content.removeClass('sidebar-move-right');
        }
    });

}

function bindClose(argument) {
    var arg = argument
    var dele = $('<div>').addClass('nav-con-close').appendTo(arg);
    $('<div>').addClass('close_i').appendTo($(dele))
    dele.click(function(){
        $('.nav-content').removeClass('sidebar-move-left');
        $('#sidebar').css('border-left','');
        $('.nav-content').addClass('sidebar-move-right');
    });
}
