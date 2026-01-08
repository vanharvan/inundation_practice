#################################################################
#                                                               #
#      Control file for COMCOT tsunami simulation package       #
#      - Main Configuration File (comcot.ctl)                   #
#                                                               #
#---+----1----+----2----+----3----+----4----+----5----+----6----#
#===============================================:================
# General Parameters for Simulation             : Value Field   |
#===============================================:================
# Job Description: Kamchatka M8.8
 Total Simulated Duration (Wall clock, seconds) : 86400
 Time Interval for Snapshot Output    (seconds) :    3600
 Zmax & Gauge Output  (0-ZMax Z;1-Gauge;2-Both) :     22
 Start Type (0-Cold start; 1-Hot start)         :     20, 0.01
 Resuming Time for Hot Start          (Seconds) :     0.00
 Minimum WaterDepth offshore           (meters) :     0.05, 0.1
 Initial Cond. (0:FLT,1:File,2:WM,3:LS,4:FLT+LS):     0
 Boundary Cond.(0-Open;1-Absorb;2-Wall;3-FACTS) :     1
 Specify Filename of z Input (for BC=3, FACTS)  :23926h.asc
 Specify Filename of u Input (for BC=3, FACTS)  :23926u.asc
 Specify Filename of v Input (for BC=3, FACTS)  :23926v.asc
#
#===============================================:================
# Parameters for Fault Model (Segment 01)       :Values         |
#===============================================:================
 Number of FLT Planes (use fault_multi.ctl if>1):       9999
 Rupture Start Time(,Uplift Duration)  (seconds):       0
 Faulting Option (0:Model-C; 1:Data; 9:Model-T) :       9
 Focal Depth                            (meters):       0
 Length of Fault Plane                  (meters):       0
 Width of Fault Plane                   (meters):       0
 Dislocation of Fault Plane             (meters):       0
 Strike Angle (theta)                  (degrees):       0
 Dip  Angle (delta)                    (degrees):       0
 Slip/Rake Angle (lamda)               (degrees):       0
 Origin of Numerical Domain: Latitude  (degrees):       28.016667
 Origin of Numerical Domain: Longitude (degrees):       128.016667
 Epicenter Location: Latitude          (degrees):       0
 Epicenter Location: Longitude         (degrees):       0
 File Name of Input Data                        : 
 Data Format (0-COMCOT;1-MOST;2-XYZ;3-ASC)      :       2
#
#===============================================:================
#  Parameters for Incident Wave Maker           :Values         |
#===============================================:================
 Wave Type  (1-Solitary; 2-given; 3-focusing)   :       1
 File Name of Input Data (for Type=2)           :fse.dat
 Incident direction( 1:tp,2:bt,3:lf,4:rt,5:obl) :       2
 Characteristic Wave Amplitude         (meters) :       0.500
 Typical Water depth                   (meters) :    2000.000
#
#===============================================:================
#  Parameters for Landslide / Ground Motion     :Values         |
#===============================================:================
 X_Start of Transient Motion Area               :     119.710
 X_End of Transient Motion Area                 :     119.890
 Y_Start of Transient Motion Area               :     -0.910
 Y_End of Transient Motion Area                 :     -0.600
 File Name of Shape Input[, format(3-XYZ;4-ASC)]: MULTIPLE
 Option (0-OLD; 1-XYT; 2-LS.Solid; 3-LS.Flow)   :       2
#
#===============================================:================
# Configurations for all grid layers
#===============================================:================
# Parameters for 1st-level grids -- layer 01    :Values         |
#===============================================:================
 Run This Layer ?       (0:Yes,       1:No     ):       0
 Coordinate System   (0-Spherical, 1-Cartesian) :       0
 Governing Equations (0-linear,    1-nonlinear) :       0
 Grid Size       (dx, sph:minutes, Cart:meters) :       5
 Time Step Size                       (seconds) :       7.5
 Bottom Friction Switch (0-ON;1-OFF;2-ON,Var.n) :       1
 Manning's n (for Fric.Switch=0), {land, water} :       0.013
 Output Option?   (0-Z+Hu+Hv; 1-Z Only; 2-NONE) :       2
 X_start                                        :     128.0000
 X_end                                          :     290.0000
 Y_Start                                        :     -55.000
 Y_end                                          :     59.000
 File Name of Bathymetry Data                   : ../../batimetri/gebco_5m.asc
 Format  (0-OLD;1-MOST;2-XYZ BP;3-XYZ BN;4-ASC) :       4
 Grid Identification Number (ID)                :      01
 Grid Level                                     :       1
 Parent Grid Layer's ID Number                  :       0
