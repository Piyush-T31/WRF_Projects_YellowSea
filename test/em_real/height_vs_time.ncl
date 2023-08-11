;ARW coordinate dynamics option.

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"

begin

; We generate plots, but what kind do we prefer?
; type = "x11"
 type = "png"
; type = "pdf"
; type = "ps"
; type = "ncgm"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
function add_right_title(wks,plot,title)
local txres, font_height, txid, amres
begin
;---Retrieve font height of left axis string.
  getvalues plot
    "tiXAxisFontHeightF" : font_height
  end getvalues

;---Create a right axis text string to add to plot.
  txres               = True
  txres@txAngleF      = 270.
  txres@txFontHeightF = font_height  ; Use same font height as left axis

  txid = gsn_create_text(wks,title,txres)


;---Move text string to center/right edge of plot.
  amres                  = True
  amres@amParallelPosF   = 0.7    ; 0.5 is the right edge of the plot, so
                                  ; 0.6 is a little further to the right.
  amres@amOrthogonalPosF = 0.0    ; This is the center of the plot.
  amres@amJust           = "CenterCenter"

  annoid = gsn_add_annotation(plot, txid, amres)  ; Attach string to plot
  return(annoid)
end
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   a = addfile("wrfout_d02_2023-07-04_12:00:00.nc","r")
;     a = addfile("../../../low_res/wrfout_d02_2018-08-15_12:00:00.nc","r")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Set some basic resources
  res = True

  mpres  = True  ; Map resources
  pltres = True ; Plot resources

lat = new(5,float)
lon = new(5,float)

lat(0) = 36.11989
lon(0) = 125.97915 ; Gisang the stationary ship

lat(1) = 37.4231
lon(1) = 124.7381 ; S-ORS

lat(2) = 33.9419
lon(2) = 124.5928 ; G-ORS

lat(3) = 32.123
lon(3) = 125.1824 ; I-ORS

lat(4) = 34.5319
lon(4) = 124.44822 ; Onnuri

i = new(dimsizes(lat),integer)
j = new(dimsizes(lon),integer)

do loca = 0,dimsizes(lat)-1
   ij = wrf_user_ll_to_xy(a,lon(loca),lat(loca),True)
   i(loca) = ij(0)
   j(loca) = ij(1)
end do

;  i = 62 ;Sable
;  j = 51
;  i = 144 ;Hibernia
;  j = 87
;   i = 150
;   j = 74
;  i = 1
;  j = 1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;    qc = wrf_user_getvar(a,"QCLOUD",-1)
;    qc = qc*1000.
;    qc@units = "g/kg"
;    qcs=transpose(qc(:,:,j,i))

    rh = wrf_user_getvar(a,"rh",-1)
    times = wrf_times_c(a->Times,0)
    z  = wrf_user_getvar(a,"z",-1)
    Eta = fspan(0,50,50)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    do point = 0,dimsizes(lat)-1
      rhs = transpose(rh(:,:,j(point),i(point)))
      zp = z(0,:,j(point),i(point))
      Z  = round(zp,3)

      if point.eq.0 then
         title = "Gisang ship"  
         wks = gsn_open_wks(type,"RHGisang")
      elseif point.eq.1 then
         title = "S-ORS platform"
         wks = gsn_open_wks(type,"RHS-ORS")
      elseif point.eq.2 then
         title = "G-ORS platform"
         wks = gsn_open_wks(type,"RHG-ORS")
      elseif point.eq.3 then
         title = "I-ORS platform"
         wks = gsn_open_wks(type,"RHI-ORS")
      else
         title = "Onnuri"
         wks = gsn_open_wks(type,"RHOnnuri")
      end if
      gsn_define_colormap(wks,"WhBlGrYeRe")   ; overwrite the .hluresfile color map
      opts                      = res
      opts@gsnDraw              = False
      opts@gsnFrame             = False
      opts@cnFillOn             = True
      opts@gsnSpreadColors      = False
      opts@gsnMaximize          = True
      opts@gsnRightString       = "Relative Humidity(%)"
      opts@tiXAxisString        = "time is DD/HH in UTC"
      opts@gsnContourLineThicknessesScale = 0.5
      opts@cnLevelSelectionMode = "ManualLevels"
;      opts@cnMinLevelValF       = 0.025
;      opts@cnMaxLevelValF       = 0.475
;      opts@cnLevelSpacingF      = 0.025
      opts@cnMinLevelValF       = 95
      opts@cnMaxLevelValF       = 100
      opts@cnLevelSpacingF      = 0.5
      opts@tmYUseLeft           = False
      opts@tmYRLabelsOn         = True
      opts@tmYROn               = True
      opts@tmYRMode             = "Explicit"
      opts@tmYRValues           = Eta
      opts@tmYRLabels           = Z
      opts@tmYRLabelStride      = 3
      opts@tmYRMajorThicknessF  = 0
      opts@tmYRMinorThicknessF  = 0
      opts@tiYAxisString        = "Grid Level"
      opts@gsnLeftString        = title
      restick                   = True
      restick@ttmFormat         = "%D/%H"
      restick@ttmMajorStride    = 12
      time_axis_labels(times,opts,restick)

      contour = gsn_csm_contour(wks,rhs,opts)
      amid = add_right_title(wks,contour,"Height(m)")

      psres = True
      psres@gsnPaperOrientation = "Portrait"
      maximize_output(wks,psres)

      delete(opts)
end do
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
end
