/**
 * Created by Jonny on 3/16/2015.
 */
$(function(){

    YoNbuy();

    //监听滚动条
    $(window).scroll(function(){
        //导航栏的高度
        //var detail = $('.module-sf').outerHeight();
        if($(window).scrollTop()>836){
            $('.detail-for-remind').css('position','fixed').css('left','80.5px');
        }else{
            $('.detail-for-remind').css('position','relative').css('left','');
        }

        Positioning();
    });

    $('[name=apply]').click(function(event) {
        buyproudect()
    });

    // 计算剩余时间
    remainTime();
})

//网页定位导航特效
function Positioning(){
    var top = $(document).scrollTop();
    var menu = $('.tab-menu');
    var item = $('#J_DetailTabMain > div');
    var currentId = '';//当前楼层的id

    item.each(function(){
        var m = $(this);
        var itemTop = m.offset().top;
        if(top>itemTop){
            currentId = "#" + m.attr("id");
        }else{
            return false;
        }
    });

    //J_DetailTabMenu
    var currentLink = menu.find('.current');
    if(currentId&&currentLink.attr('href')!= currentId){
        currentLink.removeClass('current');
        $('#J_DetailTabMenu > li').find('[href='+currentId+']').parent().addClass('current');
        //menu.find('[href='+currentId+']').addClass('current');
    }
};

// 计算剩余时间
function remainTime () {
    var pid = $.query.get('pid');
    $.post('ajax/productTime', {'pid': pid}, function (data) {
        if(data['ret'] == 'success'){
            if(data['time'] = '0'){
                var times = $('.countdown').children('var')
                $(times.get(0)).text(data['timeoutD']);
                $(times.get(1)).text(data['timeoutH']);
                $(times.get(2)).text(data['timeoutM']);
                $(times.get(3)).text(data['timeoutMm']);
                if(data['tratus'] == '1'){
                    $('[name=apply]').text('这个宝贝已被预订！！');
                    $('.status-tip').css('background-position', '-2px -81px');
                }
            }else{
                $('.countdown').empty().text(data['time']);
            }
        }else{
            $('.countdown').empty().text('对不起，这个宝贝已经下架了！！');
            $('.status-tip').css('background-position', '-2px -81px');
        }
    }, 'json');
}

// 倒计时功能函数
function Countdowntime() {

    var timeoutTT = setInterval(function(){

        var daytime = $($('.countdown').children('var').get(0)).text()
        if(daytime >= 0){
            $($('.countdown').children('var').get(0)).text(daytime)
        }else{
            $($('.countdown').children('var').get(0)).text(00)
            clearInterval(timeoutTT);
            YoNbuy();
        }

        var hourtime = $($('.countdown').children('var').get(1)).text()
        if(hourtime >= 0){
            $($('.countdown').children('var').get(1)).text(hourtime)
        }else{
            var hourtimes = $($('.countdown').children('var').get(0)).text() - 1
            $($('.countdown').children('var').get(0)).text(hourtimes)
            $($('.countdown').children('var').get(1)).text(60)
        }

        var mintime = $($('.countdown').children('var').get(2)).text()
        if(mintime >= 0){
            $($('.countdown').children('var').get(2)).text(mintime)
        }else{
            var mintimes = $($('.countdown').children('var').get(1)).text() - 1
            $($('.countdown').children('var').get(1)).text(mintimes)
            $($('.countdown').children('var').get(2)).text(60)
        }

        var miaotime = $($('.countdown').children('var').get(3)).text() - 1
        if(miaotime >= 0){
            $($('.countdown').children('var').get(3)).text(miaotime)
        }else{
            var miaotimes = $($('.countdown').children('var').get(2)).text() - 1
            $($('.countdown').children('var').get(2)).text(miaotimes)
            $($('.countdown').children('var').get(3)).text(60)
        }
    }, 1000);
}

function selectphoto (event) {
    var newphoto = $(event.currentTarget).children().attr('src');
    $('#F_ImgBooth').attr('src',newphoto);
}

// 我要购买
function buyproudect () {
    //从cookie中取得用户名
    var username = $.cookie('username');
    var uid = $.cookie('userid');
    var pid = $.query.get('pid');

    if (username == undefined || uid == undefined){
        location.href = 'login.html';
    }else{
        $.post('ajax/buyproudect', {pid:pid,uid:uid},function (data) {
            if(data['ret'] == 'success'){

                // 修改当前倒计时，显示为交易倒计时
                $($('.countdown').children('var').get(1)).text(11);
                $($('.countdown').children('var').get(2)).text(59);
                $($('.countdown').children('var').get(3)).text(59);
                $('[name=apply]').text('这个宝贝已被预订！！');
                $('.status-tip').css('background-position', '-2px -81px');
            }
        }, 'json');
    }
}

// 确认是否下架
function YoNbuy() {
    var pid = $.query.get('pid');
    $.post('ajax/yes_or_no_buyproduct',{pid:pid},function (data) {
        if(data['ret'] == 'success'){
            if(data['buyproduct'] == 'yes'){
                $('[name=apply]').text('这个宝贝已售出！');
                $('.status-tip').css('background-position', '-2px -81px');
            }else if(data['buyproduct'] == 'no'){
                $('[name=apply]').text('这个宝贝已下架！');
                $('.status-tip').css('background-position', '-2px -81px');
            }else if(data['buyproduct'] == 'no2'){
                $('[name=apply]').text('这个宝贝正在交易！');
                $('.status-tip').css('background-position', '-2px -81px');
                Countdowntime();
            }else{
                $('[name=apply]').text('我要这个宝贝 ！');
                $('.status-tip').css('background-position', '-2px -102px');
                Countdowntime();
            }
        }
    }, 'json');
}