#
#===============================================:================
#  Parameters for Sub-level grid -- layer 02    :Values         |
#===============================================:================
 Run This Layer ?       (0:Yes,       1:No     ):       1
 Coordinate System   (0:spherical, 1:cartesian) :       0
 Governing Equations (0:linear,    1:nonlinear) :       0
 Bottom Friction Switch (0-ON,1-OFF,2:ON,Var.n) :       1
 Manning's n (for Fric.Switch=0), {land, water} :       0.013
 Output Option? (0-Z+Hu+Hv; 1-Z Only; 2-NONE)   :       1
 GridSize Ratio of Parent Grid to Current Grid  :       4
 X_start                                        :    125.85000000
 X_end                                          :    131.52000000
 Y_Start                                        :    -4.47000000
 Y_end                                          :    -2.65000000
 File Name of Bathymetry Data                   : ../../DEMBATNAS/Layer2_6s.asc
 Format (0-OLD;1-MOST;2-XYZ BP;3-XYZ BN;4-ASC)  :       4
 Grid Identification Number (ID)                :      02
 Grid Level                                     :      2
 Parent Grid Layer's ID Number                  :      01
#
#===============================================:================
#  Parameters for Sub-level grid -- layer 03    :Values         |
#===============================================:================
 Run This Layer ?       (0:Yes,       1:No     ):       1
 Coordinate System   (0:spherical, 1:cartesian) :       0
 Governing Equations (0:linear,    1:nonlinear) :       0
 Bottom Friction Switch (0-ON,1-OFF,2:ON,Var.n) :       1
 Manning's n (for Fric.Switch=0), {land, water} :       0.013
 Output Option? (0-Z+Hu+Hv; 1-Z Only; 2-NONE)   :       1
 GridSize Ratio of Parent Grid to Current Grid  :       3
 X_start                                        :    99.8779323146182
 X_end                                          :    100.687705031588
 Y_Start                                        :    -3.2882126572909
 Y_end                                          :    -2.4741696416309
 File Name of Bathymetry Data                   : mentawai_R3.asc
 Format (0-OLD;1-MOST;2-XYZ BP;3-XYZ BN;4-ASC)  :       4
 Grid Identification Number (ID)                :      03
 Grid Level                                     :      3
 Parent Grid Layer's ID Number                  :      02
#
#===============================================:================
#  Parameters for Sub-level grid -- layer 04    :Values         |
#===============================================:================
 Run This Layer ?       (0:Yes,       1:No     ):       1
 Coordinate System   (0:spherical, 1:cartesian) :       0
 Governing Equations (0:linear,    1:nonlinear) :       1
 Bottom Friction Switch (0-ON,1-OFF,2:ON,Var.n) :       1
 Manning's n (for Fric.Switch=0), {land, water} :       0.025, 0.013
 Output Option? (0-Z+Hu+Hv; 1-Z Only; 2-NONE)   :       1
 GridSize Ratio of Parent Grid to Current Grid  :       5
 X_start                                        :    99.9513295092131
 X_end                                          :    100.005284980257
 Y_Start                                        :    -2.63536260021704
 Y_end                                          :    -2.58110144382511
 File Name of Bathymetry Data                   : mentawai_R4a1.asc
 Format (0-OLD;1-MOST;2-XYZ BP;3-XYZ BN;4-ASC)  :       4
 Grid Identification Number (ID)                :      04
 Grid Level                                     :      4
 Parent Grid Layer's ID Number                  :      03
#
#===============================================:================
#  Parameters for Sub-level grid -- layer 05    :Values         |
#===============================================:================
 Run This Layer ?       (0:Yes,       1:No     ):       1
 Coordinate System   (0:spherical, 1:cartesian) :       0
 Governing Equations (0:linear,    1:nonlinear) :       1
 Bottom Friction Switch (0-ON,1-OFF,2:ON,Var.n) :       1
 Manning's n (for Fric.Switch=0), {land, water} :       0.025, 0.013
 Output Option? (0-Z+Hu+Hv; 1-Z Only; 2-NONE)   :       1
 GridSize Ratio of Parent Grid to Current Grid  :       5
 X_start                                        :    100.0274844642370056
 X_end                                          :    100.1108177976370115
 Y_Start                                        :    -2.8741511309029999
 Y_end                                          :    -2.7908177975029997
 File Name of Bathymetry Data                   : mentawai_R4b2.asc
 Format (0-OLD;1-MOST;2-XYZ BP;3-XYZ BN;4-ASC)  :       4
 Grid Identification Number (ID)                :      05
 Grid Level                                     :      4
 Parent Grid Layer's ID Number                  :      03
