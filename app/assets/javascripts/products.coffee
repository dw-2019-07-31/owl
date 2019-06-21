# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'turbolinks:load', ->
  console.log location.protocol
  if location.protocol == 'https:'
    rrrapi_url = "//rrrapi.dadway.com/"
    lisapi_url = "//lisapi.dadway.com/"
  else
    rrrapi_url = "//rrrapi.dad-way.local/"
    lisapi_url = "//lisapi.dad-way.local/"

  console.log rrrapi_url

  # ブランドの<select>の中身を生成する
  # 優先的に処理するために、janなどのloadより上に書いてね
  $.get "#{rrrapi_url}brandmta?select=clsid%20clsnm&order[clsnm]=ASC", (brands) ->
    for b in brands
      $('select#hinclbid').append '<option value="' + b['clsid'] + '">' + b['clsnm'] + '</option>'
    
    selected_brand = getQueryString()['hinclbid[]']
    for b in selected_brand
      $('select#hinclbid').val selected_brand
  
  # 品目ステータスの<select>の中身を生成する
  # 優先的に処理するために、janなどのloadより上に書いてね
  $.get "#{rrrapi_url}/itemstatusmta?select=clsid%20clsnm&order[clsnm]=ASC", (itemstatuses) ->
    for s in itemstatuses
      $('select#hinstscd').append '<option value="' + s['clsid'].trim() + '">' + s['clsnm'] + '</option>'
    
    selected_itemstatuses = getQueryString()['hinstscd[]']
    for b in selected_itemstatuses
      $('select#hinstscd').val selected_itemstatuses

  # 倉庫の<select>の中身を生成する
  # 優先的に処理するために、janなどのloadより上に書いてね
  $.get "#{rrrapi_url}/soumta?select=soucd%20sounm&order[soucd]=ASC", (warehouses) ->
    for b in warehouses
      $('select#soucd').append '<option value="' + b['soucd'] + '">' + b['soucd'] + '&nbsp' + b['sounm'] + '</option>'
    
    selected_warehouses = getQueryString()['soucd[]']
    for b in selected_warehouses
      $('select#soucd').val selected_warehouses

  # 新ブランドの<select>の中身を生成する
  # 優先的に処理するために、janなどのloadより上に書いてね
  $.get "#{lisapi_url}/mst_newitem/brand?select=brand_name&order[brand_name]=ASC", (brands) ->
    for b in brands
      $('select#brand_name').append '<option value="' + b['brand_name'] + '">' + b['brand_name'] + '</option>'
    
    selected_brand = getQueryString()['brand_name[]']
    for b in selected_brand
      $('select#brand_name').val selected_brand

  
  $('.ajax-autocomplete').each ->
    $(@).attr 'list', $(@).attr('id') + '_list'
    $(@).attr 'autocomplete', 'off'
  
  $('.ajax-autocomplete').on 'input', ->
    callback = (tbox) ->
      console.time('timer')

      if $(tbox).val().length == 0
        return
      
      if $(tbox).val().match '^[a-zA-Z0-9]{1}$'
        return
      
      table = $(tbox).attr('table')
      column = $(tbox).attr('column')
      
      $.ajax "#{rrrapi_url}/" + table + '/filter?' + column + '=' + $(tbox).val() + "&row_limit=5",
        cache: false
        timeout: 1000,
        success: (res, status, xhr) ->
          datalist = ''
          $('datalist#name_list > option').remove()
          for r in res
            datalist += '<option value="' + r.hinnma.trim() + '">' + r.hincd.trim()+ '</option>'
          $('datalist#name_list').html datalist
          console.log status + ', success'
          return
        error: (xhr, status, err) ->
          $('datalist#name_list > option').remove()
          console.log status + ', error'
        complete: (xhr, status) ->
          console.log status + ', complete'
      console.timeEnd('timer')
      
      return

    t = $(this)
    setTimeout ( -> callback(t)), 300
      
  $('#tbl .code').each ->
    code = $(this).html()

    # hinmta関連を取得し、セットする
    $.ajax "#{rrrapi_url}/hinmta/#{code}",
      success: (res, status, xhr) ->
        if res[0]?
          $('#' + code + '.hinnma').html res[0].hinnma
          $('#' + code + '.hinnmb').html res[0].hinnmb
          $('#' + code + '.hinclbid').html res[0].clsnm
          $('#' + code + '.hinstscd').html res[0].hinstscd
          $('#' + code + '.prctk').html res[0].prctk
          $('#' + code + '.hinenma').html res[0].hinenma
          $('#' + code + '.hinrn').html res[0].hinrn
        else
          $('#' + code + '.hinnma').html '<div>not found</div>'
          $('#' + code + '.hinnmb').html '<div>not found</div>'
          $('#' + code + '.hinclbid').html '<div>not found</div>'
          $('#' + code + '.hinstscd').html '<div>not found</div>'
          $('#' + code + '.prctk').html '<div>not found</div>'
          $('#' + code + '.hinenma').html '<div>not found</div>'
          $('#' + code + '.hinrn').html '<div>not found</div>'
       
        console.log status + ', success'
        console.log res
        return
      error: (xhr, status, err) ->
        $('#' + code + '.hinnma').html '<div>' + status + '</div>'
        $('#' + code + '.hinnmb').html '<div>' + status + '</div>'
        $('#' + code + '.hinclbid').html '<div>' + status + '</div>'
        $('#' + code + '.hinstscd').html '<div>' + status + '</div>'
        console.log status + ', error'
        return
      complete: (xhr, status) ->
        console.log status + ', complete'
        return
    
    # hinjancd関連を取得し、セットする
    $.ajax "#{rrrapi_url}/hinjancd/#{code}",
      success: (res, status, xhr) ->
        if res[0]?
          $('#' + code + '.jsjancd').html res[0].jsjancd
          #barcode生成(products/barcode　用)
          $('#' + code + '.barcode').barcode res[0].jsjancd, 'ean13'

        else
          $('#' + code + '.jsjancd').html '<div>not found</div>'

        console.log status + ', success'
        console.log res
        return
      error: (xhr, status, err) ->
        $('#' + code + '.jsjancd').html '<div>' + status + '</div>'
        console.log status + ', error'
        return
      complete: (xhr, status) ->
        console.log status + ', complete'
        return

    return
  #return

  #showのviewで動くほう。list側だとtable要素なので、動かない。とりあえずで作ったが、色々手直しが必要。
  code = $('#code').text()
  if ((code))
    # hinmta関連を取得し、セットする
    $.ajax "#{rrrapi_url}/hinmta/#{code}",
      success: (res, status, xhr) ->
        console.log res[0].hinstscd
        console.log $('#code').text()
        if res[0]?
          $('#' + code + '.hinnma').html res[0].hinnma
          $('#' + code + '.hinnmb').html res[0].hinnmb
          $('#' + code + '.hinclbid').html res[0].clsnm
          $('#' + code + '.hinstscd').html res[0].hinstscd
          $('#' + code + '.prctk').html res[0].prctk
          $('#' + code + '.hinenma').html res[0].hinenma
          $('#' + code + '.hinrn').html res[0].hinrn
        else
          $('#' + code + '.hinnma').html '<div>not found</div>'
          $('#' + code + '.hinnmb').html '<div>not found</div>'
          $('#' + code + '.hinclbid').html '<div>not found</div>'
          $('#' + code + '.hinstscd').html '<div>not found</div>'
          $('#' + code + '.prctk').html '<div>not found</div>'
          $('#' + code + '.hinenma').html '<div>not found</div>'
          $('#' + code + '.hinrn').html '<div>not found</div>'
        
        console.log status + ', success'
        console.log res
        return
      error: (xhr, status, err) ->
        $('#' + code + '.hinnma').html '<div>' + status + '</div>'
        $('#' + code + '.hinnmb').html '<div>' + status + '</div>'
        $('#' + code + '.hinclbid').html '<div>' + status + '</div>'
        $('#' + code + '.hinstscd').html '<div>' + status + '</div>'
        console.log status + ', error'
        return
      complete: (xhr, status) ->
        console.log status + ', complete'
        return
  
  # hinjancd関連を取得し、セットする
  $.ajax "#{rrrapi_url}/hinjancd/#{code}",
    success: (res, status, xhr) ->
      if res[0]?
        $('#' + code + '.jsjancd').html res[0].jsjancd
      else
        $('#' + code + '.jsjancd').html '<div>not found</div>'

      console.log status + ', success'
      console.log res
      return
    error: (xhr, status, err) ->
      $('#' + code + '.jsjancd').html '<div>' + status + '</div>'
      console.log status + ', error'
      return
    complete: (xhr, status) ->
      console.log status + ', complete'
      return

  #textareaの文字数から動的にheightの値を変化させる
  $('textarea').focus((e) ->
    #文字数から高さ取得
    height = @scrollHeight + 'px'
    $(this).css 'height', height
    return
  ).blur (e) ->
    $(this).css 'height', 'auto'
    return
  
  # stock(フリー在庫)を取得し、セットする
  $.ajax "#{rrrapi_url}/stock/free?hincd=#{code}&soucd=004",
    success: (res, status, xhr) ->
      if res?
        $('#' + code + '.stock').html res.free_stock
      else
        $('#' + code + '.stock').html 'not found'

      console.log status + ', success'
      console.log res
      return
    error: (xhr, status, err) ->
      $('#' + code + '.stock').html '<div>' + status + '</div>'
      console.log status + ', error'
      return
    complete: (xhr, status) ->
      console.log status + ', complete'
      return

  return

