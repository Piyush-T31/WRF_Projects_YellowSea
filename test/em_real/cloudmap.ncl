;   with the ARW coordinate dynamics option.

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

begin

; We generate plots, but what kind do we prefer?
;  type = "x11"
 type = "png"
; type = "ps"
; type = "ncgm"
  wks = gsn_open_wks(type,"plt_Cloud")
  gsn_define_colormap(wks,"WhBlGrYeRe")   ; overwrite the .hluresfile color map

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Set some basic resources
  res = True
  res@MainTitle = ""
  res@Footer = False

  mpres  = True  ; Map resources
  pltres = True ; Plot resources
  pltres@PanelPlot              = True     ; Tells wrf_map_overlays to not draw plot and
                                           ; to not remove the contours afterwards.



; Resources for map marker
  mres                                  = True
  mres@gsMarkerColor                    = "red"
  mres@gsMarkerSizeF                    = 0.01
  mres@gsMarkerThicknessF               = 1.0

  mpres@mpGeophysicalLineColor      = "Black"
  mpres@mpGridLineColor             = "Black"
  mpres@mpGeophysicalLineThicknessF = 2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;    FILES = systemfunc (" ls -1 " + "wrfout_d02_2020-09-26_* ")  ; The WRF ARW input file.
    a = addfile("wrfout_d02_2023-07-04_12:00:00.nc","r")
    times = wrf_user_getvar(a,"times",-1)  ; get all times in the file
    ntimes = dimsizes(times)         ; number of times in the file

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     qc = wrf_user_getvar(a,"QCLOUD",-1)
     qc = qc*1000
     qc@units = "g/kg"
 
     u = wrf_user_getvar(a,"U10",-1)
     u = u*1.94384
     u@units = "knot"
     v = wrf_user_getvar(a,"V10",-1)
     v = v*1.94384
     v@units = "knot"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  do it = 0,ntimes-1,1        ; TIME LOOP
;    z = wrf_user_getvar(a,"height",it)
;    zout = 70
;    qc = wrf_user_getvar(a,"QCLOUD",it)
;    qc = qc*1000.
;    qc@units = "g/kg"
;    U = wrf_user_getvar(a,"ua",it)
;    V = wrf_user_getvar(a,"va",it)

;    qc_interp = wrf_user_interp_level(qc,z,70,False)
;    U_interp = wrf_user_interp_level(U,z,70,False)
;    V_interp = wrf_user_interp_level(V,z,70,False)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    do level =  0,0,1       ; LOOP OVER LEVELS

      display_level = level + 1

      print("Working on time: " + times(it) )
      res@TimeLabel = times(it)   ; Set Valid time to use on plots

;     set the contour levels

      opts = res
      opts@cnFillOn         = True
      opts@cnLevelSelectionMode = "ManualLevels" ; manually set the contour levels with the following 3 resources
      opts@cnMinLevelValF  = 0.025               ; set the minimum contour level
      opts@cnMaxLevelValF  = 0.475                       ; set the maximum contour level
      opts@cnLevelSpacingF = 0.025                ; set the interval between contours
      opts@gsnSpreadColors  = False
      contour = wrf_contour(a,wks,qc(it,0,:,:),opts)
    
      vres = res
      vres@vcGlyphStyle = "WindBarb"
      vres@vcMinDistanceF = 0.05
      vres@FieldTitle = "10 m wind"
      vector = wrf_vector(a,wks,u(it,:,:),v(it,:,:),vres)

      plot = wrf_map_overlays(a,wks,(/contour,vector/),pltres,mpres)
      delete(contour)

      lats  = new(4,float) 
      lons  = new(4,float)
      lats(0)=37.4231
      lons(0)=124.7381
      lats(1)=33.9419
      lons(1)=124.5928
      lats(2)=32.123
      lons(2)=125.1824
      lats(3)=36.11989
      lons(3)=125.97915

      mkres1 = True
      mkres1@gsMarkerIndex =  1; filled dot
      mkres1@gsMarkerSizeF = 0.03;
      mkres1@gsMarkerColor = "Purple";

      dot = new(dimsizes(lats),graphic)
      n = 0
      do i = 0,dimsizes(dot)-1
         mk = gsn_add_polymarker(wks,plot,lons(i),lats(i),mkres1)
         dot(n) = mk
         n = n + 1
      end do

      GIlat = new(5,float) 
      GIlon = new(5,float)
      GIlat(0)=33.65111667
      GIlon(0)=124.69215
      GIlat(1)=33.36056667
      GIlon(1)=124.7857
      GIlat(2)=33.07001
      GIlon(2)=124.879233
      GIlat(3)=32.7794667
      GIlon(3)=124.9727833
      GIlat(4)=32.4889167
      GIlon(4)=125.066317

      mkresGI = True
      mkresGI@gsMarkerIndex =  1; filled dot
      mkresGI@gsMarkerSizeF = 0.02;
      mkresGI@gsMarkerColor = "Red";

      dotGI = new(dimsizes(GIlat),graphic)
      n = 0
      do i = 0,dimsizes(dotGI)-1
         mkGI = gsn_add_polymarker(wks,plot,GIlon(i),GIlat(i),mkresGI)
         dotGI(n) = mkGI
         n = n + 1
      end do


     draw(plot)
     frame(wks)
 
     delete(opts)




    end do      ; END OF LEVEL LOOP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  end do        ; END OF TIME LOOP

end