#
#===============================================:================
#  Parameters for Sub-level grid -- layer 06    :Values         |
#===============================================:================
 Run This Layer ?       (0:Yes,       1:No     ):       1
 Coordinate System   (0:spherical, 1:cartesian) :       0
 Governing Equations (0:linear,    1:nonlinear) :       1
 Bottom Friction Switch (0-ON,1-OFF,2:ON,Var.n) :       1
 Manning's n (for Fric.Switch=0), {land, water} :       0.025, 0.013
 Output Option? (0-Z+Hu+Hv; 1-Z Only; 2-NONE)   :       1
 GridSize Ratio of Parent Grid to Current Grid  :       5
 X_start                                        :    100.174735983134
 X_end                                          :    100.242207063196
 Y_Start                                        :    -3.08919630568032
 Y_end                                          :    -3.02137057428536
 File Name of Bathymetry Data                   :mentawai_R4c1.asc
 Format (0-OLD;1-MOST;2-XYZ BP;3-XYZ BN;4-ASC)  :       4
 Grid Identification Number (ID)                :      06
 Grid Level                                     :      4
 Parent Grid Layer's ID Number                  :      03
#
#===============================================:================
#  Parameters for Sub-level grid -- layer 07    :Values         |
#===============================================:================
 Run This Layer ?       (0:Yes,       1:No     ):       1
 Coordinate System   (0:spherical, 1:cartesian) :       0
 Governing Equations (0:linear,    1:nonlinear) :       1
 Bottom Friction Switch (0-ON,1-OFF,2:ON,Var.n) :       1
 Manning's n (for Fric.Switch=0), {land, water} :       0.025, 0.013
 Output Option? (0-Z+Hu+Hv; 1-Z Only; 2-NONE)   :       1
 GridSize Ratio of Parent Grid to Current Grid  :       5
 X_start                                        :    100.301407052886
 X_end                                          :    100.36888794098
 Y_Start                                        :    -3.24147151350829
 Y_end                                          :    -3.17364605888817
 File Name of Bathymetry Data                   :mentawai_R4d1.asc
 Format (0-OLD;1-MOST;2-XYZ BP;3-XYZ BN;4-ASC)  :       4
 Grid Identification Number (ID)                :      07
 Grid Level                                     :      4
 Parent Grid Layer's ID Number                  :      03
#
#===============================================:================
#  Parameters for Sub-level grid -- layer 08    :Values         |
#===============================================:================
 Run This Layer ?       (0:Yes,       1:No     ):       1
 Coordinate System   (0:spherical, 1:cartesian) :       0
 Governing Equations (0:linear,    1:nonlinear) :       1
 Bottom Friction Switch (0-ON,1-OFF,2:ON,Var.n) :       1
 Manning's n (for Fric.Switch=0), {land, water} :       0.025
 Output Option? (0-Z+Hu+Hv; 1-Z Only; 2-NONE)   :       1
 GridSize Ratio of Parent Grid to Current Grid  :       3
 X_start                                        :    100.1341467869320019
 X_end                                          :    100.2614718920520056
 Y_Start                                        :    -3.1343623088399999
 Y_end                                          :    -3.0070372037199997
 File Name of Bathymetry Data                   :mentawai_R5c.asc
 Format (0-OLD;1-MOST;2-XYZ BP;3-XYZ BN;4-ASC)  :       4
 Grid Identification Number (ID)                :      08
 Grid Level                                     :      5
 Parent Grid Layer's ID Number                  :      05
#
#===============================================:================
#  Parameters for Sub-level grid -- layer 09    :Values         |
#===============================================:================
 Run This Layer ?       (0:Yes,       1:No     ):       1
 Coordinate System   (0:spherical, 1:cartesian) :       0
 Governing Equations (0:linear,    1:nonlinear) :       1
 Bottom Friction Switch (0-ON,1-OFF,2:ON,Var.n) :       1
 Manning's n (for Fric.Switch=0), {land, water} :       0.025
 Output Option? (0-Z+Hu+Hv; 1-Z Only; 2-NONE)   :       1
 GridSize Ratio of Parent Grid to Current Grid  :       3
 X_start                                        :    100.2329431051750055
 X_end                                          :    100.3602682102950092
 Y_Start                                        :    -3.3042542980390002
 Y_end                                          :    -3.1769291929190000
 File Name of Bathymetry Data                   :mentawai_R5d.asc
 Format (0-OLD;1-MOST;2-XYZ BP;3-XYZ BN;4-ASC)  :       4
 Grid Identification Number (ID)                :      09
 Grid Level                                     :      5
 Parent Grid Layer's ID Number                  :      05
#
#===============================================:================
#  Parameters for Sub-level grid -- layer 10    :Values         |
#===============================================:================
 Run This Layer ?       (0:Yes,       1:No     ):       1
 Coordinate System   (0:spherical, 1:cartesian) :       0
 Governing Equations (0:linear,    1:nonlinear) :       0
 Bottom Friction Switch (0-ON,1-OFF,2:ON,Var.n) :       1
 Manning's n (for Fric.Switch=0), {land, water} :       0.013
 Output Option? (0-Z+Hu+Hv; 1-Z Only; 2-NONE)   :       1
 GridSize Ratio of Parent Grid to Current Grid  :       2
 X_start                                        :    171.4571
 X_end                                          :    180.4357
 Y_Start                                        :    -44.1933
 Y_end                                          :    -37.5914
 File Name of Bathymetry Data                   :grid01_updated.xyz
 Format (0-OLD;1-MOST;2-XYZ BP;3-XYZ BN;4-ASC)  :       3
 Grid Identification Number (ID)                :      10
 Grid Level                                     :      10
 Parent Grid Layer's ID Number                  :      09
#
#===============================================:================
#  Parameters for Sub-level grid -- layer 11    :Values         |
#===============================================:================
 Run This Layer ?       (0:Yes,       1:No     ):       1
 Coordinate System   (0:spherical, 1:cartesian) :       0
 Governing Equations (0:linear,    1:nonlinear) :       0
 Bottom Friction Switch (0-ON,1-OFF,2:ON,Var.n) :       1
 Manning's n (for Fric.Switch=0), {land, water} :       0.013
 Output Option? (0-Z+Hu+Hv; 1-Z Only; 2-NONE)   :       1
 GridSize Ratio of Parent Grid to Current Grid  :       2
 X_start                                        :    171.9061
 X_end                                          :    180.0092
 Y_Start                                        :    -43.8632
 Y_end                                          :    -37.9050
 File Name of Bathymetry Data                   :grid01_updated.xyz
 Format (0-OLD;1-MOST;2-XYZ BP;3-XYZ BN;4-ASC)  :       3
 Grid Identification Number (ID)                :      11
 Grid Level                                     :      11
 Parent Grid Layer's ID Number                  :      10
#
#===============================================:================
#  Parameters for Sub-level grid -- layer 12    :Values         |
#===============================================:================
 Run This Layer ?       (0:Yes,       1:No     ):       1
 Coordinate System   (0:spherical, 1:cartesian) :       0
 Governing Equations (0:linear,    1:nonlinear) :       0
 Bottom Friction Switch (0-ON,1-OFF,2:ON,Var.n) :       1
 Manning's n (for Fric.Switch=0), {land, water} :       0.013
 Output Option? (0-Z+Hu+Hv; 1-Z Only; 2-NONE)   :       1
 GridSize Ratio of Parent Grid to Current Grid  :       2
 X_start                                        :    172.3112
 X_end                                          :    179.6243
 Y_Start                                        :    -43.5653
 Y_end                                          :    -38.1880
 File Name of Bathymetry Data                   :grid01_updated.xyz
 Format (0-OLD;1-MOST;2-XYZ BP;3-XYZ BN;4-ASC)  :       3
 Grid Identification Number (ID)                :      12
 Grid Level                                     :      12
 Parent Grid Layer's ID Number                  :      11
#
#===============================================:================
#  Parameters for Sub-level grid -- layer 13    :Values         |
#===============================================:================
 Run This Layer ?       (0:Yes,       1:No     ):       1
 Coordinate System   (0:spherical, 1:cartesian) :       0
 Governing Equations (0:linear,    1:nonlinear) :       0
 Bottom Friction Switch (0-ON,1-OFF,2:ON,Var.n) :       1
 Manning's n (for Fric.Switch=0), {land, water} :       0.013
 Output Option? (0-Z+Hu+Hv; 1-Z Only; 2-NONE)   :       1
 GridSize Ratio of Parent Grid to Current Grid  :       2
 X_start                                        :    172.6769
 X_end                                          :    179.2770
 Y_Start                                        :    -43.2964
 Y_end                                          :    -38.4434
 File Name of Bathymetry Data                   :grid01_updated.xyz
 Format (0-OLD;1-MOST;2-XYZ BP;3-XYZ BN;4-ASC)  :       3
 Grid Identification Number (ID)                :      13
 Grid Level                                     :      13
 Parent Grid Layer's ID Number                  :      12
#
