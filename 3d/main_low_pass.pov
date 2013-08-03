//POVRay-File created by 3d41.ulp v20110101
//C:/Users/paul_000/Documents/GitHub/pi-low-pass/main_low_pass.brd
//4-8-2013 00:58:34

#version 3.5;

//Set to on if the file should be used as .inc
#local use_file_as_inc = off;
#if(use_file_as_inc=off)


//changes the apperance of resistors (1 Blob / 0 real)
#declare global_res_shape = 1;
//randomize color of resistors 1=random 0=same color
#declare global_res_colselect = 0;
//Number of the color for the resistors
//0=Green, 1="normal color" 2=Blue 3=Brown
#declare global_res_col = 1;
//Set to on if you want to render the PCB upside-down
#declare pcb_upsidedown = off;
//Set to x or z to rotate around the corresponding axis (referring to pcb_upsidedown)
#declare pcb_rotdir = x;
//Set the length off short pins over the PCB
#declare pin_length = 2.5;
#declare global_diode_bend_radius = 1;
#declare global_res_bend_radius = 1;
#declare global_solder = on;

#declare global_show_screws = on;
#declare global_show_washers = on;
#declare global_show_nuts = on;

#declare global_use_radiosity = on;

#declare global_ambient_mul = 1;
#declare global_ambient_mul_emit = 0;

//Animation
#declare global_anim = off;
#local global_anim_showcampath = no;

#declare global_fast_mode = off;

#declare col_preset = 2;
#declare pin_short = on;

#declare e3d_environment = off;

#local cam_x = 0;
#local cam_y = 145;
#local cam_z = -70;
#local cam_a = 20;
#local cam_look_x = 0;
#local cam_look_y = -3;
#local cam_look_z = 0;

#local pcb_rotate_x = 0;
#local pcb_rotate_y = 0;
#local pcb_rotate_z = 0;

#local pcb_board = on;
#local pcb_parts = on;
#local pcb_wire_bridges = off;
#if(global_fast_mode=off)
	#local pcb_polygons = on;
	#local pcb_silkscreen = on;
	#local pcb_wires = on;
	#local pcb_pads_smds = on;
#else
	#local pcb_polygons = off;
	#local pcb_silkscreen = off;
	#local pcb_wires = off;
	#local pcb_pads_smds = off;
#end

#local lgt1_pos_x = 17;
#local lgt1_pos_y = 25;
#local lgt1_pos_z = 16;
#local lgt1_intense = 0.719758;
#local lgt2_pos_x = -17;
#local lgt2_pos_y = 25;
#local lgt2_pos_z = 16;
#local lgt2_intense = 0.719758;
#local lgt3_pos_x = 17;
#local lgt3_pos_y = 25;
#local lgt3_pos_z = -10;
#local lgt3_intense = 0.719758;
#local lgt4_pos_x = -17;
#local lgt4_pos_y = 25;
#local lgt4_pos_z = -10;
#local lgt4_intense = 0.719758;

//Do not change these values
#declare pcb_height = 1.500000;
#declare pcb_cuheight = 0.035000;
#declare pcb_x_size = 45.390000;
#declare pcb_y_size = 30.470000;
#declare pcb_layer1_used = 1;
#declare pcb_layer16_used = 1;
#declare inc_testmode = off;
#declare global_seed=seed(799);
#declare global_pcb_layer_dis = array[16]
{
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	1.535000,
}
#declare global_pcb_real_hole = 2.000000;

#include "e3d_tools.inc"
#include "e3d_user.inc"

global_settings{charset utf8}

#if(e3d_environment=on)
sky_sphere {pigment {Navy}
pigment {bozo turbulence 0.65 octaves 7 omega 0.7 lambda 2
color_map {
[0.0 0.1 color rgb <0.85, 0.85, 0.85> color rgb <0.75, 0.75, 0.75>]
[0.1 0.5 color rgb <0.75, 0.75, 0.75> color rgbt <1, 1, 1, 1>]
[0.5 1.0 color rgbt <1, 1, 1, 1> color rgbt <1, 1, 1, 1>]}
scale <0.1, 0.5, 0.1>} rotate -90*x}
plane{y, -10.0-max(pcb_x_size,pcb_y_size)*abs(max(sin((pcb_rotate_x/180)*pi),sin((pcb_rotate_z/180)*pi)))
texture{T_Chrome_2D
normal{waves 0.1 frequency 3000.0 scale 3000.0}} translate<0,0,0>}
#end

//Animation data
#if(global_anim=on)
#declare global_anim_showcampath = no;
#end

#if((global_anim=on)|(global_anim_showcampath=yes))
#declare global_anim_npoints_cam_flight=0;
#warning "No/not enough Animation Data available (min. 3 points) (Flight path)"
#end

#if((global_anim=on)|(global_anim_showcampath=yes))
#declare global_anim_npoints_cam_view=0;
#warning "No/not enough Animation Data available (min. 3 points) (View path)"
#end

#if((global_anim=on)|(global_anim_showcampath=yes))
#end

#if((global_anim_showcampath=yes)&(global_anim=off))
#end
#if(global_anim=on)
camera
{
	location global_anim_spline_cam_flight(clock)
	#if(global_anim_npoints_cam_view>2)
		look_at global_anim_spline_cam_view(clock)
	#else
		look_at global_anim_spline_cam_flight(clock+0.01)-<0,-0.01,0>
	#end
	angle 45
}
light_source
{
	global_anim_spline_cam_flight(clock)
	color rgb <1,1,1>
	spotlight point_at 
	#if(global_anim_npoints_cam_view>2)
		global_anim_spline_cam_view(clock)
	#else
		global_anim_spline_cam_flight(clock+0.01)-<0,-0.01,0>
	#end
	radius 35 falloff  40
}
#else
camera
{
	location <cam_x,cam_y,cam_z>
	look_at <cam_look_x,cam_look_y,cam_look_z>
	angle cam_a
	//translates the camera that <0,0,0> is over the Eagle <0,0>
	//translate<-22.695000,0,-15.235000>
}
#end

background{col_bgr}
light_source{<lgt1_pos_x,lgt1_pos_y,lgt1_pos_z> White*lgt1_intense}
light_source{<lgt2_pos_x,lgt2_pos_y,lgt2_pos_z> White*lgt2_intense}
light_source{<lgt3_pos_x,lgt3_pos_y,lgt3_pos_z> White*lgt3_intense}
light_source{<lgt4_pos_x,lgt4_pos_y,lgt4_pos_z> White*lgt4_intense}
#end


#macro MAIN_LOW_PASS(mac_x_ver,mac_y_ver,mac_z_ver,mac_x_rot,mac_y_rot,mac_z_rot)
union{
#if(pcb_board = on)
difference{
union{
//Board
prism{-1.500000,0.000000,8
<0.000000,-1.270000><45.390000,-1.270000>
<45.390000,-1.270000><45.390000,29.200000>
<45.390000,29.200000><0.000000,29.200000>
<0.000000,29.200000><0.000000,-1.270000>
texture{col_brd}}
}//End union(PCB)
//Holes(real)/Parts
cylinder{<43.180000,1,19.050000><43.180000,-5,19.050000>1.600000 texture{col_hls}}
cylinder{<43.180000,1,26.670000><43.180000,-5,26.670000>1.600000 texture{col_hls}}
//Holes(real)/Board
//Holes(real)/Vias
}//End difference(reale Bohrungen/Durchbrüche)
#end
#if(pcb_parts=on)//Parts
union{
#ifndef(pack_C1) #declare global_pack_C1=yes; object {CAP_SMD_ELKO_0605("15u",)translate<0,0,0> rotate<0,180.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<5.080000,0.000000,8.890000>translate<0,0.035000,0> }#end		//SMD Elko Case-Code BCComponents (rcl.lib) C1 15u 153CLV-0605
#ifndef(pack_C2) #declare global_pack_C2=yes; object {CAP_SMD_CHIP_0805()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<16.510000,0.000000,12.700000>translate<0,0.035000,0> }#end		//SMD Capacitor 0805 C2  C0805
#ifndef(pack_C3) #declare global_pack_C3=yes; object {CAP_SMD_CHIP_0805()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<22.860000,0.000000,11.430000>translate<0,0.035000,0> }#end		//SMD Capacitor 0805 C3  C0805
#ifndef(pack_IC1) #declare global_pack_IC1=yes; object {IC_SMD_SO14("74HC14D","",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<29.210000,0.000000,8.890000>translate<0,0.035000,0> }#end		//SMD IC SO14 Package IC1 74HC14D SO14
#ifndef(pack_JP1) #declare global_pack_JP1=yes; object {CON_PH_1X4()translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<5.080000,0.000000,1.270000>}#end		//Header 2,54mm Grid 4Pin 1Row (jumper.lib) JP1  1X04
#ifndef(pack_JP2) #declare global_pack_JP2=yes; object {CON_PH_1X4()translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<38.100000,0.000000,1.270000>}#end		//Header 2,54mm Grid 4Pin 1Row (jumper.lib) JP2  1X04
#ifndef(pack_JP3) #declare global_pack_JP3=yes; object {CON_PH_1X3()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<41.910000,0.000000,10.160000>}#end		//Header 2,54mm Grid 3Pin 1Row (jumper.lib) JP3  1X03
#ifndef(pack_JP4) #declare global_pack_JP4=yes; object {CON_PH_1X11()translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<20.320000,0.000000,34.290000>}#end		//Header 2,54mm Grid 11Pin 1Row (jumper.lib) JP4  1X11
#ifndef(pack_LED1) #declare global_pack_LED1=yes; object {DIODE_SMD_LED_CHIP_0805(Red,0.500000,0.000000,)translate<0,0,0> rotate<0,90.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<38.100000,0.000000,19.050000>translate<0,0.035000,0> }#end		//SMD-LED im 0805 LED1  CHIP-LED0805
#ifndef(pack_LED2) #declare global_pack_LED2=yes; object {DIODE_SMD_LED_CHIP_0805(Red,0.500000,0.000000,)translate<0,0,0> rotate<0,90.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<35.560000,0.000000,6.350000>translate<0,0.035000,0> }#end		//SMD-LED im 0805 LED2  CHIP-LED0805
#ifndef(pack_R1) #declare global_pack_R1=yes; object {RES_SMD_CHIP_0805("0R0",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<2.540000,0.000000,13.970000>translate<0,0.035000,0> }#end		//SMD Resistor 0805 R1  R0805
#ifndef(pack_R2) #declare global_pack_R2=yes; object {RES_SMD_CHIP_0805("0R0",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<7.620000,0.000000,13.970000>translate<0,0.035000,0> }#end		//SMD Resistor 0805 R2  R0805
#ifndef(pack_R3) #declare global_pack_R3=yes; object {RES_SMD_CHIP_0805("0R0",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<39.370000,0.000000,16.510000>translate<0,0.035000,0> }#end		//SMD Resistor 0805 R3  R0805
#ifndef(pack_R4) #declare global_pack_R4=yes; object {RES_SMD_CHIP_0805("0R0",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<38.100000,0.000000,7.620000>translate<0,0.035000,0> }#end		//SMD Resistor 0805 R4  R0805
#ifndef(pack_SV1) #declare global_pack_SV1=yes; object {CON_PH_2X13()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<16.510000,0.000000,19.050000>}#end		//Header 2,54mm Grid 13Pin 2Row (jumper.lib) SV1  2X13
#ifndef(pack_SV2) #declare global_pack_SV2=yes; object {CON_PH_2X13()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<16.510000,0.000000,25.400000>}#end		//Header 2,54mm Grid 13Pin 2Row (jumper.lib) SV2  2X13
}//End union
#end
#if(pcb_pads_smds=on)
//Pads&SMD/Parts
object{TOOLS_PCB_SMD(3.500000,1.600000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<2.380000,0.000000,8.890000>}
object{TOOLS_PCB_SMD(3.500000,1.600000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<7.780000,0.000000,8.890000>}
object{TOOLS_PCB_SMD(1.300000,1.500000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<17.360000,0.000000,12.700000>}
object{TOOLS_PCB_SMD(1.300000,1.500000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<15.660000,0.000000,12.700000>}
object{TOOLS_PCB_SMD(1.300000,1.500000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<22.860000,0.000000,12.280000>}
object{TOOLS_PCB_SMD(1.300000,1.500000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<22.860000,0.000000,10.580000>}
object{TOOLS_PCB_SMD(0.660400,2.032000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<25.400000,0.000000,5.816600>}
object{TOOLS_PCB_SMD(0.660400,2.032000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<26.670000,0.000000,5.816600>}
object{TOOLS_PCB_SMD(0.660400,2.032000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<27.940000,0.000000,5.816600>}
object{TOOLS_PCB_SMD(0.660400,2.032000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<29.210000,0.000000,5.816600>}
object{TOOLS_PCB_SMD(0.660400,2.032000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<30.480000,0.000000,5.816600>}
object{TOOLS_PCB_SMD(0.660400,2.032000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<31.750000,0.000000,5.816600>}
object{TOOLS_PCB_SMD(0.660400,2.032000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<33.020000,0.000000,5.816600>}
object{TOOLS_PCB_SMD(0.660400,2.032000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<33.020000,0.000000,11.963400>}
object{TOOLS_PCB_SMD(0.660400,2.032000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<31.750000,0.000000,11.963400>}
object{TOOLS_PCB_SMD(0.660400,2.032000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<30.480000,0.000000,11.963400>}
object{TOOLS_PCB_SMD(0.660400,2.032000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<29.210000,0.000000,11.963400>}
object{TOOLS_PCB_SMD(0.660400,2.032000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<27.940000,0.000000,11.963400>}
object{TOOLS_PCB_SMD(0.660400,2.032000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<26.670000,0.000000,11.963400>}
object{TOOLS_PCB_SMD(0.660400,2.032000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<25.400000,0.000000,11.963400>}
#ifndef(global_pack_JP1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<1.270000,0,1.270000> texture{col_thl}}
#ifndef(global_pack_JP1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<3.810000,0,1.270000> texture{col_thl}}
#ifndef(global_pack_JP1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<6.350000,0,1.270000> texture{col_thl}}
#ifndef(global_pack_JP1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<8.890000,0,1.270000> texture{col_thl}}
#ifndef(global_pack_JP2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<34.290000,0,1.270000> texture{col_thl}}
#ifndef(global_pack_JP2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<36.830000,0,1.270000> texture{col_thl}}
#ifndef(global_pack_JP2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<39.370000,0,1.270000> texture{col_thl}}
#ifndef(global_pack_JP2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<41.910000,0,1.270000> texture{col_thl}}
#ifndef(global_pack_JP3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<41.910000,0,7.620000> texture{col_thl}}
#ifndef(global_pack_JP3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<41.910000,0,10.160000> texture{col_thl}}
#ifndef(global_pack_JP3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<41.910000,0,12.700000> texture{col_thl}}
#ifndef(global_pack_JP4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<7.620000,0,34.290000> texture{col_thl}}
#ifndef(global_pack_JP4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<10.160000,0,34.290000> texture{col_thl}}
#ifndef(global_pack_JP4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<12.700000,0,34.290000> texture{col_thl}}
#ifndef(global_pack_JP4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<15.240000,0,34.290000> texture{col_thl}}
#ifndef(global_pack_JP4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<17.780000,0,34.290000> texture{col_thl}}
#ifndef(global_pack_JP4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<20.320000,0,34.290000> texture{col_thl}}
#ifndef(global_pack_JP4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<22.860000,0,34.290000> texture{col_thl}}
#ifndef(global_pack_JP4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<25.400000,0,34.290000> texture{col_thl}}
#ifndef(global_pack_JP4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<27.940000,0,34.290000> texture{col_thl}}
#ifndef(global_pack_JP4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<30.480000,0,34.290000> texture{col_thl}}
#ifndef(global_pack_JP4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<33.020000,0,34.290000> texture{col_thl}}
object{TOOLS_PCB_SMD(1.200000,1.200000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<39.150000,0.000000,19.050000>}
object{TOOLS_PCB_SMD(1.200000,1.200000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<37.050000,0.000000,19.050000>}
object{TOOLS_PCB_SMD(1.200000,1.200000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<35.560000,0.000000,5.300000>}
object{TOOLS_PCB_SMD(1.200000,1.200000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<35.560000,0.000000,7.400000>}
object{TOOLS_PCB_SMD(1.300000,1.500000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<1.690000,0.000000,13.970000>}
object{TOOLS_PCB_SMD(1.300000,1.500000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<3.390000,0.000000,13.970000>}
object{TOOLS_PCB_SMD(1.300000,1.500000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<6.770000,0.000000,13.970000>}
object{TOOLS_PCB_SMD(1.300000,1.500000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<8.470000,0.000000,13.970000>}
object{TOOLS_PCB_SMD(1.300000,1.500000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<39.370000,0.000000,17.360000>}
object{TOOLS_PCB_SMD(1.300000,1.500000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<39.370000,0.000000,15.660000>}
object{TOOLS_PCB_SMD(1.300000,1.500000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<38.100000,0.000000,6.770000>}
object{TOOLS_PCB_SMD(1.300000,1.500000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<38.100000,0.000000,8.470000>}
#ifndef(global_pack_SV1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<31.750000,0,20.320000> texture{col_thl}}
#ifndef(global_pack_SV1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<31.750000,0,17.780000> texture{col_thl}}
#ifndef(global_pack_SV1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<29.210000,0,20.320000> texture{col_thl}}
#ifndef(global_pack_SV1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<29.210000,0,17.780000> texture{col_thl}}
#ifndef(global_pack_SV1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<26.670000,0,20.320000> texture{col_thl}}
#ifndef(global_pack_SV1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<26.670000,0,17.780000> texture{col_thl}}
#ifndef(global_pack_SV1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<24.130000,0,20.320000> texture{col_thl}}
#ifndef(global_pack_SV1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<24.130000,0,17.780000> texture{col_thl}}
#ifndef(global_pack_SV1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<21.590000,0,20.320000> texture{col_thl}}
#ifndef(global_pack_SV1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<21.590000,0,17.780000> texture{col_thl}}
#ifndef(global_pack_SV1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<19.050000,0,20.320000> texture{col_thl}}
#ifndef(global_pack_SV1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<19.050000,0,17.780000> texture{col_thl}}
#ifndef(global_pack_SV1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<16.510000,0,20.320000> texture{col_thl}}
#ifndef(global_pack_SV1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<16.510000,0,17.780000> texture{col_thl}}
#ifndef(global_pack_SV1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<13.970000,0,20.320000> texture{col_thl}}
#ifndef(global_pack_SV1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<13.970000,0,17.780000> texture{col_thl}}
#ifndef(global_pack_SV1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<11.430000,0,20.320000> texture{col_thl}}
#ifndef(global_pack_SV1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<11.430000,0,17.780000> texture{col_thl}}
#ifndef(global_pack_SV1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<8.890000,0,20.320000> texture{col_thl}}
#ifndef(global_pack_SV1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<8.890000,0,17.780000> texture{col_thl}}
#ifndef(global_pack_SV1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<6.350000,0,20.320000> texture{col_thl}}
#ifndef(global_pack_SV1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<6.350000,0,17.780000> texture{col_thl}}
#ifndef(global_pack_SV1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<3.810000,0,20.320000> texture{col_thl}}
#ifndef(global_pack_SV1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<3.810000,0,17.780000> texture{col_thl}}
#ifndef(global_pack_SV1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<1.270000,0,20.320000> texture{col_thl}}
#ifndef(global_pack_SV1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<1.270000,0,17.780000> texture{col_thl}}
#ifndef(global_pack_SV2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<31.750000,0,26.670000> texture{col_thl}}
#ifndef(global_pack_SV2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<31.750000,0,24.130000> texture{col_thl}}
#ifndef(global_pack_SV2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<29.210000,0,26.670000> texture{col_thl}}
#ifndef(global_pack_SV2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<29.210000,0,24.130000> texture{col_thl}}
#ifndef(global_pack_SV2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<26.670000,0,26.670000> texture{col_thl}}
#ifndef(global_pack_SV2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<26.670000,0,24.130000> texture{col_thl}}
#ifndef(global_pack_SV2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<24.130000,0,26.670000> texture{col_thl}}
#ifndef(global_pack_SV2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<24.130000,0,24.130000> texture{col_thl}}
#ifndef(global_pack_SV2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<21.590000,0,26.670000> texture{col_thl}}
#ifndef(global_pack_SV2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<21.590000,0,24.130000> texture{col_thl}}
#ifndef(global_pack_SV2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<19.050000,0,26.670000> texture{col_thl}}
#ifndef(global_pack_SV2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<19.050000,0,24.130000> texture{col_thl}}
#ifndef(global_pack_SV2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<16.510000,0,26.670000> texture{col_thl}}
#ifndef(global_pack_SV2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<16.510000,0,24.130000> texture{col_thl}}
#ifndef(global_pack_SV2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<13.970000,0,26.670000> texture{col_thl}}
#ifndef(global_pack_SV2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<13.970000,0,24.130000> texture{col_thl}}
#ifndef(global_pack_SV2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<11.430000,0,26.670000> texture{col_thl}}
#ifndef(global_pack_SV2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<11.430000,0,24.130000> texture{col_thl}}
#ifndef(global_pack_SV2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<8.890000,0,26.670000> texture{col_thl}}
#ifndef(global_pack_SV2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<8.890000,0,24.130000> texture{col_thl}}
#ifndef(global_pack_SV2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<6.350000,0,26.670000> texture{col_thl}}
#ifndef(global_pack_SV2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<6.350000,0,24.130000> texture{col_thl}}
#ifndef(global_pack_SV2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<3.810000,0,26.670000> texture{col_thl}}
#ifndef(global_pack_SV2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<3.810000,0,24.130000> texture{col_thl}}
#ifndef(global_pack_SV2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<1.270000,0,26.670000> texture{col_thl}}
#ifndef(global_pack_SV2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<1.270000,0,24.130000> texture{col_thl}}
object{TOOLS_PCB_SMD(1.473200,0.355600,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<13.589000,0.000000,11.125200>}
object{TOOLS_PCB_SMD(1.473200,0.355600,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<13.589000,0.000000,10.490200>}
object{TOOLS_PCB_SMD(1.473200,0.355600,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<13.589000,0.000000,9.829800>}
object{TOOLS_PCB_SMD(1.473200,0.355600,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<13.589000,0.000000,9.194800>}
object{TOOLS_PCB_SMD(1.473200,0.355600,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<19.431000,0.000000,9.194800>}
object{TOOLS_PCB_SMD(1.473200,0.355600,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<19.431000,0.000000,9.829800>}
object{TOOLS_PCB_SMD(1.473200,0.355600,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<19.431000,0.000000,10.490200>}
object{TOOLS_PCB_SMD(1.473200,0.355600,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<19.431000,0.000000,11.125200>}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.900000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<36.830000,0,20.955000> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.900000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<34.290000,0,22.225000> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.900000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<36.830000,0,23.495000> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.900000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<34.290000,0,24.765000> texture{col_thl}}
//Pads/Vias
object{TOOLS_PCB_VIA(0.904800,0.600000,1,16,1,0) translate<1.270000,0,11.430000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.904800,0.600000,1,16,1,0) translate<30.480000,0,2.540000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.904800,0.600000,1,16,1,0) translate<22.860000,0,8.890000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.904800,0.600000,1,16,1,0) translate<35.560000,0,19.050000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.904800,0.600000,1,16,1,0) translate<25.400000,0,3.810000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.904800,0.600000,1,16,1,0) translate<33.020000,0,3.810000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.904800,0.600000,1,16,1,0) translate<5.080000,0,11.430000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.904800,0.600000,1,16,1,0) translate<5.080000,0,15.240000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.904800,0.600000,1,16,1,0) translate<21.590000,0,7.620000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.904800,0.600000,1,16,1,0) translate<21.590000,0,2.540000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.904800,0.600000,1,16,1,0) translate<2.540000,0,5.080000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.904800,0.600000,1,16,1,0) translate<8.890000,0,11.430000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.904800,0.600000,1,16,1,0) translate<15.240000,0,6.350000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.904800,0.600000,1,16,1,0) translate<33.020000,0,16.510000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.904800,0.600000,1,16,1,0) translate<35.560000,0,16.510000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.904800,0.600000,1,16,1,0) translate<30.480000,0,8.890000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.904800,0.600000,1,16,1,0) translate<25.400000,0,13.970000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.904800,0.600000,1,16,1,0) translate<34.290000,0,13.970000> texture{col_thl}}
#end
#if(pcb_wires=on)
union{
//Signals
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.270000,-1.535000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.270000,-1.535000,10.160000>}
box{<0,0,-0.127000><1.270000,0.035000,0.127000> rotate<0,-90.000000,0> translate<1.270000,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.270000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.270000,0.000000,24.130000>}
box{<0,0,-0.127000><1.270000,0.035000,0.127000> rotate<0,90.000000,0> translate<1.270000,0.000000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.270000,0.000000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.690000,0.000000,13.120000>}
box{<0,0,-0.127000><1.741407,0.035000,0.127000> rotate<0,-76.038537,0> translate<1.270000,0.000000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.690000,0.000000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.690000,0.000000,13.120000>}
box{<0,0,-0.127000><0.850000,0.035000,0.127000> rotate<0,-90.000000,0> translate<1.690000,0.000000,13.120000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.380000,0.000000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.540000,0.000000,8.730000>}
box{<0,0,-0.127000><0.226274,0.035000,0.127000> rotate<0,44.997030,0> translate<2.380000,0.000000,8.890000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.540000,0.000000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.540000,0.000000,8.730000>}
box{<0,0,-0.127000><3.650000,0.035000,0.127000> rotate<0,90.000000,0> translate<2.540000,0.000000,8.730000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.270000,0.000000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.540000,0.000000,19.050000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,-44.997030,0> translate<1.270000,0.000000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.270000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.540000,0.000000,21.590000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,44.997030,0> translate<1.270000,0.000000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.540000,0.000000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.540000,0.000000,21.590000>}
box{<0,0,-0.127000><2.540000,0.035000,0.127000> rotate<0,90.000000,0> translate<2.540000,0.000000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.390000,0.000000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.810000,0.000000,14.390000>}
box{<0,0,-0.127000><0.593970,0.035000,0.127000> rotate<0,-44.997030,0> translate<3.390000,0.000000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.810000,0.000000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.810000,0.000000,14.390000>}
box{<0,0,-0.127000><0.850000,0.035000,0.127000> rotate<0,-90.000000,0> translate<3.810000,0.000000,14.390000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.810000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.810000,0.000000,24.130000>}
box{<0,0,-0.127000><1.270000,0.035000,0.127000> rotate<0,90.000000,0> translate<3.810000,0.000000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.080000,0.000000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.080000,0.000000,11.430000>}
box{<0,0,-0.127000><6.350000,0.035000,0.127000> rotate<0,90.000000,0> translate<5.080000,0.000000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.080000,-1.535000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.080000,-1.535000,15.240000>}
box{<0,0,-0.127000><3.810000,0.035000,0.127000> rotate<0,90.000000,0> translate<5.080000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.810000,0.000000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.080000,0.000000,19.050000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,-44.997030,0> translate<3.810000,0.000000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.810000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.080000,0.000000,21.590000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,44.997030,0> translate<3.810000,0.000000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.080000,0.000000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.080000,0.000000,21.590000>}
box{<0,0,-0.127000><2.540000,0.035000,0.127000> rotate<0,90.000000,0> translate<5.080000,0.000000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.080000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.080000,0.000000,25.400000>}
box{<0,0,-0.127000><2.540000,0.035000,0.127000> rotate<0,90.000000,0> translate<5.080000,0.000000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.810000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.350000,-1.535000,20.320000>}
box{<0,0,-0.127000><2.540000,0.035000,0.127000> rotate<0,0.000000,0> translate<3.810000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.080000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.350000,0.000000,21.590000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,44.997030,0> translate<5.080000,0.000000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.350000,0.000000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.350000,0.000000,21.590000>}
box{<0,0,-0.127000><1.270000,0.035000,0.127000> rotate<0,90.000000,0> translate<6.350000,0.000000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.350000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.350000,0.000000,24.130000>}
box{<0,0,-0.127000><1.270000,0.035000,0.127000> rotate<0,90.000000,0> translate<6.350000,0.000000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.810000,0.000000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.350000,0.000000,26.670000>}
box{<0,0,-0.127000><2.540000,0.035000,0.127000> rotate<0,0.000000,0> translate<3.810000,0.000000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.080000,0.000000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.350000,0.000000,26.670000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,-44.997030,0> translate<5.080000,0.000000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.770000,0.000000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.770000,0.000000,9.740000>}
box{<0,0,-0.127000><4.230000,0.035000,0.127000> rotate<0,-90.000000,0> translate<6.770000,0.000000,9.740000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.390000,0.000000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.770000,0.000000,13.970000>}
box{<0,0,-0.127000><3.380000,0.035000,0.127000> rotate<0,0.000000,0> translate<3.390000,0.000000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.770000,0.000000,9.740000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.620000,0.000000,8.890000>}
box{<0,0,-0.127000><1.202082,0.035000,0.127000> rotate<0,44.997030,0> translate<6.770000,0.000000,9.740000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.350000,0.000000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.620000,0.000000,19.050000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,-44.997030,0> translate<6.350000,0.000000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.350000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.620000,0.000000,21.590000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,44.997030,0> translate<6.350000,0.000000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.620000,0.000000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.620000,0.000000,21.590000>}
box{<0,0,-0.127000><2.540000,0.035000,0.127000> rotate<0,90.000000,0> translate<7.620000,0.000000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.620000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.620000,0.000000,25.400000>}
box{<0,0,-0.127000><2.540000,0.035000,0.127000> rotate<0,90.000000,0> translate<7.620000,0.000000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.470000,0.000000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.470000,0.000000,11.850000>}
box{<0,0,-0.127000><2.120000,0.035000,0.127000> rotate<0,-90.000000,0> translate<8.470000,0.000000,11.850000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.470000,0.000000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.470000,0.000000,15.660000>}
box{<0,0,-0.127000><1.690000,0.035000,0.127000> rotate<0,90.000000,0> translate<8.470000,0.000000,15.660000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.080000,0.000000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.890000,0.000000,1.270000>}
box{<0,0,-0.127000><5.388154,0.035000,0.127000> rotate<0,44.997030,0> translate<5.080000,0.000000,5.080000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.540000,-1.535000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.890000,-1.535000,5.080000>}
box{<0,0,-0.127000><6.350000,0.035000,0.127000> rotate<0,0.000000,0> translate<2.540000,-1.535000,5.080000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.890000,-1.535000,6.350000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.890000,-1.535000,5.080000>}
box{<0,0,-0.127000><1.270000,0.035000,0.127000> rotate<0,-90.000000,0> translate<8.890000,-1.535000,5.080000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.890000,-1.535000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.890000,-1.535000,6.350000>}
box{<0,0,-0.127000><5.080000,0.035000,0.127000> rotate<0,-90.000000,0> translate<8.890000,-1.535000,6.350000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.470000,0.000000,11.850000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.890000,0.000000,11.430000>}
box{<0,0,-0.127000><0.593970,0.035000,0.127000> rotate<0,44.997030,0> translate<8.470000,0.000000,11.850000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.620000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.890000,0.000000,21.590000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,44.997030,0> translate<7.620000,0.000000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.890000,0.000000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.890000,0.000000,21.590000>}
box{<0,0,-0.127000><1.270000,0.035000,0.127000> rotate<0,90.000000,0> translate<8.890000,0.000000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.620000,0.000000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.890000,0.000000,26.670000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,-44.997030,0> translate<7.620000,0.000000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.890000,0.000000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.194800,0.000000,11.125200>}
box{<0,0,-0.127000><0.431052,0.035000,0.127000> rotate<0,44.997030,0> translate<8.890000,0.000000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.160000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.160000,0.000000,25.400000>}
box{<0,0,-0.127000><2.540000,0.035000,0.127000> rotate<0,90.000000,0> translate<10.160000,0.000000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.890000,0.000000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.490200,0.000000,10.490200>}
box{<0,0,-0.127000><2.263025,0.035000,0.127000> rotate<0,-44.997030,0> translate<8.890000,0.000000,8.890000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<11.430000,0.000000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<11.430000,0.000000,5.080000>}
box{<0,0,-0.127000><3.810000,0.035000,0.127000> rotate<0,-90.000000,0> translate<11.430000,0.000000,5.080000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.160000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<11.430000,0.000000,21.590000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,44.997030,0> translate<10.160000,0.000000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<11.430000,0.000000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<11.430000,0.000000,21.590000>}
box{<0,0,-0.127000><1.270000,0.035000,0.127000> rotate<0,90.000000,0> translate<11.430000,0.000000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<11.430000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<11.430000,0.000000,24.130000>}
box{<0,0,-0.127000><1.270000,0.035000,0.127000> rotate<0,90.000000,0> translate<11.430000,0.000000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.160000,0.000000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<11.430000,0.000000,26.670000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,-44.997030,0> translate<10.160000,0.000000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<11.430000,0.000000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<12.369800,0.000000,9.829800>}
box{<0,0,-0.127000><1.329078,0.035000,0.127000> rotate<0,-44.997030,0> translate<11.430000,0.000000,8.890000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<11.430000,0.000000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<12.700000,0.000000,3.810000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,44.997030,0> translate<11.430000,0.000000,5.080000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<12.700000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<12.700000,-1.535000,16.510000>}
box{<0,0,-0.127000><2.540000,0.035000,0.127000> rotate<0,-90.000000,0> translate<12.700000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<11.430000,0.000000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<12.700000,0.000000,19.050000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,-44.997030,0> translate<11.430000,0.000000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<11.430000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<12.700000,-1.535000,19.050000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,44.997030,0> translate<11.430000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<11.430000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<12.700000,0.000000,21.590000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,44.997030,0> translate<11.430000,0.000000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<12.700000,0.000000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<12.700000,0.000000,21.590000>}
box{<0,0,-0.127000><2.540000,0.035000,0.127000> rotate<0,90.000000,0> translate<12.700000,0.000000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<12.700000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<12.700000,0.000000,25.400000>}
box{<0,0,-0.127000><2.540000,0.035000,0.127000> rotate<0,90.000000,0> translate<12.700000,0.000000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<12.369800,0.000000,9.829800>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<13.589000,0.000000,9.829800>}
box{<0,0,-0.127000><1.219200,0.035000,0.127000> rotate<0,0.000000,0> translate<12.369800,0.000000,9.829800> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.490200,0.000000,10.490200>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<13.589000,0.000000,10.490200>}
box{<0,0,-0.127000><3.098800,0.035000,0.127000> rotate<0,0.000000,0> translate<10.490200,0.000000,10.490200> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.194800,0.000000,11.125200>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<13.589000,0.000000,11.125200>}
box{<0,0,-0.127000><4.394200,0.035000,0.127000> rotate<0,0.000000,0> translate<9.194800,0.000000,11.125200> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<12.700000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<13.970000,-1.535000,15.240000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,44.997030,0> translate<12.700000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<12.700000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<13.970000,0.000000,21.590000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,44.997030,0> translate<12.700000,0.000000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<13.970000,0.000000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<13.970000,0.000000,21.590000>}
box{<0,0,-0.127000><1.270000,0.035000,0.127000> rotate<0,90.000000,0> translate<13.970000,0.000000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<13.970000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<13.970000,0.000000,24.130000>}
box{<0,0,-0.127000><1.270000,0.035000,0.127000> rotate<0,90.000000,0> translate<13.970000,0.000000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<12.700000,0.000000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<13.970000,0.000000,26.670000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,-44.997030,0> translate<12.700000,0.000000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<13.589000,0.000000,9.194800>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<14.274800,0.000000,9.194800>}
box{<0,0,-0.127000><0.685800,0.035000,0.127000> rotate<0,0.000000,0> translate<13.589000,0.000000,9.194800> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.890000,-1.535000,6.350000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.240000,-1.535000,6.350000>}
box{<0,0,-0.127000><6.350000,0.035000,0.127000> rotate<0,0.000000,0> translate<8.890000,-1.535000,6.350000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<14.274800,0.000000,9.194800>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.240000,0.000000,10.160000>}
box{<0,0,-0.127000><1.364999,0.035000,0.127000> rotate<0,-44.997030,0> translate<14.274800,0.000000,9.194800> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.240000,0.000000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.240000,0.000000,12.280000>}
box{<0,0,-0.127000><2.120000,0.035000,0.127000> rotate<0,90.000000,0> translate<15.240000,0.000000,12.280000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<13.970000,0.000000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.240000,0.000000,19.050000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,-44.997030,0> translate<13.970000,0.000000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<13.970000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.240000,0.000000,21.590000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,44.997030,0> translate<13.970000,0.000000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.240000,0.000000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.240000,0.000000,21.590000>}
box{<0,0,-0.127000><2.540000,0.035000,0.127000> rotate<0,90.000000,0> translate<15.240000,0.000000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.240000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.240000,0.000000,25.400000>}
box{<0,0,-0.127000><2.540000,0.035000,0.127000> rotate<0,90.000000,0> translate<15.240000,0.000000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.240000,0.000000,12.280000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.660000,0.000000,12.700000>}
box{<0,0,-0.127000><0.593970,0.035000,0.127000> rotate<0,-44.997030,0> translate<15.240000,0.000000,12.280000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.660000,0.000000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.660000,0.000000,16.930000>}
box{<0,0,-0.127000><4.230000,0.035000,0.127000> rotate<0,90.000000,0> translate<15.660000,0.000000,16.930000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.240000,0.000000,6.350000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.773400,0.000000,5.816600>}
box{<0,0,-0.127000><0.754342,0.035000,0.127000> rotate<0,44.997030,0> translate<15.240000,0.000000,6.350000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.660000,0.000000,16.930000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.510000,0.000000,17.780000>}
box{<0,0,-0.127000><1.202082,0.035000,0.127000> rotate<0,-44.997030,0> translate<15.660000,0.000000,16.930000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.240000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.510000,0.000000,21.590000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,44.997030,0> translate<15.240000,0.000000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.510000,0.000000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.510000,0.000000,21.590000>}
box{<0,0,-0.127000><1.270000,0.035000,0.127000> rotate<0,90.000000,0> translate<16.510000,0.000000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.240000,0.000000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.510000,0.000000,26.670000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,-44.997030,0> translate<15.240000,0.000000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.780000,0.000000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.780000,0.000000,16.510000>}
box{<0,0,-0.127000><2.540000,0.035000,0.127000> rotate<0,-90.000000,0> translate<17.780000,0.000000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.510000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.780000,-1.535000,19.050000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,-44.997030,0> translate<16.510000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.780000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.780000,0.000000,25.400000>}
box{<0,0,-0.127000><2.540000,0.035000,0.127000> rotate<0,90.000000,0> translate<17.780000,0.000000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.360000,0.000000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<18.934800,0.000000,11.125200>}
box{<0,0,-0.127000><2.227104,0.035000,0.127000> rotate<0,44.997030,0> translate<17.360000,0.000000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.780000,0.000000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<19.050000,0.000000,15.240000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,44.997030,0> translate<17.780000,0.000000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.780000,0.000000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<19.050000,0.000000,20.320000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,-44.997030,0> translate<17.780000,0.000000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<19.050000,0.000000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<19.050000,0.000000,20.320000>}
box{<0,0,-0.127000><1.270000,0.035000,0.127000> rotate<0,-90.000000,0> translate<19.050000,0.000000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.780000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<19.050000,0.000000,21.590000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,44.997030,0> translate<17.780000,0.000000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.780000,0.000000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<19.050000,0.000000,26.670000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,-44.997030,0> translate<17.780000,0.000000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<18.934800,0.000000,11.125200>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<19.431000,0.000000,11.125200>}
box{<0,0,-0.127000><0.496200,0.035000,0.127000> rotate<0,0.000000,0> translate<18.934800,0.000000,11.125200> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<19.050000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.320000,-1.535000,16.510000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,44.997030,0> translate<19.050000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.780000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.320000,-1.535000,19.050000>}
box{<0,0,-0.127000><2.540000,0.035000,0.127000> rotate<0,0.000000,0> translate<17.780000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<19.050000,0.000000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.320000,0.000000,19.050000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,-44.997030,0> translate<19.050000,0.000000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.320000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.320000,0.000000,19.050000>}
box{<0,0,-0.127000><3.810000,0.035000,0.127000> rotate<0,-90.000000,0> translate<20.320000,0.000000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<19.050000,0.000000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.320000,0.000000,22.860000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,44.997030,0> translate<19.050000,0.000000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<19.431000,0.000000,11.125200>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.624800,0.000000,11.125200>}
box{<0,0,-0.127000><1.193800,0.035000,0.127000> rotate<0,0.000000,0> translate<19.431000,0.000000,11.125200> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.890000,0.000000,1.270000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.590000,0.000000,1.270000>}
box{<0,0,-0.127000><12.700000,0.035000,0.127000> rotate<0,0.000000,0> translate<8.890000,0.000000,1.270000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.590000,0.000000,2.540000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.590000,0.000000,1.270000>}
box{<0,0,-0.127000><1.270000,0.035000,0.127000> rotate<0,-90.000000,0> translate<21.590000,0.000000,1.270000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.590000,-1.535000,7.620000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.590000,-1.535000,2.540000>}
box{<0,0,-0.127000><5.080000,0.035000,0.127000> rotate<0,-90.000000,0> translate<21.590000,-1.535000,2.540000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.590000,0.000000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.590000,0.000000,7.620000>}
box{<0,0,-0.127000><2.540000,0.035000,0.127000> rotate<0,-90.000000,0> translate<21.590000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.624800,0.000000,11.125200>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.590000,0.000000,10.160000>}
box{<0,0,-0.127000><1.364999,0.035000,0.127000> rotate<0,44.997030,0> translate<20.624800,0.000000,11.125200> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.320000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.590000,-1.535000,20.320000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,-44.997030,0> translate<20.320000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.590000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.590000,0.000000,24.130000>}
box{<0,0,-0.127000><1.270000,0.035000,0.127000> rotate<0,90.000000,0> translate<21.590000,0.000000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.590000,-1.535000,7.620000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.860000,-1.535000,8.890000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,-44.997030,0> translate<21.590000,-1.535000,7.620000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.860000,0.000000,10.580000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.860000,0.000000,8.890000>}
box{<0,0,-0.127000><1.690000,0.035000,0.127000> rotate<0,-90.000000,0> translate<22.860000,0.000000,8.890000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.590000,0.000000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.860000,0.000000,19.050000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,-44.997030,0> translate<21.590000,0.000000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.590000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.860000,-1.535000,19.050000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,44.997030,0> translate<21.590000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.590000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.860000,0.000000,21.590000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,44.997030,0> translate<21.590000,0.000000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.860000,0.000000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.860000,0.000000,21.590000>}
box{<0,0,-0.127000><2.540000,0.035000,0.127000> rotate<0,90.000000,0> translate<22.860000,0.000000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.860000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.860000,0.000000,25.400000>}
box{<0,0,-0.127000><2.540000,0.035000,0.127000> rotate<0,90.000000,0> translate<22.860000,0.000000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<13.970000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.130000,-1.535000,15.240000>}
box{<0,0,-0.127000><10.160000,0.035000,0.127000> rotate<0,0.000000,0> translate<13.970000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.860000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.130000,0.000000,21.590000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,44.997030,0> translate<22.860000,0.000000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.130000,0.000000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.130000,0.000000,21.590000>}
box{<0,0,-0.127000><1.270000,0.035000,0.127000> rotate<0,90.000000,0> translate<24.130000,0.000000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.130000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.130000,0.000000,24.130000>}
box{<0,0,-0.127000><1.270000,0.035000,0.127000> rotate<0,90.000000,0> translate<24.130000,0.000000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.860000,0.000000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.130000,0.000000,26.670000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,-44.997030,0> translate<22.860000,0.000000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.860000,0.000000,12.280000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.083400,0.000000,12.280000>}
box{<0,0,-0.127000><2.223400,0.035000,0.127000> rotate<0,0.000000,0> translate<22.860000,0.000000,12.280000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<12.700000,0.000000,3.810000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.400000,0.000000,3.810000>}
box{<0,0,-0.127000><12.700000,0.035000,0.127000> rotate<0,0.000000,0> translate<12.700000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.773400,0.000000,5.816600>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.400000,0.000000,5.816600>}
box{<0,0,-0.127000><9.626600,0.035000,0.127000> rotate<0,0.000000,0> translate<15.773400,0.000000,5.816600> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.083400,0.000000,12.280000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.400000,0.000000,11.963400>}
box{<0,0,-0.127000><0.447740,0.035000,0.127000> rotate<0,44.997030,0> translate<25.083400,0.000000,12.280000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.400000,0.000000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.400000,0.000000,11.963400>}
box{<0,0,-0.127000><2.006600,0.035000,0.127000> rotate<0,-90.000000,0> translate<25.400000,0.000000,11.963400> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.130000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.400000,-1.535000,13.970000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,44.997030,0> translate<24.130000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.400000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.400000,-1.535000,13.970000>}
box{<0,0,-0.127000><1.270000,0.035000,0.127000> rotate<0,-90.000000,0> translate<25.400000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.860000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.400000,-1.535000,19.050000>}
box{<0,0,-0.127000><2.540000,0.035000,0.127000> rotate<0,0.000000,0> translate<22.860000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.130000,0.000000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.400000,0.000000,19.050000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,-44.997030,0> translate<24.130000,0.000000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.130000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.400000,0.000000,21.590000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,44.997030,0> translate<24.130000,0.000000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.400000,0.000000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.400000,0.000000,21.590000>}
box{<0,0,-0.127000><2.540000,0.035000,0.127000> rotate<0,90.000000,0> translate<25.400000,0.000000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.400000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.400000,0.000000,25.400000>}
box{<0,0,-0.127000><2.540000,0.035000,0.127000> rotate<0,90.000000,0> translate<25.400000,0.000000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.400000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.670000,-1.535000,17.780000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,44.997030,0> translate<25.400000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.400000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.670000,0.000000,21.590000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,44.997030,0> translate<25.400000,0.000000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.670000,0.000000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.670000,0.000000,21.590000>}
box{<0,0,-0.127000><1.270000,0.035000,0.127000> rotate<0,90.000000,0> translate<26.670000,0.000000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.400000,0.000000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.670000,0.000000,26.670000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,-44.997030,0> translate<25.400000,0.000000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.670000,0.000000,5.816600>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.940000,0.000000,5.816600>}
box{<0,0,-0.127000><1.270000,0.035000,0.127000> rotate<0,0.000000,0> translate<26.670000,0.000000,5.816600> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.940000,0.000000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.940000,0.000000,22.860000>}
box{<0,0,-0.127000><2.540000,0.035000,0.127000> rotate<0,-90.000000,0> translate<27.940000,0.000000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<29.210000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<29.210000,0.000000,5.816600>}
box{<0,0,-0.127000><1.803400,0.035000,0.127000> rotate<0,-90.000000,0> translate<29.210000,0.000000,5.816600> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.940000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<29.210000,0.000000,21.590000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,44.997030,0> translate<27.940000,0.000000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<29.210000,0.000000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<29.210000,0.000000,21.590000>}
box{<0,0,-0.127000><1.270000,0.035000,0.127000> rotate<0,90.000000,0> translate<29.210000,0.000000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.940000,0.000000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<29.210000,0.000000,26.670000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,-44.997030,0> translate<27.940000,0.000000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<29.210000,-1.535000,2.540000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<30.480000,-1.535000,2.540000>}
box{<0,0,-0.127000><1.270000,0.035000,0.127000> rotate<0,0.000000,0> translate<29.210000,-1.535000,2.540000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<29.210000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<30.480000,0.000000,8.890000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,-44.997030,0> translate<29.210000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<30.480000,0.000000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<30.480000,0.000000,22.860000>}
box{<0,0,-0.127000><3.810000,0.035000,0.127000> rotate<0,90.000000,0> translate<30.480000,0.000000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<30.480000,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<30.480000,-1.535000,25.400000>}
box{<0,0,-0.127000><3.810000,0.035000,0.127000> rotate<0,90.000000,0> translate<30.480000,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<29.210000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<31.750000,-1.535000,17.780000>}
box{<0,0,-0.127000><2.540000,0.035000,0.127000> rotate<0,0.000000,0> translate<29.210000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<30.480000,0.000000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<31.750000,0.000000,17.780000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,44.997030,0> translate<30.480000,0.000000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<30.480000,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<31.750000,-1.535000,20.320000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,44.997030,0> translate<30.480000,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<29.210000,0.000000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<31.750000,0.000000,24.130000>}
box{<0,0,-0.127000><2.540000,0.035000,0.127000> rotate<0,0.000000,0> translate<29.210000,0.000000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<30.480000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<31.750000,0.000000,24.130000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,-44.997030,0> translate<30.480000,0.000000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<30.480000,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<31.750000,-1.535000,26.670000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,-44.997030,0> translate<30.480000,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.400000,-1.535000,3.810000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.020000,-1.535000,3.810000>}
box{<0,0,-0.127000><7.620000,0.035000,0.127000> rotate<0,0.000000,0> translate<25.400000,-1.535000,3.810000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<30.480000,0.000000,2.540000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.020000,0.000000,5.080000>}
box{<0,0,-0.127000><3.592102,0.035000,0.127000> rotate<0,-44.997030,0> translate<30.480000,0.000000,2.540000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.020000,0.000000,5.816600>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.020000,0.000000,5.080000>}
box{<0,0,-0.127000><0.736600,0.035000,0.127000> rotate<0,-90.000000,0> translate<33.020000,0.000000,5.080000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.320000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.020000,-1.535000,16.510000>}
box{<0,0,-0.127000><12.700000,0.035000,0.127000> rotate<0,0.000000,0> translate<20.320000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<31.750000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.020000,-1.535000,20.320000>}
box{<0,0,-0.127000><1.270000,0.035000,0.127000> rotate<0,0.000000,0> translate<31.750000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.590000,0.000000,1.270000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.290000,0.000000,1.270000>}
box{<0,0,-0.127000><12.700000,0.035000,0.127000> rotate<0,0.000000,0> translate<21.590000,0.000000,1.270000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.290000,-1.535000,1.270000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.290000,-1.535000,2.540000>}
box{<0,0,-0.127000><1.270000,0.035000,0.127000> rotate<0,90.000000,0> translate<34.290000,-1.535000,2.540000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<30.480000,-1.535000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.290000,-1.535000,8.890000>}
box{<0,0,-0.127000><3.810000,0.035000,0.127000> rotate<0,0.000000,0> translate<30.480000,-1.535000,8.890000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.290000,0.000000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.290000,0.000000,12.280000>}
box{<0,0,-0.127000><1.690000,0.035000,0.127000> rotate<0,-90.000000,0> translate<34.290000,0.000000,12.280000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.290000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.290000,-1.535000,13.970000>}
box{<0,0,-0.127000><1.270000,0.035000,0.127000> rotate<0,-90.000000,0> translate<34.290000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.400000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.290000,-1.535000,15.240000>}
box{<0,0,-0.127000><8.890000,0.035000,0.127000> rotate<0,0.000000,0> translate<25.400000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.290000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.290000,-1.535000,15.240000>}
box{<0,0,-0.127000><3.810000,0.035000,0.127000> rotate<0,-90.000000,0> translate<34.290000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.020000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.290000,-1.535000,19.050000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,44.997030,0> translate<33.020000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.020000,0.000000,5.816600>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.603400,0.000000,7.400000>}
box{<0,0,-0.127000><2.239266,0.035000,0.127000> rotate<0,-44.997030,0> translate<33.020000,0.000000,5.816600> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.290000,-1.535000,2.540000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.560000,-1.535000,3.810000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,-44.997030,0> translate<34.290000,-1.535000,2.540000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.603400,0.000000,7.400000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.560000,0.000000,7.400000>}
box{<0,0,-0.127000><0.956600,0.035000,0.127000> rotate<0,0.000000,0> translate<34.603400,0.000000,7.400000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.290000,-1.535000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.560000,-1.535000,10.160000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,-44.997030,0> translate<34.290000,-1.535000,8.890000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.560000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.560000,-1.535000,10.160000>}
box{<0,0,-0.127000><6.350000,0.035000,0.127000> rotate<0,-90.000000,0> translate<35.560000,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<19.050000,0.000000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.560000,0.000000,15.240000>}
box{<0,0,-0.127000><16.510000,0.035000,0.127000> rotate<0,0.000000,0> translate<19.050000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.020000,0.000000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.560000,0.000000,16.510000>}
box{<0,0,-0.127000><2.540000,0.035000,0.127000> rotate<0,0.000000,0> translate<33.020000,0.000000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.830000,0.000000,3.810000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.830000,0.000000,1.270000>}
box{<0,0,-0.127000><2.540000,0.035000,0.127000> rotate<0,-90.000000,0> translate<36.830000,0.000000,1.270000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.020000,0.000000,3.810000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.830000,0.000000,3.810000>}
box{<0,0,-0.127000><3.810000,0.035000,0.127000> rotate<0,0.000000,0> translate<33.020000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<31.750000,0.000000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.830000,0.000000,17.780000>}
box{<0,0,-0.127000><5.080000,0.035000,0.127000> rotate<0,0.000000,0> translate<31.750000,0.000000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.560000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.830000,-1.535000,20.320000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,-44.997030,0> translate<35.560000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.560000,0.000000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<37.050000,0.000000,19.050000>}
box{<0,0,-0.127000><1.490000,0.035000,0.127000> rotate<0,0.000000,0> translate<35.560000,0.000000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.560000,0.000000,5.300000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<38.100000,0.000000,6.770000>}
box{<0,0,-0.127000><2.934706,0.035000,0.127000> rotate<0,-30.057706,0> translate<35.560000,0.000000,5.300000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.290000,0.000000,12.280000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<38.100000,0.000000,8.470000>}
box{<0,0,-0.127000><5.388154,0.035000,0.127000> rotate<0,44.997030,0> translate<34.290000,0.000000,12.280000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.830000,0.000000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<38.950000,0.000000,15.660000>}
box{<0,0,-0.127000><2.998133,0.035000,0.127000> rotate<0,44.997030,0> translate<36.830000,0.000000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.830000,0.000000,1.270000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.370000,0.000000,1.270000>}
box{<0,0,-0.203200><2.540000,0.035000,0.203200> rotate<0,0.000000,0> translate<36.830000,0.000000,1.270000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<39.370000,0.000000,15.660000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<39.370000,0.000000,15.240000>}
box{<0,0,-0.127000><0.420000,0.035000,0.127000> rotate<0,-90.000000,0> translate<39.370000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<38.950000,0.000000,15.660000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<39.370000,0.000000,15.660000>}
box{<0,0,-0.127000><0.420000,0.035000,0.127000> rotate<0,0.000000,0> translate<38.950000,0.000000,15.660000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<38.100000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<39.370000,-1.535000,16.510000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,44.997030,0> translate<38.100000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<39.150000,0.000000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<39.370000,0.000000,17.360000>}
box{<0,0,-0.127000><1.704259,0.035000,0.127000> rotate<0,82.577636,0> translate<39.150000,0.000000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.560000,0.000000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.640000,0.000000,10.160000>}
box{<0,0,-0.127000><7.184205,0.035000,0.127000> rotate<0,44.997030,0> translate<35.560000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.560000,-1.535000,3.810000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.910000,-1.535000,3.810000>}
box{<0,0,-0.127000><6.350000,0.035000,0.127000> rotate<0,0.000000,0> translate<35.560000,-1.535000,3.810000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.910000,0.000000,1.270000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.910000,0.000000,7.620000>}
box{<0,0,-0.127000><6.350000,0.035000,0.127000> rotate<0,90.000000,0> translate<41.910000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.640000,0.000000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.910000,0.000000,10.160000>}
box{<0,0,-0.127000><1.270000,0.035000,0.127000> rotate<0,0.000000,0> translate<40.640000,0.000000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<39.370000,0.000000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.910000,0.000000,12.700000>}
box{<0,0,-0.127000><3.592102,0.035000,0.127000> rotate<0,44.997030,0> translate<39.370000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.910000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.180000,-1.535000,12.700000>}
box{<0,0,-0.127000><1.270000,0.035000,0.127000> rotate<0,0.000000,0> translate<41.910000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.910000,-1.535000,3.810000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,6.350000>}
box{<0,0,-0.127000><3.592102,0.035000,0.127000> rotate<0,-44.997030,0> translate<41.910000,-1.535000,3.810000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.180000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,11.430000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,44.997030,0> translate<43.180000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,6.350000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,11.430000>}
box{<0,0,-0.127000><5.080000,0.035000,0.127000> rotate<0,90.000000,0> translate<44.450000,-1.535000,11.430000> }
//Text
//Rect
union{
texture{col_pds}
}
texture{col_wrs}
}
#end
#if(pcb_polygons=on)
union{
//Polygons
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.533397,-1.535000,3.127366>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.533397,-1.535000,16.684634>}
box{<0,0,-0.127000><13.557269,0.035000,0.127000> rotate<0,90.000000,0> translate<0.533397,-1.535000,16.684634> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.533397,-1.535000,3.127366>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.536212,-1.535000,3.130184>}
box{<0,0,-0.127000><0.003984,0.035000,0.127000> rotate<0,-45.028806,0> translate<0.533397,-1.535000,3.127366> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.533397,-1.535000,3.302000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.951013,-1.535000,3.302000>}
box{<0,0,-0.127000><0.417616,0.035000,0.127000> rotate<0,0.000000,0> translate<0.533397,-1.535000,3.302000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.533397,-1.535000,3.556000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.929600,-1.535000,3.556000>}
box{<0,0,-0.127000><20.396203,0.035000,0.127000> rotate<0,0.000000,0> translate<0.533397,-1.535000,3.556000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.533397,-1.535000,3.810000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.929600,-1.535000,3.810000>}
box{<0,0,-0.127000><20.396203,0.035000,0.127000> rotate<0,0.000000,0> translate<0.533397,-1.535000,3.810000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.533397,-1.535000,4.064000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.929600,-1.535000,4.064000>}
box{<0,0,-0.127000><20.396203,0.035000,0.127000> rotate<0,0.000000,0> translate<0.533397,-1.535000,4.064000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.533397,-1.535000,4.318000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.907866,-1.535000,4.318000>}
box{<0,0,-0.127000><1.374469,0.035000,0.127000> rotate<0,0.000000,0> translate<0.533397,-1.535000,4.318000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.533397,-1.535000,4.572000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.683394,-1.535000,4.572000>}
box{<0,0,-0.127000><1.149997,0.035000,0.127000> rotate<0,0.000000,0> translate<0.533397,-1.535000,4.572000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.533397,-1.535000,4.826000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.578184,-1.535000,4.826000>}
box{<0,0,-0.127000><1.044787,0.035000,0.127000> rotate<0,0.000000,0> translate<0.533397,-1.535000,4.826000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.533397,-1.535000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.554200,-1.535000,5.080000>}
box{<0,0,-0.127000><1.020803,0.035000,0.127000> rotate<0,0.000000,0> translate<0.533397,-1.535000,5.080000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.533397,-1.535000,5.334000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.578191,-1.535000,5.334000>}
box{<0,0,-0.127000><1.044794,0.035000,0.127000> rotate<0,0.000000,0> translate<0.533397,-1.535000,5.334000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.533397,-1.535000,5.588000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.683400,-1.535000,5.588000>}
box{<0,0,-0.127000><1.150003,0.035000,0.127000> rotate<0,0.000000,0> translate<0.533397,-1.535000,5.588000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.533397,-1.535000,5.842000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.907869,-1.535000,5.842000>}
box{<0,0,-0.127000><1.374472,0.035000,0.127000> rotate<0,0.000000,0> translate<0.533397,-1.535000,5.842000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.533397,-1.535000,6.096000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.229600,-1.535000,6.096000>}
box{<0,0,-0.127000><7.696203,0.035000,0.127000> rotate<0,0.000000,0> translate<0.533397,-1.535000,6.096000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.533397,-1.535000,6.350000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.229600,-1.535000,6.350000>}
box{<0,0,-0.127000><7.696203,0.035000,0.127000> rotate<0,0.000000,0> translate<0.533397,-1.535000,6.350000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.533397,-1.535000,6.604000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.229600,-1.535000,6.604000>}
box{<0,0,-0.127000><7.696203,0.035000,0.127000> rotate<0,0.000000,0> translate<0.533397,-1.535000,6.604000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.533397,-1.535000,6.858000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.229600,-1.535000,6.858000>}
box{<0,0,-0.127000><7.696203,0.035000,0.127000> rotate<0,0.000000,0> translate<0.533397,-1.535000,6.858000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.533397,-1.535000,7.112000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.229600,-1.535000,7.112000>}
box{<0,0,-0.127000><7.696203,0.035000,0.127000> rotate<0,0.000000,0> translate<0.533397,-1.535000,7.112000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.533397,-1.535000,7.366000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.229600,-1.535000,7.366000>}
box{<0,0,-0.127000><7.696203,0.035000,0.127000> rotate<0,0.000000,0> translate<0.533397,-1.535000,7.366000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.533397,-1.535000,7.620000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.229600,-1.535000,7.620000>}
box{<0,0,-0.127000><7.696203,0.035000,0.127000> rotate<0,0.000000,0> translate<0.533397,-1.535000,7.620000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.533397,-1.535000,7.874000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.229600,-1.535000,7.874000>}
box{<0,0,-0.127000><7.696203,0.035000,0.127000> rotate<0,0.000000,0> translate<0.533397,-1.535000,7.874000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.533397,-1.535000,8.128000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.229600,-1.535000,8.128000>}
box{<0,0,-0.127000><7.696203,0.035000,0.127000> rotate<0,0.000000,0> translate<0.533397,-1.535000,8.128000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.533397,-1.535000,8.382000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.229600,-1.535000,8.382000>}
box{<0,0,-0.127000><7.696203,0.035000,0.127000> rotate<0,0.000000,0> translate<0.533397,-1.535000,8.382000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.533397,-1.535000,8.636000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.229600,-1.535000,8.636000>}
box{<0,0,-0.127000><7.696203,0.035000,0.127000> rotate<0,0.000000,0> translate<0.533397,-1.535000,8.636000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.533397,-1.535000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.229600,-1.535000,8.890000>}
box{<0,0,-0.127000><7.696203,0.035000,0.127000> rotate<0,0.000000,0> translate<0.533397,-1.535000,8.890000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.533397,-1.535000,9.144000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.229600,-1.535000,9.144000>}
box{<0,0,-0.127000><7.696203,0.035000,0.127000> rotate<0,0.000000,0> translate<0.533397,-1.535000,9.144000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.533397,-1.535000,9.398000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.229600,-1.535000,9.398000>}
box{<0,0,-0.127000><7.696203,0.035000,0.127000> rotate<0,0.000000,0> translate<0.533397,-1.535000,9.398000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.533397,-1.535000,9.652000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.229600,-1.535000,9.652000>}
box{<0,0,-0.127000><7.696203,0.035000,0.127000> rotate<0,0.000000,0> translate<0.533397,-1.535000,9.652000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.533397,-1.535000,9.906000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.229600,-1.535000,9.906000>}
box{<0,0,-0.127000><7.696203,0.035000,0.127000> rotate<0,0.000000,0> translate<0.533397,-1.535000,9.906000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.533397,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.229600,-1.535000,10.160000>}
box{<0,0,-0.127000><7.696203,0.035000,0.127000> rotate<0,0.000000,0> translate<0.533397,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.533397,-1.535000,10.414000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.229600,-1.535000,10.414000>}
box{<0,0,-0.127000><7.696203,0.035000,0.127000> rotate<0,0.000000,0> translate<0.533397,-1.535000,10.414000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.533397,-1.535000,10.668000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.447866,-1.535000,10.668000>}
box{<0,0,-0.127000><3.914469,0.035000,0.127000> rotate<0,0.000000,0> translate<0.533397,-1.535000,10.668000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.533397,-1.535000,10.922000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.223394,-1.535000,10.922000>}
box{<0,0,-0.127000><3.689997,0.035000,0.127000> rotate<0,0.000000,0> translate<0.533397,-1.535000,10.922000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.533397,-1.535000,11.176000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.118184,-1.535000,11.176000>}
box{<0,0,-0.127000><3.584788,0.035000,0.127000> rotate<0,0.000000,0> translate<0.533397,-1.535000,11.176000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.533397,-1.535000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.094200,-1.535000,11.430000>}
box{<0,0,-0.127000><3.560803,0.035000,0.127000> rotate<0,0.000000,0> translate<0.533397,-1.535000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.533397,-1.535000,11.684000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.118191,-1.535000,11.684000>}
box{<0,0,-0.127000><3.584794,0.035000,0.127000> rotate<0,0.000000,0> translate<0.533397,-1.535000,11.684000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.533397,-1.535000,11.938000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.223400,-1.535000,11.938000>}
box{<0,0,-0.127000><3.690003,0.035000,0.127000> rotate<0,0.000000,0> translate<0.533397,-1.535000,11.938000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.533397,-1.535000,12.192000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.419600,-1.535000,12.192000>}
box{<0,0,-0.127000><3.886203,0.035000,0.127000> rotate<0,0.000000,0> translate<0.533397,-1.535000,12.192000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.533397,-1.535000,12.446000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.419600,-1.535000,12.446000>}
box{<0,0,-0.127000><3.886203,0.035000,0.127000> rotate<0,0.000000,0> translate<0.533397,-1.535000,12.446000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.533397,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.419600,-1.535000,12.700000>}
box{<0,0,-0.127000><3.886203,0.035000,0.127000> rotate<0,0.000000,0> translate<0.533397,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.533397,-1.535000,12.954000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.419600,-1.535000,12.954000>}
box{<0,0,-0.127000><3.886203,0.035000,0.127000> rotate<0,0.000000,0> translate<0.533397,-1.535000,12.954000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.533397,-1.535000,13.208000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.419600,-1.535000,13.208000>}
box{<0,0,-0.127000><3.886203,0.035000,0.127000> rotate<0,0.000000,0> translate<0.533397,-1.535000,13.208000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.533397,-1.535000,13.462000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.419600,-1.535000,13.462000>}
box{<0,0,-0.127000><3.886203,0.035000,0.127000> rotate<0,0.000000,0> translate<0.533397,-1.535000,13.462000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.533397,-1.535000,13.716000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.419600,-1.535000,13.716000>}
box{<0,0,-0.127000><3.886203,0.035000,0.127000> rotate<0,0.000000,0> translate<0.533397,-1.535000,13.716000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.533397,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.419600,-1.535000,13.970000>}
box{<0,0,-0.127000><3.886203,0.035000,0.127000> rotate<0,0.000000,0> translate<0.533397,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.533397,-1.535000,14.224000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.419600,-1.535000,14.224000>}
box{<0,0,-0.127000><3.886203,0.035000,0.127000> rotate<0,0.000000,0> translate<0.533397,-1.535000,14.224000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.533397,-1.535000,14.478000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.419600,-1.535000,14.478000>}
box{<0,0,-0.127000><3.886203,0.035000,0.127000> rotate<0,0.000000,0> translate<0.533397,-1.535000,14.478000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.533397,-1.535000,14.732000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.223394,-1.535000,14.732000>}
box{<0,0,-0.127000><3.689997,0.035000,0.127000> rotate<0,0.000000,0> translate<0.533397,-1.535000,14.732000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.533397,-1.535000,14.986000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.118184,-1.535000,14.986000>}
box{<0,0,-0.127000><3.584788,0.035000,0.127000> rotate<0,0.000000,0> translate<0.533397,-1.535000,14.986000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.533397,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.094200,-1.535000,15.240000>}
box{<0,0,-0.127000><3.560803,0.035000,0.127000> rotate<0,0.000000,0> translate<0.533397,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.533397,-1.535000,15.494000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.118191,-1.535000,15.494000>}
box{<0,0,-0.127000><3.584794,0.035000,0.127000> rotate<0,0.000000,0> translate<0.533397,-1.535000,15.494000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.533397,-1.535000,15.748000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.223400,-1.535000,15.748000>}
box{<0,0,-0.127000><3.690003,0.035000,0.127000> rotate<0,0.000000,0> translate<0.533397,-1.535000,15.748000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.533397,-1.535000,16.002000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.447869,-1.535000,16.002000>}
box{<0,0,-0.127000><3.914472,0.035000,0.127000> rotate<0,0.000000,0> translate<0.533397,-1.535000,16.002000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.533397,-1.535000,16.256000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<12.090397,-1.535000,16.256000>}
box{<0,0,-0.127000><11.557000,0.035000,0.127000> rotate<0,0.000000,0> translate<0.533397,-1.535000,16.256000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.533397,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.708028,-1.535000,16.510000>}
box{<0,0,-0.127000><0.174631,0.035000,0.127000> rotate<0,0.000000,0> translate<0.533397,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.533397,-1.535000,16.684634>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.733428,-1.535000,16.484600>}
box{<0,0,-0.127000><0.282889,0.035000,0.127000> rotate<0,44.997478,0> translate<0.533397,-1.535000,16.684634> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.533397,-1.535000,18.875363>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.533397,-1.535000,19.440159>}
box{<0,0,-0.127000><0.564797,0.035000,0.127000> rotate<0,90.000000,0> translate<0.533397,-1.535000,19.440159> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.533397,-1.535000,18.875363>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.733428,-1.535000,19.075397>}
box{<0,0,-0.127000><0.282889,0.035000,0.127000> rotate<0,-44.997478,0> translate<0.533397,-1.535000,18.875363> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.533397,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.708034,-1.535000,19.050000>}
box{<0,0,-0.127000><0.174638,0.035000,0.127000> rotate<0,0.000000,0> translate<0.533397,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.533397,-1.535000,19.304000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.669553,-1.535000,19.304000>}
box{<0,0,-0.127000><0.136156,0.035000,0.127000> rotate<0,0.000000,0> translate<0.533397,-1.535000,19.304000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.533397,-1.535000,19.440159>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.796553,-1.535000,19.177000>}
box{<0,0,-0.127000><0.372161,0.035000,0.127000> rotate<0,44.997370,0> translate<0.533397,-1.535000,19.440159> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.533397,-1.535000,21.199838>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.533397,-1.535000,23.034634>}
box{<0,0,-0.127000><1.834797,0.035000,0.127000> rotate<0,90.000000,0> translate<0.533397,-1.535000,23.034634> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.533397,-1.535000,21.199838>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.796553,-1.535000,21.462997>}
box{<0,0,-0.127000><0.372161,0.035000,0.127000> rotate<0,-44.997370,0> translate<0.533397,-1.535000,21.199838> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.533397,-1.535000,21.336000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.669559,-1.535000,21.336000>}
box{<0,0,-0.127000><0.136163,0.035000,0.127000> rotate<0,0.000000,0> translate<0.533397,-1.535000,21.336000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.533397,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.248031,-1.535000,21.590000>}
box{<0,0,-0.127000><2.714634,0.035000,0.127000> rotate<0,0.000000,0> translate<0.533397,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.533397,-1.535000,21.844000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.100669,-1.535000,21.844000>}
box{<0,0,-0.127000><32.567272,0.035000,0.127000> rotate<0,0.000000,0> translate<0.533397,-1.535000,21.844000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.533397,-1.535000,22.098000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.045400,-1.535000,22.098000>}
box{<0,0,-0.127000><32.512003,0.035000,0.127000> rotate<0,0.000000,0> translate<0.533397,-1.535000,22.098000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.533397,-1.535000,22.352000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.045400,-1.535000,22.352000>}
box{<0,0,-0.127000><32.512003,0.035000,0.127000> rotate<0,0.000000,0> translate<0.533397,-1.535000,22.352000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.533397,-1.535000,22.606000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.100672,-1.535000,22.606000>}
box{<0,0,-0.127000><32.567275,0.035000,0.127000> rotate<0,0.000000,0> translate<0.533397,-1.535000,22.606000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.533397,-1.535000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.708028,-1.535000,22.860000>}
box{<0,0,-0.127000><0.174631,0.035000,0.127000> rotate<0,0.000000,0> translate<0.533397,-1.535000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.533397,-1.535000,23.034634>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.733428,-1.535000,22.834600>}
box{<0,0,-0.127000><0.282889,0.035000,0.127000> rotate<0,44.997478,0> translate<0.533397,-1.535000,23.034634> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.533397,-1.535000,25.225363>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.533397,-1.535000,25.790159>}
box{<0,0,-0.127000><0.564797,0.035000,0.127000> rotate<0,90.000000,0> translate<0.533397,-1.535000,25.790159> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.533397,-1.535000,25.225363>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.733428,-1.535000,25.425397>}
box{<0,0,-0.127000><0.282889,0.035000,0.127000> rotate<0,-44.997478,0> translate<0.533397,-1.535000,25.225363> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.533397,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.708034,-1.535000,25.400000>}
box{<0,0,-0.127000><0.174638,0.035000,0.127000> rotate<0,0.000000,0> translate<0.533397,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.533397,-1.535000,25.654000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.669553,-1.535000,25.654000>}
box{<0,0,-0.127000><0.136156,0.035000,0.127000> rotate<0,0.000000,0> translate<0.533397,-1.535000,25.654000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.533397,-1.535000,25.790159>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.796553,-1.535000,25.527000>}
box{<0,0,-0.127000><0.372161,0.035000,0.127000> rotate<0,44.997370,0> translate<0.533397,-1.535000,25.790159> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.533397,-1.535000,27.549838>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.533397,-1.535000,28.666600>}
box{<0,0,-0.127000><1.116763,0.035000,0.127000> rotate<0,90.000000,0> translate<0.533397,-1.535000,28.666600> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.533397,-1.535000,27.549838>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.796553,-1.535000,27.812997>}
box{<0,0,-0.127000><0.372161,0.035000,0.127000> rotate<0,-44.997370,0> translate<0.533397,-1.535000,27.549838> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.533397,-1.535000,27.686000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.669559,-1.535000,27.686000>}
box{<0,0,-0.127000><0.136163,0.035000,0.127000> rotate<0,0.000000,0> translate<0.533397,-1.535000,27.686000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.533397,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.248031,-1.535000,27.940000>}
box{<0,0,-0.127000><2.714634,0.035000,0.127000> rotate<0,0.000000,0> translate<0.533397,-1.535000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.533397,-1.535000,28.194000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.686919,-1.535000,28.194000>}
box{<0,0,-0.127000><41.153522,0.035000,0.127000> rotate<0,0.000000,0> translate<0.533397,-1.535000,28.194000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.533397,-1.535000,28.448000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.940919,-1.535000,28.448000>}
box{<0,0,-0.127000><41.407522,0.035000,0.127000> rotate<0,0.000000,0> translate<0.533397,-1.535000,28.448000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.533397,-1.535000,28.666600>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.425387,-1.535000,28.666600>}
box{<0,0,-0.127000><41.891991,0.035000,0.127000> rotate<0,0.000000,0> translate<0.533397,-1.535000,28.666600> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.536212,-1.535000,3.130184>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.012325,-1.535000,3.327397>}
box{<0,0,-0.127000><0.515341,0.035000,0.127000> rotate<0,-22.498540,0> translate<0.536212,-1.535000,3.130184> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.733428,-1.535000,16.484600>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.806569,-1.535000,16.484600>}
box{<0,0,-0.127000><1.073141,0.035000,0.127000> rotate<0,0.000000,0> translate<0.733428,-1.535000,16.484600> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.733428,-1.535000,19.075397>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.806569,-1.535000,19.075397>}
box{<0,0,-0.127000><1.073141,0.035000,0.127000> rotate<0,0.000000,0> translate<0.733428,-1.535000,19.075397> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.733428,-1.535000,22.834600>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.806569,-1.535000,22.834600>}
box{<0,0,-0.127000><1.073141,0.035000,0.127000> rotate<0,0.000000,0> translate<0.733428,-1.535000,22.834600> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.733428,-1.535000,25.425397>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.806569,-1.535000,25.425397>}
box{<0,0,-0.127000><1.073141,0.035000,0.127000> rotate<0,0.000000,0> translate<0.733428,-1.535000,25.425397> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.796553,-1.535000,19.177000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.143000,-1.535000,19.177000>}
box{<0,0,-0.127000><0.346447,0.035000,0.127000> rotate<0,0.000000,0> translate<0.796553,-1.535000,19.177000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.796553,-1.535000,21.462997>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.143000,-1.535000,21.462997>}
box{<0,0,-0.127000><0.346447,0.035000,0.127000> rotate<0,0.000000,0> translate<0.796553,-1.535000,21.462997> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.796553,-1.535000,25.527000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.143000,-1.535000,25.527000>}
box{<0,0,-0.127000><0.346447,0.035000,0.127000> rotate<0,0.000000,0> translate<0.796553,-1.535000,25.527000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<0.796553,-1.535000,27.812997>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.143000,-1.535000,27.812997>}
box{<0,0,-0.127000><0.346447,0.035000,0.127000> rotate<0,0.000000,0> translate<0.796553,-1.535000,27.812997> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.012325,-1.535000,3.327397>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.527672,-1.535000,3.327397>}
box{<0,0,-0.127000><0.515347,0.035000,0.127000> rotate<0,0.000000,0> translate<1.012325,-1.535000,3.327397> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.143000,-1.535000,19.177000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.143000,-1.535000,20.192984>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,90.000000,0> translate<1.143000,-1.535000,20.192984> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.143000,-1.535000,19.304000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.396994,-1.535000,19.304000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<1.143000,-1.535000,19.304000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.143000,-1.535000,19.558000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.396994,-1.535000,19.558000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<1.143000,-1.535000,19.558000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.143000,-1.535000,19.812000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.396994,-1.535000,19.812000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<1.143000,-1.535000,19.812000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.143000,-1.535000,20.066000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.396994,-1.535000,20.066000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<1.143000,-1.535000,20.066000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.143000,-1.535000,20.192984>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.396994,-1.535000,20.192984>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<1.143000,-1.535000,20.192984> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.143000,-1.535000,20.447012>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.143000,-1.535000,21.462997>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,90.000000,0> translate<1.143000,-1.535000,21.462997> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.143000,-1.535000,20.447012>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.396994,-1.535000,20.447012>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<1.143000,-1.535000,20.447012> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.143000,-1.535000,20.574000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.396994,-1.535000,20.574000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<1.143000,-1.535000,20.574000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.143000,-1.535000,20.828000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.396994,-1.535000,20.828000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<1.143000,-1.535000,20.828000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.143000,-1.535000,21.082000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.396994,-1.535000,21.082000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<1.143000,-1.535000,21.082000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.143000,-1.535000,21.336000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.396994,-1.535000,21.336000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<1.143000,-1.535000,21.336000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.143000,-1.535000,25.527000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.143000,-1.535000,26.542984>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,90.000000,0> translate<1.143000,-1.535000,26.542984> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.143000,-1.535000,25.654000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.396994,-1.535000,25.654000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<1.143000,-1.535000,25.654000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.143000,-1.535000,25.908000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.396994,-1.535000,25.908000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<1.143000,-1.535000,25.908000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.143000,-1.535000,26.162000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.396994,-1.535000,26.162000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<1.143000,-1.535000,26.162000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.143000,-1.535000,26.416000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.396994,-1.535000,26.416000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<1.143000,-1.535000,26.416000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.143000,-1.535000,26.542984>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.396994,-1.535000,26.542984>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<1.143000,-1.535000,26.542984> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.143000,-1.535000,26.797013>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.143000,-1.535000,27.812997>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,90.000000,0> translate<1.143000,-1.535000,27.812997> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.143000,-1.535000,26.797013>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.396994,-1.535000,26.797013>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<1.143000,-1.535000,26.797013> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.143000,-1.535000,26.924000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.396994,-1.535000,26.924000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<1.143000,-1.535000,26.924000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.143000,-1.535000,27.178000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.396994,-1.535000,27.178000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<1.143000,-1.535000,27.178000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.143000,-1.535000,27.432000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.396994,-1.535000,27.432000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<1.143000,-1.535000,27.432000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.143000,-1.535000,27.686000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.396994,-1.535000,27.686000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<1.143000,-1.535000,27.686000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.396994,-1.535000,19.177000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.743444,-1.535000,19.177000>}
box{<0,0,-0.127000><0.346450,0.035000,0.127000> rotate<0,0.000000,0> translate<1.396994,-1.535000,19.177000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.396994,-1.535000,20.192984>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.396994,-1.535000,19.177000>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,-90.000000,0> translate<1.396994,-1.535000,19.177000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.396994,-1.535000,21.462997>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.396994,-1.535000,20.447012>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,-90.000000,0> translate<1.396994,-1.535000,20.447012> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.396994,-1.535000,21.462997>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.743444,-1.535000,21.462997>}
box{<0,0,-0.127000><0.346450,0.035000,0.127000> rotate<0,0.000000,0> translate<1.396994,-1.535000,21.462997> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.396994,-1.535000,25.527000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.743444,-1.535000,25.527000>}
box{<0,0,-0.127000><0.346450,0.035000,0.127000> rotate<0,0.000000,0> translate<1.396994,-1.535000,25.527000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.396994,-1.535000,26.542984>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.396994,-1.535000,25.527000>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,-90.000000,0> translate<1.396994,-1.535000,25.527000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.396994,-1.535000,27.812997>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.396994,-1.535000,26.797013>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,-90.000000,0> translate<1.396994,-1.535000,26.797013> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.396994,-1.535000,27.812997>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.743444,-1.535000,27.812997>}
box{<0,0,-0.127000><0.346450,0.035000,0.127000> rotate<0,0.000000,0> translate<1.396994,-1.535000,27.812997> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.397012,-1.535000,20.193000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.397012,-1.535000,20.446994>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,90.000000,0> translate<1.397012,-1.535000,20.446994> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.397012,-1.535000,20.193000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.412997,-1.535000,20.193000>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,0.000000,0> translate<1.397012,-1.535000,20.193000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.397012,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.514600,-1.535000,20.320000>}
box{<0,0,-0.127000><1.117588,0.035000,0.127000> rotate<0,0.000000,0> translate<1.397012,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.397012,-1.535000,20.446994>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.412997,-1.535000,20.446994>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,0.000000,0> translate<1.397012,-1.535000,20.446994> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.397012,-1.535000,26.543000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.397012,-1.535000,26.796994>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,90.000000,0> translate<1.397012,-1.535000,26.796994> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.397012,-1.535000,26.543000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.412997,-1.535000,26.543000>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,0.000000,0> translate<1.397012,-1.535000,26.543000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.397012,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.514600,-1.535000,26.670000>}
box{<0,0,-0.127000><1.117588,0.035000,0.127000> rotate<0,0.000000,0> translate<1.397012,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.397012,-1.535000,26.796994>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.412997,-1.535000,26.796994>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,0.000000,0> translate<1.397012,-1.535000,26.796994> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.527672,-1.535000,3.327397>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.003784,-1.535000,3.130184>}
box{<0,0,-0.127000><0.515341,0.035000,0.127000> rotate<0,22.498540,0> translate<1.527672,-1.535000,3.327397> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.554200,-1.535000,4.883909>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.704278,-1.535000,4.521587>}
box{<0,0,-0.127000><0.392174,0.035000,0.127000> rotate<0,67.495614,0> translate<1.554200,-1.535000,4.883909> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.554200,-1.535000,5.276088>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.554200,-1.535000,4.883909>}
box{<0,0,-0.127000><0.392178,0.035000,0.127000> rotate<0,-90.000000,0> translate<1.554200,-1.535000,4.883909> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.554200,-1.535000,5.276088>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.704278,-1.535000,5.638409>}
box{<0,0,-0.127000><0.392174,0.035000,0.127000> rotate<0,-67.495614,0> translate<1.554200,-1.535000,5.276088> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.588987,-1.535000,3.302000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.571013,-1.535000,3.302000>}
box{<0,0,-0.127000><6.982025,0.035000,0.127000> rotate<0,0.000000,0> translate<1.588987,-1.535000,3.302000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.650297,-1.535000,-0.736600>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.003784,-1.535000,-0.590184>}
box{<0,0,-0.127000><0.382611,0.035000,0.127000> rotate<0,-22.498004,0> translate<1.650297,-1.535000,-0.736600> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.650297,-1.535000,-0.736600>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.509697,-1.535000,-0.736600>}
box{<0,0,-0.127000><6.859400,0.035000,0.127000> rotate<0,0.000000,0> translate<1.650297,-1.535000,-0.736600> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.704278,-1.535000,4.521587>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.981588,-1.535000,4.244278>}
box{<0,0,-0.127000><0.392175,0.035000,0.127000> rotate<0,44.997030,0> translate<1.704278,-1.535000,4.521587> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.704278,-1.535000,5.638409>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.981588,-1.535000,5.915719>}
box{<0,0,-0.127000><0.392175,0.035000,0.127000> rotate<0,-44.997030,0> translate<1.704278,-1.535000,5.638409> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.743444,-1.535000,19.177000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.412997,-1.535000,19.846553>}
box{<0,0,-0.127000><0.946891,0.035000,0.127000> rotate<0,-44.997030,0> translate<1.743444,-1.535000,19.177000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.743444,-1.535000,21.462997>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.412997,-1.535000,20.793444>}
box{<0,0,-0.127000><0.946891,0.035000,0.127000> rotate<0,44.997030,0> translate<1.743444,-1.535000,21.462997> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.743444,-1.535000,25.527000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.412997,-1.535000,26.196553>}
box{<0,0,-0.127000><0.946891,0.035000,0.127000> rotate<0,-44.997030,0> translate<1.743444,-1.535000,25.527000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.743444,-1.535000,27.812997>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.412997,-1.535000,27.143444>}
box{<0,0,-0.127000><0.946891,0.035000,0.127000> rotate<0,44.997030,0> translate<1.743444,-1.535000,27.812997> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.806569,-1.535000,16.484600>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.540000,-1.535000,17.218031>}
box{<0,0,-0.127000><1.037228,0.035000,0.127000> rotate<0,-44.997030,0> translate<1.806569,-1.535000,16.484600> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.806569,-1.535000,19.075397>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.540000,-1.535000,18.341966>}
box{<0,0,-0.127000><1.037228,0.035000,0.127000> rotate<0,44.997030,0> translate<1.806569,-1.535000,19.075397> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.806569,-1.535000,22.834600>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.540000,-1.535000,23.568031>}
box{<0,0,-0.127000><1.037228,0.035000,0.127000> rotate<0,-44.997030,0> translate<1.806569,-1.535000,22.834600> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.806569,-1.535000,25.425397>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.540000,-1.535000,24.691966>}
box{<0,0,-0.127000><1.037228,0.035000,0.127000> rotate<0,44.997030,0> translate<1.806569,-1.535000,25.425397> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.831966,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.248031,-1.535000,19.050000>}
box{<0,0,-0.127000><1.416066,0.035000,0.127000> rotate<0,0.000000,0> translate<1.831966,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.831966,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.248031,-1.535000,25.400000>}
box{<0,0,-0.127000><1.416066,0.035000,0.127000> rotate<0,0.000000,0> translate<1.831966,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.831969,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.248028,-1.535000,16.510000>}
box{<0,0,-0.127000><1.416059,0.035000,0.127000> rotate<0,0.000000,0> translate<1.831969,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.831969,-1.535000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.248028,-1.535000,22.860000>}
box{<0,0,-0.127000><1.416059,0.035000,0.127000> rotate<0,0.000000,0> translate<1.831969,-1.535000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.870441,-1.535000,21.336000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.994031,-1.535000,21.336000>}
box{<0,0,-0.127000><1.123591,0.035000,0.127000> rotate<0,0.000000,0> translate<1.870441,-1.535000,21.336000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.870441,-1.535000,27.686000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.994031,-1.535000,27.686000>}
box{<0,0,-0.127000><1.123591,0.035000,0.127000> rotate<0,0.000000,0> translate<1.870441,-1.535000,27.686000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.870444,-1.535000,19.304000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.994028,-1.535000,19.304000>}
box{<0,0,-0.127000><1.123584,0.035000,0.127000> rotate<0,0.000000,0> translate<1.870444,-1.535000,19.304000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.870444,-1.535000,25.654000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.994028,-1.535000,25.654000>}
box{<0,0,-0.127000><1.123584,0.035000,0.127000> rotate<0,0.000000,0> translate<1.870444,-1.535000,25.654000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.981588,-1.535000,4.244278>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.343909,-1.535000,4.094200>}
box{<0,0,-0.127000><0.392174,0.035000,0.127000> rotate<0,22.498446,0> translate<1.981588,-1.535000,4.244278> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<1.981588,-1.535000,5.915719>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.343909,-1.535000,6.065797>}
box{<0,0,-0.127000><0.392174,0.035000,0.127000> rotate<0,-22.498446,0> translate<1.981588,-1.535000,5.915719> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.003784,-1.535000,-0.590184>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.368184,-1.535000,-0.225784>}
box{<0,0,-0.127000><0.515339,0.035000,0.127000> rotate<0,-44.997030,0> translate<2.003784,-1.535000,-0.590184> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.003784,-1.535000,3.130184>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.368184,-1.535000,2.765784>}
box{<0,0,-0.127000><0.515339,0.035000,0.127000> rotate<0,44.997030,0> translate<2.003784,-1.535000,3.130184> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.085966,-1.535000,18.796000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.994034,-1.535000,18.796000>}
box{<0,0,-0.127000><0.908069,0.035000,0.127000> rotate<0,0.000000,0> translate<2.085966,-1.535000,18.796000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.085966,-1.535000,25.146000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.994034,-1.535000,25.146000>}
box{<0,0,-0.127000><0.908069,0.035000,0.127000> rotate<0,0.000000,0> translate<2.085966,-1.535000,25.146000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.085969,-1.535000,-0.508000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.286341,-1.535000,-0.508000>}
box{<0,0,-0.127000><1.200372,0.035000,0.127000> rotate<0,0.000000,0> translate<2.085969,-1.535000,-0.508000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.085969,-1.535000,3.048000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.286344,-1.535000,3.048000>}
box{<0,0,-0.127000><1.200375,0.035000,0.127000> rotate<0,0.000000,0> translate<2.085969,-1.535000,3.048000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.085969,-1.535000,16.764000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.994028,-1.535000,16.764000>}
box{<0,0,-0.127000><0.908059,0.035000,0.127000> rotate<0,0.000000,0> translate<2.085969,-1.535000,16.764000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.085969,-1.535000,23.114000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.994028,-1.535000,23.114000>}
box{<0,0,-0.127000><0.908059,0.035000,0.127000> rotate<0,0.000000,0> translate<2.085969,-1.535000,23.114000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.124441,-1.535000,21.082000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.740031,-1.535000,21.082000>}
box{<0,0,-0.127000><0.615591,0.035000,0.127000> rotate<0,0.000000,0> translate<2.124441,-1.535000,21.082000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.124441,-1.535000,27.432000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.740031,-1.535000,27.432000>}
box{<0,0,-0.127000><0.615591,0.035000,0.127000> rotate<0,0.000000,0> translate<2.124441,-1.535000,27.432000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.124444,-1.535000,19.558000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.740028,-1.535000,19.558000>}
box{<0,0,-0.127000><0.615584,0.035000,0.127000> rotate<0,0.000000,0> translate<2.124444,-1.535000,19.558000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.124444,-1.535000,25.908000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.740028,-1.535000,25.908000>}
box{<0,0,-0.127000><0.615584,0.035000,0.127000> rotate<0,0.000000,0> translate<2.124444,-1.535000,25.908000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.339966,-1.535000,18.542000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.740034,-1.535000,18.542000>}
box{<0,0,-0.127000><0.400069,0.035000,0.127000> rotate<0,0.000000,0> translate<2.339966,-1.535000,18.542000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.339966,-1.535000,24.892000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.740034,-1.535000,24.892000>}
box{<0,0,-0.127000><0.400069,0.035000,0.127000> rotate<0,0.000000,0> translate<2.339966,-1.535000,24.892000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.339969,-1.535000,-0.254000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.955556,-1.535000,-0.254000>}
box{<0,0,-0.127000><0.615588,0.035000,0.127000> rotate<0,0.000000,0> translate<2.339969,-1.535000,-0.254000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.339969,-1.535000,2.794000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.955556,-1.535000,2.794000>}
box{<0,0,-0.127000><0.615588,0.035000,0.127000> rotate<0,0.000000,0> translate<2.339969,-1.535000,2.794000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.339969,-1.535000,17.018000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.740028,-1.535000,17.018000>}
box{<0,0,-0.127000><0.400059,0.035000,0.127000> rotate<0,0.000000,0> translate<2.339969,-1.535000,17.018000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.339969,-1.535000,23.368000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.740028,-1.535000,23.368000>}
box{<0,0,-0.127000><0.400059,0.035000,0.127000> rotate<0,0.000000,0> translate<2.339969,-1.535000,23.368000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.343909,-1.535000,4.094200>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.736088,-1.535000,4.094200>}
box{<0,0,-0.127000><0.392178,0.035000,0.127000> rotate<0,0.000000,0> translate<2.343909,-1.535000,4.094200> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.343909,-1.535000,6.065797>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.736088,-1.535000,6.065797>}
box{<0,0,-0.127000><0.392178,0.035000,0.127000> rotate<0,0.000000,0> translate<2.343909,-1.535000,6.065797> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.368184,-1.535000,-0.225784>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.565397,-1.535000,0.250325>}
box{<0,0,-0.127000><0.515338,0.035000,0.127000> rotate<0,-67.495387,0> translate<2.368184,-1.535000,-0.225784> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.368184,-1.535000,2.765784>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.565397,-1.535000,2.289672>}
box{<0,0,-0.127000><0.515341,0.035000,0.127000> rotate<0,67.495520,0> translate<2.368184,-1.535000,2.765784> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.378441,-1.535000,20.828000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.514600,-1.535000,20.828000>}
box{<0,0,-0.127000><0.136159,0.035000,0.127000> rotate<0,0.000000,0> translate<2.378441,-1.535000,20.828000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.378441,-1.535000,27.178000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.514600,-1.535000,27.178000>}
box{<0,0,-0.127000><0.136159,0.035000,0.127000> rotate<0,0.000000,0> translate<2.378441,-1.535000,27.178000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.378444,-1.535000,19.812000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.514600,-1.535000,19.812000>}
box{<0,0,-0.127000><0.136156,0.035000,0.127000> rotate<0,0.000000,0> translate<2.378444,-1.535000,19.812000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.378444,-1.535000,26.162000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.514600,-1.535000,26.162000>}
box{<0,0,-0.127000><0.136156,0.035000,0.127000> rotate<0,0.000000,0> translate<2.378444,-1.535000,26.162000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.412997,-1.535000,19.846553>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.412997,-1.535000,20.193000>}
box{<0,0,-0.127000><0.346447,0.035000,0.127000> rotate<0,90.000000,0> translate<2.412997,-1.535000,20.193000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.412997,-1.535000,20.066000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.514600,-1.535000,20.066000>}
box{<0,0,-0.127000><0.101603,0.035000,0.127000> rotate<0,0.000000,0> translate<2.412997,-1.535000,20.066000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.412997,-1.535000,20.446994>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.412997,-1.535000,20.793444>}
box{<0,0,-0.127000><0.346450,0.035000,0.127000> rotate<0,90.000000,0> translate<2.412997,-1.535000,20.793444> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.412997,-1.535000,20.574000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.514600,-1.535000,20.574000>}
box{<0,0,-0.127000><0.101603,0.035000,0.127000> rotate<0,0.000000,0> translate<2.412997,-1.535000,20.574000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.412997,-1.535000,26.196553>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.412997,-1.535000,26.543000>}
box{<0,0,-0.127000><0.346447,0.035000,0.127000> rotate<0,90.000000,0> translate<2.412997,-1.535000,26.543000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.412997,-1.535000,26.416000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.514600,-1.535000,26.416000>}
box{<0,0,-0.127000><0.101603,0.035000,0.127000> rotate<0,0.000000,0> translate<2.412997,-1.535000,26.416000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.412997,-1.535000,26.796994>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.412997,-1.535000,27.143444>}
box{<0,0,-0.127000><0.346450,0.035000,0.127000> rotate<0,90.000000,0> translate<2.412997,-1.535000,27.143444> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.412997,-1.535000,26.924000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.514600,-1.535000,26.924000>}
box{<0,0,-0.127000><0.101603,0.035000,0.127000> rotate<0,0.000000,0> translate<2.412997,-1.535000,26.924000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.461706,-1.535000,0.000000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.786019,-1.535000,0.000000>}
box{<0,0,-0.127000><0.324313,0.035000,0.127000> rotate<0,0.000000,0> translate<2.461706,-1.535000,0.000000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.461709,-1.535000,2.540000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.786022,-1.535000,2.540000>}
box{<0,0,-0.127000><0.324313,0.035000,0.127000> rotate<0,0.000000,0> translate<2.461709,-1.535000,2.540000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.514600,-1.535000,19.783428>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.248031,-1.535000,19.050000>}
box{<0,0,-0.127000><1.037226,0.035000,0.127000> rotate<0,44.996908,0> translate<2.514600,-1.535000,19.783428> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.514600,-1.535000,20.856569>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.514600,-1.535000,19.783428>}
box{<0,0,-0.127000><1.073141,0.035000,0.127000> rotate<0,-90.000000,0> translate<2.514600,-1.535000,19.783428> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.514600,-1.535000,20.856569>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.273428,-1.535000,21.615397>}
box{<0,0,-0.127000><1.073145,0.035000,0.127000> rotate<0,-44.997030,0> translate<2.514600,-1.535000,20.856569> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.514600,-1.535000,26.133428>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.248031,-1.535000,25.400000>}
box{<0,0,-0.127000><1.037226,0.035000,0.127000> rotate<0,44.996908,0> translate<2.514600,-1.535000,26.133428> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.514600,-1.535000,27.206569>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.514600,-1.535000,26.133428>}
box{<0,0,-0.127000><1.073141,0.035000,0.127000> rotate<0,-90.000000,0> translate<2.514600,-1.535000,26.133428> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.514600,-1.535000,27.206569>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.273428,-1.535000,27.965397>}
box{<0,0,-0.127000><1.073145,0.035000,0.127000> rotate<0,-44.997030,0> translate<2.514600,-1.535000,27.206569> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.540000,-1.535000,17.218031>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.273428,-1.535000,16.484600>}
box{<0,0,-0.127000><1.037226,0.035000,0.127000> rotate<0,44.997152,0> translate<2.540000,-1.535000,17.218031> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.540000,-1.535000,18.341966>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.248031,-1.535000,19.050000>}
box{<0,0,-0.127000><1.001310,0.035000,0.127000> rotate<0,-44.997157,0> translate<2.540000,-1.535000,18.341966> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.540000,-1.535000,23.568031>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.273428,-1.535000,22.834600>}
box{<0,0,-0.127000><1.037226,0.035000,0.127000> rotate<0,44.997152,0> translate<2.540000,-1.535000,23.568031> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.540000,-1.535000,24.691966>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.248031,-1.535000,25.400000>}
box{<0,0,-0.127000><1.001310,0.035000,0.127000> rotate<0,-44.997157,0> translate<2.540000,-1.535000,24.691966> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.565397,-1.535000,0.250325>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.565397,-1.535000,2.289672>}
box{<0,0,-0.127000><2.039347,0.035000,0.127000> rotate<0,90.000000,0> translate<2.565397,-1.535000,2.289672> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.565397,-1.535000,0.254000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.692978,-1.535000,0.254000>}
box{<0,0,-0.127000><0.127581,0.035000,0.127000> rotate<0,0.000000,0> translate<2.565397,-1.535000,0.254000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.565397,-1.535000,0.508000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.667000,-1.535000,0.508000>}
box{<0,0,-0.127000><0.101603,0.035000,0.127000> rotate<0,0.000000,0> translate<2.565397,-1.535000,0.508000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.565397,-1.535000,0.762000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.667000,-1.535000,0.762000>}
box{<0,0,-0.127000><0.101603,0.035000,0.127000> rotate<0,0.000000,0> translate<2.565397,-1.535000,0.762000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.565397,-1.535000,1.016000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.667000,-1.535000,1.016000>}
box{<0,0,-0.127000><0.101603,0.035000,0.127000> rotate<0,0.000000,0> translate<2.565397,-1.535000,1.016000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.565397,-1.535000,1.270000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.682984,-1.535000,1.270000>}
box{<0,0,-0.127000><1.117587,0.035000,0.127000> rotate<0,0.000000,0> translate<2.565397,-1.535000,1.270000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.565397,-1.535000,1.524000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.667000,-1.535000,1.524000>}
box{<0,0,-0.127000><0.101603,0.035000,0.127000> rotate<0,0.000000,0> translate<2.565397,-1.535000,1.524000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.565397,-1.535000,1.778000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.667000,-1.535000,1.778000>}
box{<0,0,-0.127000><0.101603,0.035000,0.127000> rotate<0,0.000000,0> translate<2.565397,-1.535000,1.778000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.565397,-1.535000,2.032000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.667000,-1.535000,2.032000>}
box{<0,0,-0.127000><0.101603,0.035000,0.127000> rotate<0,0.000000,0> translate<2.565397,-1.535000,2.032000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.565397,-1.535000,2.286000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.692984,-1.535000,2.286000>}
box{<0,0,-0.127000><0.127587,0.035000,0.127000> rotate<0,0.000000,0> translate<2.565397,-1.535000,2.286000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.667000,-1.535000,0.418041>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.695144,-1.535000,0.240344>}
box{<0,0,-0.127000><0.179912,0.035000,0.127000> rotate<0,80.994865,0> translate<2.667000,-1.535000,0.418041> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.667000,-1.535000,1.143000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.667000,-1.535000,0.418041>}
box{<0,0,-0.127000><0.724959,0.035000,0.127000> rotate<0,-90.000000,0> translate<2.667000,-1.535000,0.418041> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.667000,-1.535000,1.143000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.682984,-1.535000,1.143000>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,0.000000,0> translate<2.667000,-1.535000,1.143000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.667000,-1.535000,1.396994>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.682984,-1.535000,1.396994>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,0.000000,0> translate<2.667000,-1.535000,1.396994> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.667000,-1.535000,2.121956>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.667000,-1.535000,1.396994>}
box{<0,0,-0.127000><0.724963,0.035000,0.127000> rotate<0,-90.000000,0> translate<2.667000,-1.535000,1.396994> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.667000,-1.535000,2.121956>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.695144,-1.535000,2.299653>}
box{<0,0,-0.127000><0.179912,0.035000,0.127000> rotate<0,-80.994865,0> translate<2.667000,-1.535000,2.121956> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.695144,-1.535000,0.240344>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.750741,-1.535000,0.069238>}
box{<0,0,-0.127000><0.179912,0.035000,0.127000> rotate<0,71.994920,0> translate<2.695144,-1.535000,0.240344> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.695144,-1.535000,2.299653>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.750741,-1.535000,2.470759>}
box{<0,0,-0.127000><0.179912,0.035000,0.127000> rotate<0,-71.994920,0> translate<2.695144,-1.535000,2.299653> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.736088,-1.535000,4.094200>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.098409,-1.535000,4.244278>}
box{<0,0,-0.127000><0.392174,0.035000,0.127000> rotate<0,-22.498446,0> translate<2.736088,-1.535000,4.094200> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.736088,-1.535000,6.065797>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.098409,-1.535000,5.915719>}
box{<0,0,-0.127000><0.392174,0.035000,0.127000> rotate<0,22.498446,0> translate<2.736088,-1.535000,6.065797> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.750741,-1.535000,0.069238>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.832419,-1.535000,-0.091059>}
box{<0,0,-0.127000><0.179907,0.035000,0.127000> rotate<0,62.995051,0> translate<2.750741,-1.535000,0.069238> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.750741,-1.535000,2.470759>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.832419,-1.535000,2.631059>}
box{<0,0,-0.127000><0.179909,0.035000,0.127000> rotate<0,-62.995503,0> translate<2.750741,-1.535000,2.470759> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.832419,-1.535000,-0.091059>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.938169,-1.535000,-0.236613>}
box{<0,0,-0.127000><0.179913,0.035000,0.127000> rotate<0,53.996574,0> translate<2.832419,-1.535000,-0.091059> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.832419,-1.535000,2.631059>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.938169,-1.535000,2.776613>}
box{<0,0,-0.127000><0.179913,0.035000,0.127000> rotate<0,-53.996574,0> translate<2.832419,-1.535000,2.631059> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.938169,-1.535000,-0.236613>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.065384,-1.535000,-0.363828>}
box{<0,0,-0.127000><0.179910,0.035000,0.127000> rotate<0,44.997030,0> translate<2.938169,-1.535000,-0.236613> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.938169,-1.535000,2.776613>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.065384,-1.535000,2.903828>}
box{<0,0,-0.127000><0.179910,0.035000,0.127000> rotate<0,-44.997030,0> translate<2.938169,-1.535000,2.776613> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.065384,-1.535000,-0.363828>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.210938,-1.535000,-0.469578>}
box{<0,0,-0.127000><0.179913,0.035000,0.127000> rotate<0,35.997486,0> translate<3.065384,-1.535000,-0.363828> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.065384,-1.535000,2.903828>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.210938,-1.535000,3.009578>}
box{<0,0,-0.127000><0.179913,0.035000,0.127000> rotate<0,-35.997486,0> translate<3.065384,-1.535000,2.903828> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.098409,-1.535000,4.244278>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.273731,-1.535000,4.419600>}
box{<0,0,-0.127000><0.247943,0.035000,0.127000> rotate<0,-44.997030,0> translate<3.098409,-1.535000,4.244278> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.098409,-1.535000,5.915719>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.273731,-1.535000,5.740397>}
box{<0,0,-0.127000><0.247943,0.035000,0.127000> rotate<0,44.997030,0> translate<3.098409,-1.535000,5.915719> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.172128,-1.535000,5.842000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.229600,-1.535000,5.842000>}
box{<0,0,-0.127000><5.057472,0.035000,0.127000> rotate<0,0.000000,0> translate<3.172128,-1.535000,5.842000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.172131,-1.535000,4.318000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.929600,-1.535000,4.318000>}
box{<0,0,-0.127000><17.757469,0.035000,0.127000> rotate<0,0.000000,0> translate<3.172131,-1.535000,4.318000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.210938,-1.535000,-0.469578>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.371238,-1.535000,-0.551256>}
box{<0,0,-0.127000><0.179909,0.035000,0.127000> rotate<0,26.998557,0> translate<3.210938,-1.535000,-0.469578> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.210938,-1.535000,3.009578>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.371238,-1.535000,3.091256>}
box{<0,0,-0.127000><0.179909,0.035000,0.127000> rotate<0,-26.998557,0> translate<3.210938,-1.535000,3.009578> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.273428,-1.535000,16.484600>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.346569,-1.535000,16.484600>}
box{<0,0,-0.127000><1.073141,0.035000,0.127000> rotate<0,0.000000,0> translate<3.273428,-1.535000,16.484600> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.273428,-1.535000,21.615397>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.346569,-1.535000,21.615397>}
box{<0,0,-0.127000><1.073141,0.035000,0.127000> rotate<0,0.000000,0> translate<3.273428,-1.535000,21.615397> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.273428,-1.535000,22.834600>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.346569,-1.535000,22.834600>}
box{<0,0,-0.127000><1.073141,0.035000,0.127000> rotate<0,0.000000,0> translate<3.273428,-1.535000,22.834600> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.273428,-1.535000,27.965397>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.346569,-1.535000,27.965397>}
box{<0,0,-0.127000><1.073141,0.035000,0.127000> rotate<0,0.000000,0> translate<3.273428,-1.535000,27.965397> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.273731,-1.535000,4.419600>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.021363,-1.535000,4.419600>}
box{<0,0,-0.127000><5.747631,0.035000,0.127000> rotate<0,0.000000,0> translate<3.273731,-1.535000,4.419600> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.273731,-1.535000,5.740397>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.229600,-1.535000,5.740397>}
box{<0,0,-0.127000><4.955869,0.035000,0.127000> rotate<0,0.000000,0> translate<3.273731,-1.535000,5.740397> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.371238,-1.535000,-0.551256>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.542344,-1.535000,-0.606853>}
box{<0,0,-0.127000><0.179912,0.035000,0.127000> rotate<0,17.999140,0> translate<3.371238,-1.535000,-0.551256> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.371238,-1.535000,3.091256>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.542344,-1.535000,3.146853>}
box{<0,0,-0.127000><0.179912,0.035000,0.127000> rotate<0,-17.999140,0> translate<3.371238,-1.535000,3.091256> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.542344,-1.535000,-0.606853>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.683000,-1.535000,-0.629128>}
box{<0,0,-0.127000><0.142409,0.035000,0.127000> rotate<0,8.998309,0> translate<3.542344,-1.535000,-0.606853> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.542344,-1.535000,3.146853>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.683000,-1.535000,3.169128>}
box{<0,0,-0.127000><0.142409,0.035000,0.127000> rotate<0,-8.998309,0> translate<3.542344,-1.535000,3.146853> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.682984,-1.535000,1.396994>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.682984,-1.535000,1.143000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,-90.000000,0> translate<3.682984,-1.535000,1.143000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.683000,-1.535000,-0.629128>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.683000,-1.535000,1.142984>}
box{<0,0,-0.127000><1.772113,0.035000,0.127000> rotate<0,90.000000,0> translate<3.683000,-1.535000,1.142984> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.683000,-1.535000,-0.508000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.936994,-1.535000,-0.508000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<3.683000,-1.535000,-0.508000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.683000,-1.535000,-0.254000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.936994,-1.535000,-0.254000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<3.683000,-1.535000,-0.254000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.683000,-1.535000,0.000000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.936994,-1.535000,0.000000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<3.683000,-1.535000,0.000000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.683000,-1.535000,0.254000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.936994,-1.535000,0.254000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<3.683000,-1.535000,0.254000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.683000,-1.535000,0.508000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.936994,-1.535000,0.508000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<3.683000,-1.535000,0.508000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.683000,-1.535000,0.762000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.936994,-1.535000,0.762000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<3.683000,-1.535000,0.762000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.683000,-1.535000,1.016000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.936994,-1.535000,1.016000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<3.683000,-1.535000,1.016000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.683000,-1.535000,1.142984>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.936994,-1.535000,1.142984>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<3.683000,-1.535000,1.142984> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.683000,-1.535000,1.397012>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.683000,-1.535000,3.169128>}
box{<0,0,-0.127000><1.772116,0.035000,0.127000> rotate<0,90.000000,0> translate<3.683000,-1.535000,3.169128> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.683000,-1.535000,1.397012>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.936994,-1.535000,1.397012>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<3.683000,-1.535000,1.397012> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.683000,-1.535000,1.524000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.936994,-1.535000,1.524000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<3.683000,-1.535000,1.524000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.683000,-1.535000,1.778000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.936994,-1.535000,1.778000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<3.683000,-1.535000,1.778000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.683000,-1.535000,2.032000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.936994,-1.535000,2.032000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<3.683000,-1.535000,2.032000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.683000,-1.535000,2.286000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.936994,-1.535000,2.286000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<3.683000,-1.535000,2.286000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.683000,-1.535000,2.540000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.936994,-1.535000,2.540000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<3.683000,-1.535000,2.540000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.683000,-1.535000,2.794000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.936994,-1.535000,2.794000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<3.683000,-1.535000,2.794000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.683000,-1.535000,3.048000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.936994,-1.535000,3.048000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<3.683000,-1.535000,3.048000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.936994,-1.535000,-0.629128>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.077653,-1.535000,-0.606853>}
box{<0,0,-0.127000><0.142412,0.035000,0.127000> rotate<0,-8.998112,0> translate<3.936994,-1.535000,-0.629128> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.936994,-1.535000,1.142984>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.936994,-1.535000,-0.629128>}
box{<0,0,-0.127000><1.772113,0.035000,0.127000> rotate<0,-90.000000,0> translate<3.936994,-1.535000,-0.629128> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.936994,-1.535000,3.169128>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.936994,-1.535000,1.397012>}
box{<0,0,-0.127000><1.772116,0.035000,0.127000> rotate<0,-90.000000,0> translate<3.936994,-1.535000,1.397012> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.936994,-1.535000,3.169128>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.077653,-1.535000,3.146853>}
box{<0,0,-0.127000><0.142412,0.035000,0.127000> rotate<0,8.998112,0> translate<3.936994,-1.535000,3.169128> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.937013,-1.535000,1.143000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.937013,-1.535000,1.396994>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,90.000000,0> translate<3.937013,-1.535000,1.396994> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.937013,-1.535000,1.143000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.952997,-1.535000,1.143000>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,0.000000,0> translate<3.937013,-1.535000,1.143000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.937013,-1.535000,1.270000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.222984,-1.535000,1.270000>}
box{<0,0,-0.127000><2.285972,0.035000,0.127000> rotate<0,0.000000,0> translate<3.937013,-1.535000,1.270000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<3.937013,-1.535000,1.396994>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.952997,-1.535000,1.396994>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,0.000000,0> translate<3.937013,-1.535000,1.396994> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.077653,-1.535000,-0.606853>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.248759,-1.535000,-0.551256>}
box{<0,0,-0.127000><0.179912,0.035000,0.127000> rotate<0,-17.999140,0> translate<4.077653,-1.535000,-0.606853> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.077653,-1.535000,3.146853>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.248759,-1.535000,3.091256>}
box{<0,0,-0.127000><0.179912,0.035000,0.127000> rotate<0,17.999140,0> translate<4.077653,-1.535000,3.146853> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.094200,-1.535000,11.233909>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.244278,-1.535000,10.871588>}
box{<0,0,-0.127000><0.392174,0.035000,0.127000> rotate<0,67.495614,0> translate<4.094200,-1.535000,11.233909> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.094200,-1.535000,11.626088>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.094200,-1.535000,11.233909>}
box{<0,0,-0.127000><0.392178,0.035000,0.127000> rotate<0,-90.000000,0> translate<4.094200,-1.535000,11.233909> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.094200,-1.535000,11.626088>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.244278,-1.535000,11.988409>}
box{<0,0,-0.127000><0.392174,0.035000,0.127000> rotate<0,-67.495614,0> translate<4.094200,-1.535000,11.626088> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.094200,-1.535000,15.043909>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.244278,-1.535000,14.681588>}
box{<0,0,-0.127000><0.392174,0.035000,0.127000> rotate<0,67.495614,0> translate<4.094200,-1.535000,15.043909> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.094200,-1.535000,15.436088>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.094200,-1.535000,15.043909>}
box{<0,0,-0.127000><0.392178,0.035000,0.127000> rotate<0,-90.000000,0> translate<4.094200,-1.535000,15.043909> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.094200,-1.535000,15.436088>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.244278,-1.535000,15.798409>}
box{<0,0,-0.127000><0.392174,0.035000,0.127000> rotate<0,-67.495614,0> translate<4.094200,-1.535000,15.436088> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.244278,-1.535000,10.871588>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.521587,-1.535000,10.594278>}
box{<0,0,-0.127000><0.392175,0.035000,0.127000> rotate<0,44.997030,0> translate<4.244278,-1.535000,10.871588> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.244278,-1.535000,11.988409>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.419600,-1.535000,12.163731>}
box{<0,0,-0.127000><0.247943,0.035000,0.127000> rotate<0,-44.997030,0> translate<4.244278,-1.535000,11.988409> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.244278,-1.535000,14.681588>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.419600,-1.535000,14.506266>}
box{<0,0,-0.127000><0.247943,0.035000,0.127000> rotate<0,44.997030,0> translate<4.244278,-1.535000,14.681588> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.244278,-1.535000,15.798409>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.521587,-1.535000,16.075719>}
box{<0,0,-0.127000><0.392175,0.035000,0.127000> rotate<0,-44.997030,0> translate<4.244278,-1.535000,15.798409> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.248759,-1.535000,-0.551256>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.409059,-1.535000,-0.469578>}
box{<0,0,-0.127000><0.179909,0.035000,0.127000> rotate<0,-26.998557,0> translate<4.248759,-1.535000,-0.551256> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.248759,-1.535000,3.091256>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.409059,-1.535000,3.009578>}
box{<0,0,-0.127000><0.179909,0.035000,0.127000> rotate<0,26.998557,0> translate<4.248759,-1.535000,3.091256> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.333653,-1.535000,-0.508000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.826341,-1.535000,-0.508000>}
box{<0,0,-0.127000><1.492687,0.035000,0.127000> rotate<0,0.000000,0> translate<4.333653,-1.535000,-0.508000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.333656,-1.535000,3.048000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.826344,-1.535000,3.048000>}
box{<0,0,-0.127000><1.492688,0.035000,0.127000> rotate<0,0.000000,0> translate<4.333656,-1.535000,3.048000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.346569,-1.535000,16.484600>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.080000,-1.535000,17.218031>}
box{<0,0,-0.127000><1.037228,0.035000,0.127000> rotate<0,-44.997030,0> translate<4.346569,-1.535000,16.484600> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.346569,-1.535000,21.615397>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.080000,-1.535000,20.881966>}
box{<0,0,-0.127000><1.037228,0.035000,0.127000> rotate<0,44.997030,0> translate<4.346569,-1.535000,21.615397> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.346569,-1.535000,22.834600>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.080000,-1.535000,23.568031>}
box{<0,0,-0.127000><1.037228,0.035000,0.127000> rotate<0,-44.997030,0> translate<4.346569,-1.535000,22.834600> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.346569,-1.535000,27.965397>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.080000,-1.535000,27.231966>}
box{<0,0,-0.127000><1.037228,0.035000,0.127000> rotate<0,44.997030,0> translate<4.346569,-1.535000,27.965397> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.371966,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.788034,-1.535000,21.590000>}
box{<0,0,-0.127000><1.416069,0.035000,0.127000> rotate<0,0.000000,0> translate<4.371966,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.371966,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.788034,-1.535000,27.940000>}
box{<0,0,-0.127000><1.416069,0.035000,0.127000> rotate<0,0.000000,0> translate<4.371966,-1.535000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.371969,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.788028,-1.535000,16.510000>}
box{<0,0,-0.127000><1.416059,0.035000,0.127000> rotate<0,0.000000,0> translate<4.371969,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.371969,-1.535000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.788028,-1.535000,22.860000>}
box{<0,0,-0.127000><1.416059,0.035000,0.127000> rotate<0,0.000000,0> translate<4.371969,-1.535000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.409059,-1.535000,-0.469578>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.554613,-1.535000,-0.363828>}
box{<0,0,-0.127000><0.179913,0.035000,0.127000> rotate<0,-35.997486,0> translate<4.409059,-1.535000,-0.469578> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.409059,-1.535000,3.009578>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.554613,-1.535000,2.903828>}
box{<0,0,-0.127000><0.179913,0.035000,0.127000> rotate<0,35.997486,0> translate<4.409059,-1.535000,3.009578> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.419600,-1.535000,14.506266>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.419600,-1.535000,12.163731>}
box{<0,0,-0.127000><2.342534,0.035000,0.127000> rotate<0,-90.000000,0> translate<4.419600,-1.535000,12.163731> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.521587,-1.535000,10.594278>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.883909,-1.535000,10.444200>}
box{<0,0,-0.127000><0.392174,0.035000,0.127000> rotate<0,22.498446,0> translate<4.521587,-1.535000,10.594278> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.521587,-1.535000,16.075719>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.883909,-1.535000,16.225797>}
box{<0,0,-0.127000><0.392174,0.035000,0.127000> rotate<0,-22.498446,0> translate<4.521587,-1.535000,16.075719> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.554613,-1.535000,-0.363828>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.681828,-1.535000,-0.236613>}
box{<0,0,-0.127000><0.179910,0.035000,0.127000> rotate<0,-44.997030,0> translate<4.554613,-1.535000,-0.363828> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.554613,-1.535000,2.903828>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.681828,-1.535000,2.776613>}
box{<0,0,-0.127000><0.179910,0.035000,0.127000> rotate<0,44.997030,0> translate<4.554613,-1.535000,2.903828> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.625966,-1.535000,21.336000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.534034,-1.535000,21.336000>}
box{<0,0,-0.127000><0.908069,0.035000,0.127000> rotate<0,0.000000,0> translate<4.625966,-1.535000,21.336000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.625966,-1.535000,27.686000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.534034,-1.535000,27.686000>}
box{<0,0,-0.127000><0.908069,0.035000,0.127000> rotate<0,0.000000,0> translate<4.625966,-1.535000,27.686000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.625969,-1.535000,16.764000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.534028,-1.535000,16.764000>}
box{<0,0,-0.127000><0.908059,0.035000,0.127000> rotate<0,0.000000,0> translate<4.625969,-1.535000,16.764000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.625969,-1.535000,23.114000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.534028,-1.535000,23.114000>}
box{<0,0,-0.127000><0.908059,0.035000,0.127000> rotate<0,0.000000,0> translate<4.625969,-1.535000,23.114000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.664441,-1.535000,-0.254000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.495556,-1.535000,-0.254000>}
box{<0,0,-0.127000><0.831116,0.035000,0.127000> rotate<0,0.000000,0> translate<4.664441,-1.535000,-0.254000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.664441,-1.535000,2.794000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.495556,-1.535000,2.794000>}
box{<0,0,-0.127000><0.831116,0.035000,0.127000> rotate<0,0.000000,0> translate<4.664441,-1.535000,2.794000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.681828,-1.535000,-0.236613>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.787578,-1.535000,-0.091059>}
box{<0,0,-0.127000><0.179913,0.035000,0.127000> rotate<0,-53.996574,0> translate<4.681828,-1.535000,-0.236613> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.681828,-1.535000,2.776613>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.787578,-1.535000,2.631059>}
box{<0,0,-0.127000><0.179913,0.035000,0.127000> rotate<0,53.996574,0> translate<4.681828,-1.535000,2.776613> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.787578,-1.535000,-0.091059>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.869256,-1.535000,0.069238>}
box{<0,0,-0.127000><0.179907,0.035000,0.127000> rotate<0,-62.995051,0> translate<4.787578,-1.535000,-0.091059> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.787578,-1.535000,2.631059>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.869256,-1.535000,2.470759>}
box{<0,0,-0.127000><0.179909,0.035000,0.127000> rotate<0,62.995503,0> translate<4.787578,-1.535000,2.631059> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.833975,-1.535000,0.000000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.326019,-1.535000,0.000000>}
box{<0,0,-0.127000><0.492044,0.035000,0.127000> rotate<0,0.000000,0> translate<4.833975,-1.535000,0.000000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.833978,-1.535000,2.540000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.326022,-1.535000,2.540000>}
box{<0,0,-0.127000><0.492044,0.035000,0.127000> rotate<0,0.000000,0> translate<4.833978,-1.535000,2.540000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.869256,-1.535000,0.069238>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.924853,-1.535000,0.240344>}
box{<0,0,-0.127000><0.179912,0.035000,0.127000> rotate<0,-71.994920,0> translate<4.869256,-1.535000,0.069238> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.869256,-1.535000,2.470759>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.924853,-1.535000,2.299653>}
box{<0,0,-0.127000><0.179912,0.035000,0.127000> rotate<0,71.994920,0> translate<4.869256,-1.535000,2.470759> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.879966,-1.535000,21.082000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.280034,-1.535000,21.082000>}
box{<0,0,-0.127000><0.400069,0.035000,0.127000> rotate<0,0.000000,0> translate<4.879966,-1.535000,21.082000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.879966,-1.535000,27.432000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.280034,-1.535000,27.432000>}
box{<0,0,-0.127000><0.400069,0.035000,0.127000> rotate<0,0.000000,0> translate<4.879966,-1.535000,27.432000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.879969,-1.535000,17.018000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.280028,-1.535000,17.018000>}
box{<0,0,-0.127000><0.400059,0.035000,0.127000> rotate<0,0.000000,0> translate<4.879969,-1.535000,17.018000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.879969,-1.535000,23.368000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.280028,-1.535000,23.368000>}
box{<0,0,-0.127000><0.400059,0.035000,0.127000> rotate<0,0.000000,0> translate<4.879969,-1.535000,23.368000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.883909,-1.535000,10.444200>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.276088,-1.535000,10.444200>}
box{<0,0,-0.127000><0.392178,0.035000,0.127000> rotate<0,0.000000,0> translate<4.883909,-1.535000,10.444200> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.883909,-1.535000,16.225797>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.276088,-1.535000,16.225797>}
box{<0,0,-0.127000><0.392178,0.035000,0.127000> rotate<0,0.000000,0> translate<4.883909,-1.535000,16.225797> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.924853,-1.535000,0.240344>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.952997,-1.535000,0.418041>}
box{<0,0,-0.127000><0.179912,0.035000,0.127000> rotate<0,-80.994865,0> translate<4.924853,-1.535000,0.240344> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.924853,-1.535000,2.299653>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.952997,-1.535000,2.121956>}
box{<0,0,-0.127000><0.179912,0.035000,0.127000> rotate<0,80.994865,0> translate<4.924853,-1.535000,2.299653> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.927016,-1.535000,0.254000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.232978,-1.535000,0.254000>}
box{<0,0,-0.127000><0.305962,0.035000,0.127000> rotate<0,0.000000,0> translate<4.927016,-1.535000,0.254000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.927016,-1.535000,2.286000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.232984,-1.535000,2.286000>}
box{<0,0,-0.127000><0.305969,0.035000,0.127000> rotate<0,0.000000,0> translate<4.927016,-1.535000,2.286000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.952997,-1.535000,0.418041>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.952997,-1.535000,1.143000>}
box{<0,0,-0.127000><0.724959,0.035000,0.127000> rotate<0,90.000000,0> translate<4.952997,-1.535000,1.143000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.952997,-1.535000,0.508000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.207000,-1.535000,0.508000>}
box{<0,0,-0.127000><0.254003,0.035000,0.127000> rotate<0,0.000000,0> translate<4.952997,-1.535000,0.508000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.952997,-1.535000,0.762000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.207000,-1.535000,0.762000>}
box{<0,0,-0.127000><0.254003,0.035000,0.127000> rotate<0,0.000000,0> translate<4.952997,-1.535000,0.762000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.952997,-1.535000,1.016000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.207000,-1.535000,1.016000>}
box{<0,0,-0.127000><0.254003,0.035000,0.127000> rotate<0,0.000000,0> translate<4.952997,-1.535000,1.016000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.952997,-1.535000,1.396994>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.952997,-1.535000,2.121956>}
box{<0,0,-0.127000><0.724963,0.035000,0.127000> rotate<0,90.000000,0> translate<4.952997,-1.535000,2.121956> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.952997,-1.535000,1.524000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.207000,-1.535000,1.524000>}
box{<0,0,-0.127000><0.254003,0.035000,0.127000> rotate<0,0.000000,0> translate<4.952997,-1.535000,1.524000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.952997,-1.535000,1.778000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.207000,-1.535000,1.778000>}
box{<0,0,-0.127000><0.254003,0.035000,0.127000> rotate<0,0.000000,0> translate<4.952997,-1.535000,1.778000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<4.952997,-1.535000,2.032000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.207000,-1.535000,2.032000>}
box{<0,0,-0.127000><0.254003,0.035000,0.127000> rotate<0,0.000000,0> translate<4.952997,-1.535000,2.032000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.080000,-1.535000,17.218031>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.813428,-1.535000,16.484600>}
box{<0,0,-0.127000><1.037226,0.035000,0.127000> rotate<0,44.997152,0> translate<5.080000,-1.535000,17.218031> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.080000,-1.535000,20.881966>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.813428,-1.535000,21.615397>}
box{<0,0,-0.127000><1.037226,0.035000,0.127000> rotate<0,-44.997152,0> translate<5.080000,-1.535000,20.881966> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.080000,-1.535000,23.568031>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.813428,-1.535000,22.834600>}
box{<0,0,-0.127000><1.037226,0.035000,0.127000> rotate<0,44.997152,0> translate<5.080000,-1.535000,23.568031> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.080000,-1.535000,27.231966>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.813428,-1.535000,27.965397>}
box{<0,0,-0.127000><1.037226,0.035000,0.127000> rotate<0,-44.997152,0> translate<5.080000,-1.535000,27.231966> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.207000,-1.535000,0.418041>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.235144,-1.535000,0.240344>}
box{<0,0,-0.127000><0.179912,0.035000,0.127000> rotate<0,80.994865,0> translate<5.207000,-1.535000,0.418041> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.207000,-1.535000,1.143000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.207000,-1.535000,0.418041>}
box{<0,0,-0.127000><0.724959,0.035000,0.127000> rotate<0,-90.000000,0> translate<5.207000,-1.535000,0.418041> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.207000,-1.535000,1.143000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.222984,-1.535000,1.143000>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,0.000000,0> translate<5.207000,-1.535000,1.143000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.207000,-1.535000,1.396994>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.222984,-1.535000,1.396994>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,0.000000,0> translate<5.207000,-1.535000,1.396994> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.207000,-1.535000,2.121956>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.207000,-1.535000,1.396994>}
box{<0,0,-0.127000><0.724963,0.035000,0.127000> rotate<0,-90.000000,0> translate<5.207000,-1.535000,1.396994> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.207000,-1.535000,2.121956>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.235144,-1.535000,2.299653>}
box{<0,0,-0.127000><0.179912,0.035000,0.127000> rotate<0,-80.994865,0> translate<5.207000,-1.535000,2.121956> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.235144,-1.535000,0.240344>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.290741,-1.535000,0.069238>}
box{<0,0,-0.127000><0.179912,0.035000,0.127000> rotate<0,71.994920,0> translate<5.235144,-1.535000,0.240344> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.235144,-1.535000,2.299653>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.290741,-1.535000,2.470759>}
box{<0,0,-0.127000><0.179912,0.035000,0.127000> rotate<0,-71.994920,0> translate<5.235144,-1.535000,2.299653> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.276088,-1.535000,10.444200>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.638409,-1.535000,10.594278>}
box{<0,0,-0.127000><0.392174,0.035000,0.127000> rotate<0,-22.498446,0> translate<5.276088,-1.535000,10.444200> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.276088,-1.535000,16.225797>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.638409,-1.535000,16.075719>}
box{<0,0,-0.127000><0.392174,0.035000,0.127000> rotate<0,22.498446,0> translate<5.276088,-1.535000,16.225797> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.290741,-1.535000,0.069238>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.372419,-1.535000,-0.091059>}
box{<0,0,-0.127000><0.179907,0.035000,0.127000> rotate<0,62.995051,0> translate<5.290741,-1.535000,0.069238> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.290741,-1.535000,2.470759>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.372419,-1.535000,2.631059>}
box{<0,0,-0.127000><0.179909,0.035000,0.127000> rotate<0,-62.995503,0> translate<5.290741,-1.535000,2.470759> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.372419,-1.535000,-0.091059>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.478169,-1.535000,-0.236613>}
box{<0,0,-0.127000><0.179913,0.035000,0.127000> rotate<0,53.996574,0> translate<5.372419,-1.535000,-0.091059> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.372419,-1.535000,2.631059>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.478169,-1.535000,2.776613>}
box{<0,0,-0.127000><0.179913,0.035000,0.127000> rotate<0,-53.996574,0> translate<5.372419,-1.535000,2.631059> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.478169,-1.535000,-0.236613>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.605384,-1.535000,-0.363828>}
box{<0,0,-0.127000><0.179910,0.035000,0.127000> rotate<0,44.997030,0> translate<5.478169,-1.535000,-0.236613> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.478169,-1.535000,2.776613>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.605384,-1.535000,2.903828>}
box{<0,0,-0.127000><0.179910,0.035000,0.127000> rotate<0,-44.997030,0> translate<5.478169,-1.535000,2.776613> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.605384,-1.535000,-0.363828>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.750938,-1.535000,-0.469578>}
box{<0,0,-0.127000><0.179913,0.035000,0.127000> rotate<0,35.997486,0> translate<5.605384,-1.535000,-0.363828> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.605384,-1.535000,2.903828>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.750938,-1.535000,3.009578>}
box{<0,0,-0.127000><0.179913,0.035000,0.127000> rotate<0,-35.997486,0> translate<5.605384,-1.535000,2.903828> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.638409,-1.535000,10.594278>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.915719,-1.535000,10.871588>}
box{<0,0,-0.127000><0.392175,0.035000,0.127000> rotate<0,-44.997030,0> translate<5.638409,-1.535000,10.594278> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.638409,-1.535000,16.075719>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.915719,-1.535000,15.798409>}
box{<0,0,-0.127000><0.392175,0.035000,0.127000> rotate<0,44.997030,0> translate<5.638409,-1.535000,16.075719> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.712128,-1.535000,16.002000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<12.274053,-1.535000,16.002000>}
box{<0,0,-0.127000><6.561925,0.035000,0.127000> rotate<0,0.000000,0> translate<5.712128,-1.535000,16.002000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.712131,-1.535000,10.668000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.229600,-1.535000,10.668000>}
box{<0,0,-0.127000><2.517469,0.035000,0.127000> rotate<0,0.000000,0> translate<5.712131,-1.535000,10.668000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.740397,-1.535000,12.163731>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.740397,-1.535000,14.506266>}
box{<0,0,-0.127000><2.342534,0.035000,0.127000> rotate<0,90.000000,0> translate<5.740397,-1.535000,14.506266> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.740397,-1.535000,12.163731>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.915719,-1.535000,11.988409>}
box{<0,0,-0.127000><0.247943,0.035000,0.127000> rotate<0,44.997030,0> translate<5.740397,-1.535000,12.163731> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.740397,-1.535000,12.192000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.257869,-1.535000,12.192000>}
box{<0,0,-0.127000><2.517472,0.035000,0.127000> rotate<0,0.000000,0> translate<5.740397,-1.535000,12.192000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.740397,-1.535000,12.446000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.899600,-1.535000,12.446000>}
box{<0,0,-0.127000><29.159203,0.035000,0.127000> rotate<0,0.000000,0> translate<5.740397,-1.535000,12.446000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.740397,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.899600,-1.535000,12.700000>}
box{<0,0,-0.127000><29.159203,0.035000,0.127000> rotate<0,0.000000,0> translate<5.740397,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.740397,-1.535000,12.954000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.899600,-1.535000,12.954000>}
box{<0,0,-0.127000><29.159203,0.035000,0.127000> rotate<0,0.000000,0> translate<5.740397,-1.535000,12.954000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.740397,-1.535000,13.208000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.767866,-1.535000,13.208000>}
box{<0,0,-0.127000><19.027469,0.035000,0.127000> rotate<0,0.000000,0> translate<5.740397,-1.535000,13.208000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.740397,-1.535000,13.462000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.543394,-1.535000,13.462000>}
box{<0,0,-0.127000><18.802997,0.035000,0.127000> rotate<0,0.000000,0> translate<5.740397,-1.535000,13.462000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.740397,-1.535000,13.716000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.438184,-1.535000,13.716000>}
box{<0,0,-0.127000><18.697788,0.035000,0.127000> rotate<0,0.000000,0> translate<5.740397,-1.535000,13.716000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.740397,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.414200,-1.535000,13.970000>}
box{<0,0,-0.127000><18.673803,0.035000,0.127000> rotate<0,0.000000,0> translate<5.740397,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.740397,-1.535000,14.224000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.212053,-1.535000,14.224000>}
box{<0,0,-0.127000><18.471656,0.035000,0.127000> rotate<0,0.000000,0> translate<5.740397,-1.535000,14.224000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.740397,-1.535000,14.478000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<23.958053,-1.535000,14.478000>}
box{<0,0,-0.127000><18.217656,0.035000,0.127000> rotate<0,0.000000,0> translate<5.740397,-1.535000,14.478000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.740397,-1.535000,14.506266>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.915719,-1.535000,14.681588>}
box{<0,0,-0.127000><0.247943,0.035000,0.127000> rotate<0,-44.997030,0> translate<5.740397,-1.535000,14.506266> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.750938,-1.535000,-0.469578>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.911238,-1.535000,-0.551256>}
box{<0,0,-0.127000><0.179909,0.035000,0.127000> rotate<0,26.998557,0> translate<5.750938,-1.535000,-0.469578> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.750938,-1.535000,3.009578>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.911238,-1.535000,3.091256>}
box{<0,0,-0.127000><0.179909,0.035000,0.127000> rotate<0,-26.998557,0> translate<5.750938,-1.535000,3.009578> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.813428,-1.535000,16.484600>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.886569,-1.535000,16.484600>}
box{<0,0,-0.127000><1.073141,0.035000,0.127000> rotate<0,0.000000,0> translate<5.813428,-1.535000,16.484600> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.813428,-1.535000,21.615397>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.886569,-1.535000,21.615397>}
box{<0,0,-0.127000><1.073141,0.035000,0.127000> rotate<0,0.000000,0> translate<5.813428,-1.535000,21.615397> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.813428,-1.535000,22.834600>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.886569,-1.535000,22.834600>}
box{<0,0,-0.127000><1.073141,0.035000,0.127000> rotate<0,0.000000,0> translate<5.813428,-1.535000,22.834600> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.813428,-1.535000,27.965397>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.886569,-1.535000,27.965397>}
box{<0,0,-0.127000><1.073141,0.035000,0.127000> rotate<0,0.000000,0> translate<5.813428,-1.535000,27.965397> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.911238,-1.535000,-0.551256>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.082344,-1.535000,-0.606853>}
box{<0,0,-0.127000><0.179912,0.035000,0.127000> rotate<0,17.999140,0> translate<5.911238,-1.535000,-0.551256> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.911238,-1.535000,3.091256>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.082344,-1.535000,3.146853>}
box{<0,0,-0.127000><0.179912,0.035000,0.127000> rotate<0,-17.999140,0> translate<5.911238,-1.535000,3.091256> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.915719,-1.535000,10.871588>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.065797,-1.535000,11.233909>}
box{<0,0,-0.127000><0.392174,0.035000,0.127000> rotate<0,-67.495614,0> translate<5.915719,-1.535000,10.871588> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.915719,-1.535000,11.988409>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.065797,-1.535000,11.626088>}
box{<0,0,-0.127000><0.392174,0.035000,0.127000> rotate<0,67.495614,0> translate<5.915719,-1.535000,11.988409> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.915719,-1.535000,14.681588>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.065797,-1.535000,15.043909>}
box{<0,0,-0.127000><0.392174,0.035000,0.127000> rotate<0,-67.495614,0> translate<5.915719,-1.535000,14.681588> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.915719,-1.535000,15.798409>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.065797,-1.535000,15.436088>}
box{<0,0,-0.127000><0.392174,0.035000,0.127000> rotate<0,67.495614,0> translate<5.915719,-1.535000,15.798409> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.936600,-1.535000,10.922000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.033394,-1.535000,10.922000>}
box{<0,0,-0.127000><2.096794,0.035000,0.127000> rotate<0,0.000000,0> translate<5.936600,-1.535000,10.922000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.936600,-1.535000,11.938000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.033400,-1.535000,11.938000>}
box{<0,0,-0.127000><2.096800,0.035000,0.127000> rotate<0,0.000000,0> translate<5.936600,-1.535000,11.938000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.936600,-1.535000,14.732000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<13.544053,-1.535000,14.732000>}
box{<0,0,-0.127000><7.607453,0.035000,0.127000> rotate<0,0.000000,0> translate<5.936600,-1.535000,14.732000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.936600,-1.535000,15.748000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<12.528053,-1.535000,15.748000>}
box{<0,0,-0.127000><6.591453,0.035000,0.127000> rotate<0,0.000000,0> translate<5.936600,-1.535000,15.748000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.041809,-1.535000,11.176000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.928184,-1.535000,11.176000>}
box{<0,0,-0.127000><1.886375,0.035000,0.127000> rotate<0,0.000000,0> translate<6.041809,-1.535000,11.176000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.041809,-1.535000,11.684000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.928191,-1.535000,11.684000>}
box{<0,0,-0.127000><1.886381,0.035000,0.127000> rotate<0,0.000000,0> translate<6.041809,-1.535000,11.684000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.041809,-1.535000,14.986000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<13.290053,-1.535000,14.986000>}
box{<0,0,-0.127000><7.248244,0.035000,0.127000> rotate<0,0.000000,0> translate<6.041809,-1.535000,14.986000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.041809,-1.535000,15.494000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<12.782053,-1.535000,15.494000>}
box{<0,0,-0.127000><6.740244,0.035000,0.127000> rotate<0,0.000000,0> translate<6.041809,-1.535000,15.494000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.065797,-1.535000,11.233909>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.065797,-1.535000,11.626088>}
box{<0,0,-0.127000><0.392178,0.035000,0.127000> rotate<0,90.000000,0> translate<6.065797,-1.535000,11.626088> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.065797,-1.535000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.904200,-1.535000,11.430000>}
box{<0,0,-0.127000><1.838403,0.035000,0.127000> rotate<0,0.000000,0> translate<6.065797,-1.535000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.065797,-1.535000,15.043909>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.065797,-1.535000,15.436088>}
box{<0,0,-0.127000><0.392178,0.035000,0.127000> rotate<0,90.000000,0> translate<6.065797,-1.535000,15.436088> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.065797,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<13.036053,-1.535000,15.240000>}
box{<0,0,-0.127000><6.970256,0.035000,0.127000> rotate<0,0.000000,0> translate<6.065797,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.082344,-1.535000,-0.606853>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.223000,-1.535000,-0.629128>}
box{<0,0,-0.127000><0.142409,0.035000,0.127000> rotate<0,8.998309,0> translate<6.082344,-1.535000,-0.606853> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.082344,-1.535000,3.146853>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.223000,-1.535000,3.169128>}
box{<0,0,-0.127000><0.142409,0.035000,0.127000> rotate<0,-8.998309,0> translate<6.082344,-1.535000,3.146853> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.222984,-1.535000,1.396994>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.222984,-1.535000,1.143000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,-90.000000,0> translate<6.222984,-1.535000,1.143000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.223000,-1.535000,-0.629128>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.223000,-1.535000,1.142984>}
box{<0,0,-0.127000><1.772113,0.035000,0.127000> rotate<0,90.000000,0> translate<6.223000,-1.535000,1.142984> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.223000,-1.535000,-0.508000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.476994,-1.535000,-0.508000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<6.223000,-1.535000,-0.508000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.223000,-1.535000,-0.254000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.476994,-1.535000,-0.254000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<6.223000,-1.535000,-0.254000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.223000,-1.535000,0.000000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.476994,-1.535000,0.000000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<6.223000,-1.535000,0.000000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.223000,-1.535000,0.254000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.476994,-1.535000,0.254000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<6.223000,-1.535000,0.254000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.223000,-1.535000,0.508000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.476994,-1.535000,0.508000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<6.223000,-1.535000,0.508000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.223000,-1.535000,0.762000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.476994,-1.535000,0.762000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<6.223000,-1.535000,0.762000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.223000,-1.535000,1.016000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.476994,-1.535000,1.016000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<6.223000,-1.535000,1.016000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.223000,-1.535000,1.142984>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.476994,-1.535000,1.142984>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<6.223000,-1.535000,1.142984> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.223000,-1.535000,1.397012>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.223000,-1.535000,3.169128>}
box{<0,0,-0.127000><1.772116,0.035000,0.127000> rotate<0,90.000000,0> translate<6.223000,-1.535000,3.169128> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.223000,-1.535000,1.397012>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.476994,-1.535000,1.397012>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<6.223000,-1.535000,1.397012> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.223000,-1.535000,1.524000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.476994,-1.535000,1.524000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<6.223000,-1.535000,1.524000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.223000,-1.535000,1.778000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.476994,-1.535000,1.778000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<6.223000,-1.535000,1.778000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.223000,-1.535000,2.032000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.476994,-1.535000,2.032000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<6.223000,-1.535000,2.032000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.223000,-1.535000,2.286000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.476994,-1.535000,2.286000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<6.223000,-1.535000,2.286000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.223000,-1.535000,2.540000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.476994,-1.535000,2.540000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<6.223000,-1.535000,2.540000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.223000,-1.535000,2.794000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.476994,-1.535000,2.794000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<6.223000,-1.535000,2.794000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.223000,-1.535000,3.048000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.476994,-1.535000,3.048000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<6.223000,-1.535000,3.048000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.476994,-1.535000,-0.629128>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.617653,-1.535000,-0.606853>}
box{<0,0,-0.127000><0.142412,0.035000,0.127000> rotate<0,-8.998112,0> translate<6.476994,-1.535000,-0.629128> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.476994,-1.535000,1.142984>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.476994,-1.535000,-0.629128>}
box{<0,0,-0.127000><1.772113,0.035000,0.127000> rotate<0,-90.000000,0> translate<6.476994,-1.535000,-0.629128> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.476994,-1.535000,3.169128>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.476994,-1.535000,1.397012>}
box{<0,0,-0.127000><1.772116,0.035000,0.127000> rotate<0,-90.000000,0> translate<6.476994,-1.535000,1.397012> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.476994,-1.535000,3.169128>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.617653,-1.535000,3.146853>}
box{<0,0,-0.127000><0.142412,0.035000,0.127000> rotate<0,8.998112,0> translate<6.476994,-1.535000,3.169128> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.477013,-1.535000,1.143000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.477013,-1.535000,1.396994>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,90.000000,0> translate<6.477013,-1.535000,1.396994> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.477013,-1.535000,1.143000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.492997,-1.535000,1.143000>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,0.000000,0> translate<6.477013,-1.535000,1.143000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.477013,-1.535000,1.270000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.594600,-1.535000,1.270000>}
box{<0,0,-0.127000><1.117587,0.035000,0.127000> rotate<0,0.000000,0> translate<6.477013,-1.535000,1.270000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.477013,-1.535000,1.396994>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.492997,-1.535000,1.396994>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,0.000000,0> translate<6.477013,-1.535000,1.396994> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.617653,-1.535000,-0.606853>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.788759,-1.535000,-0.551256>}
box{<0,0,-0.127000><0.179912,0.035000,0.127000> rotate<0,-17.999140,0> translate<6.617653,-1.535000,-0.606853> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.617653,-1.535000,3.146853>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.788759,-1.535000,3.091256>}
box{<0,0,-0.127000><0.179912,0.035000,0.127000> rotate<0,17.999140,0> translate<6.617653,-1.535000,3.146853> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.788759,-1.535000,-0.551256>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.949059,-1.535000,-0.469578>}
box{<0,0,-0.127000><0.179909,0.035000,0.127000> rotate<0,-26.998557,0> translate<6.788759,-1.535000,-0.551256> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.788759,-1.535000,3.091256>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.949059,-1.535000,3.009578>}
box{<0,0,-0.127000><0.179909,0.035000,0.127000> rotate<0,26.998557,0> translate<6.788759,-1.535000,3.091256> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.873653,-1.535000,-0.508000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.074028,-1.535000,-0.508000>}
box{<0,0,-0.127000><1.200375,0.035000,0.127000> rotate<0,0.000000,0> translate<6.873653,-1.535000,-0.508000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.873656,-1.535000,3.048000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.074028,-1.535000,3.048000>}
box{<0,0,-0.127000><1.200372,0.035000,0.127000> rotate<0,0.000000,0> translate<6.873656,-1.535000,3.048000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.886569,-1.535000,16.484600>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.645397,-1.535000,17.243428>}
box{<0,0,-0.127000><1.073145,0.035000,0.127000> rotate<0,-44.997030,0> translate<6.886569,-1.535000,16.484600> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.886569,-1.535000,21.615397>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.619997,-1.535000,20.881966>}
box{<0,0,-0.127000><1.037226,0.035000,0.127000> rotate<0,44.997152,0> translate<6.886569,-1.535000,21.615397> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.886569,-1.535000,22.834600>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.645397,-1.535000,23.593428>}
box{<0,0,-0.127000><1.073145,0.035000,0.127000> rotate<0,-44.997030,0> translate<6.886569,-1.535000,22.834600> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.886569,-1.535000,27.965397>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.620000,-1.535000,27.231966>}
box{<0,0,-0.127000><1.037228,0.035000,0.127000> rotate<0,44.997030,0> translate<6.886569,-1.535000,27.965397> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.911966,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.619997,-1.535000,19.758031>}
box{<0,0,-0.127000><1.001307,0.035000,0.127000> rotate<0,-44.997030,0> translate<6.911966,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.911966,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.645397,-1.535000,18.316569>}
box{<0,0,-0.127000><1.037228,0.035000,0.127000> rotate<0,44.997030,0> translate<6.911966,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.911966,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.328028,-1.535000,19.050000>}
box{<0,0,-0.127000><1.416063,0.035000,0.127000> rotate<0,0.000000,0> translate<6.911966,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.911966,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.328031,-1.535000,21.590000>}
box{<0,0,-0.127000><1.416066,0.035000,0.127000> rotate<0,0.000000,0> translate<6.911966,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.911966,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.620000,-1.535000,26.108031>}
box{<0,0,-0.127000><1.001310,0.035000,0.127000> rotate<0,-44.996904,0> translate<6.911966,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.911966,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.645397,-1.535000,24.666569>}
box{<0,0,-0.127000><1.037228,0.035000,0.127000> rotate<0,44.997030,0> translate<6.911966,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.911966,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.328028,-1.535000,25.400000>}
box{<0,0,-0.127000><1.416063,0.035000,0.127000> rotate<0,0.000000,0> translate<6.911966,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.911966,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.328034,-1.535000,27.940000>}
box{<0,0,-0.127000><1.416069,0.035000,0.127000> rotate<0,0.000000,0> translate<6.911966,-1.535000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.911969,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.868028,-1.535000,16.510000>}
box{<0,0,-0.127000><3.956059,0.035000,0.127000> rotate<0,0.000000,0> translate<6.911969,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.911969,-1.535000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.868028,-1.535000,22.860000>}
box{<0,0,-0.127000><3.956059,0.035000,0.127000> rotate<0,0.000000,0> translate<6.911969,-1.535000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.949059,-1.535000,-0.469578>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.094613,-1.535000,-0.363828>}
box{<0,0,-0.127000><0.179913,0.035000,0.127000> rotate<0,-35.997486,0> translate<6.949059,-1.535000,-0.469578> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.949059,-1.535000,3.009578>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.094613,-1.535000,2.903828>}
box{<0,0,-0.127000><0.179913,0.035000,0.127000> rotate<0,35.997486,0> translate<6.949059,-1.535000,3.009578> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.094613,-1.535000,-0.363828>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.221828,-1.535000,-0.236613>}
box{<0,0,-0.127000><0.179910,0.035000,0.127000> rotate<0,-44.997030,0> translate<7.094613,-1.535000,-0.363828> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.094613,-1.535000,2.903828>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.221828,-1.535000,2.776613>}
box{<0,0,-0.127000><0.179910,0.035000,0.127000> rotate<0,44.997030,0> translate<7.094613,-1.535000,2.903828> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.165966,-1.535000,18.796000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.289556,-1.535000,18.796000>}
box{<0,0,-0.127000><1.123591,0.035000,0.127000> rotate<0,0.000000,0> translate<7.165966,-1.535000,18.796000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.165966,-1.535000,19.304000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.074028,-1.535000,19.304000>}
box{<0,0,-0.127000><0.908062,0.035000,0.127000> rotate<0,0.000000,0> translate<7.165966,-1.535000,19.304000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.165966,-1.535000,21.336000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.074031,-1.535000,21.336000>}
box{<0,0,-0.127000><0.908066,0.035000,0.127000> rotate<0,0.000000,0> translate<7.165966,-1.535000,21.336000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.165966,-1.535000,25.146000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.289556,-1.535000,25.146000>}
box{<0,0,-0.127000><1.123591,0.035000,0.127000> rotate<0,0.000000,0> translate<7.165966,-1.535000,25.146000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.165966,-1.535000,25.654000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.074028,-1.535000,25.654000>}
box{<0,0,-0.127000><0.908062,0.035000,0.127000> rotate<0,0.000000,0> translate<7.165966,-1.535000,25.654000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.165966,-1.535000,27.686000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.074034,-1.535000,27.686000>}
box{<0,0,-0.127000><0.908069,0.035000,0.127000> rotate<0,0.000000,0> translate<7.165966,-1.535000,27.686000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.165969,-1.535000,16.764000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.289553,-1.535000,16.764000>}
box{<0,0,-0.127000><1.123584,0.035000,0.127000> rotate<0,0.000000,0> translate<7.165969,-1.535000,16.764000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.165969,-1.535000,23.114000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.289553,-1.535000,23.114000>}
box{<0,0,-0.127000><1.123584,0.035000,0.127000> rotate<0,0.000000,0> translate<7.165969,-1.535000,23.114000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.204441,-1.535000,-0.254000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.820028,-1.535000,-0.254000>}
box{<0,0,-0.127000><0.615588,0.035000,0.127000> rotate<0,0.000000,0> translate<7.204441,-1.535000,-0.254000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.204441,-1.535000,2.794000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.820028,-1.535000,2.794000>}
box{<0,0,-0.127000><0.615588,0.035000,0.127000> rotate<0,0.000000,0> translate<7.204441,-1.535000,2.794000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.221828,-1.535000,-0.236613>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.327578,-1.535000,-0.091059>}
box{<0,0,-0.127000><0.179913,0.035000,0.127000> rotate<0,-53.996574,0> translate<7.221828,-1.535000,-0.236613> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.221828,-1.535000,2.776613>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.327578,-1.535000,2.631059>}
box{<0,0,-0.127000><0.179913,0.035000,0.127000> rotate<0,53.996574,0> translate<7.221828,-1.535000,2.776613> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.327578,-1.535000,-0.091059>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.409256,-1.535000,0.069238>}
box{<0,0,-0.127000><0.179907,0.035000,0.127000> rotate<0,-62.995051,0> translate<7.327578,-1.535000,-0.091059> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.327578,-1.535000,2.631059>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.409256,-1.535000,2.470759>}
box{<0,0,-0.127000><0.179909,0.035000,0.127000> rotate<0,62.995503,0> translate<7.327578,-1.535000,2.631059> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.373975,-1.535000,0.000000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.698288,-1.535000,0.000000>}
box{<0,0,-0.127000><0.324312,0.035000,0.127000> rotate<0,0.000000,0> translate<7.373975,-1.535000,0.000000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.373978,-1.535000,2.540000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.698291,-1.535000,2.540000>}
box{<0,0,-0.127000><0.324312,0.035000,0.127000> rotate<0,0.000000,0> translate<7.373978,-1.535000,2.540000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.409256,-1.535000,0.069238>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.464853,-1.535000,0.240344>}
box{<0,0,-0.127000><0.179912,0.035000,0.127000> rotate<0,-71.994920,0> translate<7.409256,-1.535000,0.069238> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.409256,-1.535000,2.470759>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.464853,-1.535000,2.299653>}
box{<0,0,-0.127000><0.179912,0.035000,0.127000> rotate<0,71.994920,0> translate<7.409256,-1.535000,2.470759> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.419966,-1.535000,18.542000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.035556,-1.535000,18.542000>}
box{<0,0,-0.127000><0.615591,0.035000,0.127000> rotate<0,0.000000,0> translate<7.419966,-1.535000,18.542000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.419966,-1.535000,19.558000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.820028,-1.535000,19.558000>}
box{<0,0,-0.127000><0.400062,0.035000,0.127000> rotate<0,0.000000,0> translate<7.419966,-1.535000,19.558000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.419966,-1.535000,21.082000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.820031,-1.535000,21.082000>}
box{<0,0,-0.127000><0.400066,0.035000,0.127000> rotate<0,0.000000,0> translate<7.419966,-1.535000,21.082000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.419966,-1.535000,24.892000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.035556,-1.535000,24.892000>}
box{<0,0,-0.127000><0.615591,0.035000,0.127000> rotate<0,0.000000,0> translate<7.419966,-1.535000,24.892000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.419966,-1.535000,25.908000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.820028,-1.535000,25.908000>}
box{<0,0,-0.127000><0.400062,0.035000,0.127000> rotate<0,0.000000,0> translate<7.419966,-1.535000,25.908000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.419966,-1.535000,27.432000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.820034,-1.535000,27.432000>}
box{<0,0,-0.127000><0.400069,0.035000,0.127000> rotate<0,0.000000,0> translate<7.419966,-1.535000,27.432000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.419969,-1.535000,17.018000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.035553,-1.535000,17.018000>}
box{<0,0,-0.127000><0.615584,0.035000,0.127000> rotate<0,0.000000,0> translate<7.419969,-1.535000,17.018000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.419969,-1.535000,23.368000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.035553,-1.535000,23.368000>}
box{<0,0,-0.127000><0.615584,0.035000,0.127000> rotate<0,0.000000,0> translate<7.419969,-1.535000,23.368000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.464853,-1.535000,0.240344>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.492997,-1.535000,0.418041>}
box{<0,0,-0.127000><0.179912,0.035000,0.127000> rotate<0,-80.994865,0> translate<7.464853,-1.535000,0.240344> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.464853,-1.535000,2.299653>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.492997,-1.535000,2.121956>}
box{<0,0,-0.127000><0.179912,0.035000,0.127000> rotate<0,80.994865,0> translate<7.464853,-1.535000,2.299653> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.467016,-1.535000,0.254000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.594600,-1.535000,0.254000>}
box{<0,0,-0.127000><0.127584,0.035000,0.127000> rotate<0,0.000000,0> translate<7.467016,-1.535000,0.254000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.467016,-1.535000,2.286000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.594600,-1.535000,2.286000>}
box{<0,0,-0.127000><0.127584,0.035000,0.127000> rotate<0,0.000000,0> translate<7.467016,-1.535000,2.286000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.492997,-1.535000,0.418041>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.492997,-1.535000,1.143000>}
box{<0,0,-0.127000><0.724959,0.035000,0.127000> rotate<0,90.000000,0> translate<7.492997,-1.535000,1.143000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.492997,-1.535000,0.508000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.594600,-1.535000,0.508000>}
box{<0,0,-0.127000><0.101603,0.035000,0.127000> rotate<0,0.000000,0> translate<7.492997,-1.535000,0.508000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.492997,-1.535000,0.762000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.594600,-1.535000,0.762000>}
box{<0,0,-0.127000><0.101603,0.035000,0.127000> rotate<0,0.000000,0> translate<7.492997,-1.535000,0.762000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.492997,-1.535000,1.016000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.594600,-1.535000,1.016000>}
box{<0,0,-0.127000><0.101603,0.035000,0.127000> rotate<0,0.000000,0> translate<7.492997,-1.535000,1.016000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.492997,-1.535000,1.396994>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.492997,-1.535000,2.121956>}
box{<0,0,-0.127000><0.724963,0.035000,0.127000> rotate<0,90.000000,0> translate<7.492997,-1.535000,2.121956> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.492997,-1.535000,1.524000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.594600,-1.535000,1.524000>}
box{<0,0,-0.127000><0.101603,0.035000,0.127000> rotate<0,0.000000,0> translate<7.492997,-1.535000,1.524000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.492997,-1.535000,1.778000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.594600,-1.535000,1.778000>}
box{<0,0,-0.127000><0.101603,0.035000,0.127000> rotate<0,0.000000,0> translate<7.492997,-1.535000,1.778000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.492997,-1.535000,2.032000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.594600,-1.535000,2.032000>}
box{<0,0,-0.127000><0.101603,0.035000,0.127000> rotate<0,0.000000,0> translate<7.492997,-1.535000,2.032000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.594600,-1.535000,0.250325>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.791813,-1.535000,-0.225784>}
box{<0,0,-0.127000><0.515338,0.035000,0.127000> rotate<0,67.495387,0> translate<7.594600,-1.535000,0.250325> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.594600,-1.535000,2.289672>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.594600,-1.535000,0.250325>}
box{<0,0,-0.127000><2.039347,0.035000,0.127000> rotate<0,-90.000000,0> translate<7.594600,-1.535000,0.250325> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.594600,-1.535000,2.289672>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.791813,-1.535000,2.765784>}
box{<0,0,-0.127000><0.515341,0.035000,0.127000> rotate<0,-67.495520,0> translate<7.594600,-1.535000,2.289672> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.619997,-1.535000,19.758031>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.353428,-1.535000,19.024600>}
box{<0,0,-0.127000><1.037228,0.035000,0.127000> rotate<0,44.997030,0> translate<7.619997,-1.535000,19.758031> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.619997,-1.535000,20.881966>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.353428,-1.535000,21.615397>}
box{<0,0,-0.127000><1.037228,0.035000,0.127000> rotate<0,-44.997030,0> translate<7.619997,-1.535000,20.881966> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.620000,-1.535000,26.108031>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.353428,-1.535000,25.374600>}
box{<0,0,-0.127000><1.037226,0.035000,0.127000> rotate<0,44.997152,0> translate<7.620000,-1.535000,26.108031> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.620000,-1.535000,27.231966>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.353428,-1.535000,27.965397>}
box{<0,0,-0.127000><1.037226,0.035000,0.127000> rotate<0,-44.997152,0> translate<7.620000,-1.535000,27.231966> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.645397,-1.535000,17.243428>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.645397,-1.535000,18.316569>}
box{<0,0,-0.127000><1.073141,0.035000,0.127000> rotate<0,90.000000,0> translate<7.645397,-1.535000,18.316569> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.645397,-1.535000,17.272000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.781553,-1.535000,17.272000>}
box{<0,0,-0.127000><0.136156,0.035000,0.127000> rotate<0,0.000000,0> translate<7.645397,-1.535000,17.272000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.645397,-1.535000,17.526000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.747000,-1.535000,17.526000>}
box{<0,0,-0.127000><0.101603,0.035000,0.127000> rotate<0,0.000000,0> translate<7.645397,-1.535000,17.526000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.645397,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.762984,-1.535000,17.780000>}
box{<0,0,-0.127000><1.117587,0.035000,0.127000> rotate<0,0.000000,0> translate<7.645397,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.645397,-1.535000,18.034000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.747000,-1.535000,18.034000>}
box{<0,0,-0.127000><0.101603,0.035000,0.127000> rotate<0,0.000000,0> translate<7.645397,-1.535000,18.034000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.645397,-1.535000,18.288000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.781556,-1.535000,18.288000>}
box{<0,0,-0.127000><0.136159,0.035000,0.127000> rotate<0,0.000000,0> translate<7.645397,-1.535000,18.288000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.645397,-1.535000,23.593428>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.645397,-1.535000,24.666569>}
box{<0,0,-0.127000><1.073141,0.035000,0.127000> rotate<0,90.000000,0> translate<7.645397,-1.535000,24.666569> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.645397,-1.535000,23.622000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.781553,-1.535000,23.622000>}
box{<0,0,-0.127000><0.136156,0.035000,0.127000> rotate<0,0.000000,0> translate<7.645397,-1.535000,23.622000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.645397,-1.535000,23.876000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.747000,-1.535000,23.876000>}
box{<0,0,-0.127000><0.101603,0.035000,0.127000> rotate<0,0.000000,0> translate<7.645397,-1.535000,23.876000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.645397,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.762984,-1.535000,24.130000>}
box{<0,0,-0.127000><1.117587,0.035000,0.127000> rotate<0,0.000000,0> translate<7.645397,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.645397,-1.535000,24.384000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.747000,-1.535000,24.384000>}
box{<0,0,-0.127000><0.101603,0.035000,0.127000> rotate<0,0.000000,0> translate<7.645397,-1.535000,24.384000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.645397,-1.535000,24.638000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.781556,-1.535000,24.638000>}
box{<0,0,-0.127000><0.136159,0.035000,0.127000> rotate<0,0.000000,0> translate<7.645397,-1.535000,24.638000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.747000,-1.535000,17.306553>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.416553,-1.535000,16.637000>}
box{<0,0,-0.127000><0.946891,0.035000,0.127000> rotate<0,44.997030,0> translate<7.747000,-1.535000,17.306553> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.747000,-1.535000,17.653000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.747000,-1.535000,17.306553>}
box{<0,0,-0.127000><0.346447,0.035000,0.127000> rotate<0,-90.000000,0> translate<7.747000,-1.535000,17.306553> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.747000,-1.535000,17.653000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.762984,-1.535000,17.653000>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,0.000000,0> translate<7.747000,-1.535000,17.653000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.747000,-1.535000,17.906994>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.762984,-1.535000,17.906994>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,0.000000,0> translate<7.747000,-1.535000,17.906994> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.747000,-1.535000,18.253444>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.747000,-1.535000,17.906994>}
box{<0,0,-0.127000><0.346450,0.035000,0.127000> rotate<0,-90.000000,0> translate<7.747000,-1.535000,17.906994> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.747000,-1.535000,18.253444>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.416553,-1.535000,18.922997>}
box{<0,0,-0.127000><0.946891,0.035000,0.127000> rotate<0,-44.997030,0> translate<7.747000,-1.535000,18.253444> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.747000,-1.535000,23.656553>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.416553,-1.535000,22.987000>}
box{<0,0,-0.127000><0.946891,0.035000,0.127000> rotate<0,44.997030,0> translate<7.747000,-1.535000,23.656553> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.747000,-1.535000,24.003000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.747000,-1.535000,23.656553>}
box{<0,0,-0.127000><0.346447,0.035000,0.127000> rotate<0,-90.000000,0> translate<7.747000,-1.535000,23.656553> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.747000,-1.535000,24.003000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.762984,-1.535000,24.003000>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,0.000000,0> translate<7.747000,-1.535000,24.003000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.747000,-1.535000,24.256994>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.762984,-1.535000,24.256994>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,0.000000,0> translate<7.747000,-1.535000,24.256994> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.747000,-1.535000,24.603444>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.747000,-1.535000,24.256994>}
box{<0,0,-0.127000><0.346450,0.035000,0.127000> rotate<0,-90.000000,0> translate<7.747000,-1.535000,24.256994> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.747000,-1.535000,24.603444>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.416553,-1.535000,25.272997>}
box{<0,0,-0.127000><0.946891,0.035000,0.127000> rotate<0,-44.997030,0> translate<7.747000,-1.535000,24.603444> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.791813,-1.535000,-0.225784>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.156213,-1.535000,-0.590184>}
box{<0,0,-0.127000><0.515339,0.035000,0.127000> rotate<0,44.997030,0> translate<7.791813,-1.535000,-0.225784> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.791813,-1.535000,2.765784>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.156213,-1.535000,3.130184>}
box{<0,0,-0.127000><0.515339,0.035000,0.127000> rotate<0,-44.997030,0> translate<7.791813,-1.535000,2.765784> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.904200,-1.535000,11.233909>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.054278,-1.535000,10.871588>}
box{<0,0,-0.127000><0.392174,0.035000,0.127000> rotate<0,67.495614,0> translate<7.904200,-1.535000,11.233909> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.904200,-1.535000,11.626088>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.904200,-1.535000,11.233909>}
box{<0,0,-0.127000><0.392178,0.035000,0.127000> rotate<0,-90.000000,0> translate<7.904200,-1.535000,11.233909> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.904200,-1.535000,11.626088>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.054278,-1.535000,11.988409>}
box{<0,0,-0.127000><0.392174,0.035000,0.127000> rotate<0,-67.495614,0> translate<7.904200,-1.535000,11.626088> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.054278,-1.535000,10.871588>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.229600,-1.535000,10.696266>}
box{<0,0,-0.127000><0.247943,0.035000,0.127000> rotate<0,44.997030,0> translate<8.054278,-1.535000,10.871588> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.054278,-1.535000,11.988409>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.331588,-1.535000,12.265719>}
box{<0,0,-0.127000><0.392175,0.035000,0.127000> rotate<0,-44.997030,0> translate<8.054278,-1.535000,11.988409> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.156213,-1.535000,-0.590184>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.509697,-1.535000,-0.736600>}
box{<0,0,-0.127000><0.382608,0.035000,0.127000> rotate<0,22.498183,0> translate<8.156213,-1.535000,-0.590184> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.156213,-1.535000,3.130184>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.632325,-1.535000,3.327397>}
box{<0,0,-0.127000><0.515341,0.035000,0.127000> rotate<0,-22.498540,0> translate<8.156213,-1.535000,3.130184> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.229600,-1.535000,10.696266>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.229600,-1.535000,5.740397>}
box{<0,0,-0.127000><4.955869,0.035000,0.127000> rotate<0,-90.000000,0> translate<8.229600,-1.535000,5.740397> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.331588,-1.535000,12.265719>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.693909,-1.535000,12.415797>}
box{<0,0,-0.127000><0.392174,0.035000,0.127000> rotate<0,-22.498446,0> translate<8.331588,-1.535000,12.265719> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.353428,-1.535000,19.024600>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.426569,-1.535000,19.024600>}
box{<0,0,-0.127000><1.073141,0.035000,0.127000> rotate<0,0.000000,0> translate<8.353428,-1.535000,19.024600> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.353428,-1.535000,21.615397>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.426569,-1.535000,21.615397>}
box{<0,0,-0.127000><1.073141,0.035000,0.127000> rotate<0,0.000000,0> translate<8.353428,-1.535000,21.615397> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.353428,-1.535000,25.374600>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.426569,-1.535000,25.374600>}
box{<0,0,-0.127000><1.073141,0.035000,0.127000> rotate<0,0.000000,0> translate<8.353428,-1.535000,25.374600> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.353428,-1.535000,27.965397>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.426569,-1.535000,27.965397>}
box{<0,0,-0.127000><1.073141,0.035000,0.127000> rotate<0,0.000000,0> translate<8.353428,-1.535000,27.965397> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.416553,-1.535000,16.637000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.763000,-1.535000,16.637000>}
box{<0,0,-0.127000><0.346447,0.035000,0.127000> rotate<0,0.000000,0> translate<8.416553,-1.535000,16.637000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.416553,-1.535000,18.922997>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.763000,-1.535000,18.922997>}
box{<0,0,-0.127000><0.346447,0.035000,0.127000> rotate<0,0.000000,0> translate<8.416553,-1.535000,18.922997> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.416553,-1.535000,22.987000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.763000,-1.535000,22.987000>}
box{<0,0,-0.127000><0.346447,0.035000,0.127000> rotate<0,0.000000,0> translate<8.416553,-1.535000,22.987000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.416553,-1.535000,25.272997>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.763000,-1.535000,25.272997>}
box{<0,0,-0.127000><0.346447,0.035000,0.127000> rotate<0,0.000000,0> translate<8.416553,-1.535000,25.272997> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.632325,-1.535000,3.327397>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.147672,-1.535000,3.327397>}
box{<0,0,-0.127000><0.515347,0.035000,0.127000> rotate<0,0.000000,0> translate<8.632325,-1.535000,3.327397> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.693909,-1.535000,12.415797>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.086087,-1.535000,12.415797>}
box{<0,0,-0.127000><0.392178,0.035000,0.127000> rotate<0,0.000000,0> translate<8.693909,-1.535000,12.415797> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.762984,-1.535000,17.906994>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.762984,-1.535000,17.653000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,-90.000000,0> translate<8.762984,-1.535000,17.653000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.762984,-1.535000,24.256994>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.762984,-1.535000,24.003000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,-90.000000,0> translate<8.762984,-1.535000,24.003000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.763000,-1.535000,16.637000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.763000,-1.535000,17.652984>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,90.000000,0> translate<8.763000,-1.535000,17.652984> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.763000,-1.535000,16.764000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.016994,-1.535000,16.764000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<8.763000,-1.535000,16.764000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.763000,-1.535000,17.018000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.016994,-1.535000,17.018000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<8.763000,-1.535000,17.018000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.763000,-1.535000,17.272000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.016994,-1.535000,17.272000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<8.763000,-1.535000,17.272000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.763000,-1.535000,17.526000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.016994,-1.535000,17.526000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<8.763000,-1.535000,17.526000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.763000,-1.535000,17.652984>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.016994,-1.535000,17.652984>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<8.763000,-1.535000,17.652984> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.763000,-1.535000,17.907013>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.763000,-1.535000,18.922997>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,90.000000,0> translate<8.763000,-1.535000,18.922997> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.763000,-1.535000,17.907013>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.016994,-1.535000,17.907013>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<8.763000,-1.535000,17.907013> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.763000,-1.535000,18.034000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.016994,-1.535000,18.034000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<8.763000,-1.535000,18.034000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.763000,-1.535000,18.288000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.016994,-1.535000,18.288000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<8.763000,-1.535000,18.288000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.763000,-1.535000,18.542000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.016994,-1.535000,18.542000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<8.763000,-1.535000,18.542000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.763000,-1.535000,18.796000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.016994,-1.535000,18.796000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<8.763000,-1.535000,18.796000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.763000,-1.535000,22.987000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.763000,-1.535000,24.002984>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,90.000000,0> translate<8.763000,-1.535000,24.002984> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.763000,-1.535000,23.114000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.016994,-1.535000,23.114000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<8.763000,-1.535000,23.114000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.763000,-1.535000,23.368000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.016994,-1.535000,23.368000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<8.763000,-1.535000,23.368000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.763000,-1.535000,23.622000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.016994,-1.535000,23.622000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<8.763000,-1.535000,23.622000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.763000,-1.535000,23.876000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.016994,-1.535000,23.876000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<8.763000,-1.535000,23.876000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.763000,-1.535000,24.002984>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.016994,-1.535000,24.002984>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<8.763000,-1.535000,24.002984> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.763000,-1.535000,24.257013>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.763000,-1.535000,25.272997>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,90.000000,0> translate<8.763000,-1.535000,25.272997> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.763000,-1.535000,24.257013>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.016994,-1.535000,24.257013>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<8.763000,-1.535000,24.257013> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.763000,-1.535000,24.384000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.016994,-1.535000,24.384000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<8.763000,-1.535000,24.384000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.763000,-1.535000,24.638000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.016994,-1.535000,24.638000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<8.763000,-1.535000,24.638000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.763000,-1.535000,24.892000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.016994,-1.535000,24.892000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<8.763000,-1.535000,24.892000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<8.763000,-1.535000,25.146000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.016994,-1.535000,25.146000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<8.763000,-1.535000,25.146000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.016994,-1.535000,16.637000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.363444,-1.535000,16.637000>}
box{<0,0,-0.127000><0.346450,0.035000,0.127000> rotate<0,0.000000,0> translate<9.016994,-1.535000,16.637000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.016994,-1.535000,17.652984>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.016994,-1.535000,16.637000>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,-90.000000,0> translate<9.016994,-1.535000,16.637000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.016994,-1.535000,18.922997>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.016994,-1.535000,17.907013>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,-90.000000,0> translate<9.016994,-1.535000,17.907013> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.016994,-1.535000,18.922997>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.363444,-1.535000,18.922997>}
box{<0,0,-0.127000><0.346450,0.035000,0.127000> rotate<0,0.000000,0> translate<9.016994,-1.535000,18.922997> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.016994,-1.535000,22.987000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.363444,-1.535000,22.987000>}
box{<0,0,-0.127000><0.346450,0.035000,0.127000> rotate<0,0.000000,0> translate<9.016994,-1.535000,22.987000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.016994,-1.535000,24.002984>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.016994,-1.535000,22.987000>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,-90.000000,0> translate<9.016994,-1.535000,22.987000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.016994,-1.535000,25.272997>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.016994,-1.535000,24.257013>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,-90.000000,0> translate<9.016994,-1.535000,24.257013> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.016994,-1.535000,25.272997>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.363444,-1.535000,25.272997>}
box{<0,0,-0.127000><0.346450,0.035000,0.127000> rotate<0,0.000000,0> translate<9.016994,-1.535000,25.272997> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.017012,-1.535000,17.653000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.017012,-1.535000,17.906994>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,90.000000,0> translate<9.017012,-1.535000,17.906994> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.017012,-1.535000,17.653000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.032997,-1.535000,17.653000>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,0.000000,0> translate<9.017012,-1.535000,17.653000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.017012,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.134600,-1.535000,17.780000>}
box{<0,0,-0.127000><1.117588,0.035000,0.127000> rotate<0,0.000000,0> translate<9.017012,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.017012,-1.535000,17.906994>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.032997,-1.535000,17.906994>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,0.000000,0> translate<9.017012,-1.535000,17.906994> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.017012,-1.535000,24.003000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.017012,-1.535000,24.256994>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,90.000000,0> translate<9.017012,-1.535000,24.256994> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.017012,-1.535000,24.003000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.032997,-1.535000,24.003000>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,0.000000,0> translate<9.017012,-1.535000,24.003000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.017012,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.134600,-1.535000,24.130000>}
box{<0,0,-0.127000><1.117588,0.035000,0.127000> rotate<0,0.000000,0> translate<9.017012,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.017012,-1.535000,24.256994>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.032997,-1.535000,24.256994>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,0.000000,0> translate<9.017012,-1.535000,24.256994> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.021363,-1.535000,4.419600>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.264084,-1.535000,4.520141>}
box{<0,0,-0.127000><0.262721,0.035000,0.127000> rotate<0,-22.498904,0> translate<9.021363,-1.535000,4.419600> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.086087,-1.535000,12.415797>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.448409,-1.535000,12.265719>}
box{<0,0,-0.127000><0.392174,0.035000,0.127000> rotate<0,22.498446,0> translate<9.086087,-1.535000,12.415797> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.147672,-1.535000,3.327397>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.623784,-1.535000,3.130184>}
box{<0,0,-0.127000><0.515341,0.035000,0.127000> rotate<0,22.498540,0> translate<9.147672,-1.535000,3.327397> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.208988,-1.535000,3.302000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.929600,-1.535000,3.302000>}
box{<0,0,-0.127000><11.720612,0.035000,0.127000> rotate<0,0.000000,0> translate<9.208988,-1.535000,3.302000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.264084,-1.535000,4.520141>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.449856,-1.535000,4.705913>}
box{<0,0,-0.127000><0.262721,0.035000,0.127000> rotate<0,-44.997030,0> translate<9.264084,-1.535000,4.520141> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.270300,-1.535000,-0.736600>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.623784,-1.535000,-0.590184>}
box{<0,0,-0.127000><0.382608,0.035000,0.127000> rotate<0,-22.498183,0> translate<9.270300,-1.535000,-0.736600> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.270300,-1.535000,-0.736600>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.909697,-1.535000,-0.736600>}
box{<0,0,-0.127000><24.639397,0.035000,0.127000> rotate<0,0.000000,0> translate<9.270300,-1.535000,-0.736600> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.315944,-1.535000,4.572000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.929600,-1.535000,4.572000>}
box{<0,0,-0.127000><11.613656,0.035000,0.127000> rotate<0,0.000000,0> translate<9.315944,-1.535000,4.572000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.363444,-1.535000,16.637000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.032997,-1.535000,17.306553>}
box{<0,0,-0.127000><0.946891,0.035000,0.127000> rotate<0,-44.997030,0> translate<9.363444,-1.535000,16.637000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.363444,-1.535000,18.922997>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.032997,-1.535000,18.253444>}
box{<0,0,-0.127000><0.946891,0.035000,0.127000> rotate<0,44.997030,0> translate<9.363444,-1.535000,18.922997> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.363444,-1.535000,22.987000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.032997,-1.535000,23.656553>}
box{<0,0,-0.127000><0.946891,0.035000,0.127000> rotate<0,-44.997030,0> translate<9.363444,-1.535000,22.987000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.363444,-1.535000,25.272997>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.032997,-1.535000,24.603444>}
box{<0,0,-0.127000><0.946891,0.035000,0.127000> rotate<0,44.997030,0> translate<9.363444,-1.535000,25.272997> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.426569,-1.535000,19.024600>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.160000,-1.535000,19.758031>}
box{<0,0,-0.127000><1.037228,0.035000,0.127000> rotate<0,-44.997030,0> translate<9.426569,-1.535000,19.024600> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.426569,-1.535000,21.615397>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.160000,-1.535000,20.881966>}
box{<0,0,-0.127000><1.037228,0.035000,0.127000> rotate<0,44.997030,0> translate<9.426569,-1.535000,21.615397> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.426569,-1.535000,25.374600>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.160000,-1.535000,26.108031>}
box{<0,0,-0.127000><1.037228,0.035000,0.127000> rotate<0,-44.997030,0> translate<9.426569,-1.535000,25.374600> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.426569,-1.535000,27.965397>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.160000,-1.535000,27.231966>}
box{<0,0,-0.127000><1.037228,0.035000,0.127000> rotate<0,44.997030,0> translate<9.426569,-1.535000,27.965397> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.448409,-1.535000,12.265719>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.725719,-1.535000,11.988409>}
box{<0,0,-0.127000><0.392175,0.035000,0.127000> rotate<0,44.997030,0> translate<9.448409,-1.535000,12.265719> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.449856,-1.535000,4.705913>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.550397,-1.535000,4.948634>}
box{<0,0,-0.127000><0.262721,0.035000,0.127000> rotate<0,-67.495156,0> translate<9.449856,-1.535000,4.705913> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.451966,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.868034,-1.535000,21.590000>}
box{<0,0,-0.127000><1.416069,0.035000,0.127000> rotate<0,0.000000,0> translate<9.451966,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.451966,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.868034,-1.535000,27.940000>}
box{<0,0,-0.127000><1.416069,0.035000,0.127000> rotate<0,0.000000,0> translate<9.451966,-1.535000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.451969,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.868031,-1.535000,19.050000>}
box{<0,0,-0.127000><1.416063,0.035000,0.127000> rotate<0,0.000000,0> translate<9.451969,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.451969,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.868031,-1.535000,25.400000>}
box{<0,0,-0.127000><1.416063,0.035000,0.127000> rotate<0,0.000000,0> translate<9.451969,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.490441,-1.535000,18.796000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.614031,-1.535000,18.796000>}
box{<0,0,-0.127000><1.123591,0.035000,0.127000> rotate<0,0.000000,0> translate<9.490441,-1.535000,18.796000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.490441,-1.535000,25.146000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.614031,-1.535000,25.146000>}
box{<0,0,-0.127000><1.123591,0.035000,0.127000> rotate<0,0.000000,0> translate<9.490441,-1.535000,25.146000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.490444,-1.535000,16.764000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.614028,-1.535000,16.764000>}
box{<0,0,-0.127000><1.123584,0.035000,0.127000> rotate<0,0.000000,0> translate<9.490444,-1.535000,16.764000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.490444,-1.535000,23.114000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.614028,-1.535000,23.114000>}
box{<0,0,-0.127000><1.123584,0.035000,0.127000> rotate<0,0.000000,0> translate<9.490444,-1.535000,23.114000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.499597,-1.535000,4.826000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.929600,-1.535000,4.826000>}
box{<0,0,-0.127000><11.430003,0.035000,0.127000> rotate<0,0.000000,0> translate<9.499597,-1.535000,4.826000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.522128,-1.535000,12.192000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.899600,-1.535000,12.192000>}
box{<0,0,-0.127000><25.377472,0.035000,0.127000> rotate<0,0.000000,0> translate<9.522128,-1.535000,12.192000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.550397,-1.535000,4.948634>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.550397,-1.535000,5.689600>}
box{<0,0,-0.127000><0.740966,0.035000,0.127000> rotate<0,90.000000,0> translate<9.550397,-1.535000,5.689600> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.550397,-1.535000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.929600,-1.535000,5.080000>}
box{<0,0,-0.127000><11.379203,0.035000,0.127000> rotate<0,0.000000,0> translate<9.550397,-1.535000,5.080000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.550397,-1.535000,5.334000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.929600,-1.535000,5.334000>}
box{<0,0,-0.127000><11.379203,0.035000,0.127000> rotate<0,0.000000,0> translate<9.550397,-1.535000,5.334000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.550397,-1.535000,5.588000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<14.607866,-1.535000,5.588000>}
box{<0,0,-0.127000><5.057469,0.035000,0.127000> rotate<0,0.000000,0> translate<9.550397,-1.535000,5.588000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.550397,-1.535000,5.689600>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<14.506266,-1.535000,5.689600>}
box{<0,0,-0.127000><4.955869,0.035000,0.127000> rotate<0,0.000000,0> translate<9.550397,-1.535000,5.689600> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.550397,-1.535000,7.010397>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.550397,-1.535000,10.696266>}
box{<0,0,-0.127000><3.685869,0.035000,0.127000> rotate<0,90.000000,0> translate<9.550397,-1.535000,10.696266> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.550397,-1.535000,7.010397>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<14.506266,-1.535000,7.010397>}
box{<0,0,-0.127000><4.955869,0.035000,0.127000> rotate<0,0.000000,0> translate<9.550397,-1.535000,7.010397> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.550397,-1.535000,7.112000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<14.607869,-1.535000,7.112000>}
box{<0,0,-0.127000><5.057472,0.035000,0.127000> rotate<0,0.000000,0> translate<9.550397,-1.535000,7.112000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.550397,-1.535000,7.366000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.628184,-1.535000,7.366000>}
box{<0,0,-0.127000><11.077787,0.035000,0.127000> rotate<0,0.000000,0> translate<9.550397,-1.535000,7.366000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.550397,-1.535000,7.620000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.604200,-1.535000,7.620000>}
box{<0,0,-0.127000><11.053803,0.035000,0.127000> rotate<0,0.000000,0> translate<9.550397,-1.535000,7.620000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.550397,-1.535000,7.874000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.628191,-1.535000,7.874000>}
box{<0,0,-0.127000><11.077794,0.035000,0.127000> rotate<0,0.000000,0> translate<9.550397,-1.535000,7.874000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.550397,-1.535000,8.128000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.733400,-1.535000,8.128000>}
box{<0,0,-0.127000><11.183003,0.035000,0.127000> rotate<0,0.000000,0> translate<9.550397,-1.535000,8.128000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.550397,-1.535000,8.382000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.957869,-1.535000,8.382000>}
box{<0,0,-0.127000><11.407472,0.035000,0.127000> rotate<0,0.000000,0> translate<9.550397,-1.535000,8.382000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.550397,-1.535000,8.636000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<29.518184,-1.535000,8.636000>}
box{<0,0,-0.127000><19.967788,0.035000,0.127000> rotate<0,0.000000,0> translate<9.550397,-1.535000,8.636000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.550397,-1.535000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<29.494200,-1.535000,8.890000>}
box{<0,0,-0.127000><19.943803,0.035000,0.127000> rotate<0,0.000000,0> translate<9.550397,-1.535000,8.890000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.550397,-1.535000,9.144000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<29.518191,-1.535000,9.144000>}
box{<0,0,-0.127000><19.967794,0.035000,0.127000> rotate<0,0.000000,0> translate<9.550397,-1.535000,9.144000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.550397,-1.535000,9.398000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<29.623400,-1.535000,9.398000>}
box{<0,0,-0.127000><20.073003,0.035000,0.127000> rotate<0,0.000000,0> translate<9.550397,-1.535000,9.398000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.550397,-1.535000,9.652000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<29.847869,-1.535000,9.652000>}
box{<0,0,-0.127000><20.297472,0.035000,0.127000> rotate<0,0.000000,0> translate<9.550397,-1.535000,9.652000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.550397,-1.535000,9.906000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.372059,-1.535000,9.906000>}
box{<0,0,-0.127000><24.821662,0.035000,0.127000> rotate<0,0.000000,0> translate<9.550397,-1.535000,9.906000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.550397,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.626059,-1.535000,10.160000>}
box{<0,0,-0.127000><25.075663,0.035000,0.127000> rotate<0,0.000000,0> translate<9.550397,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.550397,-1.535000,10.414000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.880059,-1.535000,10.414000>}
box{<0,0,-0.127000><25.329663,0.035000,0.127000> rotate<0,0.000000,0> translate<9.550397,-1.535000,10.414000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.550397,-1.535000,10.668000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.899600,-1.535000,10.668000>}
box{<0,0,-0.127000><25.349203,0.035000,0.127000> rotate<0,0.000000,0> translate<9.550397,-1.535000,10.668000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.550397,-1.535000,10.696266>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.725719,-1.535000,10.871588>}
box{<0,0,-0.127000><0.247943,0.035000,0.127000> rotate<0,-44.997030,0> translate<9.550397,-1.535000,10.696266> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.623784,-1.535000,-0.590184>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.988184,-1.535000,-0.225784>}
box{<0,0,-0.127000><0.515339,0.035000,0.127000> rotate<0,-44.997030,0> translate<9.623784,-1.535000,-0.590184> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.623784,-1.535000,3.130184>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.988184,-1.535000,2.765784>}
box{<0,0,-0.127000><0.515339,0.035000,0.127000> rotate<0,44.997030,0> translate<9.623784,-1.535000,3.130184> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.705966,-1.535000,21.336000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.614034,-1.535000,21.336000>}
box{<0,0,-0.127000><0.908069,0.035000,0.127000> rotate<0,0.000000,0> translate<9.705966,-1.535000,21.336000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.705966,-1.535000,27.686000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.614034,-1.535000,27.686000>}
box{<0,0,-0.127000><0.908069,0.035000,0.127000> rotate<0,0.000000,0> translate<9.705966,-1.535000,27.686000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.705969,-1.535000,-0.508000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.474028,-1.535000,-0.508000>}
box{<0,0,-0.127000><23.768059,0.035000,0.127000> rotate<0,0.000000,0> translate<9.705969,-1.535000,-0.508000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.705969,-1.535000,3.048000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.733400,-1.535000,3.048000>}
box{<0,0,-0.127000><11.027431,0.035000,0.127000> rotate<0,0.000000,0> translate<9.705969,-1.535000,3.048000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.705969,-1.535000,19.304000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.614031,-1.535000,19.304000>}
box{<0,0,-0.127000><0.908062,0.035000,0.127000> rotate<0,0.000000,0> translate<9.705969,-1.535000,19.304000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.705969,-1.535000,25.654000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.614031,-1.535000,25.654000>}
box{<0,0,-0.127000><0.908062,0.035000,0.127000> rotate<0,0.000000,0> translate<9.705969,-1.535000,25.654000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.725719,-1.535000,10.871588>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.875797,-1.535000,11.233909>}
box{<0,0,-0.127000><0.392174,0.035000,0.127000> rotate<0,-67.495614,0> translate<9.725719,-1.535000,10.871588> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.725719,-1.535000,11.988409>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.875797,-1.535000,11.626088>}
box{<0,0,-0.127000><0.392174,0.035000,0.127000> rotate<0,67.495614,0> translate<9.725719,-1.535000,11.988409> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.744441,-1.535000,18.542000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.360031,-1.535000,18.542000>}
box{<0,0,-0.127000><0.615591,0.035000,0.127000> rotate<0,0.000000,0> translate<9.744441,-1.535000,18.542000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.744441,-1.535000,24.892000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.360031,-1.535000,24.892000>}
box{<0,0,-0.127000><0.615591,0.035000,0.127000> rotate<0,0.000000,0> translate<9.744441,-1.535000,24.892000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.744444,-1.535000,17.018000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.360028,-1.535000,17.018000>}
box{<0,0,-0.127000><0.615584,0.035000,0.127000> rotate<0,0.000000,0> translate<9.744444,-1.535000,17.018000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.744444,-1.535000,23.368000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.360028,-1.535000,23.368000>}
box{<0,0,-0.127000><0.615584,0.035000,0.127000> rotate<0,0.000000,0> translate<9.744444,-1.535000,23.368000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.746600,-1.535000,10.922000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.899600,-1.535000,10.922000>}
box{<0,0,-0.127000><25.153000,0.035000,0.127000> rotate<0,0.000000,0> translate<9.746600,-1.535000,10.922000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.746600,-1.535000,11.938000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.899600,-1.535000,11.938000>}
box{<0,0,-0.127000><25.153000,0.035000,0.127000> rotate<0,0.000000,0> translate<9.746600,-1.535000,11.938000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.851809,-1.535000,11.176000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.899600,-1.535000,11.176000>}
box{<0,0,-0.127000><25.047791,0.035000,0.127000> rotate<0,0.000000,0> translate<9.851809,-1.535000,11.176000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.851809,-1.535000,11.684000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.899600,-1.535000,11.684000>}
box{<0,0,-0.127000><25.047791,0.035000,0.127000> rotate<0,0.000000,0> translate<9.851809,-1.535000,11.684000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.875797,-1.535000,11.233909>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.875797,-1.535000,11.626088>}
box{<0,0,-0.127000><0.392178,0.035000,0.127000> rotate<0,90.000000,0> translate<9.875797,-1.535000,11.626088> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.875797,-1.535000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.899600,-1.535000,11.430000>}
box{<0,0,-0.127000><25.023803,0.035000,0.127000> rotate<0,0.000000,0> translate<9.875797,-1.535000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.959966,-1.535000,21.082000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.360034,-1.535000,21.082000>}
box{<0,0,-0.127000><0.400069,0.035000,0.127000> rotate<0,0.000000,0> translate<9.959966,-1.535000,21.082000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.959966,-1.535000,27.432000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.360034,-1.535000,27.432000>}
box{<0,0,-0.127000><0.400069,0.035000,0.127000> rotate<0,0.000000,0> translate<9.959966,-1.535000,27.432000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.959969,-1.535000,-0.254000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.220028,-1.535000,-0.254000>}
box{<0,0,-0.127000><23.260059,0.035000,0.127000> rotate<0,0.000000,0> translate<9.959969,-1.535000,-0.254000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.959969,-1.535000,2.794000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.628191,-1.535000,2.794000>}
box{<0,0,-0.127000><10.668222,0.035000,0.127000> rotate<0,0.000000,0> translate<9.959969,-1.535000,2.794000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.959969,-1.535000,19.558000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.360031,-1.535000,19.558000>}
box{<0,0,-0.127000><0.400063,0.035000,0.127000> rotate<0,0.000000,0> translate<9.959969,-1.535000,19.558000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.959969,-1.535000,25.908000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.360031,-1.535000,25.908000>}
box{<0,0,-0.127000><0.400063,0.035000,0.127000> rotate<0,0.000000,0> translate<9.959969,-1.535000,25.908000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.988184,-1.535000,-0.225784>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.185397,-1.535000,0.250325>}
box{<0,0,-0.127000><0.515338,0.035000,0.127000> rotate<0,-67.495387,0> translate<9.988184,-1.535000,-0.225784> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.988184,-1.535000,2.765784>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.185397,-1.535000,2.289672>}
box{<0,0,-0.127000><0.515341,0.035000,0.127000> rotate<0,67.495520,0> translate<9.988184,-1.535000,2.765784> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.998441,-1.535000,18.288000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.134600,-1.535000,18.288000>}
box{<0,0,-0.127000><0.136159,0.035000,0.127000> rotate<0,0.000000,0> translate<9.998441,-1.535000,18.288000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.998441,-1.535000,24.638000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.134600,-1.535000,24.638000>}
box{<0,0,-0.127000><0.136159,0.035000,0.127000> rotate<0,0.000000,0> translate<9.998441,-1.535000,24.638000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.998444,-1.535000,17.272000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.134600,-1.535000,17.272000>}
box{<0,0,-0.127000><0.136156,0.035000,0.127000> rotate<0,0.000000,0> translate<9.998444,-1.535000,17.272000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.998444,-1.535000,23.622000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.134600,-1.535000,23.622000>}
box{<0,0,-0.127000><0.136156,0.035000,0.127000> rotate<0,0.000000,0> translate<9.998444,-1.535000,23.622000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.032997,-1.535000,17.306553>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.032997,-1.535000,17.653000>}
box{<0,0,-0.127000><0.346447,0.035000,0.127000> rotate<0,90.000000,0> translate<10.032997,-1.535000,17.653000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.032997,-1.535000,17.526000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.134600,-1.535000,17.526000>}
box{<0,0,-0.127000><0.101603,0.035000,0.127000> rotate<0,0.000000,0> translate<10.032997,-1.535000,17.526000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.032997,-1.535000,17.906994>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.032997,-1.535000,18.253444>}
box{<0,0,-0.127000><0.346450,0.035000,0.127000> rotate<0,90.000000,0> translate<10.032997,-1.535000,18.253444> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.032997,-1.535000,18.034000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.134600,-1.535000,18.034000>}
box{<0,0,-0.127000><0.101603,0.035000,0.127000> rotate<0,0.000000,0> translate<10.032997,-1.535000,18.034000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.032997,-1.535000,23.656553>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.032997,-1.535000,24.003000>}
box{<0,0,-0.127000><0.346447,0.035000,0.127000> rotate<0,90.000000,0> translate<10.032997,-1.535000,24.003000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.032997,-1.535000,23.876000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.134600,-1.535000,23.876000>}
box{<0,0,-0.127000><0.101603,0.035000,0.127000> rotate<0,0.000000,0> translate<10.032997,-1.535000,23.876000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.032997,-1.535000,24.256994>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.032997,-1.535000,24.603444>}
box{<0,0,-0.127000><0.346450,0.035000,0.127000> rotate<0,90.000000,0> translate<10.032997,-1.535000,24.603444> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.032997,-1.535000,24.384000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.134600,-1.535000,24.384000>}
box{<0,0,-0.127000><0.101603,0.035000,0.127000> rotate<0,0.000000,0> translate<10.032997,-1.535000,24.384000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.081706,-1.535000,0.000000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.098288,-1.535000,0.000000>}
box{<0,0,-0.127000><23.016581,0.035000,0.127000> rotate<0,0.000000,0> translate<10.081706,-1.535000,0.000000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.081709,-1.535000,2.540000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.604200,-1.535000,2.540000>}
box{<0,0,-0.127000><10.522491,0.035000,0.127000> rotate<0,0.000000,0> translate<10.081709,-1.535000,2.540000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.134600,-1.535000,17.243428>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.893428,-1.535000,16.484600>}
box{<0,0,-0.127000><1.073145,0.035000,0.127000> rotate<0,44.997030,0> translate<10.134600,-1.535000,17.243428> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.134600,-1.535000,18.316569>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.134600,-1.535000,17.243428>}
box{<0,0,-0.127000><1.073141,0.035000,0.127000> rotate<0,-90.000000,0> translate<10.134600,-1.535000,17.243428> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.134600,-1.535000,18.316569>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.868031,-1.535000,19.050000>}
box{<0,0,-0.127000><1.037228,0.035000,0.127000> rotate<0,-44.997030,0> translate<10.134600,-1.535000,18.316569> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.134600,-1.535000,23.593428>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.893428,-1.535000,22.834600>}
box{<0,0,-0.127000><1.073145,0.035000,0.127000> rotate<0,44.997030,0> translate<10.134600,-1.535000,23.593428> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.134600,-1.535000,24.666569>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.134600,-1.535000,23.593428>}
box{<0,0,-0.127000><1.073141,0.035000,0.127000> rotate<0,-90.000000,0> translate<10.134600,-1.535000,23.593428> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.134600,-1.535000,24.666569>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.868031,-1.535000,25.400000>}
box{<0,0,-0.127000><1.037228,0.035000,0.127000> rotate<0,-44.997030,0> translate<10.134600,-1.535000,24.666569> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.160000,-1.535000,19.758031>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.868031,-1.535000,19.050000>}
box{<0,0,-0.127000><1.001307,0.035000,0.127000> rotate<0,44.997030,0> translate<10.160000,-1.535000,19.758031> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.160000,-1.535000,20.881966>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.893428,-1.535000,21.615397>}
box{<0,0,-0.127000><1.037226,0.035000,0.127000> rotate<0,-44.997152,0> translate<10.160000,-1.535000,20.881966> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.160000,-1.535000,26.108031>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.868031,-1.535000,25.400000>}
box{<0,0,-0.127000><1.001307,0.035000,0.127000> rotate<0,44.997030,0> translate<10.160000,-1.535000,26.108031> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.160000,-1.535000,27.231966>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.893428,-1.535000,27.965397>}
box{<0,0,-0.127000><1.037226,0.035000,0.127000> rotate<0,-44.997152,0> translate<10.160000,-1.535000,27.231966> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.185397,-1.535000,0.250325>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.185397,-1.535000,2.289672>}
box{<0,0,-0.127000><2.039347,0.035000,0.127000> rotate<0,90.000000,0> translate<10.185397,-1.535000,2.289672> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.185397,-1.535000,0.254000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<32.994600,-1.535000,0.254000>}
box{<0,0,-0.127000><22.809203,0.035000,0.127000> rotate<0,0.000000,0> translate<10.185397,-1.535000,0.254000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.185397,-1.535000,0.508000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<32.994600,-1.535000,0.508000>}
box{<0,0,-0.127000><22.809203,0.035000,0.127000> rotate<0,0.000000,0> translate<10.185397,-1.535000,0.508000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.185397,-1.535000,0.762000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<32.994600,-1.535000,0.762000>}
box{<0,0,-0.127000><22.809203,0.035000,0.127000> rotate<0,0.000000,0> translate<10.185397,-1.535000,0.762000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.185397,-1.535000,1.016000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<32.994600,-1.535000,1.016000>}
box{<0,0,-0.127000><22.809203,0.035000,0.127000> rotate<0,0.000000,0> translate<10.185397,-1.535000,1.016000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.185397,-1.535000,1.270000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<32.994600,-1.535000,1.270000>}
box{<0,0,-0.127000><22.809203,0.035000,0.127000> rotate<0,0.000000,0> translate<10.185397,-1.535000,1.270000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.185397,-1.535000,1.524000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<32.994600,-1.535000,1.524000>}
box{<0,0,-0.127000><22.809203,0.035000,0.127000> rotate<0,0.000000,0> translate<10.185397,-1.535000,1.524000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.185397,-1.535000,1.778000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.957866,-1.535000,1.778000>}
box{<0,0,-0.127000><10.772469,0.035000,0.127000> rotate<0,0.000000,0> translate<10.185397,-1.535000,1.778000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.185397,-1.535000,2.032000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.733394,-1.535000,2.032000>}
box{<0,0,-0.127000><10.547997,0.035000,0.127000> rotate<0,0.000000,0> translate<10.185397,-1.535000,2.032000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.185397,-1.535000,2.286000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.628184,-1.535000,2.286000>}
box{<0,0,-0.127000><10.442787,0.035000,0.127000> rotate<0,0.000000,0> translate<10.185397,-1.535000,2.286000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.893428,-1.535000,16.484600>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<11.966569,-1.535000,16.484600>}
box{<0,0,-0.127000><1.073141,0.035000,0.127000> rotate<0,0.000000,0> translate<10.893428,-1.535000,16.484600> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.893428,-1.535000,21.615397>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<11.966569,-1.535000,21.615397>}
box{<0,0,-0.127000><1.073141,0.035000,0.127000> rotate<0,0.000000,0> translate<10.893428,-1.535000,21.615397> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.893428,-1.535000,22.834600>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<11.966569,-1.535000,22.834600>}
box{<0,0,-0.127000><1.073141,0.035000,0.127000> rotate<0,0.000000,0> translate<10.893428,-1.535000,22.834600> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.893428,-1.535000,27.965397>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<11.966569,-1.535000,27.965397>}
box{<0,0,-0.127000><1.073141,0.035000,0.127000> rotate<0,0.000000,0> translate<10.893428,-1.535000,27.965397> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<11.966569,-1.535000,16.484600>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<12.039600,-1.535000,16.557634>}
box{<0,0,-0.127000><0.103284,0.035000,0.127000> rotate<0,-44.998256,0> translate<11.966569,-1.535000,16.484600> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<11.966569,-1.535000,21.615397>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<12.700000,-1.535000,20.881966>}
box{<0,0,-0.127000><1.037228,0.035000,0.127000> rotate<0,44.997030,0> translate<11.966569,-1.535000,21.615397> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<11.966569,-1.535000,22.834600>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<12.700000,-1.535000,23.568031>}
box{<0,0,-0.127000><1.037228,0.035000,0.127000> rotate<0,-44.997030,0> translate<11.966569,-1.535000,22.834600> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<11.966569,-1.535000,27.965397>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<12.700000,-1.535000,27.231966>}
box{<0,0,-0.127000><1.037228,0.035000,0.127000> rotate<0,44.997030,0> translate<11.966569,-1.535000,27.965397> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<11.991966,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<12.039600,-1.535000,16.510000>}
box{<0,0,-0.127000><0.047634,0.035000,0.127000> rotate<0,0.000000,0> translate<11.991966,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<11.991966,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<13.408034,-1.535000,21.590000>}
box{<0,0,-0.127000><1.416069,0.035000,0.127000> rotate<0,0.000000,0> translate<11.991966,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<11.991966,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<13.408034,-1.535000,27.940000>}
box{<0,0,-0.127000><1.416069,0.035000,0.127000> rotate<0,0.000000,0> translate<11.991966,-1.535000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<11.991969,-1.535000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<13.408028,-1.535000,22.860000>}
box{<0,0,-0.127000><1.416059,0.035000,0.127000> rotate<0,0.000000,0> translate<11.991969,-1.535000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<12.039600,-1.535000,16.378634>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<12.140141,-1.535000,16.135912>}
box{<0,0,-0.127000><0.262721,0.035000,0.127000> rotate<0,67.495156,0> translate<12.039600,-1.535000,16.378634> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<12.039600,-1.535000,16.557634>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<12.039600,-1.535000,16.378634>}
box{<0,0,-0.127000><0.179000,0.035000,0.127000> rotate<0,-90.000000,0> translate<12.039600,-1.535000,16.378634> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<12.140141,-1.535000,16.135912>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<13.410141,-1.535000,14.865913>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,44.997030,0> translate<12.140141,-1.535000,16.135912> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<12.245966,-1.535000,21.336000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<13.154034,-1.535000,21.336000>}
box{<0,0,-0.127000><0.908069,0.035000,0.127000> rotate<0,0.000000,0> translate<12.245966,-1.535000,21.336000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<12.245966,-1.535000,27.686000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<13.154034,-1.535000,27.686000>}
box{<0,0,-0.127000><0.908069,0.035000,0.127000> rotate<0,0.000000,0> translate<12.245966,-1.535000,27.686000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<12.245969,-1.535000,23.114000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<13.154028,-1.535000,23.114000>}
box{<0,0,-0.127000><0.908059,0.035000,0.127000> rotate<0,0.000000,0> translate<12.245969,-1.535000,23.114000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<12.499966,-1.535000,21.082000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<12.900034,-1.535000,21.082000>}
box{<0,0,-0.127000><0.400069,0.035000,0.127000> rotate<0,0.000000,0> translate<12.499966,-1.535000,21.082000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<12.499966,-1.535000,27.432000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<12.900034,-1.535000,27.432000>}
box{<0,0,-0.127000><0.400069,0.035000,0.127000> rotate<0,0.000000,0> translate<12.499966,-1.535000,27.432000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<12.499969,-1.535000,23.368000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<12.900028,-1.535000,23.368000>}
box{<0,0,-0.127000><0.400059,0.035000,0.127000> rotate<0,0.000000,0> translate<12.499969,-1.535000,23.368000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<12.700000,-1.535000,20.881966>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<13.433428,-1.535000,21.615397>}
box{<0,0,-0.127000><1.037226,0.035000,0.127000> rotate<0,-44.997152,0> translate<12.700000,-1.535000,20.881966> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<12.700000,-1.535000,23.568031>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<13.433428,-1.535000,22.834600>}
box{<0,0,-0.127000><1.037226,0.035000,0.127000> rotate<0,44.997152,0> translate<12.700000,-1.535000,23.568031> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<12.700000,-1.535000,27.231966>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<13.433428,-1.535000,27.965397>}
box{<0,0,-0.127000><1.037226,0.035000,0.127000> rotate<0,-44.997152,0> translate<12.700000,-1.535000,27.231966> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<13.410141,-1.535000,14.865913>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<13.595913,-1.535000,14.680141>}
box{<0,0,-0.127000><0.262721,0.035000,0.127000> rotate<0,44.997030,0> translate<13.410141,-1.535000,14.865913> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<13.433428,-1.535000,21.615397>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<14.506569,-1.535000,21.615397>}
box{<0,0,-0.127000><1.073141,0.035000,0.127000> rotate<0,0.000000,0> translate<13.433428,-1.535000,21.615397> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<13.433428,-1.535000,22.834600>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<14.506569,-1.535000,22.834600>}
box{<0,0,-0.127000><1.073141,0.035000,0.127000> rotate<0,0.000000,0> translate<13.433428,-1.535000,22.834600> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<13.433428,-1.535000,27.965397>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<14.506569,-1.535000,27.965397>}
box{<0,0,-0.127000><1.073141,0.035000,0.127000> rotate<0,0.000000,0> translate<13.433428,-1.535000,27.965397> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<13.595913,-1.535000,14.680141>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<13.838634,-1.535000,14.579600>}
box{<0,0,-0.127000><0.262721,0.035000,0.127000> rotate<0,22.498904,0> translate<13.595913,-1.535000,14.680141> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<13.659338,-1.535000,16.484600>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<14.243544,-1.535000,15.900397>}
box{<0,0,-0.127000><0.826190,0.035000,0.127000> rotate<0,44.996877,0> translate<13.659338,-1.535000,16.484600> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<13.659338,-1.535000,16.484600>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<14.506569,-1.535000,16.484600>}
box{<0,0,-0.127000><0.847231,0.035000,0.127000> rotate<0,0.000000,0> translate<13.659338,-1.535000,16.484600> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<13.838634,-1.535000,14.579600>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<23.856453,-1.535000,14.579600>}
box{<0,0,-0.127000><10.017819,0.035000,0.127000> rotate<0,0.000000,0> translate<13.838634,-1.535000,14.579600> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<13.887941,-1.535000,16.256000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<19.640053,-1.535000,16.256000>}
box{<0,0,-0.127000><5.752113,0.035000,0.127000> rotate<0,0.000000,0> translate<13.887941,-1.535000,16.256000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<14.141941,-1.535000,16.002000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<19.894053,-1.535000,16.002000>}
box{<0,0,-0.127000><5.752112,0.035000,0.127000> rotate<0,0.000000,0> translate<14.141941,-1.535000,16.002000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<14.243544,-1.535000,15.900397>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.066009,-1.535000,15.900397>}
box{<0,0,-0.127000><5.822466,0.035000,0.127000> rotate<0,0.000000,0> translate<14.243544,-1.535000,15.900397> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<14.506266,-1.535000,5.689600>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<14.681588,-1.535000,5.514278>}
box{<0,0,-0.127000><0.247943,0.035000,0.127000> rotate<0,44.997030,0> translate<14.506266,-1.535000,5.689600> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<14.506266,-1.535000,7.010397>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<14.681588,-1.535000,7.185719>}
box{<0,0,-0.127000><0.247943,0.035000,0.127000> rotate<0,-44.997030,0> translate<14.506266,-1.535000,7.010397> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<14.506569,-1.535000,16.484600>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.265397,-1.535000,17.243428>}
box{<0,0,-0.127000><1.073145,0.035000,0.127000> rotate<0,-44.997030,0> translate<14.506569,-1.535000,16.484600> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<14.506569,-1.535000,21.615397>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.240000,-1.535000,20.881966>}
box{<0,0,-0.127000><1.037228,0.035000,0.127000> rotate<0,44.997030,0> translate<14.506569,-1.535000,21.615397> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<14.506569,-1.535000,22.834600>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.265397,-1.535000,23.593428>}
box{<0,0,-0.127000><1.073145,0.035000,0.127000> rotate<0,-44.997030,0> translate<14.506569,-1.535000,22.834600> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<14.506569,-1.535000,27.965397>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.239997,-1.535000,27.231966>}
box{<0,0,-0.127000><1.037226,0.035000,0.127000> rotate<0,44.997152,0> translate<14.506569,-1.535000,27.965397> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<14.531966,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.240000,-1.535000,19.758031>}
box{<0,0,-0.127000><1.001310,0.035000,0.127000> rotate<0,-44.996904,0> translate<14.531966,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<14.531966,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.265397,-1.535000,18.316569>}
box{<0,0,-0.127000><1.037228,0.035000,0.127000> rotate<0,44.997030,0> translate<14.531966,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<14.531966,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.948028,-1.535000,19.050000>}
box{<0,0,-0.127000><1.416062,0.035000,0.127000> rotate<0,0.000000,0> translate<14.531966,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<14.531966,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.948034,-1.535000,21.590000>}
box{<0,0,-0.127000><1.416069,0.035000,0.127000> rotate<0,0.000000,0> translate<14.531966,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<14.531966,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.239997,-1.535000,26.108031>}
box{<0,0,-0.127000><1.001307,0.035000,0.127000> rotate<0,-44.997030,0> translate<14.531966,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<14.531966,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.265397,-1.535000,24.666569>}
box{<0,0,-0.127000><1.037228,0.035000,0.127000> rotate<0,44.997030,0> translate<14.531966,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<14.531966,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.948028,-1.535000,25.400000>}
box{<0,0,-0.127000><1.416062,0.035000,0.127000> rotate<0,0.000000,0> translate<14.531966,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<14.531966,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.948031,-1.535000,27.940000>}
box{<0,0,-0.127000><1.416066,0.035000,0.127000> rotate<0,0.000000,0> translate<14.531966,-1.535000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<14.531969,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<18.488028,-1.535000,16.510000>}
box{<0,0,-0.127000><3.956059,0.035000,0.127000> rotate<0,0.000000,0> translate<14.531969,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<14.531969,-1.535000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<18.488028,-1.535000,22.860000>}
box{<0,0,-0.127000><3.956059,0.035000,0.127000> rotate<0,0.000000,0> translate<14.531969,-1.535000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<14.681588,-1.535000,5.514278>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.043909,-1.535000,5.364200>}
box{<0,0,-0.127000><0.392174,0.035000,0.127000> rotate<0,22.498446,0> translate<14.681588,-1.535000,5.514278> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<14.681588,-1.535000,7.185719>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.043909,-1.535000,7.335797>}
box{<0,0,-0.127000><0.392174,0.035000,0.127000> rotate<0,-22.498446,0> translate<14.681588,-1.535000,7.185719> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<14.785966,-1.535000,18.796000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.909556,-1.535000,18.796000>}
box{<0,0,-0.127000><1.123591,0.035000,0.127000> rotate<0,0.000000,0> translate<14.785966,-1.535000,18.796000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<14.785966,-1.535000,19.304000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.694028,-1.535000,19.304000>}
box{<0,0,-0.127000><0.908062,0.035000,0.127000> rotate<0,0.000000,0> translate<14.785966,-1.535000,19.304000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<14.785966,-1.535000,21.336000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.694034,-1.535000,21.336000>}
box{<0,0,-0.127000><0.908069,0.035000,0.127000> rotate<0,0.000000,0> translate<14.785966,-1.535000,21.336000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<14.785966,-1.535000,25.146000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.909556,-1.535000,25.146000>}
box{<0,0,-0.127000><1.123591,0.035000,0.127000> rotate<0,0.000000,0> translate<14.785966,-1.535000,25.146000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<14.785966,-1.535000,25.654000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.694028,-1.535000,25.654000>}
box{<0,0,-0.127000><0.908062,0.035000,0.127000> rotate<0,0.000000,0> translate<14.785966,-1.535000,25.654000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<14.785966,-1.535000,27.686000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.694031,-1.535000,27.686000>}
box{<0,0,-0.127000><0.908066,0.035000,0.127000> rotate<0,0.000000,0> translate<14.785966,-1.535000,27.686000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<14.785969,-1.535000,16.764000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.909553,-1.535000,16.764000>}
box{<0,0,-0.127000><1.123584,0.035000,0.127000> rotate<0,0.000000,0> translate<14.785969,-1.535000,16.764000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<14.785969,-1.535000,23.114000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.909553,-1.535000,23.114000>}
box{<0,0,-0.127000><1.123584,0.035000,0.127000> rotate<0,0.000000,0> translate<14.785969,-1.535000,23.114000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.039966,-1.535000,18.542000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.655556,-1.535000,18.542000>}
box{<0,0,-0.127000><0.615591,0.035000,0.127000> rotate<0,0.000000,0> translate<15.039966,-1.535000,18.542000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.039966,-1.535000,19.558000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.440028,-1.535000,19.558000>}
box{<0,0,-0.127000><0.400063,0.035000,0.127000> rotate<0,0.000000,0> translate<15.039966,-1.535000,19.558000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.039966,-1.535000,21.082000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.440034,-1.535000,21.082000>}
box{<0,0,-0.127000><0.400069,0.035000,0.127000> rotate<0,0.000000,0> translate<15.039966,-1.535000,21.082000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.039966,-1.535000,24.892000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.655556,-1.535000,24.892000>}
box{<0,0,-0.127000><0.615591,0.035000,0.127000> rotate<0,0.000000,0> translate<15.039966,-1.535000,24.892000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.039966,-1.535000,25.908000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.440028,-1.535000,25.908000>}
box{<0,0,-0.127000><0.400063,0.035000,0.127000> rotate<0,0.000000,0> translate<15.039966,-1.535000,25.908000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.039966,-1.535000,27.432000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.440031,-1.535000,27.432000>}
box{<0,0,-0.127000><0.400066,0.035000,0.127000> rotate<0,0.000000,0> translate<15.039966,-1.535000,27.432000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.039969,-1.535000,17.018000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.655553,-1.535000,17.018000>}
box{<0,0,-0.127000><0.615584,0.035000,0.127000> rotate<0,0.000000,0> translate<15.039969,-1.535000,17.018000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.039969,-1.535000,23.368000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.655553,-1.535000,23.368000>}
box{<0,0,-0.127000><0.615584,0.035000,0.127000> rotate<0,0.000000,0> translate<15.039969,-1.535000,23.368000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.043909,-1.535000,5.364200>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.436088,-1.535000,5.364200>}
box{<0,0,-0.127000><0.392178,0.035000,0.127000> rotate<0,0.000000,0> translate<15.043909,-1.535000,5.364200> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.043909,-1.535000,7.335797>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.436088,-1.535000,7.335797>}
box{<0,0,-0.127000><0.392178,0.035000,0.127000> rotate<0,0.000000,0> translate<15.043909,-1.535000,7.335797> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.239997,-1.535000,26.108031>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.973428,-1.535000,25.374600>}
box{<0,0,-0.127000><1.037228,0.035000,0.127000> rotate<0,44.997030,0> translate<15.239997,-1.535000,26.108031> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.239997,-1.535000,27.231966>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.973428,-1.535000,27.965397>}
box{<0,0,-0.127000><1.037228,0.035000,0.127000> rotate<0,-44.997030,0> translate<15.239997,-1.535000,27.231966> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.240000,-1.535000,19.758031>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.973428,-1.535000,19.024600>}
box{<0,0,-0.127000><1.037226,0.035000,0.127000> rotate<0,44.997152,0> translate<15.240000,-1.535000,19.758031> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.240000,-1.535000,20.881966>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.973428,-1.535000,21.615397>}
box{<0,0,-0.127000><1.037226,0.035000,0.127000> rotate<0,-44.997152,0> translate<15.240000,-1.535000,20.881966> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.265397,-1.535000,17.243428>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.265397,-1.535000,18.316569>}
box{<0,0,-0.127000><1.073141,0.035000,0.127000> rotate<0,90.000000,0> translate<15.265397,-1.535000,18.316569> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.265397,-1.535000,17.272000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.401553,-1.535000,17.272000>}
box{<0,0,-0.127000><0.136156,0.035000,0.127000> rotate<0,0.000000,0> translate<15.265397,-1.535000,17.272000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.265397,-1.535000,17.526000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.367000,-1.535000,17.526000>}
box{<0,0,-0.127000><0.101603,0.035000,0.127000> rotate<0,0.000000,0> translate<15.265397,-1.535000,17.526000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.265397,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.382984,-1.535000,17.780000>}
box{<0,0,-0.127000><1.117587,0.035000,0.127000> rotate<0,0.000000,0> translate<15.265397,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.265397,-1.535000,18.034000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.367000,-1.535000,18.034000>}
box{<0,0,-0.127000><0.101603,0.035000,0.127000> rotate<0,0.000000,0> translate<15.265397,-1.535000,18.034000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.265397,-1.535000,18.288000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.401556,-1.535000,18.288000>}
box{<0,0,-0.127000><0.136159,0.035000,0.127000> rotate<0,0.000000,0> translate<15.265397,-1.535000,18.288000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.265397,-1.535000,23.593428>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.265397,-1.535000,24.666569>}
box{<0,0,-0.127000><1.073141,0.035000,0.127000> rotate<0,90.000000,0> translate<15.265397,-1.535000,24.666569> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.265397,-1.535000,23.622000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.401553,-1.535000,23.622000>}
box{<0,0,-0.127000><0.136156,0.035000,0.127000> rotate<0,0.000000,0> translate<15.265397,-1.535000,23.622000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.265397,-1.535000,23.876000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.367000,-1.535000,23.876000>}
box{<0,0,-0.127000><0.101603,0.035000,0.127000> rotate<0,0.000000,0> translate<15.265397,-1.535000,23.876000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.265397,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.382984,-1.535000,24.130000>}
box{<0,0,-0.127000><1.117587,0.035000,0.127000> rotate<0,0.000000,0> translate<15.265397,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.265397,-1.535000,24.384000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.367000,-1.535000,24.384000>}
box{<0,0,-0.127000><0.101603,0.035000,0.127000> rotate<0,0.000000,0> translate<15.265397,-1.535000,24.384000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.265397,-1.535000,24.638000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.401556,-1.535000,24.638000>}
box{<0,0,-0.127000><0.136159,0.035000,0.127000> rotate<0,0.000000,0> translate<15.265397,-1.535000,24.638000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.367000,-1.535000,17.306553>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.036553,-1.535000,16.637000>}
box{<0,0,-0.127000><0.946891,0.035000,0.127000> rotate<0,44.997030,0> translate<15.367000,-1.535000,17.306553> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.367000,-1.535000,17.653000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.367000,-1.535000,17.306553>}
box{<0,0,-0.127000><0.346447,0.035000,0.127000> rotate<0,-90.000000,0> translate<15.367000,-1.535000,17.306553> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.367000,-1.535000,17.653000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.382984,-1.535000,17.653000>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,0.000000,0> translate<15.367000,-1.535000,17.653000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.367000,-1.535000,17.906994>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.382984,-1.535000,17.906994>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,0.000000,0> translate<15.367000,-1.535000,17.906994> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.367000,-1.535000,18.253444>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.367000,-1.535000,17.906994>}
box{<0,0,-0.127000><0.346450,0.035000,0.127000> rotate<0,-90.000000,0> translate<15.367000,-1.535000,17.906994> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.367000,-1.535000,18.253444>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.036553,-1.535000,18.922997>}
box{<0,0,-0.127000><0.946891,0.035000,0.127000> rotate<0,-44.997030,0> translate<15.367000,-1.535000,18.253444> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.367000,-1.535000,23.656553>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.036553,-1.535000,22.987000>}
box{<0,0,-0.127000><0.946891,0.035000,0.127000> rotate<0,44.997030,0> translate<15.367000,-1.535000,23.656553> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.367000,-1.535000,24.003000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.367000,-1.535000,23.656553>}
box{<0,0,-0.127000><0.346447,0.035000,0.127000> rotate<0,-90.000000,0> translate<15.367000,-1.535000,23.656553> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.367000,-1.535000,24.003000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.382984,-1.535000,24.003000>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,0.000000,0> translate<15.367000,-1.535000,24.003000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.367000,-1.535000,24.256994>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.382984,-1.535000,24.256994>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,0.000000,0> translate<15.367000,-1.535000,24.256994> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.367000,-1.535000,24.603444>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.367000,-1.535000,24.256994>}
box{<0,0,-0.127000><0.346450,0.035000,0.127000> rotate<0,-90.000000,0> translate<15.367000,-1.535000,24.256994> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.367000,-1.535000,24.603444>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.036553,-1.535000,25.272997>}
box{<0,0,-0.127000><0.946891,0.035000,0.127000> rotate<0,-44.997030,0> translate<15.367000,-1.535000,24.603444> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.436088,-1.535000,5.364200>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.798409,-1.535000,5.514278>}
box{<0,0,-0.127000><0.392174,0.035000,0.127000> rotate<0,-22.498446,0> translate<15.436088,-1.535000,5.364200> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.436088,-1.535000,7.335797>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.798409,-1.535000,7.185719>}
box{<0,0,-0.127000><0.392174,0.035000,0.127000> rotate<0,22.498446,0> translate<15.436088,-1.535000,7.335797> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.798409,-1.535000,5.514278>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.075719,-1.535000,5.791588>}
box{<0,0,-0.127000><0.392175,0.035000,0.127000> rotate<0,-44.997030,0> translate<15.798409,-1.535000,5.514278> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.798409,-1.535000,7.185719>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.075719,-1.535000,6.908409>}
box{<0,0,-0.127000><0.392175,0.035000,0.127000> rotate<0,44.997030,0> translate<15.798409,-1.535000,7.185719> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.872128,-1.535000,7.112000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.733394,-1.535000,7.112000>}
box{<0,0,-0.127000><4.861266,0.035000,0.127000> rotate<0,0.000000,0> translate<15.872128,-1.535000,7.112000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.872131,-1.535000,5.588000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.929600,-1.535000,5.588000>}
box{<0,0,-0.127000><5.057469,0.035000,0.127000> rotate<0,0.000000,0> translate<15.872131,-1.535000,5.588000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.973428,-1.535000,19.024600>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.046569,-1.535000,19.024600>}
box{<0,0,-0.127000><1.073141,0.035000,0.127000> rotate<0,0.000000,0> translate<15.973428,-1.535000,19.024600> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.973428,-1.535000,21.615397>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.046569,-1.535000,21.615397>}
box{<0,0,-0.127000><1.073141,0.035000,0.127000> rotate<0,0.000000,0> translate<15.973428,-1.535000,21.615397> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.973428,-1.535000,25.374600>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.046569,-1.535000,25.374600>}
box{<0,0,-0.127000><1.073141,0.035000,0.127000> rotate<0,0.000000,0> translate<15.973428,-1.535000,25.374600> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.973428,-1.535000,27.965397>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.046569,-1.535000,27.965397>}
box{<0,0,-0.127000><1.073141,0.035000,0.127000> rotate<0,0.000000,0> translate<15.973428,-1.535000,27.965397> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.036553,-1.535000,16.637000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.383000,-1.535000,16.637000>}
box{<0,0,-0.127000><0.346447,0.035000,0.127000> rotate<0,0.000000,0> translate<16.036553,-1.535000,16.637000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.036553,-1.535000,18.922997>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.383000,-1.535000,18.922997>}
box{<0,0,-0.127000><0.346447,0.035000,0.127000> rotate<0,0.000000,0> translate<16.036553,-1.535000,18.922997> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.036553,-1.535000,22.987000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.383000,-1.535000,22.987000>}
box{<0,0,-0.127000><0.346447,0.035000,0.127000> rotate<0,0.000000,0> translate<16.036553,-1.535000,22.987000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.036553,-1.535000,25.272997>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.383000,-1.535000,25.272997>}
box{<0,0,-0.127000><0.346447,0.035000,0.127000> rotate<0,0.000000,0> translate<16.036553,-1.535000,25.272997> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.075719,-1.535000,5.791588>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.225797,-1.535000,6.153909>}
box{<0,0,-0.127000><0.392174,0.035000,0.127000> rotate<0,-67.495614,0> translate<16.075719,-1.535000,5.791588> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.075719,-1.535000,6.908409>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.225797,-1.535000,6.546088>}
box{<0,0,-0.127000><0.392174,0.035000,0.127000> rotate<0,67.495614,0> translate<16.075719,-1.535000,6.908409> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.096600,-1.535000,5.842000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.929600,-1.535000,5.842000>}
box{<0,0,-0.127000><4.833000,0.035000,0.127000> rotate<0,0.000000,0> translate<16.096600,-1.535000,5.842000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.096600,-1.535000,6.858000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.929600,-1.535000,6.858000>}
box{<0,0,-0.127000><4.833000,0.035000,0.127000> rotate<0,0.000000,0> translate<16.096600,-1.535000,6.858000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.201809,-1.535000,6.096000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.929600,-1.535000,6.096000>}
box{<0,0,-0.127000><4.727791,0.035000,0.127000> rotate<0,0.000000,0> translate<16.201809,-1.535000,6.096000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.201809,-1.535000,6.604000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.929600,-1.535000,6.604000>}
box{<0,0,-0.127000><4.727791,0.035000,0.127000> rotate<0,0.000000,0> translate<16.201809,-1.535000,6.604000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.225797,-1.535000,6.153909>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.225797,-1.535000,6.546088>}
box{<0,0,-0.127000><0.392178,0.035000,0.127000> rotate<0,90.000000,0> translate<16.225797,-1.535000,6.546088> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.225797,-1.535000,6.350000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.929600,-1.535000,6.350000>}
box{<0,0,-0.127000><4.703803,0.035000,0.127000> rotate<0,0.000000,0> translate<16.225797,-1.535000,6.350000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.382984,-1.535000,17.906994>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.382984,-1.535000,17.653000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,-90.000000,0> translate<16.382984,-1.535000,17.653000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.382984,-1.535000,24.256994>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.382984,-1.535000,24.003000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,-90.000000,0> translate<16.382984,-1.535000,24.003000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.383000,-1.535000,16.637000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.383000,-1.535000,17.652984>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,90.000000,0> translate<16.383000,-1.535000,17.652984> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.383000,-1.535000,16.764000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.636994,-1.535000,16.764000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<16.383000,-1.535000,16.764000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.383000,-1.535000,17.018000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.636994,-1.535000,17.018000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<16.383000,-1.535000,17.018000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.383000,-1.535000,17.272000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.636994,-1.535000,17.272000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<16.383000,-1.535000,17.272000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.383000,-1.535000,17.526000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.636994,-1.535000,17.526000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<16.383000,-1.535000,17.526000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.383000,-1.535000,17.652984>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.636994,-1.535000,17.652984>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<16.383000,-1.535000,17.652984> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.383000,-1.535000,17.907013>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.383000,-1.535000,18.922997>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,90.000000,0> translate<16.383000,-1.535000,18.922997> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.383000,-1.535000,17.907013>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.636994,-1.535000,17.907013>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<16.383000,-1.535000,17.907013> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.383000,-1.535000,18.034000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.636994,-1.535000,18.034000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<16.383000,-1.535000,18.034000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.383000,-1.535000,18.288000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.636994,-1.535000,18.288000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<16.383000,-1.535000,18.288000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.383000,-1.535000,18.542000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.636994,-1.535000,18.542000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<16.383000,-1.535000,18.542000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.383000,-1.535000,18.796000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.636994,-1.535000,18.796000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<16.383000,-1.535000,18.796000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.383000,-1.535000,22.987000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.383000,-1.535000,24.002984>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,90.000000,0> translate<16.383000,-1.535000,24.002984> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.383000,-1.535000,23.114000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.636994,-1.535000,23.114000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<16.383000,-1.535000,23.114000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.383000,-1.535000,23.368000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.636994,-1.535000,23.368000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<16.383000,-1.535000,23.368000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.383000,-1.535000,23.622000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.636994,-1.535000,23.622000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<16.383000,-1.535000,23.622000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.383000,-1.535000,23.876000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.636994,-1.535000,23.876000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<16.383000,-1.535000,23.876000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.383000,-1.535000,24.002984>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.636994,-1.535000,24.002984>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<16.383000,-1.535000,24.002984> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.383000,-1.535000,24.257013>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.383000,-1.535000,25.272997>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,90.000000,0> translate<16.383000,-1.535000,25.272997> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.383000,-1.535000,24.257013>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.636994,-1.535000,24.257013>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<16.383000,-1.535000,24.257013> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.383000,-1.535000,24.384000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.636994,-1.535000,24.384000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<16.383000,-1.535000,24.384000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.383000,-1.535000,24.638000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.636994,-1.535000,24.638000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<16.383000,-1.535000,24.638000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.383000,-1.535000,24.892000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.636994,-1.535000,24.892000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<16.383000,-1.535000,24.892000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.383000,-1.535000,25.146000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.636994,-1.535000,25.146000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<16.383000,-1.535000,25.146000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.636994,-1.535000,16.637000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.983444,-1.535000,16.637000>}
box{<0,0,-0.127000><0.346450,0.035000,0.127000> rotate<0,0.000000,0> translate<16.636994,-1.535000,16.637000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.636994,-1.535000,17.652984>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.636994,-1.535000,16.637000>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,-90.000000,0> translate<16.636994,-1.535000,16.637000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.636994,-1.535000,18.922997>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.636994,-1.535000,17.907013>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,-90.000000,0> translate<16.636994,-1.535000,17.907013> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.636994,-1.535000,18.922997>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.983444,-1.535000,18.922997>}
box{<0,0,-0.127000><0.346450,0.035000,0.127000> rotate<0,0.000000,0> translate<16.636994,-1.535000,18.922997> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.636994,-1.535000,22.987000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.983444,-1.535000,22.987000>}
box{<0,0,-0.127000><0.346450,0.035000,0.127000> rotate<0,0.000000,0> translate<16.636994,-1.535000,22.987000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.636994,-1.535000,24.002984>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.636994,-1.535000,22.987000>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,-90.000000,0> translate<16.636994,-1.535000,22.987000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.636994,-1.535000,25.272997>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.636994,-1.535000,24.257013>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,-90.000000,0> translate<16.636994,-1.535000,24.257013> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.636994,-1.535000,25.272997>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.983444,-1.535000,25.272997>}
box{<0,0,-0.127000><0.346450,0.035000,0.127000> rotate<0,0.000000,0> translate<16.636994,-1.535000,25.272997> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.637013,-1.535000,17.653000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.637013,-1.535000,17.906994>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,90.000000,0> translate<16.637013,-1.535000,17.906994> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.637013,-1.535000,17.653000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.652997,-1.535000,17.653000>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,0.000000,0> translate<16.637013,-1.535000,17.653000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.637013,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.754600,-1.535000,17.780000>}
box{<0,0,-0.127000><1.117587,0.035000,0.127000> rotate<0,0.000000,0> translate<16.637013,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.637013,-1.535000,17.906994>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.652997,-1.535000,17.906994>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,0.000000,0> translate<16.637013,-1.535000,17.906994> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.637013,-1.535000,24.003000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.637013,-1.535000,24.256994>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,90.000000,0> translate<16.637013,-1.535000,24.256994> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.637013,-1.535000,24.003000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.652997,-1.535000,24.003000>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,0.000000,0> translate<16.637013,-1.535000,24.003000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.637013,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.754600,-1.535000,24.130000>}
box{<0,0,-0.127000><1.117587,0.035000,0.127000> rotate<0,0.000000,0> translate<16.637013,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.637013,-1.535000,24.256994>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.652997,-1.535000,24.256994>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,0.000000,0> translate<16.637013,-1.535000,24.256994> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.983444,-1.535000,16.637000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.652997,-1.535000,17.306553>}
box{<0,0,-0.127000><0.946891,0.035000,0.127000> rotate<0,-44.997030,0> translate<16.983444,-1.535000,16.637000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.983444,-1.535000,18.922997>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.652997,-1.535000,18.253444>}
box{<0,0,-0.127000><0.946891,0.035000,0.127000> rotate<0,44.997030,0> translate<16.983444,-1.535000,18.922997> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.983444,-1.535000,22.987000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.652997,-1.535000,23.656553>}
box{<0,0,-0.127000><0.946891,0.035000,0.127000> rotate<0,-44.997030,0> translate<16.983444,-1.535000,22.987000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.983444,-1.535000,25.272997>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.652997,-1.535000,24.603444>}
box{<0,0,-0.127000><0.946891,0.035000,0.127000> rotate<0,44.997030,0> translate<16.983444,-1.535000,25.272997> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.046569,-1.535000,19.024600>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.780000,-1.535000,19.758031>}
box{<0,0,-0.127000><1.037228,0.035000,0.127000> rotate<0,-44.997030,0> translate<17.046569,-1.535000,19.024600> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.046569,-1.535000,21.615397>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.780000,-1.535000,20.881966>}
box{<0,0,-0.127000><1.037228,0.035000,0.127000> rotate<0,44.997030,0> translate<17.046569,-1.535000,21.615397> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.046569,-1.535000,25.374600>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.780000,-1.535000,26.108031>}
box{<0,0,-0.127000><1.037228,0.035000,0.127000> rotate<0,-44.997030,0> translate<17.046569,-1.535000,25.374600> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.046569,-1.535000,27.965397>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.780000,-1.535000,27.231966>}
box{<0,0,-0.127000><1.037228,0.035000,0.127000> rotate<0,44.997030,0> translate<17.046569,-1.535000,27.965397> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.071966,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<18.488034,-1.535000,21.590000>}
box{<0,0,-0.127000><1.416069,0.035000,0.127000> rotate<0,0.000000,0> translate<17.071966,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.071966,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<18.488034,-1.535000,27.940000>}
box{<0,0,-0.127000><1.416069,0.035000,0.127000> rotate<0,0.000000,0> translate<17.071966,-1.535000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.071969,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<18.488031,-1.535000,19.050000>}
box{<0,0,-0.127000><1.416063,0.035000,0.127000> rotate<0,0.000000,0> translate<17.071969,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.071969,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<18.488031,-1.535000,25.400000>}
box{<0,0,-0.127000><1.416063,0.035000,0.127000> rotate<0,0.000000,0> translate<17.071969,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.110441,-1.535000,18.796000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<18.234031,-1.535000,18.796000>}
box{<0,0,-0.127000><1.123591,0.035000,0.127000> rotate<0,0.000000,0> translate<17.110441,-1.535000,18.796000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.110441,-1.535000,25.146000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<18.234031,-1.535000,25.146000>}
box{<0,0,-0.127000><1.123591,0.035000,0.127000> rotate<0,0.000000,0> translate<17.110441,-1.535000,25.146000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.110444,-1.535000,16.764000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<18.234028,-1.535000,16.764000>}
box{<0,0,-0.127000><1.123584,0.035000,0.127000> rotate<0,0.000000,0> translate<17.110444,-1.535000,16.764000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.110444,-1.535000,23.114000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<18.234028,-1.535000,23.114000>}
box{<0,0,-0.127000><1.123584,0.035000,0.127000> rotate<0,0.000000,0> translate<17.110444,-1.535000,23.114000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.325966,-1.535000,21.336000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<18.234034,-1.535000,21.336000>}
box{<0,0,-0.127000><0.908069,0.035000,0.127000> rotate<0,0.000000,0> translate<17.325966,-1.535000,21.336000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.325966,-1.535000,27.686000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<18.234034,-1.535000,27.686000>}
box{<0,0,-0.127000><0.908069,0.035000,0.127000> rotate<0,0.000000,0> translate<17.325966,-1.535000,27.686000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.325969,-1.535000,19.304000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<18.234031,-1.535000,19.304000>}
box{<0,0,-0.127000><0.908062,0.035000,0.127000> rotate<0,0.000000,0> translate<17.325969,-1.535000,19.304000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.325969,-1.535000,25.654000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<18.234031,-1.535000,25.654000>}
box{<0,0,-0.127000><0.908062,0.035000,0.127000> rotate<0,0.000000,0> translate<17.325969,-1.535000,25.654000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.364441,-1.535000,18.542000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.980031,-1.535000,18.542000>}
box{<0,0,-0.127000><0.615591,0.035000,0.127000> rotate<0,0.000000,0> translate<17.364441,-1.535000,18.542000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.364441,-1.535000,24.892000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.980031,-1.535000,24.892000>}
box{<0,0,-0.127000><0.615591,0.035000,0.127000> rotate<0,0.000000,0> translate<17.364441,-1.535000,24.892000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.364444,-1.535000,17.018000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.980028,-1.535000,17.018000>}
box{<0,0,-0.127000><0.615584,0.035000,0.127000> rotate<0,0.000000,0> translate<17.364444,-1.535000,17.018000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.364444,-1.535000,23.368000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.980028,-1.535000,23.368000>}
box{<0,0,-0.127000><0.615584,0.035000,0.127000> rotate<0,0.000000,0> translate<17.364444,-1.535000,23.368000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.579966,-1.535000,21.082000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.980034,-1.535000,21.082000>}
box{<0,0,-0.127000><0.400069,0.035000,0.127000> rotate<0,0.000000,0> translate<17.579966,-1.535000,21.082000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.579966,-1.535000,27.432000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.980034,-1.535000,27.432000>}
box{<0,0,-0.127000><0.400069,0.035000,0.127000> rotate<0,0.000000,0> translate<17.579966,-1.535000,27.432000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.579969,-1.535000,19.558000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.980031,-1.535000,19.558000>}
box{<0,0,-0.127000><0.400062,0.035000,0.127000> rotate<0,0.000000,0> translate<17.579969,-1.535000,19.558000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.579969,-1.535000,25.908000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.980031,-1.535000,25.908000>}
box{<0,0,-0.127000><0.400062,0.035000,0.127000> rotate<0,0.000000,0> translate<17.579969,-1.535000,25.908000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.618441,-1.535000,18.288000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.754600,-1.535000,18.288000>}
box{<0,0,-0.127000><0.136159,0.035000,0.127000> rotate<0,0.000000,0> translate<17.618441,-1.535000,18.288000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.618441,-1.535000,24.638000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.754600,-1.535000,24.638000>}
box{<0,0,-0.127000><0.136159,0.035000,0.127000> rotate<0,0.000000,0> translate<17.618441,-1.535000,24.638000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.618444,-1.535000,17.272000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.754600,-1.535000,17.272000>}
box{<0,0,-0.127000><0.136156,0.035000,0.127000> rotate<0,0.000000,0> translate<17.618444,-1.535000,17.272000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.618444,-1.535000,23.622000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.754600,-1.535000,23.622000>}
box{<0,0,-0.127000><0.136156,0.035000,0.127000> rotate<0,0.000000,0> translate<17.618444,-1.535000,23.622000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.652997,-1.535000,17.306553>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.652997,-1.535000,17.653000>}
box{<0,0,-0.127000><0.346447,0.035000,0.127000> rotate<0,90.000000,0> translate<17.652997,-1.535000,17.653000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.652997,-1.535000,17.526000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.754600,-1.535000,17.526000>}
box{<0,0,-0.127000><0.101603,0.035000,0.127000> rotate<0,0.000000,0> translate<17.652997,-1.535000,17.526000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.652997,-1.535000,17.906994>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.652997,-1.535000,18.253444>}
box{<0,0,-0.127000><0.346450,0.035000,0.127000> rotate<0,90.000000,0> translate<17.652997,-1.535000,18.253444> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.652997,-1.535000,18.034000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.754600,-1.535000,18.034000>}
box{<0,0,-0.127000><0.101603,0.035000,0.127000> rotate<0,0.000000,0> translate<17.652997,-1.535000,18.034000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.652997,-1.535000,23.656553>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.652997,-1.535000,24.003000>}
box{<0,0,-0.127000><0.346447,0.035000,0.127000> rotate<0,90.000000,0> translate<17.652997,-1.535000,24.003000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.652997,-1.535000,23.876000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.754600,-1.535000,23.876000>}
box{<0,0,-0.127000><0.101603,0.035000,0.127000> rotate<0,0.000000,0> translate<17.652997,-1.535000,23.876000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.652997,-1.535000,24.256994>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.652997,-1.535000,24.603444>}
box{<0,0,-0.127000><0.346450,0.035000,0.127000> rotate<0,90.000000,0> translate<17.652997,-1.535000,24.603444> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.652997,-1.535000,24.384000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.754600,-1.535000,24.384000>}
box{<0,0,-0.127000><0.101603,0.035000,0.127000> rotate<0,0.000000,0> translate<17.652997,-1.535000,24.384000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.754600,-1.535000,17.243428>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<18.513428,-1.535000,16.484600>}
box{<0,0,-0.127000><1.073145,0.035000,0.127000> rotate<0,44.997030,0> translate<17.754600,-1.535000,17.243428> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.754600,-1.535000,18.316569>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.754600,-1.535000,17.243428>}
box{<0,0,-0.127000><1.073141,0.035000,0.127000> rotate<0,-90.000000,0> translate<17.754600,-1.535000,17.243428> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.754600,-1.535000,18.316569>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<18.488031,-1.535000,19.050000>}
box{<0,0,-0.127000><1.037228,0.035000,0.127000> rotate<0,-44.997030,0> translate<17.754600,-1.535000,18.316569> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.754600,-1.535000,23.593428>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<18.513428,-1.535000,22.834600>}
box{<0,0,-0.127000><1.073145,0.035000,0.127000> rotate<0,44.997030,0> translate<17.754600,-1.535000,23.593428> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.754600,-1.535000,24.666569>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.754600,-1.535000,23.593428>}
box{<0,0,-0.127000><1.073141,0.035000,0.127000> rotate<0,-90.000000,0> translate<17.754600,-1.535000,23.593428> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.754600,-1.535000,24.666569>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<18.488031,-1.535000,25.400000>}
box{<0,0,-0.127000><1.037228,0.035000,0.127000> rotate<0,-44.997030,0> translate<17.754600,-1.535000,24.666569> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.780000,-1.535000,19.758031>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<18.488031,-1.535000,19.050000>}
box{<0,0,-0.127000><1.001307,0.035000,0.127000> rotate<0,44.997030,0> translate<17.780000,-1.535000,19.758031> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.780000,-1.535000,20.881966>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<18.513428,-1.535000,21.615397>}
box{<0,0,-0.127000><1.037226,0.035000,0.127000> rotate<0,-44.997152,0> translate<17.780000,-1.535000,20.881966> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.780000,-1.535000,26.108031>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<18.488031,-1.535000,25.400000>}
box{<0,0,-0.127000><1.001307,0.035000,0.127000> rotate<0,44.997030,0> translate<17.780000,-1.535000,26.108031> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.780000,-1.535000,27.231966>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<18.513428,-1.535000,27.965397>}
box{<0,0,-0.127000><1.037226,0.035000,0.127000> rotate<0,-44.997152,0> translate<17.780000,-1.535000,27.231966> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<18.513428,-1.535000,16.484600>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<19.411453,-1.535000,16.484600>}
box{<0,0,-0.127000><0.898025,0.035000,0.127000> rotate<0,0.000000,0> translate<18.513428,-1.535000,16.484600> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<18.513428,-1.535000,21.615397>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<19.586569,-1.535000,21.615397>}
box{<0,0,-0.127000><1.073141,0.035000,0.127000> rotate<0,0.000000,0> translate<18.513428,-1.535000,21.615397> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<18.513428,-1.535000,22.834600>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<19.586569,-1.535000,22.834600>}
box{<0,0,-0.127000><1.073141,0.035000,0.127000> rotate<0,0.000000,0> translate<18.513428,-1.535000,22.834600> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<18.513428,-1.535000,27.965397>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<19.586569,-1.535000,27.965397>}
box{<0,0,-0.127000><1.073141,0.035000,0.127000> rotate<0,0.000000,0> translate<18.513428,-1.535000,27.965397> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<19.411453,-1.535000,16.484600>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<19.760141,-1.535000,16.135912>}
box{<0,0,-0.127000><0.493119,0.035000,0.127000> rotate<0,44.997030,0> translate<19.411453,-1.535000,16.484600> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<19.586569,-1.535000,21.615397>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.345397,-1.535000,20.856569>}
box{<0,0,-0.127000><1.073145,0.035000,0.127000> rotate<0,44.997030,0> translate<19.586569,-1.535000,21.615397> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<19.586569,-1.535000,22.834600>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.320000,-1.535000,23.568031>}
box{<0,0,-0.127000><1.037228,0.035000,0.127000> rotate<0,-44.997030,0> translate<19.586569,-1.535000,22.834600> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<19.586569,-1.535000,27.965397>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.345397,-1.535000,27.206569>}
box{<0,0,-0.127000><1.073145,0.035000,0.127000> rotate<0,44.997030,0> translate<19.586569,-1.535000,27.965397> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<19.611966,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.320000,-1.535000,18.341966>}
box{<0,0,-0.127000><1.001312,0.035000,0.127000> rotate<0,44.997030,0> translate<19.611966,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<19.611966,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.345397,-1.535000,19.783428>}
box{<0,0,-0.127000><1.037226,0.035000,0.127000> rotate<0,-44.996908,0> translate<19.611966,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<19.611966,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.028034,-1.535000,19.050000>}
box{<0,0,-0.127000><1.416069,0.035000,0.127000> rotate<0,0.000000,0> translate<19.611966,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<19.611966,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<23.568031,-1.535000,21.590000>}
box{<0,0,-0.127000><3.956066,0.035000,0.127000> rotate<0,0.000000,0> translate<19.611966,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<19.611966,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.320000,-1.535000,24.691966>}
box{<0,0,-0.127000><1.001312,0.035000,0.127000> rotate<0,44.997030,0> translate<19.611966,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<19.611966,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.345397,-1.535000,26.133428>}
box{<0,0,-0.127000><1.037226,0.035000,0.127000> rotate<0,-44.996908,0> translate<19.611966,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<19.611966,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.028034,-1.535000,25.400000>}
box{<0,0,-0.127000><1.416069,0.035000,0.127000> rotate<0,0.000000,0> translate<19.611966,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<19.611966,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<23.568031,-1.535000,27.940000>}
box{<0,0,-0.127000><3.956066,0.035000,0.127000> rotate<0,0.000000,0> translate<19.611966,-1.535000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<19.611969,-1.535000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.028028,-1.535000,22.860000>}
box{<0,0,-0.127000><1.416059,0.035000,0.127000> rotate<0,0.000000,0> translate<19.611969,-1.535000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<19.760141,-1.535000,16.135912>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<19.945913,-1.535000,15.950141>}
box{<0,0,-0.127000><0.262721,0.035000,0.127000> rotate<0,44.997030,0> translate<19.760141,-1.535000,16.135912> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<19.865966,-1.535000,18.796000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.774034,-1.535000,18.796000>}
box{<0,0,-0.127000><0.908069,0.035000,0.127000> rotate<0,0.000000,0> translate<19.865966,-1.535000,18.796000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<19.865966,-1.535000,19.304000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.989553,-1.535000,19.304000>}
box{<0,0,-0.127000><1.123587,0.035000,0.127000> rotate<0,0.000000,0> translate<19.865966,-1.535000,19.304000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<19.865966,-1.535000,21.336000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.989556,-1.535000,21.336000>}
box{<0,0,-0.127000><1.123591,0.035000,0.127000> rotate<0,0.000000,0> translate<19.865966,-1.535000,21.336000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<19.865966,-1.535000,25.146000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.774034,-1.535000,25.146000>}
box{<0,0,-0.127000><0.908069,0.035000,0.127000> rotate<0,0.000000,0> translate<19.865966,-1.535000,25.146000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<19.865966,-1.535000,25.654000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.989553,-1.535000,25.654000>}
box{<0,0,-0.127000><1.123587,0.035000,0.127000> rotate<0,0.000000,0> translate<19.865966,-1.535000,25.654000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<19.865966,-1.535000,27.686000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.989556,-1.535000,27.686000>}
box{<0,0,-0.127000><1.123591,0.035000,0.127000> rotate<0,0.000000,0> translate<19.865966,-1.535000,27.686000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<19.865969,-1.535000,23.114000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.774028,-1.535000,23.114000>}
box{<0,0,-0.127000><0.908059,0.035000,0.127000> rotate<0,0.000000,0> translate<19.865969,-1.535000,23.114000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<19.945913,-1.535000,15.950141>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.066009,-1.535000,15.900397>}
box{<0,0,-0.127000><0.129991,0.035000,0.127000> rotate<0,22.497699,0> translate<19.945913,-1.535000,15.950141> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.119966,-1.535000,18.542000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.520034,-1.535000,18.542000>}
box{<0,0,-0.127000><0.400069,0.035000,0.127000> rotate<0,0.000000,0> translate<20.119966,-1.535000,18.542000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.119966,-1.535000,19.558000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.735553,-1.535000,19.558000>}
box{<0,0,-0.127000><0.615588,0.035000,0.127000> rotate<0,0.000000,0> translate<20.119966,-1.535000,19.558000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.119966,-1.535000,21.082000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.735556,-1.535000,21.082000>}
box{<0,0,-0.127000><0.615591,0.035000,0.127000> rotate<0,0.000000,0> translate<20.119966,-1.535000,21.082000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.119966,-1.535000,24.892000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.520034,-1.535000,24.892000>}
box{<0,0,-0.127000><0.400069,0.035000,0.127000> rotate<0,0.000000,0> translate<20.119966,-1.535000,24.892000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.119966,-1.535000,25.908000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.735553,-1.535000,25.908000>}
box{<0,0,-0.127000><0.615588,0.035000,0.127000> rotate<0,0.000000,0> translate<20.119966,-1.535000,25.908000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.119966,-1.535000,27.432000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.735556,-1.535000,27.432000>}
box{<0,0,-0.127000><0.615591,0.035000,0.127000> rotate<0,0.000000,0> translate<20.119966,-1.535000,27.432000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.119969,-1.535000,23.368000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.520028,-1.535000,23.368000>}
box{<0,0,-0.127000><0.400059,0.035000,0.127000> rotate<0,0.000000,0> translate<20.119969,-1.535000,23.368000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.320000,-1.535000,18.341966>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.053428,-1.535000,19.075397>}
box{<0,0,-0.127000><1.037226,0.035000,0.127000> rotate<0,-44.997152,0> translate<20.320000,-1.535000,18.341966> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.320000,-1.535000,23.568031>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.053428,-1.535000,22.834600>}
box{<0,0,-0.127000><1.037226,0.035000,0.127000> rotate<0,44.997152,0> translate<20.320000,-1.535000,23.568031> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.320000,-1.535000,24.691966>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.053428,-1.535000,25.425397>}
box{<0,0,-0.127000><1.037226,0.035000,0.127000> rotate<0,-44.997152,0> translate<20.320000,-1.535000,24.691966> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.345397,-1.535000,19.783428>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.345397,-1.535000,20.856569>}
box{<0,0,-0.127000><1.073141,0.035000,0.127000> rotate<0,90.000000,0> translate<20.345397,-1.535000,20.856569> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.345397,-1.535000,19.812000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.481553,-1.535000,19.812000>}
box{<0,0,-0.127000><0.136156,0.035000,0.127000> rotate<0,0.000000,0> translate<20.345397,-1.535000,19.812000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.345397,-1.535000,20.066000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.447000,-1.535000,20.066000>}
box{<0,0,-0.127000><0.101603,0.035000,0.127000> rotate<0,0.000000,0> translate<20.345397,-1.535000,20.066000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.345397,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.462984,-1.535000,20.320000>}
box{<0,0,-0.127000><1.117587,0.035000,0.127000> rotate<0,0.000000,0> translate<20.345397,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.345397,-1.535000,20.574000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.447000,-1.535000,20.574000>}
box{<0,0,-0.127000><0.101603,0.035000,0.127000> rotate<0,0.000000,0> translate<20.345397,-1.535000,20.574000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.345397,-1.535000,20.828000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.481556,-1.535000,20.828000>}
box{<0,0,-0.127000><0.136159,0.035000,0.127000> rotate<0,0.000000,0> translate<20.345397,-1.535000,20.828000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.345397,-1.535000,26.133428>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.345397,-1.535000,27.206569>}
box{<0,0,-0.127000><1.073141,0.035000,0.127000> rotate<0,90.000000,0> translate<20.345397,-1.535000,27.206569> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.345397,-1.535000,26.162000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.481553,-1.535000,26.162000>}
box{<0,0,-0.127000><0.136156,0.035000,0.127000> rotate<0,0.000000,0> translate<20.345397,-1.535000,26.162000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.345397,-1.535000,26.416000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.447000,-1.535000,26.416000>}
box{<0,0,-0.127000><0.101603,0.035000,0.127000> rotate<0,0.000000,0> translate<20.345397,-1.535000,26.416000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.345397,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.462984,-1.535000,26.670000>}
box{<0,0,-0.127000><1.117587,0.035000,0.127000> rotate<0,0.000000,0> translate<20.345397,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.345397,-1.535000,26.924000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.447000,-1.535000,26.924000>}
box{<0,0,-0.127000><0.101603,0.035000,0.127000> rotate<0,0.000000,0> translate<20.345397,-1.535000,26.924000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.345397,-1.535000,27.178000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.481556,-1.535000,27.178000>}
box{<0,0,-0.127000><0.136159,0.035000,0.127000> rotate<0,0.000000,0> translate<20.345397,-1.535000,27.178000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.447000,-1.535000,19.846553>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.116553,-1.535000,19.177000>}
box{<0,0,-0.127000><0.946891,0.035000,0.127000> rotate<0,44.997030,0> translate<20.447000,-1.535000,19.846553> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.447000,-1.535000,20.193000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.447000,-1.535000,19.846553>}
box{<0,0,-0.127000><0.346447,0.035000,0.127000> rotate<0,-90.000000,0> translate<20.447000,-1.535000,19.846553> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.447000,-1.535000,20.193000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.462984,-1.535000,20.193000>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,0.000000,0> translate<20.447000,-1.535000,20.193000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.447000,-1.535000,20.446994>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.462984,-1.535000,20.446994>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,0.000000,0> translate<20.447000,-1.535000,20.446994> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.447000,-1.535000,20.793444>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.447000,-1.535000,20.446994>}
box{<0,0,-0.127000><0.346450,0.035000,0.127000> rotate<0,-90.000000,0> translate<20.447000,-1.535000,20.446994> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.447000,-1.535000,20.793444>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.116553,-1.535000,21.462997>}
box{<0,0,-0.127000><0.946891,0.035000,0.127000> rotate<0,-44.997030,0> translate<20.447000,-1.535000,20.793444> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.447000,-1.535000,26.196553>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.116553,-1.535000,25.527000>}
box{<0,0,-0.127000><0.946891,0.035000,0.127000> rotate<0,44.997030,0> translate<20.447000,-1.535000,26.196553> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.447000,-1.535000,26.543000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.447000,-1.535000,26.196553>}
box{<0,0,-0.127000><0.346447,0.035000,0.127000> rotate<0,-90.000000,0> translate<20.447000,-1.535000,26.196553> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.447000,-1.535000,26.543000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.462984,-1.535000,26.543000>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,0.000000,0> translate<20.447000,-1.535000,26.543000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.447000,-1.535000,26.796994>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.462984,-1.535000,26.796994>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,0.000000,0> translate<20.447000,-1.535000,26.796994> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.447000,-1.535000,27.143444>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.447000,-1.535000,26.796994>}
box{<0,0,-0.127000><0.346450,0.035000,0.127000> rotate<0,-90.000000,0> translate<20.447000,-1.535000,26.796994> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.447000,-1.535000,27.143444>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.116553,-1.535000,27.812997>}
box{<0,0,-0.127000><0.946891,0.035000,0.127000> rotate<0,-44.997030,0> translate<20.447000,-1.535000,27.143444> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.604200,-1.535000,2.343909>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.754278,-1.535000,1.981588>}
box{<0,0,-0.127000><0.392174,0.035000,0.127000> rotate<0,67.495614,0> translate<20.604200,-1.535000,2.343909> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.604200,-1.535000,2.736088>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.604200,-1.535000,2.343909>}
box{<0,0,-0.127000><0.392178,0.035000,0.127000> rotate<0,-90.000000,0> translate<20.604200,-1.535000,2.343909> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.604200,-1.535000,2.736088>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.754278,-1.535000,3.098409>}
box{<0,0,-0.127000><0.392174,0.035000,0.127000> rotate<0,-67.495614,0> translate<20.604200,-1.535000,2.736088> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.604200,-1.535000,7.423909>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.754278,-1.535000,7.061587>}
box{<0,0,-0.127000><0.392174,0.035000,0.127000> rotate<0,67.495614,0> translate<20.604200,-1.535000,7.423909> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.604200,-1.535000,7.816088>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.604200,-1.535000,7.423909>}
box{<0,0,-0.127000><0.392178,0.035000,0.127000> rotate<0,-90.000000,0> translate<20.604200,-1.535000,7.423909> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.604200,-1.535000,7.816088>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.754278,-1.535000,8.178409>}
box{<0,0,-0.127000><0.392174,0.035000,0.127000> rotate<0,-67.495614,0> translate<20.604200,-1.535000,7.816088> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.754278,-1.535000,1.981588>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.031588,-1.535000,1.704278>}
box{<0,0,-0.127000><0.392175,0.035000,0.127000> rotate<0,44.997030,0> translate<20.754278,-1.535000,1.981588> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.754278,-1.535000,3.098409>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.929600,-1.535000,3.273731>}
box{<0,0,-0.127000><0.247943,0.035000,0.127000> rotate<0,-44.997030,0> translate<20.754278,-1.535000,3.098409> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.754278,-1.535000,7.061587>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.929600,-1.535000,6.886266>}
box{<0,0,-0.127000><0.247943,0.035000,0.127000> rotate<0,44.997030,0> translate<20.754278,-1.535000,7.061587> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.754278,-1.535000,8.178409>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.031588,-1.535000,8.455719>}
box{<0,0,-0.127000><0.392175,0.035000,0.127000> rotate<0,-44.997030,0> translate<20.754278,-1.535000,8.178409> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.929600,-1.535000,6.886266>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.929600,-1.535000,3.273731>}
box{<0,0,-0.127000><3.612534,0.035000,0.127000> rotate<0,-90.000000,0> translate<20.929600,-1.535000,3.273731> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.031588,-1.535000,1.704278>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.393909,-1.535000,1.554200>}
box{<0,0,-0.127000><0.392174,0.035000,0.127000> rotate<0,22.498446,0> translate<21.031588,-1.535000,1.704278> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.031588,-1.535000,8.455719>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.393909,-1.535000,8.605797>}
box{<0,0,-0.127000><0.392174,0.035000,0.127000> rotate<0,-22.498446,0> translate<21.031588,-1.535000,8.455719> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.053428,-1.535000,19.075397>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.126569,-1.535000,19.075397>}
box{<0,0,-0.127000><1.073141,0.035000,0.127000> rotate<0,0.000000,0> translate<21.053428,-1.535000,19.075397> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.053428,-1.535000,22.834600>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.126569,-1.535000,22.834600>}
box{<0,0,-0.127000><1.073141,0.035000,0.127000> rotate<0,0.000000,0> translate<21.053428,-1.535000,22.834600> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.053428,-1.535000,25.425397>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.126569,-1.535000,25.425397>}
box{<0,0,-0.127000><1.073141,0.035000,0.127000> rotate<0,0.000000,0> translate<21.053428,-1.535000,25.425397> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.116553,-1.535000,19.177000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.463000,-1.535000,19.177000>}
box{<0,0,-0.127000><0.346447,0.035000,0.127000> rotate<0,0.000000,0> translate<21.116553,-1.535000,19.177000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.116553,-1.535000,21.462997>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.463000,-1.535000,21.462997>}
box{<0,0,-0.127000><0.346447,0.035000,0.127000> rotate<0,0.000000,0> translate<21.116553,-1.535000,21.462997> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.116553,-1.535000,25.527000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.463000,-1.535000,25.527000>}
box{<0,0,-0.127000><0.346447,0.035000,0.127000> rotate<0,0.000000,0> translate<21.116553,-1.535000,25.527000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.116553,-1.535000,27.812997>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.463000,-1.535000,27.812997>}
box{<0,0,-0.127000><0.346447,0.035000,0.127000> rotate<0,0.000000,0> translate<21.116553,-1.535000,27.812997> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.393909,-1.535000,1.554200>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.786088,-1.535000,1.554200>}
box{<0,0,-0.127000><0.392178,0.035000,0.127000> rotate<0,0.000000,0> translate<21.393909,-1.535000,1.554200> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.393909,-1.535000,8.605797>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.786088,-1.535000,8.605797>}
box{<0,0,-0.127000><0.392178,0.035000,0.127000> rotate<0,0.000000,0> translate<21.393909,-1.535000,8.605797> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.462984,-1.535000,20.446994>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.462984,-1.535000,20.193000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,-90.000000,0> translate<21.462984,-1.535000,20.193000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.462984,-1.535000,26.796994>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.462984,-1.535000,26.543000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,-90.000000,0> translate<21.462984,-1.535000,26.543000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.463000,-1.535000,19.177000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.463000,-1.535000,20.192984>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,90.000000,0> translate<21.463000,-1.535000,20.192984> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.463000,-1.535000,19.304000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.716994,-1.535000,19.304000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<21.463000,-1.535000,19.304000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.463000,-1.535000,19.558000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.716994,-1.535000,19.558000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<21.463000,-1.535000,19.558000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.463000,-1.535000,19.812000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.716994,-1.535000,19.812000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<21.463000,-1.535000,19.812000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.463000,-1.535000,20.066000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.716994,-1.535000,20.066000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<21.463000,-1.535000,20.066000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.463000,-1.535000,20.192984>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.716994,-1.535000,20.192984>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<21.463000,-1.535000,20.192984> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.463000,-1.535000,20.447012>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.463000,-1.535000,21.462997>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,90.000000,0> translate<21.463000,-1.535000,21.462997> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.463000,-1.535000,20.447012>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.716994,-1.535000,20.447012>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<21.463000,-1.535000,20.447012> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.463000,-1.535000,20.574000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.716994,-1.535000,20.574000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<21.463000,-1.535000,20.574000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.463000,-1.535000,20.828000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.716994,-1.535000,20.828000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<21.463000,-1.535000,20.828000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.463000,-1.535000,21.082000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.716994,-1.535000,21.082000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<21.463000,-1.535000,21.082000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.463000,-1.535000,21.336000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.716994,-1.535000,21.336000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<21.463000,-1.535000,21.336000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.463000,-1.535000,25.527000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.463000,-1.535000,26.542984>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,90.000000,0> translate<21.463000,-1.535000,26.542984> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.463000,-1.535000,25.654000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.716994,-1.535000,25.654000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<21.463000,-1.535000,25.654000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.463000,-1.535000,25.908000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.716994,-1.535000,25.908000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<21.463000,-1.535000,25.908000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.463000,-1.535000,26.162000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.716994,-1.535000,26.162000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<21.463000,-1.535000,26.162000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.463000,-1.535000,26.416000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.716994,-1.535000,26.416000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<21.463000,-1.535000,26.416000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.463000,-1.535000,26.542984>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.716994,-1.535000,26.542984>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<21.463000,-1.535000,26.542984> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.463000,-1.535000,26.797013>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.463000,-1.535000,27.812997>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,90.000000,0> translate<21.463000,-1.535000,27.812997> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.463000,-1.535000,26.797013>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.716994,-1.535000,26.797013>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<21.463000,-1.535000,26.797013> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.463000,-1.535000,26.924000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.716994,-1.535000,26.924000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<21.463000,-1.535000,26.924000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.463000,-1.535000,27.178000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.716994,-1.535000,27.178000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<21.463000,-1.535000,27.178000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.463000,-1.535000,27.432000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.716994,-1.535000,27.432000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<21.463000,-1.535000,27.432000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.463000,-1.535000,27.686000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.716994,-1.535000,27.686000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<21.463000,-1.535000,27.686000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.716994,-1.535000,19.177000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.063444,-1.535000,19.177000>}
box{<0,0,-0.127000><0.346450,0.035000,0.127000> rotate<0,0.000000,0> translate<21.716994,-1.535000,19.177000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.716994,-1.535000,20.192984>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.716994,-1.535000,19.177000>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,-90.000000,0> translate<21.716994,-1.535000,19.177000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.716994,-1.535000,21.462997>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.716994,-1.535000,20.447012>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,-90.000000,0> translate<21.716994,-1.535000,20.447012> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.716994,-1.535000,21.462997>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.063444,-1.535000,21.462997>}
box{<0,0,-0.127000><0.346450,0.035000,0.127000> rotate<0,0.000000,0> translate<21.716994,-1.535000,21.462997> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.716994,-1.535000,25.527000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.063444,-1.535000,25.527000>}
box{<0,0,-0.127000><0.346450,0.035000,0.127000> rotate<0,0.000000,0> translate<21.716994,-1.535000,25.527000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.716994,-1.535000,26.542984>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.716994,-1.535000,25.527000>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,-90.000000,0> translate<21.716994,-1.535000,25.527000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.716994,-1.535000,27.812997>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.716994,-1.535000,26.797013>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,-90.000000,0> translate<21.716994,-1.535000,26.797013> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.716994,-1.535000,27.812997>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.063444,-1.535000,27.812997>}
box{<0,0,-0.127000><0.346450,0.035000,0.127000> rotate<0,0.000000,0> translate<21.716994,-1.535000,27.812997> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.717013,-1.535000,20.193000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.717013,-1.535000,20.446994>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,90.000000,0> translate<21.717013,-1.535000,20.446994> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.717013,-1.535000,20.193000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.732997,-1.535000,20.193000>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,0.000000,0> translate<21.717013,-1.535000,20.193000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.717013,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.834600,-1.535000,20.320000>}
box{<0,0,-0.127000><1.117587,0.035000,0.127000> rotate<0,0.000000,0> translate<21.717013,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.717013,-1.535000,20.446994>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.732997,-1.535000,20.446994>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,0.000000,0> translate<21.717013,-1.535000,20.446994> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.717013,-1.535000,26.543000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.717013,-1.535000,26.796994>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,90.000000,0> translate<21.717013,-1.535000,26.796994> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.717013,-1.535000,26.543000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.732997,-1.535000,26.543000>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,0.000000,0> translate<21.717013,-1.535000,26.543000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.717013,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.834600,-1.535000,26.670000>}
box{<0,0,-0.127000><1.117587,0.035000,0.127000> rotate<0,0.000000,0> translate<21.717013,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.717013,-1.535000,26.796994>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.732997,-1.535000,26.796994>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,0.000000,0> translate<21.717013,-1.535000,26.796994> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.786088,-1.535000,1.554200>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.148409,-1.535000,1.704278>}
box{<0,0,-0.127000><0.392174,0.035000,0.127000> rotate<0,-22.498446,0> translate<21.786088,-1.535000,1.554200> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.786088,-1.535000,8.605797>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.148409,-1.535000,8.455719>}
box{<0,0,-0.127000><0.392174,0.035000,0.127000> rotate<0,22.498446,0> translate<21.786088,-1.535000,8.605797> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.063444,-1.535000,19.177000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.732997,-1.535000,19.846553>}
box{<0,0,-0.127000><0.946891,0.035000,0.127000> rotate<0,-44.997030,0> translate<22.063444,-1.535000,19.177000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.063444,-1.535000,21.462997>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.732997,-1.535000,20.793444>}
box{<0,0,-0.127000><0.946891,0.035000,0.127000> rotate<0,44.997030,0> translate<22.063444,-1.535000,21.462997> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.063444,-1.535000,25.527000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.732997,-1.535000,26.196553>}
box{<0,0,-0.127000><0.946891,0.035000,0.127000> rotate<0,-44.997030,0> translate<22.063444,-1.535000,25.527000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.063444,-1.535000,27.812997>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.732997,-1.535000,27.143444>}
box{<0,0,-0.127000><0.946891,0.035000,0.127000> rotate<0,44.997030,0> translate<22.063444,-1.535000,27.812997> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.126569,-1.535000,19.075397>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.860000,-1.535000,18.341966>}
box{<0,0,-0.127000><1.037228,0.035000,0.127000> rotate<0,44.997030,0> translate<22.126569,-1.535000,19.075397> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.126569,-1.535000,22.834600>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.860000,-1.535000,23.568031>}
box{<0,0,-0.127000><1.037228,0.035000,0.127000> rotate<0,-44.997030,0> translate<22.126569,-1.535000,22.834600> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.126569,-1.535000,25.425397>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.860000,-1.535000,24.691966>}
box{<0,0,-0.127000><1.037228,0.035000,0.127000> rotate<0,44.997030,0> translate<22.126569,-1.535000,25.425397> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.148409,-1.535000,1.704278>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.425719,-1.535000,1.981588>}
box{<0,0,-0.127000><0.392175,0.035000,0.127000> rotate<0,-44.997030,0> translate<22.148409,-1.535000,1.704278> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.148409,-1.535000,8.455719>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.425719,-1.535000,8.178409>}
box{<0,0,-0.127000><0.392175,0.035000,0.127000> rotate<0,44.997030,0> translate<22.148409,-1.535000,8.455719> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.151966,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<23.568031,-1.535000,19.050000>}
box{<0,0,-0.127000><1.416066,0.035000,0.127000> rotate<0,0.000000,0> translate<22.151966,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.151966,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<23.568031,-1.535000,25.400000>}
box{<0,0,-0.127000><1.416066,0.035000,0.127000> rotate<0,0.000000,0> translate<22.151966,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.151969,-1.535000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<23.568028,-1.535000,22.860000>}
box{<0,0,-0.127000><1.416059,0.035000,0.127000> rotate<0,0.000000,0> translate<22.151969,-1.535000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.190441,-1.535000,21.336000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<23.314031,-1.535000,21.336000>}
box{<0,0,-0.127000><1.123591,0.035000,0.127000> rotate<0,0.000000,0> translate<22.190441,-1.535000,21.336000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.190441,-1.535000,27.686000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<23.314031,-1.535000,27.686000>}
box{<0,0,-0.127000><1.123591,0.035000,0.127000> rotate<0,0.000000,0> translate<22.190441,-1.535000,27.686000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.190444,-1.535000,19.304000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<23.314028,-1.535000,19.304000>}
box{<0,0,-0.127000><1.123584,0.035000,0.127000> rotate<0,0.000000,0> translate<22.190444,-1.535000,19.304000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.190444,-1.535000,25.654000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<23.314028,-1.535000,25.654000>}
box{<0,0,-0.127000><1.123584,0.035000,0.127000> rotate<0,0.000000,0> translate<22.190444,-1.535000,25.654000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.222128,-1.535000,8.382000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<29.623394,-1.535000,8.382000>}
box{<0,0,-0.127000><7.401266,0.035000,0.127000> rotate<0,0.000000,0> translate<22.222128,-1.535000,8.382000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.222131,-1.535000,1.778000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<32.994600,-1.535000,1.778000>}
box{<0,0,-0.127000><10.772469,0.035000,0.127000> rotate<0,0.000000,0> translate<22.222131,-1.535000,1.778000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.250397,-1.535000,3.273731>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.250397,-1.535000,6.886266>}
box{<0,0,-0.127000><3.612534,0.035000,0.127000> rotate<0,90.000000,0> translate<22.250397,-1.535000,6.886266> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.250397,-1.535000,3.273731>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.425719,-1.535000,3.098409>}
box{<0,0,-0.127000><0.247943,0.035000,0.127000> rotate<0,44.997030,0> translate<22.250397,-1.535000,3.273731> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.250397,-1.535000,3.302000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.543394,-1.535000,3.302000>}
box{<0,0,-0.127000><2.292997,0.035000,0.127000> rotate<0,0.000000,0> translate<22.250397,-1.535000,3.302000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.250397,-1.535000,3.556000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.438184,-1.535000,3.556000>}
box{<0,0,-0.127000><2.187788,0.035000,0.127000> rotate<0,0.000000,0> translate<22.250397,-1.535000,3.556000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.250397,-1.535000,3.810000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.414200,-1.535000,3.810000>}
box{<0,0,-0.127000><2.163803,0.035000,0.127000> rotate<0,0.000000,0> translate<22.250397,-1.535000,3.810000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.250397,-1.535000,4.064000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.438191,-1.535000,4.064000>}
box{<0,0,-0.127000><2.187794,0.035000,0.127000> rotate<0,0.000000,0> translate<22.250397,-1.535000,4.064000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.250397,-1.535000,4.318000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.543400,-1.535000,4.318000>}
box{<0,0,-0.127000><2.293003,0.035000,0.127000> rotate<0,0.000000,0> translate<22.250397,-1.535000,4.318000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.250397,-1.535000,4.572000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.767869,-1.535000,4.572000>}
box{<0,0,-0.127000><2.517472,0.035000,0.127000> rotate<0,0.000000,0> translate<22.250397,-1.535000,4.572000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.250397,-1.535000,4.826000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.992056,-1.535000,4.826000>}
box{<0,0,-0.127000><19.741659,0.035000,0.127000> rotate<0,0.000000,0> translate<22.250397,-1.535000,4.826000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.250397,-1.535000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.246056,-1.535000,5.080000>}
box{<0,0,-0.127000><19.995659,0.035000,0.127000> rotate<0,0.000000,0> translate<22.250397,-1.535000,5.080000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.250397,-1.535000,5.334000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.500056,-1.535000,5.334000>}
box{<0,0,-0.127000><20.249659,0.035000,0.127000> rotate<0,0.000000,0> translate<22.250397,-1.535000,5.334000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.250397,-1.535000,5.588000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.754056,-1.535000,5.588000>}
box{<0,0,-0.127000><20.503659,0.035000,0.127000> rotate<0,0.000000,0> translate<22.250397,-1.535000,5.588000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.250397,-1.535000,5.842000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.008056,-1.535000,5.842000>}
box{<0,0,-0.127000><20.757659,0.035000,0.127000> rotate<0,0.000000,0> translate<22.250397,-1.535000,5.842000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.250397,-1.535000,6.096000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.262056,-1.535000,6.096000>}
box{<0,0,-0.127000><21.011659,0.035000,0.127000> rotate<0,0.000000,0> translate<22.250397,-1.535000,6.096000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.250397,-1.535000,6.350000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.516056,-1.535000,6.350000>}
box{<0,0,-0.127000><21.265659,0.035000,0.127000> rotate<0,0.000000,0> translate<22.250397,-1.535000,6.350000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.250397,-1.535000,6.604000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.624334,-1.535000,6.604000>}
box{<0,0,-0.127000><18.373938,0.035000,0.127000> rotate<0,0.000000,0> translate<22.250397,-1.535000,6.604000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.250397,-1.535000,6.858000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.293553,-1.535000,6.858000>}
box{<0,0,-0.127000><18.043156,0.035000,0.127000> rotate<0,0.000000,0> translate<22.250397,-1.535000,6.858000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.250397,-1.535000,6.886266>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.425719,-1.535000,7.061587>}
box{<0,0,-0.127000><0.247943,0.035000,0.127000> rotate<0,-44.997030,0> translate<22.250397,-1.535000,6.886266> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.405966,-1.535000,18.796000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<23.314034,-1.535000,18.796000>}
box{<0,0,-0.127000><0.908069,0.035000,0.127000> rotate<0,0.000000,0> translate<22.405966,-1.535000,18.796000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.405966,-1.535000,25.146000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<23.314034,-1.535000,25.146000>}
box{<0,0,-0.127000><0.908069,0.035000,0.127000> rotate<0,0.000000,0> translate<22.405966,-1.535000,25.146000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.405969,-1.535000,23.114000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<23.314028,-1.535000,23.114000>}
box{<0,0,-0.127000><0.908059,0.035000,0.127000> rotate<0,0.000000,0> translate<22.405969,-1.535000,23.114000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.425719,-1.535000,1.981588>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.575797,-1.535000,2.343909>}
box{<0,0,-0.127000><0.392174,0.035000,0.127000> rotate<0,-67.495614,0> translate<22.425719,-1.535000,1.981588> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.425719,-1.535000,3.098409>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.575797,-1.535000,2.736088>}
box{<0,0,-0.127000><0.392174,0.035000,0.127000> rotate<0,67.495614,0> translate<22.425719,-1.535000,3.098409> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.425719,-1.535000,7.061587>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.575797,-1.535000,7.423909>}
box{<0,0,-0.127000><0.392174,0.035000,0.127000> rotate<0,-67.495614,0> translate<22.425719,-1.535000,7.061587> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.425719,-1.535000,8.178409>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.575797,-1.535000,7.816088>}
box{<0,0,-0.127000><0.392174,0.035000,0.127000> rotate<0,67.495614,0> translate<22.425719,-1.535000,8.178409> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.444441,-1.535000,21.082000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<23.060031,-1.535000,21.082000>}
box{<0,0,-0.127000><0.615591,0.035000,0.127000> rotate<0,0.000000,0> translate<22.444441,-1.535000,21.082000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.444441,-1.535000,27.432000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<23.060031,-1.535000,27.432000>}
box{<0,0,-0.127000><0.615591,0.035000,0.127000> rotate<0,0.000000,0> translate<22.444441,-1.535000,27.432000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.444444,-1.535000,19.558000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<23.060028,-1.535000,19.558000>}
box{<0,0,-0.127000><0.615584,0.035000,0.127000> rotate<0,0.000000,0> translate<22.444444,-1.535000,19.558000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.444444,-1.535000,25.908000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<23.060028,-1.535000,25.908000>}
box{<0,0,-0.127000><0.615584,0.035000,0.127000> rotate<0,0.000000,0> translate<22.444444,-1.535000,25.908000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.446600,-1.535000,2.032000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<32.994600,-1.535000,2.032000>}
box{<0,0,-0.127000><10.548000,0.035000,0.127000> rotate<0,0.000000,0> translate<22.446600,-1.535000,2.032000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.446600,-1.535000,3.048000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.767866,-1.535000,3.048000>}
box{<0,0,-0.127000><2.321266,0.035000,0.127000> rotate<0,0.000000,0> translate<22.446600,-1.535000,3.048000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.446600,-1.535000,7.112000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.124019,-1.535000,7.112000>}
box{<0,0,-0.127000><17.677419,0.035000,0.127000> rotate<0,0.000000,0> translate<22.446600,-1.535000,7.112000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.446600,-1.535000,8.128000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<29.847866,-1.535000,8.128000>}
box{<0,0,-0.127000><7.401266,0.035000,0.127000> rotate<0,0.000000,0> translate<22.446600,-1.535000,8.128000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.551809,-1.535000,2.286000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<32.994600,-1.535000,2.286000>}
box{<0,0,-0.127000><10.442791,0.035000,0.127000> rotate<0,0.000000,0> translate<22.551809,-1.535000,2.286000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.551809,-1.535000,2.794000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.220031,-1.535000,2.794000>}
box{<0,0,-0.127000><10.668222,0.035000,0.127000> rotate<0,0.000000,0> translate<22.551809,-1.535000,2.794000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.551809,-1.535000,7.366000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.030978,-1.535000,7.366000>}
box{<0,0,-0.127000><17.479169,0.035000,0.127000> rotate<0,0.000000,0> translate<22.551809,-1.535000,7.366000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.551809,-1.535000,7.874000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.030984,-1.535000,7.874000>}
box{<0,0,-0.127000><17.479175,0.035000,0.127000> rotate<0,0.000000,0> translate<22.551809,-1.535000,7.874000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.575797,-1.535000,2.343909>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.575797,-1.535000,2.736088>}
box{<0,0,-0.127000><0.392178,0.035000,0.127000> rotate<0,90.000000,0> translate<22.575797,-1.535000,2.736088> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.575797,-1.535000,2.540000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.098291,-1.535000,2.540000>}
box{<0,0,-0.127000><10.522494,0.035000,0.127000> rotate<0,0.000000,0> translate<22.575797,-1.535000,2.540000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.575797,-1.535000,7.423909>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.575797,-1.535000,7.816088>}
box{<0,0,-0.127000><0.392178,0.035000,0.127000> rotate<0,90.000000,0> translate<22.575797,-1.535000,7.816088> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.575797,-1.535000,7.620000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.782984,-1.535000,7.620000>}
box{<0,0,-0.127000><19.207188,0.035000,0.127000> rotate<0,0.000000,0> translate<22.575797,-1.535000,7.620000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.659966,-1.535000,18.542000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<23.060034,-1.535000,18.542000>}
box{<0,0,-0.127000><0.400069,0.035000,0.127000> rotate<0,0.000000,0> translate<22.659966,-1.535000,18.542000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.659966,-1.535000,24.892000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<23.060034,-1.535000,24.892000>}
box{<0,0,-0.127000><0.400069,0.035000,0.127000> rotate<0,0.000000,0> translate<22.659966,-1.535000,24.892000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.659969,-1.535000,23.368000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<23.060028,-1.535000,23.368000>}
box{<0,0,-0.127000><0.400059,0.035000,0.127000> rotate<0,0.000000,0> translate<22.659969,-1.535000,23.368000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.698441,-1.535000,20.828000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.834600,-1.535000,20.828000>}
box{<0,0,-0.127000><0.136159,0.035000,0.127000> rotate<0,0.000000,0> translate<22.698441,-1.535000,20.828000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.698441,-1.535000,27.178000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.834600,-1.535000,27.178000>}
box{<0,0,-0.127000><0.136159,0.035000,0.127000> rotate<0,0.000000,0> translate<22.698441,-1.535000,27.178000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.698444,-1.535000,19.812000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.834600,-1.535000,19.812000>}
box{<0,0,-0.127000><0.136156,0.035000,0.127000> rotate<0,0.000000,0> translate<22.698444,-1.535000,19.812000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.698444,-1.535000,26.162000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.834600,-1.535000,26.162000>}
box{<0,0,-0.127000><0.136156,0.035000,0.127000> rotate<0,0.000000,0> translate<22.698444,-1.535000,26.162000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.732997,-1.535000,19.846553>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.732997,-1.535000,20.193000>}
box{<0,0,-0.127000><0.346447,0.035000,0.127000> rotate<0,90.000000,0> translate<22.732997,-1.535000,20.193000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.732997,-1.535000,20.066000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.834600,-1.535000,20.066000>}
box{<0,0,-0.127000><0.101603,0.035000,0.127000> rotate<0,0.000000,0> translate<22.732997,-1.535000,20.066000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.732997,-1.535000,20.446994>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.732997,-1.535000,20.793444>}
box{<0,0,-0.127000><0.346450,0.035000,0.127000> rotate<0,90.000000,0> translate<22.732997,-1.535000,20.793444> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.732997,-1.535000,20.574000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.834600,-1.535000,20.574000>}
box{<0,0,-0.127000><0.101603,0.035000,0.127000> rotate<0,0.000000,0> translate<22.732997,-1.535000,20.574000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.732997,-1.535000,26.196553>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.732997,-1.535000,26.543000>}
box{<0,0,-0.127000><0.346447,0.035000,0.127000> rotate<0,90.000000,0> translate<22.732997,-1.535000,26.543000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.732997,-1.535000,26.416000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.834600,-1.535000,26.416000>}
box{<0,0,-0.127000><0.101603,0.035000,0.127000> rotate<0,0.000000,0> translate<22.732997,-1.535000,26.416000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.732997,-1.535000,26.796994>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.732997,-1.535000,27.143444>}
box{<0,0,-0.127000><0.346450,0.035000,0.127000> rotate<0,90.000000,0> translate<22.732997,-1.535000,27.143444> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.732997,-1.535000,26.924000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.834600,-1.535000,26.924000>}
box{<0,0,-0.127000><0.101603,0.035000,0.127000> rotate<0,0.000000,0> translate<22.732997,-1.535000,26.924000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.834600,-1.535000,19.783428>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<23.568031,-1.535000,19.050000>}
box{<0,0,-0.127000><1.037226,0.035000,0.127000> rotate<0,44.996908,0> translate<22.834600,-1.535000,19.783428> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.834600,-1.535000,20.856569>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.834600,-1.535000,19.783428>}
box{<0,0,-0.127000><1.073141,0.035000,0.127000> rotate<0,-90.000000,0> translate<22.834600,-1.535000,19.783428> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.834600,-1.535000,20.856569>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<23.593428,-1.535000,21.615397>}
box{<0,0,-0.127000><1.073145,0.035000,0.127000> rotate<0,-44.997030,0> translate<22.834600,-1.535000,20.856569> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.834600,-1.535000,26.133428>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<23.568031,-1.535000,25.400000>}
box{<0,0,-0.127000><1.037226,0.035000,0.127000> rotate<0,44.996908,0> translate<22.834600,-1.535000,26.133428> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.834600,-1.535000,27.206569>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.834600,-1.535000,26.133428>}
box{<0,0,-0.127000><1.073141,0.035000,0.127000> rotate<0,-90.000000,0> translate<22.834600,-1.535000,26.133428> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.834600,-1.535000,27.206569>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<23.593428,-1.535000,27.965397>}
box{<0,0,-0.127000><1.073145,0.035000,0.127000> rotate<0,-44.997030,0> translate<22.834600,-1.535000,27.206569> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.860000,-1.535000,18.341966>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<23.568031,-1.535000,19.050000>}
box{<0,0,-0.127000><1.001310,0.035000,0.127000> rotate<0,-44.997157,0> translate<22.860000,-1.535000,18.341966> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.860000,-1.535000,23.568031>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<23.593428,-1.535000,22.834600>}
box{<0,0,-0.127000><1.037226,0.035000,0.127000> rotate<0,44.997152,0> translate<22.860000,-1.535000,23.568031> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.860000,-1.535000,24.691966>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<23.568031,-1.535000,25.400000>}
box{<0,0,-0.127000><1.001310,0.035000,0.127000> rotate<0,-44.997157,0> translate<22.860000,-1.535000,24.691966> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<23.593428,-1.535000,21.615397>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.666569,-1.535000,21.615397>}
box{<0,0,-0.127000><1.073141,0.035000,0.127000> rotate<0,0.000000,0> translate<23.593428,-1.535000,21.615397> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<23.593428,-1.535000,22.834600>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.666569,-1.535000,22.834600>}
box{<0,0,-0.127000><1.073141,0.035000,0.127000> rotate<0,0.000000,0> translate<23.593428,-1.535000,22.834600> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<23.593428,-1.535000,27.965397>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.666569,-1.535000,27.965397>}
box{<0,0,-0.127000><1.073141,0.035000,0.127000> rotate<0,0.000000,0> translate<23.593428,-1.535000,27.965397> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<23.856453,-1.535000,14.579600>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.414200,-1.535000,14.021853>}
box{<0,0,-0.127000><0.788773,0.035000,0.127000> rotate<0,44.997030,0> translate<23.856453,-1.535000,14.579600> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.414200,-1.535000,3.613909>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.564278,-1.535000,3.251588>}
box{<0,0,-0.127000><0.392174,0.035000,0.127000> rotate<0,67.495614,0> translate<24.414200,-1.535000,3.613909> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.414200,-1.535000,4.006088>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.414200,-1.535000,3.613909>}
box{<0,0,-0.127000><0.392178,0.035000,0.127000> rotate<0,-90.000000,0> translate<24.414200,-1.535000,3.613909> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.414200,-1.535000,4.006088>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.564278,-1.535000,4.368409>}
box{<0,0,-0.127000><0.392174,0.035000,0.127000> rotate<0,-67.495614,0> translate<24.414200,-1.535000,4.006088> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.414200,-1.535000,13.773909>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.564278,-1.535000,13.411588>}
box{<0,0,-0.127000><0.392174,0.035000,0.127000> rotate<0,67.495614,0> translate<24.414200,-1.535000,13.773909> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.414200,-1.535000,14.021853>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.414200,-1.535000,13.773909>}
box{<0,0,-0.127000><0.247944,0.035000,0.127000> rotate<0,-90.000000,0> translate<24.414200,-1.535000,13.773909> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.564278,-1.535000,3.251588>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.841588,-1.535000,2.974278>}
box{<0,0,-0.127000><0.392175,0.035000,0.127000> rotate<0,44.997030,0> translate<24.564278,-1.535000,3.251588> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.564278,-1.535000,4.368409>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.841588,-1.535000,4.645719>}
box{<0,0,-0.127000><0.392175,0.035000,0.127000> rotate<0,-44.997030,0> translate<24.564278,-1.535000,4.368409> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.564278,-1.535000,13.411588>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.841588,-1.535000,13.134278>}
box{<0,0,-0.127000><0.392175,0.035000,0.127000> rotate<0,44.997030,0> translate<24.564278,-1.535000,13.411588> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.666569,-1.535000,21.615397>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.400000,-1.535000,20.881966>}
box{<0,0,-0.127000><1.037228,0.035000,0.127000> rotate<0,44.997030,0> translate<24.666569,-1.535000,21.615397> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.666569,-1.535000,22.834600>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.425397,-1.535000,23.593428>}
box{<0,0,-0.127000><1.073145,0.035000,0.127000> rotate<0,-44.997030,0> translate<24.666569,-1.535000,22.834600> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.666569,-1.535000,27.965397>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.400000,-1.535000,27.231966>}
box{<0,0,-0.127000><1.037228,0.035000,0.127000> rotate<0,44.997030,0> translate<24.666569,-1.535000,27.965397> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.691966,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.400000,-1.535000,19.758031>}
box{<0,0,-0.127000><1.001310,0.035000,0.127000> rotate<0,-44.996904,0> translate<24.691966,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.691966,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.425397,-1.535000,18.316569>}
box{<0,0,-0.127000><1.037228,0.035000,0.127000> rotate<0,44.997030,0> translate<24.691966,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.691966,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.108028,-1.535000,19.050000>}
box{<0,0,-0.127000><1.416062,0.035000,0.127000> rotate<0,0.000000,0> translate<24.691966,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.691966,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.108034,-1.535000,21.590000>}
box{<0,0,-0.127000><1.416069,0.035000,0.127000> rotate<0,0.000000,0> translate<24.691966,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.691966,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.400000,-1.535000,26.108031>}
box{<0,0,-0.127000><1.001310,0.035000,0.127000> rotate<0,-44.996904,0> translate<24.691966,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.691966,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.425397,-1.535000,24.666569>}
box{<0,0,-0.127000><1.037228,0.035000,0.127000> rotate<0,44.997030,0> translate<24.691966,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.691966,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.108028,-1.535000,25.400000>}
box{<0,0,-0.127000><1.416062,0.035000,0.127000> rotate<0,0.000000,0> translate<24.691966,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.691966,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.108034,-1.535000,27.940000>}
box{<0,0,-0.127000><1.416069,0.035000,0.127000> rotate<0,0.000000,0> translate<24.691966,-1.535000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.691969,-1.535000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<28.648028,-1.535000,22.860000>}
box{<0,0,-0.127000><3.956059,0.035000,0.127000> rotate<0,0.000000,0> translate<24.691969,-1.535000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.841588,-1.535000,2.974278>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.203909,-1.535000,2.824200>}
box{<0,0,-0.127000><0.392174,0.035000,0.127000> rotate<0,22.498446,0> translate<24.841588,-1.535000,2.974278> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.841588,-1.535000,4.645719>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.203909,-1.535000,4.795797>}
box{<0,0,-0.127000><0.392174,0.035000,0.127000> rotate<0,-22.498446,0> translate<24.841588,-1.535000,4.645719> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.841588,-1.535000,13.134278>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.203909,-1.535000,12.984200>}
box{<0,0,-0.127000><0.392174,0.035000,0.127000> rotate<0,22.498446,0> translate<24.841588,-1.535000,13.134278> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.945966,-1.535000,18.796000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.069556,-1.535000,18.796000>}
box{<0,0,-0.127000><1.123591,0.035000,0.127000> rotate<0,0.000000,0> translate<24.945966,-1.535000,18.796000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.945966,-1.535000,19.304000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.854028,-1.535000,19.304000>}
box{<0,0,-0.127000><0.908063,0.035000,0.127000> rotate<0,0.000000,0> translate<24.945966,-1.535000,19.304000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.945966,-1.535000,21.336000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.854034,-1.535000,21.336000>}
box{<0,0,-0.127000><0.908069,0.035000,0.127000> rotate<0,0.000000,0> translate<24.945966,-1.535000,21.336000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.945966,-1.535000,25.146000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.069556,-1.535000,25.146000>}
box{<0,0,-0.127000><1.123591,0.035000,0.127000> rotate<0,0.000000,0> translate<24.945966,-1.535000,25.146000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.945966,-1.535000,25.654000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.854028,-1.535000,25.654000>}
box{<0,0,-0.127000><0.908063,0.035000,0.127000> rotate<0,0.000000,0> translate<24.945966,-1.535000,25.654000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.945966,-1.535000,27.686000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.854034,-1.535000,27.686000>}
box{<0,0,-0.127000><0.908069,0.035000,0.127000> rotate<0,0.000000,0> translate<24.945966,-1.535000,27.686000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<24.945969,-1.535000,23.114000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.069553,-1.535000,23.114000>}
box{<0,0,-0.127000><1.123584,0.035000,0.127000> rotate<0,0.000000,0> translate<24.945969,-1.535000,23.114000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.199966,-1.535000,18.542000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.815556,-1.535000,18.542000>}
box{<0,0,-0.127000><0.615591,0.035000,0.127000> rotate<0,0.000000,0> translate<25.199966,-1.535000,18.542000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.199966,-1.535000,19.558000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.600028,-1.535000,19.558000>}
box{<0,0,-0.127000><0.400063,0.035000,0.127000> rotate<0,0.000000,0> translate<25.199966,-1.535000,19.558000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.199966,-1.535000,21.082000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.600034,-1.535000,21.082000>}
box{<0,0,-0.127000><0.400069,0.035000,0.127000> rotate<0,0.000000,0> translate<25.199966,-1.535000,21.082000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.199966,-1.535000,24.892000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.815556,-1.535000,24.892000>}
box{<0,0,-0.127000><0.615591,0.035000,0.127000> rotate<0,0.000000,0> translate<25.199966,-1.535000,24.892000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.199966,-1.535000,25.908000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.600028,-1.535000,25.908000>}
box{<0,0,-0.127000><0.400063,0.035000,0.127000> rotate<0,0.000000,0> translate<25.199966,-1.535000,25.908000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.199966,-1.535000,27.432000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.600034,-1.535000,27.432000>}
box{<0,0,-0.127000><0.400069,0.035000,0.127000> rotate<0,0.000000,0> translate<25.199966,-1.535000,27.432000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.199969,-1.535000,23.368000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.815553,-1.535000,23.368000>}
box{<0,0,-0.127000><0.615584,0.035000,0.127000> rotate<0,0.000000,0> translate<25.199969,-1.535000,23.368000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.203909,-1.535000,2.824200>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.596088,-1.535000,2.824200>}
box{<0,0,-0.127000><0.392178,0.035000,0.127000> rotate<0,0.000000,0> translate<25.203909,-1.535000,2.824200> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.203909,-1.535000,4.795797>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.596088,-1.535000,4.795797>}
box{<0,0,-0.127000><0.392178,0.035000,0.127000> rotate<0,0.000000,0> translate<25.203909,-1.535000,4.795797> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.203909,-1.535000,12.984200>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.596088,-1.535000,12.984200>}
box{<0,0,-0.127000><0.392178,0.035000,0.127000> rotate<0,0.000000,0> translate<25.203909,-1.535000,12.984200> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.352363,-1.535000,17.170397>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.425397,-1.535000,17.243428>}
box{<0,0,-0.127000><0.103284,0.035000,0.127000> rotate<0,-44.995804,0> translate<25.352363,-1.535000,17.170397> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.352363,-1.535000,17.170397>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.663159,-1.535000,17.170397>}
box{<0,0,-0.127000><0.310797,0.035000,0.127000> rotate<0,0.000000,0> translate<25.352363,-1.535000,17.170397> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.400000,-1.535000,19.758031>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.133428,-1.535000,19.024600>}
box{<0,0,-0.127000><1.037226,0.035000,0.127000> rotate<0,44.997152,0> translate<25.400000,-1.535000,19.758031> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.400000,-1.535000,20.881966>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.133428,-1.535000,21.615397>}
box{<0,0,-0.127000><1.037226,0.035000,0.127000> rotate<0,-44.997152,0> translate<25.400000,-1.535000,20.881966> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.400000,-1.535000,26.108031>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.133428,-1.535000,25.374600>}
box{<0,0,-0.127000><1.037226,0.035000,0.127000> rotate<0,44.997152,0> translate<25.400000,-1.535000,26.108031> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.400000,-1.535000,27.231966>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.133428,-1.535000,27.965397>}
box{<0,0,-0.127000><1.037226,0.035000,0.127000> rotate<0,-44.997152,0> translate<25.400000,-1.535000,27.231966> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.425397,-1.535000,17.243428>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.425397,-1.535000,18.316569>}
box{<0,0,-0.127000><1.073141,0.035000,0.127000> rotate<0,90.000000,0> translate<25.425397,-1.535000,18.316569> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.425397,-1.535000,17.272000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.561553,-1.535000,17.272000>}
box{<0,0,-0.127000><0.136156,0.035000,0.127000> rotate<0,0.000000,0> translate<25.425397,-1.535000,17.272000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.425397,-1.535000,17.526000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.527000,-1.535000,17.526000>}
box{<0,0,-0.127000><0.101603,0.035000,0.127000> rotate<0,0.000000,0> translate<25.425397,-1.535000,17.526000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.425397,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.542984,-1.535000,17.780000>}
box{<0,0,-0.127000><1.117587,0.035000,0.127000> rotate<0,0.000000,0> translate<25.425397,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.425397,-1.535000,18.034000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.527000,-1.535000,18.034000>}
box{<0,0,-0.127000><0.101603,0.035000,0.127000> rotate<0,0.000000,0> translate<25.425397,-1.535000,18.034000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.425397,-1.535000,18.288000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.561556,-1.535000,18.288000>}
box{<0,0,-0.127000><0.136159,0.035000,0.127000> rotate<0,0.000000,0> translate<25.425397,-1.535000,18.288000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.425397,-1.535000,23.593428>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.425397,-1.535000,24.666569>}
box{<0,0,-0.127000><1.073141,0.035000,0.127000> rotate<0,90.000000,0> translate<25.425397,-1.535000,24.666569> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.425397,-1.535000,23.622000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.561553,-1.535000,23.622000>}
box{<0,0,-0.127000><0.136156,0.035000,0.127000> rotate<0,0.000000,0> translate<25.425397,-1.535000,23.622000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.425397,-1.535000,23.876000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.527000,-1.535000,23.876000>}
box{<0,0,-0.127000><0.101603,0.035000,0.127000> rotate<0,0.000000,0> translate<25.425397,-1.535000,23.876000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.425397,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.542984,-1.535000,24.130000>}
box{<0,0,-0.127000><1.117587,0.035000,0.127000> rotate<0,0.000000,0> translate<25.425397,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.425397,-1.535000,24.384000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.527000,-1.535000,24.384000>}
box{<0,0,-0.127000><0.101603,0.035000,0.127000> rotate<0,0.000000,0> translate<25.425397,-1.535000,24.384000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.425397,-1.535000,24.638000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.561556,-1.535000,24.638000>}
box{<0,0,-0.127000><0.136159,0.035000,0.127000> rotate<0,0.000000,0> translate<25.425397,-1.535000,24.638000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.527000,-1.535000,17.306553>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.663159,-1.535000,17.170397>}
box{<0,0,-0.127000><0.192556,0.035000,0.127000> rotate<0,44.996373,0> translate<25.527000,-1.535000,17.306553> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.527000,-1.535000,17.653000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.527000,-1.535000,17.306553>}
box{<0,0,-0.127000><0.346447,0.035000,0.127000> rotate<0,-90.000000,0> translate<25.527000,-1.535000,17.306553> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.527000,-1.535000,17.653000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.542984,-1.535000,17.653000>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,0.000000,0> translate<25.527000,-1.535000,17.653000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.527000,-1.535000,17.906994>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.542984,-1.535000,17.906994>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,0.000000,0> translate<25.527000,-1.535000,17.906994> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.527000,-1.535000,18.253444>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.527000,-1.535000,17.906994>}
box{<0,0,-0.127000><0.346450,0.035000,0.127000> rotate<0,-90.000000,0> translate<25.527000,-1.535000,17.906994> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.527000,-1.535000,18.253444>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.196553,-1.535000,18.922997>}
box{<0,0,-0.127000><0.946891,0.035000,0.127000> rotate<0,-44.997030,0> translate<25.527000,-1.535000,18.253444> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.527000,-1.535000,23.656553>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.196553,-1.535000,22.987000>}
box{<0,0,-0.127000><0.946891,0.035000,0.127000> rotate<0,44.997030,0> translate<25.527000,-1.535000,23.656553> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.527000,-1.535000,24.003000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.527000,-1.535000,23.656553>}
box{<0,0,-0.127000><0.346447,0.035000,0.127000> rotate<0,-90.000000,0> translate<25.527000,-1.535000,23.656553> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.527000,-1.535000,24.003000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.542984,-1.535000,24.003000>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,0.000000,0> translate<25.527000,-1.535000,24.003000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.527000,-1.535000,24.256994>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.542984,-1.535000,24.256994>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,0.000000,0> translate<25.527000,-1.535000,24.256994> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.527000,-1.535000,24.603444>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.527000,-1.535000,24.256994>}
box{<0,0,-0.127000><0.346450,0.035000,0.127000> rotate<0,-90.000000,0> translate<25.527000,-1.535000,24.256994> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.527000,-1.535000,24.603444>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.196553,-1.535000,25.272997>}
box{<0,0,-0.127000><0.946891,0.035000,0.127000> rotate<0,-44.997030,0> translate<25.527000,-1.535000,24.603444> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.596088,-1.535000,2.824200>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.958409,-1.535000,2.974278>}
box{<0,0,-0.127000><0.392174,0.035000,0.127000> rotate<0,-22.498446,0> translate<25.596088,-1.535000,2.824200> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.596088,-1.535000,4.795797>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.958409,-1.535000,4.645719>}
box{<0,0,-0.127000><0.392174,0.035000,0.127000> rotate<0,22.498446,0> translate<25.596088,-1.535000,4.795797> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.596088,-1.535000,12.984200>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.958409,-1.535000,13.134278>}
box{<0,0,-0.127000><0.392174,0.035000,0.127000> rotate<0,-22.498446,0> translate<25.596088,-1.535000,12.984200> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.958409,-1.535000,2.974278>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.133731,-1.535000,3.149600>}
box{<0,0,-0.127000><0.247943,0.035000,0.127000> rotate<0,-44.997030,0> translate<25.958409,-1.535000,2.974278> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.958409,-1.535000,4.645719>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.133731,-1.535000,4.470397>}
box{<0,0,-0.127000><0.247943,0.035000,0.127000> rotate<0,44.997030,0> translate<25.958409,-1.535000,4.645719> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.958409,-1.535000,13.134278>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.235719,-1.535000,13.411588>}
box{<0,0,-0.127000><0.392175,0.035000,0.127000> rotate<0,-44.997030,0> translate<25.958409,-1.535000,13.134278> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.032128,-1.535000,4.572000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<32.387869,-1.535000,4.572000>}
box{<0,0,-0.127000><6.355741,0.035000,0.127000> rotate<0,0.000000,0> translate<26.032128,-1.535000,4.572000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.032131,-1.535000,3.048000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<32.387866,-1.535000,3.048000>}
box{<0,0,-0.127000><6.355734,0.035000,0.127000> rotate<0,0.000000,0> translate<26.032131,-1.535000,3.048000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.032131,-1.535000,13.208000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.657866,-1.535000,13.208000>}
box{<0,0,-0.127000><7.625734,0.035000,0.127000> rotate<0,0.000000,0> translate<26.032131,-1.535000,13.208000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.133428,-1.535000,19.024600>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.206569,-1.535000,19.024600>}
box{<0,0,-0.127000><1.073141,0.035000,0.127000> rotate<0,0.000000,0> translate<26.133428,-1.535000,19.024600> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.133428,-1.535000,21.615397>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.206569,-1.535000,21.615397>}
box{<0,0,-0.127000><1.073141,0.035000,0.127000> rotate<0,0.000000,0> translate<26.133428,-1.535000,21.615397> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.133428,-1.535000,25.374600>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.206569,-1.535000,25.374600>}
box{<0,0,-0.127000><1.073141,0.035000,0.127000> rotate<0,0.000000,0> translate<26.133428,-1.535000,25.374600> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.133428,-1.535000,27.965397>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.206569,-1.535000,27.965397>}
box{<0,0,-0.127000><1.073141,0.035000,0.127000> rotate<0,0.000000,0> translate<26.133428,-1.535000,27.965397> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.133731,-1.535000,3.149600>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<32.286266,-1.535000,3.149600>}
box{<0,0,-0.127000><6.152534,0.035000,0.127000> rotate<0,0.000000,0> translate<26.133731,-1.535000,3.149600> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.133731,-1.535000,4.470397>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<32.286266,-1.535000,4.470397>}
box{<0,0,-0.127000><6.152534,0.035000,0.127000> rotate<0,0.000000,0> translate<26.133731,-1.535000,4.470397> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.184525,-1.535000,14.579600>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.235719,-1.535000,14.528409>}
box{<0,0,-0.127000><0.072397,0.035000,0.127000> rotate<0,44.995281,0> translate<26.184525,-1.535000,14.579600> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.184525,-1.535000,14.579600>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.505472,-1.535000,14.579600>}
box{<0,0,-0.127000><7.320947,0.035000,0.127000> rotate<0,0.000000,0> translate<26.184525,-1.535000,14.579600> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.196553,-1.535000,18.922997>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.543000,-1.535000,18.922997>}
box{<0,0,-0.127000><0.346447,0.035000,0.127000> rotate<0,0.000000,0> translate<26.196553,-1.535000,18.922997> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.196553,-1.535000,22.987000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.543000,-1.535000,22.987000>}
box{<0,0,-0.127000><0.346447,0.035000,0.127000> rotate<0,0.000000,0> translate<26.196553,-1.535000,22.987000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.196553,-1.535000,25.272997>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.543000,-1.535000,25.272997>}
box{<0,0,-0.127000><0.346447,0.035000,0.127000> rotate<0,0.000000,0> translate<26.196553,-1.535000,25.272997> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.235719,-1.535000,13.411588>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.385797,-1.535000,13.773909>}
box{<0,0,-0.127000><0.392174,0.035000,0.127000> rotate<0,-67.495614,0> translate<26.235719,-1.535000,13.411588> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.235719,-1.535000,14.528409>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.385797,-1.535000,14.166088>}
box{<0,0,-0.127000><0.392174,0.035000,0.127000> rotate<0,67.495614,0> translate<26.235719,-1.535000,14.528409> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.256600,-1.535000,13.462000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.433394,-1.535000,13.462000>}
box{<0,0,-0.127000><7.176794,0.035000,0.127000> rotate<0,0.000000,0> translate<26.256600,-1.535000,13.462000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.256600,-1.535000,14.478000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.433400,-1.535000,14.478000>}
box{<0,0,-0.127000><7.176800,0.035000,0.127000> rotate<0,0.000000,0> translate<26.256600,-1.535000,14.478000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.361809,-1.535000,13.716000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.328184,-1.535000,13.716000>}
box{<0,0,-0.127000><6.966375,0.035000,0.127000> rotate<0,0.000000,0> translate<26.361809,-1.535000,13.716000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.361809,-1.535000,14.224000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.328191,-1.535000,14.224000>}
box{<0,0,-0.127000><6.966381,0.035000,0.127000> rotate<0,0.000000,0> translate<26.361809,-1.535000,14.224000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.385797,-1.535000,13.773909>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.385797,-1.535000,14.166088>}
box{<0,0,-0.127000><0.392178,0.035000,0.127000> rotate<0,90.000000,0> translate<26.385797,-1.535000,14.166088> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.385797,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.304200,-1.535000,13.970000>}
box{<0,0,-0.127000><6.918403,0.035000,0.127000> rotate<0,0.000000,0> translate<26.385797,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.542984,-1.535000,17.906994>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.542984,-1.535000,17.653000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,-90.000000,0> translate<26.542984,-1.535000,17.653000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.542984,-1.535000,24.256994>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.542984,-1.535000,24.003000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,-90.000000,0> translate<26.542984,-1.535000,24.003000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.543000,-1.535000,17.907013>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.543000,-1.535000,18.922997>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,90.000000,0> translate<26.543000,-1.535000,18.922997> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.543000,-1.535000,17.907013>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.796994,-1.535000,17.907013>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<26.543000,-1.535000,17.907013> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.543000,-1.535000,18.034000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.796994,-1.535000,18.034000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<26.543000,-1.535000,18.034000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.543000,-1.535000,18.288000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.796994,-1.535000,18.288000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<26.543000,-1.535000,18.288000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.543000,-1.535000,18.542000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.796994,-1.535000,18.542000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<26.543000,-1.535000,18.542000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.543000,-1.535000,18.796000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.796994,-1.535000,18.796000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<26.543000,-1.535000,18.796000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.543000,-1.535000,22.987000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.543000,-1.535000,24.002984>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,90.000000,0> translate<26.543000,-1.535000,24.002984> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.543000,-1.535000,23.114000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.796994,-1.535000,23.114000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<26.543000,-1.535000,23.114000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.543000,-1.535000,23.368000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.796994,-1.535000,23.368000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<26.543000,-1.535000,23.368000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.543000,-1.535000,23.622000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.796994,-1.535000,23.622000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<26.543000,-1.535000,23.622000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.543000,-1.535000,23.876000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.796994,-1.535000,23.876000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<26.543000,-1.535000,23.876000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.543000,-1.535000,24.002984>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.796994,-1.535000,24.002984>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<26.543000,-1.535000,24.002984> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.543000,-1.535000,24.257013>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.543000,-1.535000,25.272997>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,90.000000,0> translate<26.543000,-1.535000,25.272997> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.543000,-1.535000,24.257013>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.796994,-1.535000,24.257013>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<26.543000,-1.535000,24.257013> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.543000,-1.535000,24.384000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.796994,-1.535000,24.384000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<26.543000,-1.535000,24.384000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.543000,-1.535000,24.638000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.796994,-1.535000,24.638000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<26.543000,-1.535000,24.638000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.543000,-1.535000,24.892000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.796994,-1.535000,24.892000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<26.543000,-1.535000,24.892000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.543000,-1.535000,25.146000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.796994,-1.535000,25.146000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<26.543000,-1.535000,25.146000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.796994,-1.535000,18.922997>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.796994,-1.535000,17.907013>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,-90.000000,0> translate<26.796994,-1.535000,17.907013> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.796994,-1.535000,18.922997>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.143444,-1.535000,18.922997>}
box{<0,0,-0.127000><0.346450,0.035000,0.127000> rotate<0,0.000000,0> translate<26.796994,-1.535000,18.922997> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.796994,-1.535000,22.987000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.143444,-1.535000,22.987000>}
box{<0,0,-0.127000><0.346450,0.035000,0.127000> rotate<0,0.000000,0> translate<26.796994,-1.535000,22.987000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.796994,-1.535000,24.002984>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.796994,-1.535000,22.987000>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,-90.000000,0> translate<26.796994,-1.535000,22.987000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.796994,-1.535000,25.272997>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.796994,-1.535000,24.257013>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,-90.000000,0> translate<26.796994,-1.535000,24.257013> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.796994,-1.535000,25.272997>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.143444,-1.535000,25.272997>}
box{<0,0,-0.127000><0.346450,0.035000,0.127000> rotate<0,0.000000,0> translate<26.796994,-1.535000,25.272997> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.797013,-1.535000,17.653000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.797013,-1.535000,17.906994>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,90.000000,0> translate<26.797013,-1.535000,17.906994> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.797013,-1.535000,17.653000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.812997,-1.535000,17.653000>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,0.000000,0> translate<26.797013,-1.535000,17.653000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.797013,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.914600,-1.535000,17.780000>}
box{<0,0,-0.127000><1.117587,0.035000,0.127000> rotate<0,0.000000,0> translate<26.797013,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.797013,-1.535000,17.906994>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.812997,-1.535000,17.906994>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,0.000000,0> translate<26.797013,-1.535000,17.906994> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.797013,-1.535000,24.003000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.797013,-1.535000,24.256994>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,90.000000,0> translate<26.797013,-1.535000,24.256994> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.797013,-1.535000,24.003000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.812997,-1.535000,24.003000>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,0.000000,0> translate<26.797013,-1.535000,24.003000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.797013,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.914600,-1.535000,24.130000>}
box{<0,0,-0.127000><1.117587,0.035000,0.127000> rotate<0,0.000000,0> translate<26.797013,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.797013,-1.535000,24.256994>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.812997,-1.535000,24.256994>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,0.000000,0> translate<26.797013,-1.535000,24.256994> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.143444,-1.535000,18.922997>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.812997,-1.535000,18.253444>}
box{<0,0,-0.127000><0.946891,0.035000,0.127000> rotate<0,44.997030,0> translate<27.143444,-1.535000,18.922997> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.143444,-1.535000,22.987000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.812997,-1.535000,23.656553>}
box{<0,0,-0.127000><0.946891,0.035000,0.127000> rotate<0,-44.997030,0> translate<27.143444,-1.535000,22.987000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.143444,-1.535000,25.272997>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.812997,-1.535000,24.603444>}
box{<0,0,-0.127000><0.946891,0.035000,0.127000> rotate<0,44.997030,0> translate<27.143444,-1.535000,25.272997> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.206569,-1.535000,19.024600>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.940000,-1.535000,19.758031>}
box{<0,0,-0.127000><1.037228,0.035000,0.127000> rotate<0,-44.997030,0> translate<27.206569,-1.535000,19.024600> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.206569,-1.535000,21.615397>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.940000,-1.535000,20.881966>}
box{<0,0,-0.127000><1.037228,0.035000,0.127000> rotate<0,44.997030,0> translate<27.206569,-1.535000,21.615397> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.206569,-1.535000,25.374600>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.940000,-1.535000,26.108031>}
box{<0,0,-0.127000><1.037228,0.035000,0.127000> rotate<0,-44.997030,0> translate<27.206569,-1.535000,25.374600> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.206569,-1.535000,27.965397>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.940000,-1.535000,27.231966>}
box{<0,0,-0.127000><1.037228,0.035000,0.127000> rotate<0,44.997030,0> translate<27.206569,-1.535000,27.965397> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.231966,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<28.648034,-1.535000,21.590000>}
box{<0,0,-0.127000><1.416069,0.035000,0.127000> rotate<0,0.000000,0> translate<27.231966,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.231966,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<28.648034,-1.535000,27.940000>}
box{<0,0,-0.127000><1.416069,0.035000,0.127000> rotate<0,0.000000,0> translate<27.231966,-1.535000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.231969,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<28.648031,-1.535000,19.050000>}
box{<0,0,-0.127000><1.416063,0.035000,0.127000> rotate<0,0.000000,0> translate<27.231969,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.231969,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<28.648031,-1.535000,25.400000>}
box{<0,0,-0.127000><1.416063,0.035000,0.127000> rotate<0,0.000000,0> translate<27.231969,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.270441,-1.535000,18.796000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<28.394031,-1.535000,18.796000>}
box{<0,0,-0.127000><1.123591,0.035000,0.127000> rotate<0,0.000000,0> translate<27.270441,-1.535000,18.796000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.270441,-1.535000,25.146000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<28.394031,-1.535000,25.146000>}
box{<0,0,-0.127000><1.123591,0.035000,0.127000> rotate<0,0.000000,0> translate<27.270441,-1.535000,25.146000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.270444,-1.535000,23.114000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<28.394028,-1.535000,23.114000>}
box{<0,0,-0.127000><1.123584,0.035000,0.127000> rotate<0,0.000000,0> translate<27.270444,-1.535000,23.114000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.485966,-1.535000,21.336000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<28.394034,-1.535000,21.336000>}
box{<0,0,-0.127000><0.908069,0.035000,0.127000> rotate<0,0.000000,0> translate<27.485966,-1.535000,21.336000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.485966,-1.535000,27.686000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<28.394034,-1.535000,27.686000>}
box{<0,0,-0.127000><0.908069,0.035000,0.127000> rotate<0,0.000000,0> translate<27.485966,-1.535000,27.686000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.485969,-1.535000,19.304000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<28.394031,-1.535000,19.304000>}
box{<0,0,-0.127000><0.908062,0.035000,0.127000> rotate<0,0.000000,0> translate<27.485969,-1.535000,19.304000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.485969,-1.535000,25.654000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<28.394031,-1.535000,25.654000>}
box{<0,0,-0.127000><0.908062,0.035000,0.127000> rotate<0,0.000000,0> translate<27.485969,-1.535000,25.654000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.524441,-1.535000,18.542000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<28.140031,-1.535000,18.542000>}
box{<0,0,-0.127000><0.615591,0.035000,0.127000> rotate<0,0.000000,0> translate<27.524441,-1.535000,18.542000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.524441,-1.535000,24.892000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<28.140031,-1.535000,24.892000>}
box{<0,0,-0.127000><0.615591,0.035000,0.127000> rotate<0,0.000000,0> translate<27.524441,-1.535000,24.892000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.524444,-1.535000,23.368000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<28.140028,-1.535000,23.368000>}
box{<0,0,-0.127000><0.615584,0.035000,0.127000> rotate<0,0.000000,0> translate<27.524444,-1.535000,23.368000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.676838,-1.535000,17.170397>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.812997,-1.535000,17.306553>}
box{<0,0,-0.127000><0.192556,0.035000,0.127000> rotate<0,-44.996373,0> translate<27.676838,-1.535000,17.170397> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.676838,-1.535000,17.170397>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.987634,-1.535000,17.170397>}
box{<0,0,-0.127000><0.310797,0.035000,0.127000> rotate<0,0.000000,0> translate<27.676838,-1.535000,17.170397> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.739966,-1.535000,21.082000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<28.140034,-1.535000,21.082000>}
box{<0,0,-0.127000><0.400069,0.035000,0.127000> rotate<0,0.000000,0> translate<27.739966,-1.535000,21.082000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.739966,-1.535000,27.432000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<28.140034,-1.535000,27.432000>}
box{<0,0,-0.127000><0.400069,0.035000,0.127000> rotate<0,0.000000,0> translate<27.739966,-1.535000,27.432000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.739969,-1.535000,19.558000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<28.140031,-1.535000,19.558000>}
box{<0,0,-0.127000><0.400062,0.035000,0.127000> rotate<0,0.000000,0> translate<27.739969,-1.535000,19.558000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.739969,-1.535000,25.908000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<28.140031,-1.535000,25.908000>}
box{<0,0,-0.127000><0.400062,0.035000,0.127000> rotate<0,0.000000,0> translate<27.739969,-1.535000,25.908000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.778441,-1.535000,17.272000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.914600,-1.535000,17.272000>}
box{<0,0,-0.127000><0.136159,0.035000,0.127000> rotate<0,0.000000,0> translate<27.778441,-1.535000,17.272000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.778441,-1.535000,18.288000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.914600,-1.535000,18.288000>}
box{<0,0,-0.127000><0.136159,0.035000,0.127000> rotate<0,0.000000,0> translate<27.778441,-1.535000,18.288000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.778441,-1.535000,24.638000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.914600,-1.535000,24.638000>}
box{<0,0,-0.127000><0.136159,0.035000,0.127000> rotate<0,0.000000,0> translate<27.778441,-1.535000,24.638000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.778444,-1.535000,23.622000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.914600,-1.535000,23.622000>}
box{<0,0,-0.127000><0.136156,0.035000,0.127000> rotate<0,0.000000,0> translate<27.778444,-1.535000,23.622000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.812997,-1.535000,17.306553>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.812997,-1.535000,17.653000>}
box{<0,0,-0.127000><0.346447,0.035000,0.127000> rotate<0,90.000000,0> translate<27.812997,-1.535000,17.653000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.812997,-1.535000,17.526000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.914600,-1.535000,17.526000>}
box{<0,0,-0.127000><0.101603,0.035000,0.127000> rotate<0,0.000000,0> translate<27.812997,-1.535000,17.526000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.812997,-1.535000,17.906994>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.812997,-1.535000,18.253444>}
box{<0,0,-0.127000><0.346450,0.035000,0.127000> rotate<0,90.000000,0> translate<27.812997,-1.535000,18.253444> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.812997,-1.535000,18.034000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.914600,-1.535000,18.034000>}
box{<0,0,-0.127000><0.101603,0.035000,0.127000> rotate<0,0.000000,0> translate<27.812997,-1.535000,18.034000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.812997,-1.535000,23.656553>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.812997,-1.535000,24.003000>}
box{<0,0,-0.127000><0.346447,0.035000,0.127000> rotate<0,90.000000,0> translate<27.812997,-1.535000,24.003000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.812997,-1.535000,23.876000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.914600,-1.535000,23.876000>}
box{<0,0,-0.127000><0.101603,0.035000,0.127000> rotate<0,0.000000,0> translate<27.812997,-1.535000,23.876000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.812997,-1.535000,24.256994>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.812997,-1.535000,24.603444>}
box{<0,0,-0.127000><0.346450,0.035000,0.127000> rotate<0,90.000000,0> translate<27.812997,-1.535000,24.603444> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.812997,-1.535000,24.384000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.914600,-1.535000,24.384000>}
box{<0,0,-0.127000><0.101603,0.035000,0.127000> rotate<0,0.000000,0> translate<27.812997,-1.535000,24.384000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.914600,-1.535000,17.243428>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.987634,-1.535000,17.170397>}
box{<0,0,-0.127000><0.103284,0.035000,0.127000> rotate<0,44.995804,0> translate<27.914600,-1.535000,17.243428> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.914600,-1.535000,18.316569>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.914600,-1.535000,17.243428>}
box{<0,0,-0.127000><1.073141,0.035000,0.127000> rotate<0,-90.000000,0> translate<27.914600,-1.535000,17.243428> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.914600,-1.535000,18.316569>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<28.648031,-1.535000,19.050000>}
box{<0,0,-0.127000><1.037228,0.035000,0.127000> rotate<0,-44.997030,0> translate<27.914600,-1.535000,18.316569> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.914600,-1.535000,23.593428>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<28.673428,-1.535000,22.834600>}
box{<0,0,-0.127000><1.073145,0.035000,0.127000> rotate<0,44.997030,0> translate<27.914600,-1.535000,23.593428> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.914600,-1.535000,24.666569>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.914600,-1.535000,23.593428>}
box{<0,0,-0.127000><1.073141,0.035000,0.127000> rotate<0,-90.000000,0> translate<27.914600,-1.535000,23.593428> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.914600,-1.535000,24.666569>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<28.648031,-1.535000,25.400000>}
box{<0,0,-0.127000><1.037228,0.035000,0.127000> rotate<0,-44.997030,0> translate<27.914600,-1.535000,24.666569> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.940000,-1.535000,19.758031>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<28.648031,-1.535000,19.050000>}
box{<0,0,-0.127000><1.001307,0.035000,0.127000> rotate<0,44.997030,0> translate<27.940000,-1.535000,19.758031> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.940000,-1.535000,20.881966>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<28.673428,-1.535000,21.615397>}
box{<0,0,-0.127000><1.037226,0.035000,0.127000> rotate<0,-44.997152,0> translate<27.940000,-1.535000,20.881966> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.940000,-1.535000,26.108031>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<28.648031,-1.535000,25.400000>}
box{<0,0,-0.127000><1.001307,0.035000,0.127000> rotate<0,44.997030,0> translate<27.940000,-1.535000,26.108031> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.940000,-1.535000,27.231966>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<28.673428,-1.535000,27.965397>}
box{<0,0,-0.127000><1.037226,0.035000,0.127000> rotate<0,-44.997152,0> translate<27.940000,-1.535000,27.231966> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<28.673428,-1.535000,21.615397>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<29.746569,-1.535000,21.615397>}
box{<0,0,-0.127000><1.073141,0.035000,0.127000> rotate<0,0.000000,0> translate<28.673428,-1.535000,21.615397> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<28.673428,-1.535000,22.834600>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<29.746569,-1.535000,22.834600>}
box{<0,0,-0.127000><1.073141,0.035000,0.127000> rotate<0,0.000000,0> translate<28.673428,-1.535000,22.834600> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<28.673428,-1.535000,27.965397>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<29.746569,-1.535000,27.965397>}
box{<0,0,-0.127000><1.073141,0.035000,0.127000> rotate<0,0.000000,0> translate<28.673428,-1.535000,27.965397> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<29.494200,-1.535000,8.693909>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<29.644278,-1.535000,8.331588>}
box{<0,0,-0.127000><0.392174,0.035000,0.127000> rotate<0,67.495614,0> translate<29.494200,-1.535000,8.693909> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<29.494200,-1.535000,9.086087>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<29.494200,-1.535000,8.693909>}
box{<0,0,-0.127000><0.392178,0.035000,0.127000> rotate<0,-90.000000,0> translate<29.494200,-1.535000,8.693909> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<29.494200,-1.535000,9.086087>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<29.644278,-1.535000,9.448409>}
box{<0,0,-0.127000><0.392174,0.035000,0.127000> rotate<0,-67.495614,0> translate<29.494200,-1.535000,9.086087> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<29.644278,-1.535000,8.331588>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<29.921588,-1.535000,8.054278>}
box{<0,0,-0.127000><0.392175,0.035000,0.127000> rotate<0,44.997030,0> translate<29.644278,-1.535000,8.331588> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<29.644278,-1.535000,9.448409>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<29.921588,-1.535000,9.725719>}
box{<0,0,-0.127000><0.392175,0.035000,0.127000> rotate<0,-44.997030,0> translate<29.644278,-1.535000,9.448409> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<29.746569,-1.535000,21.615397>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<30.480000,-1.535000,20.881966>}
box{<0,0,-0.127000><1.037228,0.035000,0.127000> rotate<0,44.997030,0> translate<29.746569,-1.535000,21.615397> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<29.746569,-1.535000,22.834600>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<30.480000,-1.535000,23.568031>}
box{<0,0,-0.127000><1.037228,0.035000,0.127000> rotate<0,-44.997030,0> translate<29.746569,-1.535000,22.834600> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<29.746569,-1.535000,27.965397>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<30.480000,-1.535000,27.231966>}
box{<0,0,-0.127000><1.037228,0.035000,0.127000> rotate<0,44.997030,0> translate<29.746569,-1.535000,27.965397> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<29.771966,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<31.188034,-1.535000,21.590000>}
box{<0,0,-0.127000><1.416069,0.035000,0.127000> rotate<0,0.000000,0> translate<29.771966,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<29.771966,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<31.188034,-1.535000,27.940000>}
box{<0,0,-0.127000><1.416069,0.035000,0.127000> rotate<0,0.000000,0> translate<29.771966,-1.535000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<29.771969,-1.535000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<31.188028,-1.535000,22.860000>}
box{<0,0,-0.127000><1.416059,0.035000,0.127000> rotate<0,0.000000,0> translate<29.771969,-1.535000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<29.921588,-1.535000,8.054278>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<30.283909,-1.535000,7.904200>}
box{<0,0,-0.127000><0.392174,0.035000,0.127000> rotate<0,22.498446,0> translate<29.921588,-1.535000,8.054278> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<29.921588,-1.535000,9.725719>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<30.283909,-1.535000,9.875797>}
box{<0,0,-0.127000><0.392174,0.035000,0.127000> rotate<0,-22.498446,0> translate<29.921588,-1.535000,9.725719> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<30.025966,-1.535000,21.336000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<30.934034,-1.535000,21.336000>}
box{<0,0,-0.127000><0.908069,0.035000,0.127000> rotate<0,0.000000,0> translate<30.025966,-1.535000,21.336000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<30.025966,-1.535000,27.686000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<30.934034,-1.535000,27.686000>}
box{<0,0,-0.127000><0.908069,0.035000,0.127000> rotate<0,0.000000,0> translate<30.025966,-1.535000,27.686000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<30.025969,-1.535000,23.114000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<30.934028,-1.535000,23.114000>}
box{<0,0,-0.127000><0.908059,0.035000,0.127000> rotate<0,0.000000,0> translate<30.025969,-1.535000,23.114000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<30.279966,-1.535000,21.082000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<30.680034,-1.535000,21.082000>}
box{<0,0,-0.127000><0.400069,0.035000,0.127000> rotate<0,0.000000,0> translate<30.279966,-1.535000,21.082000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<30.279966,-1.535000,27.432000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<30.680034,-1.535000,27.432000>}
box{<0,0,-0.127000><0.400069,0.035000,0.127000> rotate<0,0.000000,0> translate<30.279966,-1.535000,27.432000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<30.279969,-1.535000,23.368000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<30.680028,-1.535000,23.368000>}
box{<0,0,-0.127000><0.400059,0.035000,0.127000> rotate<0,0.000000,0> translate<30.279969,-1.535000,23.368000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<30.283909,-1.535000,7.904200>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<30.676088,-1.535000,7.904200>}
box{<0,0,-0.127000><0.392178,0.035000,0.127000> rotate<0,0.000000,0> translate<30.283909,-1.535000,7.904200> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<30.283909,-1.535000,9.875797>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<30.676088,-1.535000,9.875797>}
box{<0,0,-0.127000><0.392178,0.035000,0.127000> rotate<0,0.000000,0> translate<30.283909,-1.535000,9.875797> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<30.480000,-1.535000,20.881966>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<31.213428,-1.535000,21.615397>}
box{<0,0,-0.127000><1.037226,0.035000,0.127000> rotate<0,-44.997152,0> translate<30.480000,-1.535000,20.881966> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<30.480000,-1.535000,23.568031>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<31.213428,-1.535000,22.834600>}
box{<0,0,-0.127000><1.037226,0.035000,0.127000> rotate<0,44.997152,0> translate<30.480000,-1.535000,23.568031> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<30.480000,-1.535000,27.231966>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<31.213428,-1.535000,27.965397>}
box{<0,0,-0.127000><1.037226,0.035000,0.127000> rotate<0,-44.997152,0> translate<30.480000,-1.535000,27.231966> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<30.676088,-1.535000,7.904200>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<31.038409,-1.535000,8.054278>}
box{<0,0,-0.127000><0.392174,0.035000,0.127000> rotate<0,-22.498446,0> translate<30.676088,-1.535000,7.904200> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<30.676088,-1.535000,9.875797>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<31.038409,-1.535000,9.725719>}
box{<0,0,-0.127000><0.392174,0.035000,0.127000> rotate<0,22.498446,0> translate<30.676088,-1.535000,9.875797> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<31.038409,-1.535000,8.054278>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<31.213731,-1.535000,8.229600>}
box{<0,0,-0.127000><0.247943,0.035000,0.127000> rotate<0,-44.997030,0> translate<31.038409,-1.535000,8.054278> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<31.038409,-1.535000,9.725719>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<31.213731,-1.535000,9.550397>}
box{<0,0,-0.127000><0.247943,0.035000,0.127000> rotate<0,44.997030,0> translate<31.038409,-1.535000,9.725719> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<31.112128,-1.535000,9.652000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.118059,-1.535000,9.652000>}
box{<0,0,-0.127000><3.005931,0.035000,0.127000> rotate<0,0.000000,0> translate<31.112128,-1.535000,9.652000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<31.112131,-1.535000,8.128000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.124022,-1.535000,8.128000>}
box{<0,0,-0.127000><9.011891,0.035000,0.127000> rotate<0,0.000000,0> translate<31.112131,-1.535000,8.128000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<31.213428,-1.535000,21.615397>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<32.286569,-1.535000,21.615397>}
box{<0,0,-0.127000><1.073141,0.035000,0.127000> rotate<0,0.000000,0> translate<31.213428,-1.535000,21.615397> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<31.213428,-1.535000,22.834600>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<32.286569,-1.535000,22.834600>}
box{<0,0,-0.127000><1.073141,0.035000,0.127000> rotate<0,0.000000,0> translate<31.213428,-1.535000,22.834600> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<31.213428,-1.535000,27.965397>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<32.286569,-1.535000,27.965397>}
box{<0,0,-0.127000><1.073141,0.035000,0.127000> rotate<0,0.000000,0> translate<31.213428,-1.535000,27.965397> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<31.213731,-1.535000,8.229600>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.421363,-1.535000,8.229600>}
box{<0,0,-0.127000><3.207631,0.035000,0.127000> rotate<0,0.000000,0> translate<31.213731,-1.535000,8.229600> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<31.213731,-1.535000,9.550397>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.016456,-1.535000,9.550397>}
box{<0,0,-0.127000><2.802725,0.035000,0.127000> rotate<0,0.000000,0> translate<31.213731,-1.535000,9.550397> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<32.286266,-1.535000,3.149600>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<32.461588,-1.535000,2.974278>}
box{<0,0,-0.127000><0.247943,0.035000,0.127000> rotate<0,44.997030,0> translate<32.286266,-1.535000,3.149600> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<32.286266,-1.535000,4.470397>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<32.461588,-1.535000,4.645719>}
box{<0,0,-0.127000><0.247943,0.035000,0.127000> rotate<0,-44.997030,0> translate<32.286266,-1.535000,4.470397> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<32.286569,-1.535000,21.615397>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<32.921566,-1.535000,20.980397>}
box{<0,0,-0.127000><0.898023,0.035000,0.127000> rotate<0,44.997171,0> translate<32.286569,-1.535000,21.615397> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<32.286569,-1.535000,22.834600>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.045397,-1.535000,23.593428>}
box{<0,0,-0.127000><1.073145,0.035000,0.127000> rotate<0,-44.997030,0> translate<32.286569,-1.535000,22.834600> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<32.286569,-1.535000,27.965397>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.045397,-1.535000,27.206569>}
box{<0,0,-0.127000><1.073145,0.035000,0.127000> rotate<0,44.997030,0> translate<32.286569,-1.535000,27.965397> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<32.311966,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.205878,-1.535000,21.590000>}
box{<0,0,-0.127000><0.893912,0.035000,0.127000> rotate<0,0.000000,0> translate<32.311966,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<32.311966,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.045397,-1.535000,24.666569>}
box{<0,0,-0.127000><1.037228,0.035000,0.127000> rotate<0,44.997030,0> translate<32.311966,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<32.311966,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.045397,-1.535000,26.133428>}
box{<0,0,-0.127000><1.037226,0.035000,0.127000> rotate<0,-44.996908,0> translate<32.311966,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<32.311966,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.205881,-1.535000,25.400000>}
box{<0,0,-0.127000><0.893916,0.035000,0.127000> rotate<0,0.000000,0> translate<32.311966,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<32.311966,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.432919,-1.535000,27.940000>}
box{<0,0,-0.127000><9.120953,0.035000,0.127000> rotate<0,0.000000,0> translate<32.311966,-1.535000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<32.311969,-1.535000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.205881,-1.535000,22.860000>}
box{<0,0,-0.127000><0.893913,0.035000,0.127000> rotate<0,0.000000,0> translate<32.311969,-1.535000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<32.461588,-1.535000,2.974278>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<32.823909,-1.535000,2.824200>}
box{<0,0,-0.127000><0.392174,0.035000,0.127000> rotate<0,22.498446,0> translate<32.461588,-1.535000,2.974278> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<32.461588,-1.535000,4.645719>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<32.823909,-1.535000,4.795797>}
box{<0,0,-0.127000><0.392174,0.035000,0.127000> rotate<0,-22.498446,0> translate<32.461588,-1.535000,4.645719> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<32.565966,-1.535000,21.336000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.418869,-1.535000,21.336000>}
box{<0,0,-0.127000><0.852903,0.035000,0.127000> rotate<0,0.000000,0> translate<32.565966,-1.535000,21.336000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<32.565966,-1.535000,25.146000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.100672,-1.535000,25.146000>}
box{<0,0,-0.127000><0.534706,0.035000,0.127000> rotate<0,0.000000,0> translate<32.565966,-1.535000,25.146000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<32.565966,-1.535000,25.654000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.418872,-1.535000,25.654000>}
box{<0,0,-0.127000><0.852906,0.035000,0.127000> rotate<0,0.000000,0> translate<32.565966,-1.535000,25.654000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<32.565966,-1.535000,27.686000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.291669,-1.535000,27.686000>}
box{<0,0,-0.127000><8.725703,0.035000,0.127000> rotate<0,0.000000,0> translate<32.565966,-1.535000,27.686000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<32.565969,-1.535000,23.114000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.418872,-1.535000,23.114000>}
box{<0,0,-0.127000><0.852903,0.035000,0.127000> rotate<0,0.000000,0> translate<32.565969,-1.535000,23.114000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<32.819966,-1.535000,21.082000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.797147,-1.535000,21.082000>}
box{<0,0,-0.127000><0.977181,0.035000,0.127000> rotate<0,0.000000,0> translate<32.819966,-1.535000,21.082000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<32.819966,-1.535000,24.892000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.045400,-1.535000,24.892000>}
box{<0,0,-0.127000><0.225434,0.035000,0.127000> rotate<0,0.000000,0> translate<32.819966,-1.535000,24.892000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<32.819966,-1.535000,25.908000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.797156,-1.535000,25.908000>}
box{<0,0,-0.127000><0.977191,0.035000,0.127000> rotate<0,0.000000,0> translate<32.819966,-1.535000,25.908000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<32.819966,-1.535000,27.432000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.186456,-1.535000,27.432000>}
box{<0,0,-0.127000><8.366491,0.035000,0.127000> rotate<0,0.000000,0> translate<32.819966,-1.535000,27.432000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<32.819969,-1.535000,23.368000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.797156,-1.535000,23.368000>}
box{<0,0,-0.127000><0.977187,0.035000,0.127000> rotate<0,0.000000,0> translate<32.819969,-1.535000,23.368000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<32.823909,-1.535000,2.824200>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.216088,-1.535000,2.824200>}
box{<0,0,-0.127000><0.392178,0.035000,0.127000> rotate<0,0.000000,0> translate<32.823909,-1.535000,2.824200> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<32.823909,-1.535000,4.795797>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.216088,-1.535000,4.795797>}
box{<0,0,-0.127000><0.392178,0.035000,0.127000> rotate<0,0.000000,0> translate<32.823909,-1.535000,4.795797> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<32.921566,-1.535000,20.980397>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.151363,-1.535000,20.980397>}
box{<0,0,-0.127000><0.229797,0.035000,0.127000> rotate<0,0.000000,0> translate<32.921566,-1.535000,20.980397> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<32.994600,-1.535000,0.250325>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.191813,-1.535000,-0.225784>}
box{<0,0,-0.127000><0.515338,0.035000,0.127000> rotate<0,67.495387,0> translate<32.994600,-1.535000,0.250325> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<32.994600,-1.535000,2.289672>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<32.994600,-1.535000,0.250325>}
box{<0,0,-0.127000><2.039347,0.035000,0.127000> rotate<0,-90.000000,0> translate<32.994600,-1.535000,0.250325> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<32.994600,-1.535000,2.289672>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.191813,-1.535000,2.765784>}
box{<0,0,-0.127000><0.515341,0.035000,0.127000> rotate<0,-67.495520,0> translate<32.994600,-1.535000,2.289672> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.045397,-1.535000,23.593428>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.045397,-1.535000,24.666569>}
box{<0,0,-0.127000><1.073141,0.035000,0.127000> rotate<0,90.000000,0> translate<33.045397,-1.535000,24.666569> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.045397,-1.535000,23.622000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.797147,-1.535000,23.622000>}
box{<0,0,-0.127000><0.751750,0.035000,0.127000> rotate<0,0.000000,0> translate<33.045397,-1.535000,23.622000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.045397,-1.535000,23.876000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.418869,-1.535000,23.876000>}
box{<0,0,-0.127000><0.373472,0.035000,0.127000> rotate<0,0.000000,0> translate<33.045397,-1.535000,23.876000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.045397,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.205878,-1.535000,24.130000>}
box{<0,0,-0.127000><0.160481,0.035000,0.127000> rotate<0,0.000000,0> translate<33.045397,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.045397,-1.535000,24.384000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.100669,-1.535000,24.384000>}
box{<0,0,-0.127000><0.055272,0.035000,0.127000> rotate<0,0.000000,0> translate<33.045397,-1.535000,24.384000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.045397,-1.535000,24.638000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.045400,-1.535000,24.638000>}
box{<0,0,-0.127000><0.000003,0.035000,0.127000> rotate<0,0.000000,0> translate<33.045397,-1.535000,24.638000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.045397,-1.535000,26.133428>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.045397,-1.535000,27.206569>}
box{<0,0,-0.127000><1.073141,0.035000,0.127000> rotate<0,90.000000,0> translate<33.045397,-1.535000,27.206569> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.045397,-1.535000,26.162000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.081244,-1.535000,26.162000>}
box{<0,0,-0.127000><8.035847,0.035000,0.127000> rotate<0,0.000000,0> translate<33.045397,-1.535000,26.162000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.045397,-1.535000,26.416000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.046600,-1.535000,26.416000>}
box{<0,0,-0.127000><8.001203,0.035000,0.127000> rotate<0,0.000000,0> translate<33.045397,-1.535000,26.416000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.045397,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.046600,-1.535000,26.670000>}
box{<0,0,-0.127000><8.001203,0.035000,0.127000> rotate<0,0.000000,0> translate<33.045397,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.045397,-1.535000,26.924000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.046600,-1.535000,26.924000>}
box{<0,0,-0.127000><8.001203,0.035000,0.127000> rotate<0,0.000000,0> translate<33.045397,-1.535000,26.924000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.045397,-1.535000,27.178000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.081247,-1.535000,27.178000>}
box{<0,0,-0.127000><8.035850,0.035000,0.127000> rotate<0,0.000000,0> translate<33.045397,-1.535000,27.178000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.045400,-1.535000,21.977431>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.234878,-1.535000,21.519991>}
box{<0,0,-0.127000><0.495130,0.035000,0.127000> rotate<0,67.495544,0> translate<33.045400,-1.535000,21.977431> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.045400,-1.535000,22.472566>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.045400,-1.535000,21.977431>}
box{<0,0,-0.127000><0.495134,0.035000,0.127000> rotate<0,-90.000000,0> translate<33.045400,-1.535000,21.977431> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.045400,-1.535000,22.472566>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.234878,-1.535000,22.930006>}
box{<0,0,-0.127000><0.495130,0.035000,0.127000> rotate<0,-67.495544,0> translate<33.045400,-1.535000,22.472566> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.045400,-1.535000,24.517431>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.234878,-1.535000,24.059991>}
box{<0,0,-0.127000><0.495130,0.035000,0.127000> rotate<0,67.495544,0> translate<33.045400,-1.535000,24.517431> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.045400,-1.535000,25.012566>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.045400,-1.535000,24.517431>}
box{<0,0,-0.127000><0.495134,0.035000,0.127000> rotate<0,-90.000000,0> translate<33.045400,-1.535000,24.517431> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.045400,-1.535000,25.012566>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.234878,-1.535000,25.470006>}
box{<0,0,-0.127000><0.495130,0.035000,0.127000> rotate<0,-67.495544,0> translate<33.045400,-1.535000,25.012566> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.151363,-1.535000,20.980397>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.394084,-1.535000,20.879856>}
box{<0,0,-0.127000><0.262721,0.035000,0.127000> rotate<0,22.498904,0> translate<33.151363,-1.535000,20.980397> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.191813,-1.535000,-0.225784>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.556213,-1.535000,-0.590184>}
box{<0,0,-0.127000><0.515339,0.035000,0.127000> rotate<0,44.997030,0> translate<33.191813,-1.535000,-0.225784> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.191813,-1.535000,2.765784>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.274375,-1.535000,2.848344>}
box{<0,0,-0.127000><0.116759,0.035000,0.127000> rotate<0,-44.995946,0> translate<33.191813,-1.535000,2.765784> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.216088,-1.535000,2.824200>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.274375,-1.535000,2.848344>}
box{<0,0,-0.127000><0.063090,0.035000,0.127000> rotate<0,-22.498747,0> translate<33.216088,-1.535000,2.824200> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.216088,-1.535000,4.795797>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.578409,-1.535000,4.645719>}
box{<0,0,-0.127000><0.392174,0.035000,0.127000> rotate<0,22.498446,0> translate<33.216088,-1.535000,4.795797> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.234878,-1.535000,21.519991>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.584991,-1.535000,21.169878>}
box{<0,0,-0.127000><0.495134,0.035000,0.127000> rotate<0,44.997030,0> translate<33.234878,-1.535000,21.519991> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.234878,-1.535000,22.930006>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.584991,-1.535000,23.280119>}
box{<0,0,-0.127000><0.495134,0.035000,0.127000> rotate<0,-44.997030,0> translate<33.234878,-1.535000,22.930006> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.234878,-1.535000,24.059991>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.584991,-1.535000,23.709878>}
box{<0,0,-0.127000><0.495134,0.035000,0.127000> rotate<0,44.997030,0> translate<33.234878,-1.535000,24.059991> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.234878,-1.535000,25.470006>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.584991,-1.535000,25.820119>}
box{<0,0,-0.127000><0.495134,0.035000,0.127000> rotate<0,-44.997030,0> translate<33.234878,-1.535000,25.470006> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.304200,-1.535000,13.773909>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.454278,-1.535000,13.411588>}
box{<0,0,-0.127000><0.392174,0.035000,0.127000> rotate<0,67.495614,0> translate<33.304200,-1.535000,13.773909> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.304200,-1.535000,14.166088>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.304200,-1.535000,13.773909>}
box{<0,0,-0.127000><0.392178,0.035000,0.127000> rotate<0,-90.000000,0> translate<33.304200,-1.535000,13.773909> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.304200,-1.535000,14.166088>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.454278,-1.535000,14.528409>}
box{<0,0,-0.127000><0.392174,0.035000,0.127000> rotate<0,-67.495614,0> translate<33.304200,-1.535000,14.166088> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.394084,-1.535000,20.879856>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.664084,-1.535000,19.609856>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,44.997030,0> translate<33.394084,-1.535000,20.879856> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.445941,-1.535000,20.828000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.585400,-1.535000,20.828000>}
box{<0,0,-0.127000><2.139459,0.035000,0.127000> rotate<0,0.000000,0> translate<33.445941,-1.535000,20.828000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.454278,-1.535000,13.411588>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.731588,-1.535000,13.134278>}
box{<0,0,-0.127000><0.392175,0.035000,0.127000> rotate<0,44.997030,0> translate<33.454278,-1.535000,13.411588> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.454278,-1.535000,14.528409>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.505472,-1.535000,14.579600>}
box{<0,0,-0.127000><0.072397,0.035000,0.127000> rotate<0,-44.995281,0> translate<33.454278,-1.535000,14.528409> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.556213,-1.535000,-0.590184>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.909697,-1.535000,-0.736600>}
box{<0,0,-0.127000><0.382608,0.035000,0.127000> rotate<0,22.498183,0> translate<33.556213,-1.535000,-0.590184> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.578409,-1.535000,4.645719>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.855719,-1.535000,4.368409>}
box{<0,0,-0.127000><0.392175,0.035000,0.127000> rotate<0,44.997030,0> translate<33.578409,-1.535000,4.645719> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.584991,-1.535000,21.169878>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.042431,-1.535000,20.980400>}
box{<0,0,-0.127000><0.495130,0.035000,0.127000> rotate<0,22.498517,0> translate<33.584991,-1.535000,21.169878> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.584991,-1.535000,23.280119>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.042431,-1.535000,23.469597>}
box{<0,0,-0.127000><0.495130,0.035000,0.127000> rotate<0,-22.498517,0> translate<33.584991,-1.535000,23.280119> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.584991,-1.535000,23.709878>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.042431,-1.535000,23.520400>}
box{<0,0,-0.127000><0.495130,0.035000,0.127000> rotate<0,22.498517,0> translate<33.584991,-1.535000,23.709878> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.584991,-1.535000,25.820119>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.042431,-1.535000,26.009597>}
box{<0,0,-0.127000><0.495130,0.035000,0.127000> rotate<0,-22.498517,0> translate<33.584991,-1.535000,25.820119> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.652128,-1.535000,4.572000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.738056,-1.535000,4.572000>}
box{<0,0,-0.127000><8.085928,0.035000,0.127000> rotate<0,0.000000,0> translate<33.652128,-1.535000,4.572000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.699941,-1.535000,20.574000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.640669,-1.535000,20.574000>}
box{<0,0,-0.127000><1.940728,0.035000,0.127000> rotate<0,0.000000,0> translate<33.699941,-1.535000,20.574000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.731588,-1.535000,13.134278>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.093909,-1.535000,12.984200>}
box{<0,0,-0.127000><0.392174,0.035000,0.127000> rotate<0,22.498446,0> translate<33.731588,-1.535000,13.134278> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.855719,-1.535000,4.368409>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.005797,-1.535000,4.006088>}
box{<0,0,-0.127000><0.392174,0.035000,0.127000> rotate<0,67.495614,0> translate<33.855719,-1.535000,4.368409> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.857044,-1.535000,3.254791>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.005797,-1.535000,3.613909>}
box{<0,0,-0.127000><0.388708,0.035000,0.127000> rotate<0,-67.495373,0> translate<33.857044,-1.535000,3.254791> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.857044,-1.535000,3.254791>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.032325,-1.535000,3.327397>}
box{<0,0,-0.127000><0.189724,0.035000,0.127000> rotate<0,-22.499179,0> translate<33.857044,-1.535000,3.254791> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.876597,-1.535000,3.302000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.971016,-1.535000,3.302000>}
box{<0,0,-0.127000><0.094419,0.035000,0.127000> rotate<0,0.000000,0> translate<33.876597,-1.535000,3.302000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.876600,-1.535000,4.318000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.134056,-1.535000,4.318000>}
box{<0,0,-0.127000><1.257456,0.035000,0.127000> rotate<0,0.000000,0> translate<33.876600,-1.535000,4.318000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.953941,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.745878,-1.535000,20.320000>}
box{<0,0,-0.127000><1.791938,0.035000,0.127000> rotate<0,0.000000,0> translate<33.953941,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.981809,-1.535000,3.556000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.372056,-1.535000,3.556000>}
box{<0,0,-0.127000><0.390247,0.035000,0.127000> rotate<0,0.000000,0> translate<33.981809,-1.535000,3.556000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.981809,-1.535000,4.064000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.880056,-1.535000,4.064000>}
box{<0,0,-0.127000><0.898247,0.035000,0.127000> rotate<0,0.000000,0> translate<33.981809,-1.535000,4.064000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.005797,-1.535000,3.613909>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.005797,-1.535000,4.006088>}
box{<0,0,-0.127000><0.392178,0.035000,0.127000> rotate<0,90.000000,0> translate<34.005797,-1.535000,4.006088> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.005797,-1.535000,3.810000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.626056,-1.535000,3.810000>}
box{<0,0,-0.127000><0.620259,0.035000,0.127000> rotate<0,0.000000,0> translate<34.005797,-1.535000,3.810000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.016456,-1.535000,9.550397>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.899600,-1.535000,10.433544>}
box{<0,0,-0.127000><1.248956,0.035000,0.127000> rotate<0,-44.997132,0> translate<34.016456,-1.535000,9.550397> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.032325,-1.535000,3.327397>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.143453,-1.535000,3.327397>}
box{<0,0,-0.127000><0.111128,0.035000,0.127000> rotate<0,0.000000,0> translate<34.032325,-1.535000,3.327397> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.042431,-1.535000,20.980400>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.537566,-1.535000,20.980400>}
box{<0,0,-0.127000><0.495134,0.035000,0.127000> rotate<0,0.000000,0> translate<34.042431,-1.535000,20.980400> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.042431,-1.535000,23.469597>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.537566,-1.535000,23.469597>}
box{<0,0,-0.127000><0.495134,0.035000,0.127000> rotate<0,0.000000,0> translate<34.042431,-1.535000,23.469597> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.042431,-1.535000,23.520400>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.537566,-1.535000,23.520400>}
box{<0,0,-0.127000><0.495134,0.035000,0.127000> rotate<0,0.000000,0> translate<34.042431,-1.535000,23.520400> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.042431,-1.535000,26.009597>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.537566,-1.535000,26.009597>}
box{<0,0,-0.127000><0.495134,0.035000,0.127000> rotate<0,0.000000,0> translate<34.042431,-1.535000,26.009597> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.093909,-1.535000,12.984200>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.486088,-1.535000,12.984200>}
box{<0,0,-0.127000><0.392178,0.035000,0.127000> rotate<0,0.000000,0> translate<34.093909,-1.535000,12.984200> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.143453,-1.535000,3.327397>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.000141,-1.535000,4.184084>}
box{<0,0,-0.127000><1.211539,0.035000,0.127000> rotate<0,-44.997030,0> translate<34.143453,-1.535000,3.327397> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.207941,-1.535000,20.066000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.958869,-1.535000,20.066000>}
box{<0,0,-0.127000><1.750928,0.035000,0.127000> rotate<0,0.000000,0> translate<34.207941,-1.535000,20.066000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.421363,-1.535000,8.229600>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.664084,-1.535000,8.330141>}
box{<0,0,-0.127000><0.262721,0.035000,0.127000> rotate<0,-22.498904,0> translate<34.421363,-1.535000,8.229600> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.461941,-1.535000,19.812000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.337147,-1.535000,19.812000>}
box{<0,0,-0.127000><1.875206,0.035000,0.127000> rotate<0,0.000000,0> translate<34.461941,-1.535000,19.812000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.486088,-1.535000,12.984200>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.848409,-1.535000,13.134278>}
box{<0,0,-0.127000><0.392174,0.035000,0.127000> rotate<0,-22.498446,0> translate<34.486088,-1.535000,12.984200> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.537566,-1.535000,20.980400>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.995006,-1.535000,21.169878>}
box{<0,0,-0.127000><0.495130,0.035000,0.127000> rotate<0,-22.498517,0> translate<34.537566,-1.535000,20.980400> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.537566,-1.535000,23.469597>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.995006,-1.535000,23.280119>}
box{<0,0,-0.127000><0.495130,0.035000,0.127000> rotate<0,22.498517,0> translate<34.537566,-1.535000,23.469597> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.537566,-1.535000,23.520400>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.995006,-1.535000,23.709878>}
box{<0,0,-0.127000><0.495130,0.035000,0.127000> rotate<0,-22.498517,0> translate<34.537566,-1.535000,23.520400> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.537566,-1.535000,26.009597>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.995006,-1.535000,25.820119>}
box{<0,0,-0.127000><0.495130,0.035000,0.127000> rotate<0,22.498517,0> translate<34.537566,-1.535000,26.009597> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.664084,-1.535000,8.330141>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.849856,-1.535000,8.515913>}
box{<0,0,-0.127000><0.262721,0.035000,0.127000> rotate<0,-44.997030,0> translate<34.664084,-1.535000,8.330141> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.664084,-1.535000,19.609856>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.849856,-1.535000,19.424084>}
box{<0,0,-0.127000><0.262721,0.035000,0.127000> rotate<0,44.997030,0> translate<34.664084,-1.535000,19.609856> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.715941,-1.535000,19.558000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.081247,-1.535000,19.558000>}
box{<0,0,-0.127000><6.365306,0.035000,0.127000> rotate<0,0.000000,0> translate<34.715941,-1.535000,19.558000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.715944,-1.535000,8.382000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.293556,-1.535000,8.382000>}
box{<0,0,-0.127000><5.577613,0.035000,0.127000> rotate<0,0.000000,0> translate<34.715944,-1.535000,8.382000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.782844,-1.535000,23.368000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.585400,-1.535000,23.368000>}
box{<0,0,-0.127000><0.802556,0.035000,0.127000> rotate<0,0.000000,0> translate<34.782844,-1.535000,23.368000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.782844,-1.535000,25.908000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.186453,-1.535000,25.908000>}
box{<0,0,-0.127000><6.403609,0.035000,0.127000> rotate<0,0.000000,0> translate<34.782844,-1.535000,25.908000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.782847,-1.535000,21.082000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.585400,-1.535000,21.082000>}
box{<0,0,-0.127000><0.802553,0.035000,0.127000> rotate<0,0.000000,0> translate<34.782847,-1.535000,21.082000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.782847,-1.535000,23.622000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.585400,-1.535000,23.622000>}
box{<0,0,-0.127000><0.802553,0.035000,0.127000> rotate<0,0.000000,0> translate<34.782847,-1.535000,23.622000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.848409,-1.535000,13.134278>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.899600,-1.535000,13.185472>}
box{<0,0,-0.127000><0.072397,0.035000,0.127000> rotate<0,-44.998779,0> translate<34.848409,-1.535000,13.134278> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.849856,-1.535000,8.515913>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.849856,-1.535000,8.515916>}
box{<0,0,-0.127000><0.000003,0.035000,0.127000> rotate<0,90.000000,0> translate<34.849856,-1.535000,8.515916> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.849856,-1.535000,8.515916>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.119856,-1.535000,9.785913>}
box{<0,0,-0.127000><1.796049,0.035000,0.127000> rotate<0,-44.996960,0> translate<34.849856,-1.535000,8.515916> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.849856,-1.535000,19.424084>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.950397,-1.535000,19.181363>}
box{<0,0,-0.127000><0.262721,0.035000,0.127000> rotate<0,67.495156,0> translate<34.849856,-1.535000,19.424084> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.899600,-1.535000,13.185472>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.899600,-1.535000,10.433544>}
box{<0,0,-0.127000><2.751928,0.035000,0.127000> rotate<0,-90.000000,0> translate<34.899600,-1.535000,10.433544> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.899600,-1.535000,19.304000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.046600,-1.535000,19.304000>}
box{<0,0,-0.127000><6.147000,0.035000,0.127000> rotate<0,0.000000,0> translate<34.899600,-1.535000,19.304000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.950397,-1.535000,17.294525>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.950397,-1.535000,19.181363>}
box{<0,0,-0.127000><1.886838,0.035000,0.127000> rotate<0,90.000000,0> translate<34.950397,-1.535000,19.181363> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.950397,-1.535000,17.294525>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.001587,-1.535000,17.345719>}
box{<0,0,-0.127000><0.072397,0.035000,0.127000> rotate<0,-44.998779,0> translate<34.950397,-1.535000,17.294525> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.950397,-1.535000,17.526000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.686916,-1.535000,17.526000>}
box{<0,0,-0.127000><6.736519,0.035000,0.127000> rotate<0,0.000000,0> translate<34.950397,-1.535000,17.526000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.950397,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.432916,-1.535000,17.780000>}
box{<0,0,-0.127000><6.482519,0.035000,0.127000> rotate<0,0.000000,0> translate<34.950397,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.950397,-1.535000,18.034000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.291663,-1.535000,18.034000>}
box{<0,0,-0.127000><6.341266,0.035000,0.127000> rotate<0,0.000000,0> translate<34.950397,-1.535000,18.034000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.950397,-1.535000,18.288000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.186453,-1.535000,18.288000>}
box{<0,0,-0.127000><6.236056,0.035000,0.127000> rotate<0,0.000000,0> translate<34.950397,-1.535000,18.288000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.950397,-1.535000,18.542000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.081244,-1.535000,18.542000>}
box{<0,0,-0.127000><6.130847,0.035000,0.127000> rotate<0,0.000000,0> translate<34.950397,-1.535000,18.542000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.950397,-1.535000,18.796000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.046600,-1.535000,18.796000>}
box{<0,0,-0.127000><6.096203,0.035000,0.127000> rotate<0,0.000000,0> translate<34.950397,-1.535000,18.796000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.950397,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.046600,-1.535000,19.050000>}
box{<0,0,-0.127000><6.096203,0.035000,0.127000> rotate<0,0.000000,0> translate<34.950397,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.969941,-1.535000,8.636000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.624344,-1.535000,8.636000>}
box{<0,0,-0.127000><5.654403,0.035000,0.127000> rotate<0,0.000000,0> translate<34.969941,-1.535000,8.636000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.995006,-1.535000,21.169878>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.345119,-1.535000,21.519991>}
box{<0,0,-0.127000><0.495134,0.035000,0.127000> rotate<0,-44.997030,0> translate<34.995006,-1.535000,21.169878> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.995006,-1.535000,23.280119>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.345119,-1.535000,22.930006>}
box{<0,0,-0.127000><0.495134,0.035000,0.127000> rotate<0,44.997030,0> translate<34.995006,-1.535000,23.280119> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.995006,-1.535000,23.709878>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.345119,-1.535000,24.059991>}
box{<0,0,-0.127000><0.495134,0.035000,0.127000> rotate<0,-44.997030,0> translate<34.995006,-1.535000,23.709878> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.995006,-1.535000,25.820119>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.345119,-1.535000,25.470006>}
box{<0,0,-0.127000><0.495134,0.035000,0.127000> rotate<0,44.997030,0> translate<34.995006,-1.535000,25.820119> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.000141,-1.535000,4.184084>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.185913,-1.535000,4.369856>}
box{<0,0,-0.127000><0.262721,0.035000,0.127000> rotate<0,-44.997030,0> translate<35.000141,-1.535000,4.184084> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.001587,-1.535000,17.345719>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.363909,-1.535000,17.495797>}
box{<0,0,-0.127000><0.392174,0.035000,0.127000> rotate<0,-22.498446,0> translate<35.001587,-1.535000,17.345719> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.161125,-1.535000,23.114000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.640669,-1.535000,23.114000>}
box{<0,0,-0.127000><0.479544,0.035000,0.127000> rotate<0,0.000000,0> translate<35.161125,-1.535000,23.114000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.161125,-1.535000,25.654000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.291663,-1.535000,25.654000>}
box{<0,0,-0.127000><6.130538,0.035000,0.127000> rotate<0,0.000000,0> translate<35.161125,-1.535000,25.654000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.161128,-1.535000,21.336000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.640672,-1.535000,21.336000>}
box{<0,0,-0.127000><0.479544,0.035000,0.127000> rotate<0,0.000000,0> translate<35.161128,-1.535000,21.336000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.161128,-1.535000,23.876000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.640672,-1.535000,23.876000>}
box{<0,0,-0.127000><0.479544,0.035000,0.127000> rotate<0,0.000000,0> translate<35.161128,-1.535000,23.876000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.185913,-1.535000,4.369856>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.428634,-1.535000,4.470397>}
box{<0,0,-0.127000><0.262721,0.035000,0.127000> rotate<0,-22.498904,0> translate<35.185913,-1.535000,4.369856> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.223941,-1.535000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.829003,-1.535000,8.890000>}
box{<0,0,-0.127000><5.605062,0.035000,0.127000> rotate<0,0.000000,0> translate<35.223941,-1.535000,8.890000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.345119,-1.535000,21.519991>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.534597,-1.535000,21.977431>}
box{<0,0,-0.127000><0.495130,0.035000,0.127000> rotate<0,-67.495544,0> translate<35.345119,-1.535000,21.519991> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.345119,-1.535000,22.930006>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.534597,-1.535000,22.472566>}
box{<0,0,-0.127000><0.495130,0.035000,0.127000> rotate<0,67.495544,0> translate<35.345119,-1.535000,22.930006> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.345119,-1.535000,24.059991>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.534597,-1.535000,24.517431>}
box{<0,0,-0.127000><0.495130,0.035000,0.127000> rotate<0,-67.495544,0> translate<35.345119,-1.535000,24.059991> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.345119,-1.535000,25.470006>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.534597,-1.535000,25.012566>}
box{<0,0,-0.127000><0.495130,0.035000,0.127000> rotate<0,67.495544,0> translate<35.345119,-1.535000,25.470006> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.363909,-1.535000,17.495797>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.756087,-1.535000,17.495797>}
box{<0,0,-0.127000><0.392178,0.035000,0.127000> rotate<0,0.000000,0> translate<35.363909,-1.535000,17.495797> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.374116,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.745881,-1.535000,21.590000>}
box{<0,0,-0.127000><0.371766,0.035000,0.127000> rotate<0,0.000000,0> translate<35.374116,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.374116,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.745881,-1.535000,24.130000>}
box{<0,0,-0.127000><0.371766,0.035000,0.127000> rotate<0,0.000000,0> translate<35.374116,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.374119,-1.535000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.745878,-1.535000,22.860000>}
box{<0,0,-0.127000><0.371759,0.035000,0.127000> rotate<0,0.000000,0> translate<35.374119,-1.535000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.374119,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.432916,-1.535000,25.400000>}
box{<0,0,-0.127000><6.058797,0.035000,0.127000> rotate<0,0.000000,0> translate<35.374119,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.428634,-1.535000,4.470397>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.636453,-1.535000,4.470397>}
box{<0,0,-0.127000><6.207819,0.035000,0.127000> rotate<0,0.000000,0> translate<35.428634,-1.535000,4.470397> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.477941,-1.535000,9.144000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.332025,-1.535000,9.144000>}
box{<0,0,-0.127000><4.854084,0.035000,0.127000> rotate<0,0.000000,0> translate<35.477941,-1.535000,9.144000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.479325,-1.535000,21.844000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.958872,-1.535000,21.844000>}
box{<0,0,-0.127000><0.479547,0.035000,0.127000> rotate<0,0.000000,0> translate<35.479325,-1.535000,21.844000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.479325,-1.535000,24.384000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.958872,-1.535000,24.384000>}
box{<0,0,-0.127000><0.479547,0.035000,0.127000> rotate<0,0.000000,0> translate<35.479325,-1.535000,24.384000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.479328,-1.535000,22.606000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.958869,-1.535000,22.606000>}
box{<0,0,-0.127000><0.479541,0.035000,0.127000> rotate<0,0.000000,0> translate<35.479328,-1.535000,22.606000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.479328,-1.535000,25.146000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.686916,-1.535000,25.146000>}
box{<0,0,-0.127000><6.207588,0.035000,0.127000> rotate<0,0.000000,0> translate<35.479328,-1.535000,25.146000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.534597,-1.535000,21.977431>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.534597,-1.535000,22.472566>}
box{<0,0,-0.127000><0.495134,0.035000,0.127000> rotate<0,90.000000,0> translate<35.534597,-1.535000,22.472566> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.534597,-1.535000,22.098000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.337156,-1.535000,22.098000>}
box{<0,0,-0.127000><0.802559,0.035000,0.127000> rotate<0,0.000000,0> translate<35.534597,-1.535000,22.098000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.534597,-1.535000,22.352000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.337147,-1.535000,22.352000>}
box{<0,0,-0.127000><0.802550,0.035000,0.127000> rotate<0,0.000000,0> translate<35.534597,-1.535000,22.352000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.534597,-1.535000,24.517431>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.534597,-1.535000,25.012566>}
box{<0,0,-0.127000><0.495134,0.035000,0.127000> rotate<0,90.000000,0> translate<35.534597,-1.535000,25.012566> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.534597,-1.535000,24.638000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.337156,-1.535000,24.638000>}
box{<0,0,-0.127000><0.802559,0.035000,0.127000> rotate<0,0.000000,0> translate<35.534597,-1.535000,24.638000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.534597,-1.535000,24.892000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.940916,-1.535000,24.892000>}
box{<0,0,-0.127000><6.406319,0.035000,0.127000> rotate<0,0.000000,0> translate<35.534597,-1.535000,24.892000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.585400,-1.535000,20.707431>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.774878,-1.535000,20.249991>}
box{<0,0,-0.127000><0.495130,0.035000,0.127000> rotate<0,67.495544,0> translate<35.585400,-1.535000,20.707431> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.585400,-1.535000,21.202566>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.585400,-1.535000,20.707431>}
box{<0,0,-0.127000><0.495134,0.035000,0.127000> rotate<0,-90.000000,0> translate<35.585400,-1.535000,20.707431> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.585400,-1.535000,21.202566>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.774878,-1.535000,21.660006>}
box{<0,0,-0.127000><0.495130,0.035000,0.127000> rotate<0,-67.495544,0> translate<35.585400,-1.535000,21.202566> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.585400,-1.535000,23.247431>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.774878,-1.535000,22.789991>}
box{<0,0,-0.127000><0.495130,0.035000,0.127000> rotate<0,67.495544,0> translate<35.585400,-1.535000,23.247431> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.585400,-1.535000,23.742566>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.585400,-1.535000,23.247431>}
box{<0,0,-0.127000><0.495134,0.035000,0.127000> rotate<0,-90.000000,0> translate<35.585400,-1.535000,23.247431> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.585400,-1.535000,23.742566>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.774878,-1.535000,24.200006>}
box{<0,0,-0.127000><0.495130,0.035000,0.127000> rotate<0,-67.495544,0> translate<35.585400,-1.535000,23.742566> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.731941,-1.535000,9.398000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.078025,-1.535000,9.398000>}
box{<0,0,-0.127000><4.346084,0.035000,0.127000> rotate<0,0.000000,0> translate<35.731941,-1.535000,9.398000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.756087,-1.535000,17.495797>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.118409,-1.535000,17.345719>}
box{<0,0,-0.127000><0.392174,0.035000,0.127000> rotate<0,22.498446,0> translate<35.756087,-1.535000,17.495797> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.774878,-1.535000,20.249991>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.124991,-1.535000,19.899878>}
box{<0,0,-0.127000><0.495134,0.035000,0.127000> rotate<0,44.997030,0> translate<35.774878,-1.535000,20.249991> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.774878,-1.535000,21.660006>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.124991,-1.535000,22.010119>}
box{<0,0,-0.127000><0.495134,0.035000,0.127000> rotate<0,-44.997030,0> translate<35.774878,-1.535000,21.660006> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.774878,-1.535000,22.789991>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.124991,-1.535000,22.439878>}
box{<0,0,-0.127000><0.495134,0.035000,0.127000> rotate<0,44.997030,0> translate<35.774878,-1.535000,22.789991> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.774878,-1.535000,24.200006>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.124991,-1.535000,24.550119>}
box{<0,0,-0.127000><0.495134,0.035000,0.127000> rotate<0,-44.997030,0> translate<35.774878,-1.535000,24.200006> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.985941,-1.535000,9.652000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<39.956288,-1.535000,9.652000>}
box{<0,0,-0.127000><3.970347,0.035000,0.127000> rotate<0,0.000000,0> translate<35.985941,-1.535000,9.652000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.118409,-1.535000,17.345719>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.395719,-1.535000,17.068409>}
box{<0,0,-0.127000><0.392175,0.035000,0.127000> rotate<0,44.997030,0> translate<36.118409,-1.535000,17.345719> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.119856,-1.535000,9.785913>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.220397,-1.535000,10.028634>}
box{<0,0,-0.127000><0.262721,0.035000,0.127000> rotate<0,-67.495156,0> translate<36.119856,-1.535000,9.785913> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.124991,-1.535000,19.899878>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.582431,-1.535000,19.710400>}
box{<0,0,-0.127000><0.495130,0.035000,0.127000> rotate<0,22.498517,0> translate<36.124991,-1.535000,19.899878> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.124991,-1.535000,22.010119>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.582431,-1.535000,22.199597>}
box{<0,0,-0.127000><0.495130,0.035000,0.127000> rotate<0,-22.498517,0> translate<36.124991,-1.535000,22.010119> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.124991,-1.535000,22.439878>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.582431,-1.535000,22.250400>}
box{<0,0,-0.127000><0.495130,0.035000,0.127000> rotate<0,22.498517,0> translate<36.124991,-1.535000,22.439878> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.124991,-1.535000,24.550119>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.582431,-1.535000,24.739597>}
box{<0,0,-0.127000><0.495130,0.035000,0.127000> rotate<0,-22.498517,0> translate<36.124991,-1.535000,24.550119> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.169597,-1.535000,9.906000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<39.852600,-1.535000,9.906000>}
box{<0,0,-0.127000><3.683003,0.035000,0.127000> rotate<0,0.000000,0> translate<36.169597,-1.535000,9.906000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.192128,-1.535000,17.272000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.940916,-1.535000,17.272000>}
box{<0,0,-0.127000><5.748787,0.035000,0.127000> rotate<0,0.000000,0> translate<36.192128,-1.535000,17.272000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.220397,-1.535000,10.028634>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.220397,-1.535000,15.776266>}
box{<0,0,-0.127000><5.747631,0.035000,0.127000> rotate<0,90.000000,0> translate<36.220397,-1.535000,15.776266> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.220397,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<39.852600,-1.535000,10.160000>}
box{<0,0,-0.127000><3.632203,0.035000,0.127000> rotate<0,0.000000,0> translate<36.220397,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.220397,-1.535000,10.414000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<39.852600,-1.535000,10.414000>}
box{<0,0,-0.127000><3.632203,0.035000,0.127000> rotate<0,0.000000,0> translate<36.220397,-1.535000,10.414000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.220397,-1.535000,10.668000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<39.956291,-1.535000,10.668000>}
box{<0,0,-0.127000><3.735894,0.035000,0.127000> rotate<0,0.000000,0> translate<36.220397,-1.535000,10.668000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.220397,-1.535000,10.922000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.078028,-1.535000,10.922000>}
box{<0,0,-0.127000><3.857631,0.035000,0.127000> rotate<0,0.000000,0> translate<36.220397,-1.535000,10.922000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.220397,-1.535000,11.176000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.332028,-1.535000,11.176000>}
box{<0,0,-0.127000><4.111631,0.035000,0.127000> rotate<0,0.000000,0> translate<36.220397,-1.535000,11.176000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.220397,-1.535000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.829003,-1.535000,11.430000>}
box{<0,0,-0.127000><4.608606,0.035000,0.127000> rotate<0,0.000000,0> translate<36.220397,-1.535000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.220397,-1.535000,11.684000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.332025,-1.535000,11.684000>}
box{<0,0,-0.127000><4.111628,0.035000,0.127000> rotate<0,0.000000,0> translate<36.220397,-1.535000,11.684000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.220397,-1.535000,11.938000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.078025,-1.535000,11.938000>}
box{<0,0,-0.127000><3.857628,0.035000,0.127000> rotate<0,0.000000,0> translate<36.220397,-1.535000,11.938000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.220397,-1.535000,12.192000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<39.956288,-1.535000,12.192000>}
box{<0,0,-0.127000><3.735891,0.035000,0.127000> rotate<0,0.000000,0> translate<36.220397,-1.535000,12.192000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.220397,-1.535000,12.446000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<39.852600,-1.535000,12.446000>}
box{<0,0,-0.127000><3.632203,0.035000,0.127000> rotate<0,0.000000,0> translate<36.220397,-1.535000,12.446000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.220397,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<39.852600,-1.535000,12.700000>}
box{<0,0,-0.127000><3.632203,0.035000,0.127000> rotate<0,0.000000,0> translate<36.220397,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.220397,-1.535000,12.954000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<39.852600,-1.535000,12.954000>}
box{<0,0,-0.127000><3.632203,0.035000,0.127000> rotate<0,0.000000,0> translate<36.220397,-1.535000,12.954000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.220397,-1.535000,13.208000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<39.956291,-1.535000,13.208000>}
box{<0,0,-0.127000><3.735894,0.035000,0.127000> rotate<0,0.000000,0> translate<36.220397,-1.535000,13.208000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.220397,-1.535000,13.462000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.078028,-1.535000,13.462000>}
box{<0,0,-0.127000><3.857631,0.035000,0.127000> rotate<0,0.000000,0> translate<36.220397,-1.535000,13.462000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.220397,-1.535000,13.716000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.332028,-1.535000,13.716000>}
box{<0,0,-0.127000><4.111631,0.035000,0.127000> rotate<0,0.000000,0> translate<36.220397,-1.535000,13.716000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.220397,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.829013,-1.535000,13.970000>}
box{<0,0,-0.127000><4.608616,0.035000,0.127000> rotate<0,0.000000,0> translate<36.220397,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.220397,-1.535000,14.224000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,14.224000>}
box{<0,0,-0.127000><8.229603,0.035000,0.127000> rotate<0,0.000000,0> translate<36.220397,-1.535000,14.224000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.220397,-1.535000,14.478000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,14.478000>}
box{<0,0,-0.127000><8.229603,0.035000,0.127000> rotate<0,0.000000,0> translate<36.220397,-1.535000,14.478000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.220397,-1.535000,14.732000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,14.732000>}
box{<0,0,-0.127000><8.229603,0.035000,0.127000> rotate<0,0.000000,0> translate<36.220397,-1.535000,14.732000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.220397,-1.535000,14.986000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,14.986000>}
box{<0,0,-0.127000><8.229603,0.035000,0.127000> rotate<0,0.000000,0> translate<36.220397,-1.535000,14.986000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.220397,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,15.240000>}
box{<0,0,-0.127000><8.229603,0.035000,0.127000> rotate<0,0.000000,0> translate<36.220397,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.220397,-1.535000,15.494000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,15.494000>}
box{<0,0,-0.127000><8.229603,0.035000,0.127000> rotate<0,0.000000,0> translate<36.220397,-1.535000,15.494000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.220397,-1.535000,15.748000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,15.748000>}
box{<0,0,-0.127000><8.229603,0.035000,0.127000> rotate<0,0.000000,0> translate<36.220397,-1.535000,15.748000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.220397,-1.535000,15.776266>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.395719,-1.535000,15.951588>}
box{<0,0,-0.127000><0.247943,0.035000,0.127000> rotate<0,-44.997030,0> translate<36.220397,-1.535000,15.776266> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.395719,-1.535000,15.951588>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.545797,-1.535000,16.313909>}
box{<0,0,-0.127000><0.392174,0.035000,0.127000> rotate<0,-67.495614,0> translate<36.395719,-1.535000,15.951588> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.395719,-1.535000,17.068409>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.545797,-1.535000,16.706088>}
box{<0,0,-0.127000><0.392174,0.035000,0.127000> rotate<0,67.495614,0> translate<36.395719,-1.535000,17.068409> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.416600,-1.535000,16.002000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,16.002000>}
box{<0,0,-0.127000><8.033400,0.035000,0.127000> rotate<0,0.000000,0> translate<36.416600,-1.535000,16.002000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.416600,-1.535000,17.018000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.510834,-1.535000,17.018000>}
box{<0,0,-0.127000><6.094234,0.035000,0.127000> rotate<0,0.000000,0> translate<36.416600,-1.535000,17.018000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.521809,-1.535000,16.256000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,16.256000>}
box{<0,0,-0.127000><7.928191,0.035000,0.127000> rotate<0,0.000000,0> translate<36.521809,-1.535000,16.256000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.521809,-1.535000,16.764000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,16.764000>}
box{<0,0,-0.127000><7.928191,0.035000,0.127000> rotate<0,0.000000,0> translate<36.521809,-1.535000,16.764000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.545797,-1.535000,16.313909>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.545797,-1.535000,16.706088>}
box{<0,0,-0.127000><0.392178,0.035000,0.127000> rotate<0,90.000000,0> translate<36.545797,-1.535000,16.706088> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.545797,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,16.510000>}
box{<0,0,-0.127000><7.904203,0.035000,0.127000> rotate<0,0.000000,0> translate<36.545797,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.582431,-1.535000,19.710400>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<37.077566,-1.535000,19.710400>}
box{<0,0,-0.127000><0.495134,0.035000,0.127000> rotate<0,0.000000,0> translate<36.582431,-1.535000,19.710400> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.582431,-1.535000,22.199597>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<37.077566,-1.535000,22.199597>}
box{<0,0,-0.127000><0.495134,0.035000,0.127000> rotate<0,0.000000,0> translate<36.582431,-1.535000,22.199597> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.582431,-1.535000,22.250400>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<37.077566,-1.535000,22.250400>}
box{<0,0,-0.127000><0.495134,0.035000,0.127000> rotate<0,0.000000,0> translate<36.582431,-1.535000,22.250400> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.582431,-1.535000,24.739597>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<37.077566,-1.535000,24.739597>}
box{<0,0,-0.127000><0.495134,0.035000,0.127000> rotate<0,0.000000,0> translate<36.582431,-1.535000,24.739597> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<37.077566,-1.535000,19.710400>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<37.535006,-1.535000,19.899878>}
box{<0,0,-0.127000><0.495130,0.035000,0.127000> rotate<0,-22.498517,0> translate<37.077566,-1.535000,19.710400> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<37.077566,-1.535000,22.199597>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<37.535006,-1.535000,22.010119>}
box{<0,0,-0.127000><0.495130,0.035000,0.127000> rotate<0,22.498517,0> translate<37.077566,-1.535000,22.199597> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<37.077566,-1.535000,22.250400>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<37.535006,-1.535000,22.439878>}
box{<0,0,-0.127000><0.495130,0.035000,0.127000> rotate<0,-22.498517,0> translate<37.077566,-1.535000,22.250400> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<37.077566,-1.535000,24.739597>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<37.535006,-1.535000,24.550119>}
box{<0,0,-0.127000><0.495130,0.035000,0.127000> rotate<0,22.498517,0> translate<37.077566,-1.535000,24.739597> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<37.322844,-1.535000,22.098000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,22.098000>}
box{<0,0,-0.127000><7.127156,0.035000,0.127000> rotate<0,0.000000,0> translate<37.322844,-1.535000,22.098000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<37.322844,-1.535000,24.638000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.510834,-1.535000,24.638000>}
box{<0,0,-0.127000><5.187991,0.035000,0.127000> rotate<0,0.000000,0> translate<37.322844,-1.535000,24.638000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<37.322847,-1.535000,19.812000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.186456,-1.535000,19.812000>}
box{<0,0,-0.127000><3.863609,0.035000,0.127000> rotate<0,0.000000,0> translate<37.322847,-1.535000,19.812000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<37.322847,-1.535000,22.352000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,22.352000>}
box{<0,0,-0.127000><7.127153,0.035000,0.127000> rotate<0,0.000000,0> translate<37.322847,-1.535000,22.352000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<37.535006,-1.535000,19.899878>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<37.885119,-1.535000,20.249991>}
box{<0,0,-0.127000><0.495134,0.035000,0.127000> rotate<0,-44.997030,0> translate<37.535006,-1.535000,19.899878> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<37.535006,-1.535000,22.010119>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<37.885119,-1.535000,21.660006>}
box{<0,0,-0.127000><0.495134,0.035000,0.127000> rotate<0,44.997030,0> translate<37.535006,-1.535000,22.010119> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<37.535006,-1.535000,22.439878>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<37.885119,-1.535000,22.789991>}
box{<0,0,-0.127000><0.495134,0.035000,0.127000> rotate<0,-44.997030,0> translate<37.535006,-1.535000,22.439878> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<37.535006,-1.535000,24.550119>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<37.885119,-1.535000,24.200006>}
box{<0,0,-0.127000><0.495134,0.035000,0.127000> rotate<0,44.997030,0> translate<37.535006,-1.535000,24.550119> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<37.701125,-1.535000,21.844000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,21.844000>}
box{<0,0,-0.127000><6.748875,0.035000,0.127000> rotate<0,0.000000,0> translate<37.701125,-1.535000,21.844000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<37.701125,-1.535000,24.384000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,24.384000>}
box{<0,0,-0.127000><6.748875,0.035000,0.127000> rotate<0,0.000000,0> translate<37.701125,-1.535000,24.384000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<37.701128,-1.535000,20.066000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.291669,-1.535000,20.066000>}
box{<0,0,-0.127000><3.590541,0.035000,0.127000> rotate<0,0.000000,0> translate<37.701128,-1.535000,20.066000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<37.701128,-1.535000,22.606000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,22.606000>}
box{<0,0,-0.127000><6.748872,0.035000,0.127000> rotate<0,0.000000,0> translate<37.701128,-1.535000,22.606000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<37.885119,-1.535000,20.249991>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<38.074597,-1.535000,20.707431>}
box{<0,0,-0.127000><0.495130,0.035000,0.127000> rotate<0,-67.495544,0> translate<37.885119,-1.535000,20.249991> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<37.885119,-1.535000,21.660006>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<38.074597,-1.535000,21.202566>}
box{<0,0,-0.127000><0.495130,0.035000,0.127000> rotate<0,67.495544,0> translate<37.885119,-1.535000,21.660006> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<37.885119,-1.535000,22.789991>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<38.074597,-1.535000,23.247431>}
box{<0,0,-0.127000><0.495130,0.035000,0.127000> rotate<0,-67.495544,0> translate<37.885119,-1.535000,22.789991> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<37.885119,-1.535000,24.200006>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<38.074597,-1.535000,23.742566>}
box{<0,0,-0.127000><0.495130,0.035000,0.127000> rotate<0,67.495544,0> translate<37.885119,-1.535000,24.200006> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<37.914116,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.432919,-1.535000,20.320000>}
box{<0,0,-0.127000><3.518803,0.035000,0.127000> rotate<0,0.000000,0> translate<37.914116,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<37.914116,-1.535000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,22.860000>}
box{<0,0,-0.127000><6.535884,0.035000,0.127000> rotate<0,0.000000,0> translate<37.914116,-1.535000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<37.914119,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,21.590000>}
box{<0,0,-0.127000><6.535881,0.035000,0.127000> rotate<0,0.000000,0> translate<37.914119,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<37.914119,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,24.130000>}
box{<0,0,-0.127000><6.535881,0.035000,0.127000> rotate<0,0.000000,0> translate<37.914119,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<38.019325,-1.535000,20.574000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.686919,-1.535000,20.574000>}
box{<0,0,-0.127000><3.667594,0.035000,0.127000> rotate<0,0.000000,0> translate<38.019325,-1.535000,20.574000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<38.019325,-1.535000,23.114000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,23.114000>}
box{<0,0,-0.127000><6.430675,0.035000,0.127000> rotate<0,0.000000,0> translate<38.019325,-1.535000,23.114000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<38.019328,-1.535000,21.336000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,21.336000>}
box{<0,0,-0.127000><6.430672,0.035000,0.127000> rotate<0,0.000000,0> translate<38.019328,-1.535000,21.336000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<38.019328,-1.535000,23.876000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,23.876000>}
box{<0,0,-0.127000><6.430672,0.035000,0.127000> rotate<0,0.000000,0> translate<38.019328,-1.535000,23.876000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<38.074597,-1.535000,20.707431>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<38.074597,-1.535000,21.202566>}
box{<0,0,-0.127000><0.495134,0.035000,0.127000> rotate<0,90.000000,0> translate<38.074597,-1.535000,21.202566> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<38.074597,-1.535000,20.828000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.940919,-1.535000,20.828000>}
box{<0,0,-0.127000><3.866322,0.035000,0.127000> rotate<0,0.000000,0> translate<38.074597,-1.535000,20.828000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<38.074597,-1.535000,21.082000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.510847,-1.535000,21.082000>}
box{<0,0,-0.127000><4.436250,0.035000,0.127000> rotate<0,0.000000,0> translate<38.074597,-1.535000,21.082000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<38.074597,-1.535000,23.247431>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<38.074597,-1.535000,23.742566>}
box{<0,0,-0.127000><0.495134,0.035000,0.127000> rotate<0,90.000000,0> translate<38.074597,-1.535000,23.742566> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<38.074597,-1.535000,23.368000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,23.368000>}
box{<0,0,-0.127000><6.375403,0.035000,0.127000> rotate<0,0.000000,0> translate<38.074597,-1.535000,23.368000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<38.074597,-1.535000,23.622000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,23.622000>}
box{<0,0,-0.127000><6.375403,0.035000,0.127000> rotate<0,0.000000,0> translate<38.074597,-1.535000,23.622000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<39.750300,-1.535000,-0.736600>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.103784,-1.535000,-0.590184>}
box{<0,0,-0.127000><0.382608,0.035000,0.127000> rotate<0,-22.498183,0> translate<39.750300,-1.535000,-0.736600> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<39.750300,-1.535000,-0.736600>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,-0.736600>}
box{<0,0,-0.127000><4.699700,0.035000,0.127000> rotate<0,0.000000,0> translate<39.750300,-1.535000,-0.736600> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<39.852600,-1.535000,9.902325>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.049813,-1.535000,9.426213>}
box{<0,0,-0.127000><0.515341,0.035000,0.127000> rotate<0,67.495520,0> translate<39.852600,-1.535000,9.902325> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<39.852600,-1.535000,10.417672>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<39.852600,-1.535000,9.902325>}
box{<0,0,-0.127000><0.515347,0.035000,0.127000> rotate<0,-90.000000,0> translate<39.852600,-1.535000,9.902325> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<39.852600,-1.535000,10.417672>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.049813,-1.535000,10.893784>}
box{<0,0,-0.127000><0.515341,0.035000,0.127000> rotate<0,-67.495520,0> translate<39.852600,-1.535000,10.417672> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<39.852600,-1.535000,12.442325>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.049813,-1.535000,11.966213>}
box{<0,0,-0.127000><0.515341,0.035000,0.127000> rotate<0,67.495520,0> translate<39.852600,-1.535000,12.442325> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<39.852600,-1.535000,12.957672>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<39.852600,-1.535000,12.442325>}
box{<0,0,-0.127000><0.515347,0.035000,0.127000> rotate<0,-90.000000,0> translate<39.852600,-1.535000,12.442325> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<39.852600,-1.535000,12.957672>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.049813,-1.535000,13.433784>}
box{<0,0,-0.127000><0.515341,0.035000,0.127000> rotate<0,-67.495520,0> translate<39.852600,-1.535000,12.957672> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.010866,-1.535000,7.493000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.033144,-1.535000,7.352344>}
box{<0,0,-0.127000><0.142410,0.035000,0.127000> rotate<0,80.994510,0> translate<40.010866,-1.535000,7.493000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.010866,-1.535000,7.493000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.782984,-1.535000,7.493000>}
box{<0,0,-0.127000><1.772119,0.035000,0.127000> rotate<0,0.000000,0> translate<40.010866,-1.535000,7.493000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.010866,-1.535000,7.746994>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.033144,-1.535000,7.887653>}
box{<0,0,-0.127000><0.142413,0.035000,0.127000> rotate<0,-80.994707,0> translate<40.010866,-1.535000,7.746994> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.010866,-1.535000,7.746994>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.782984,-1.535000,7.746994>}
box{<0,0,-0.127000><1.772119,0.035000,0.127000> rotate<0,0.000000,0> translate<40.010866,-1.535000,7.746994> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.033144,-1.535000,7.352344>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.088741,-1.535000,7.181237>}
box{<0,0,-0.127000><0.179912,0.035000,0.127000> rotate<0,71.994920,0> translate<40.033144,-1.535000,7.352344> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.033144,-1.535000,7.887653>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.088741,-1.535000,8.058759>}
box{<0,0,-0.127000><0.179912,0.035000,0.127000> rotate<0,-71.994920,0> translate<40.033144,-1.535000,7.887653> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.049813,-1.535000,9.426213>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.414213,-1.535000,9.061813>}
box{<0,0,-0.127000><0.515339,0.035000,0.127000> rotate<0,44.997030,0> translate<40.049813,-1.535000,9.426213> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.049813,-1.535000,10.893784>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.414213,-1.535000,11.258184>}
box{<0,0,-0.127000><0.515339,0.035000,0.127000> rotate<0,-44.997030,0> translate<40.049813,-1.535000,10.893784> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.049813,-1.535000,11.966213>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.414213,-1.535000,11.601813>}
box{<0,0,-0.127000><0.515339,0.035000,0.127000> rotate<0,44.997030,0> translate<40.049813,-1.535000,11.966213> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.049813,-1.535000,13.433784>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.414213,-1.535000,13.798184>}
box{<0,0,-0.127000><0.515339,0.035000,0.127000> rotate<0,-44.997030,0> translate<40.049813,-1.535000,13.433784> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.056906,-1.535000,3.149600>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.103784,-1.535000,3.130184>}
box{<0,0,-0.127000><0.050740,0.035000,0.127000> rotate<0,22.496502,0> translate<40.056906,-1.535000,3.149600> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.056906,-1.535000,3.149600>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.659697,-1.535000,3.149600>}
box{<0,0,-0.127000><1.602791,0.035000,0.127000> rotate<0,0.000000,0> translate<40.056906,-1.535000,3.149600> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.088741,-1.535000,7.181237>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.170419,-1.535000,7.020938>}
box{<0,0,-0.127000><0.179909,0.035000,0.127000> rotate<0,62.995503,0> translate<40.088741,-1.535000,7.181237> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.088741,-1.535000,8.058759>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.170419,-1.535000,8.219059>}
box{<0,0,-0.127000><0.179909,0.035000,0.127000> rotate<0,-62.995503,0> translate<40.088741,-1.535000,8.058759> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.103784,-1.535000,-0.590184>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.468184,-1.535000,-0.225784>}
box{<0,0,-0.127000><0.515339,0.035000,0.127000> rotate<0,-44.997030,0> translate<40.103784,-1.535000,-0.590184> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.103784,-1.535000,3.130184>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.468184,-1.535000,2.765784>}
box{<0,0,-0.127000><0.515339,0.035000,0.127000> rotate<0,44.997030,0> translate<40.103784,-1.535000,3.130184> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.170419,-1.535000,7.020938>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.276169,-1.535000,6.875384>}
box{<0,0,-0.127000><0.179913,0.035000,0.127000> rotate<0,53.996574,0> translate<40.170419,-1.535000,7.020938> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.170419,-1.535000,8.219059>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.276169,-1.535000,8.364612>}
box{<0,0,-0.127000><0.179913,0.035000,0.127000> rotate<0,-53.996574,0> translate<40.170419,-1.535000,8.219059> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.185969,-1.535000,-0.508000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.386341,-1.535000,-0.508000>}
box{<0,0,-0.127000><1.200372,0.035000,0.127000> rotate<0,0.000000,0> translate<40.185969,-1.535000,-0.508000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.185969,-1.535000,3.048000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.386344,-1.535000,3.048000>}
box{<0,0,-0.127000><1.200375,0.035000,0.127000> rotate<0,0.000000,0> translate<40.185969,-1.535000,3.048000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.276169,-1.535000,6.875384>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.403384,-1.535000,6.748169>}
box{<0,0,-0.127000><0.179910,0.035000,0.127000> rotate<0,44.997030,0> translate<40.276169,-1.535000,6.875384> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.276169,-1.535000,8.364612>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.403384,-1.535000,8.491828>}
box{<0,0,-0.127000><0.179910,0.035000,0.127000> rotate<0,-44.997030,0> translate<40.276169,-1.535000,8.364612> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.403384,-1.535000,6.748169>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.548938,-1.535000,6.642419>}
box{<0,0,-0.127000><0.179913,0.035000,0.127000> rotate<0,35.997486,0> translate<40.403384,-1.535000,6.748169> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.403384,-1.535000,8.491828>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.548938,-1.535000,8.597578>}
box{<0,0,-0.127000><0.179913,0.035000,0.127000> rotate<0,-35.997486,0> translate<40.403384,-1.535000,8.491828> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.414213,-1.535000,9.061813>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.890325,-1.535000,8.864600>}
box{<0,0,-0.127000><0.515341,0.035000,0.127000> rotate<0,22.498540,0> translate<40.414213,-1.535000,9.061813> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.414213,-1.535000,11.258184>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.829013,-1.535000,11.429997>}
box{<0,0,-0.127000><0.448975,0.035000,0.127000> rotate<0,-22.498128,0> translate<40.414213,-1.535000,11.258184> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.414213,-1.535000,11.601813>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.829013,-1.535000,11.429997>}
box{<0,0,-0.127000><0.448976,0.035000,0.127000> rotate<0,22.498496,0> translate<40.414213,-1.535000,11.601813> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.414213,-1.535000,13.798184>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.890325,-1.535000,13.995397>}
box{<0,0,-0.127000><0.515341,0.035000,0.127000> rotate<0,-22.498540,0> translate<40.414213,-1.535000,13.798184> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.439969,-1.535000,-0.254000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.055556,-1.535000,-0.254000>}
box{<0,0,-0.127000><0.615588,0.035000,0.127000> rotate<0,0.000000,0> translate<40.439969,-1.535000,-0.254000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.439969,-1.535000,2.794000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.055556,-1.535000,2.794000>}
box{<0,0,-0.127000><0.615588,0.035000,0.127000> rotate<0,0.000000,0> translate<40.439969,-1.535000,2.794000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.468184,-1.535000,-0.225784>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.665397,-1.535000,0.250325>}
box{<0,0,-0.127000><0.515338,0.035000,0.127000> rotate<0,-67.495387,0> translate<40.468184,-1.535000,-0.225784> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.468184,-1.535000,2.765784>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.665397,-1.535000,2.289672>}
box{<0,0,-0.127000><0.515341,0.035000,0.127000> rotate<0,67.495520,0> translate<40.468184,-1.535000,2.765784> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.548938,-1.535000,6.642419>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.709238,-1.535000,6.560741>}
box{<0,0,-0.127000><0.179909,0.035000,0.127000> rotate<0,26.998557,0> translate<40.548938,-1.535000,6.642419> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.548938,-1.535000,8.597578>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.709238,-1.535000,8.679256>}
box{<0,0,-0.127000><0.179909,0.035000,0.127000> rotate<0,-26.998557,0> translate<40.548938,-1.535000,8.597578> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.561706,-1.535000,0.000000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.886019,-1.535000,0.000000>}
box{<0,0,-0.127000><0.324313,0.035000,0.127000> rotate<0,0.000000,0> translate<40.561706,-1.535000,0.000000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.561709,-1.535000,2.540000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.886022,-1.535000,2.540000>}
box{<0,0,-0.127000><0.324313,0.035000,0.127000> rotate<0,0.000000,0> translate<40.561709,-1.535000,2.540000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.665397,-1.535000,0.250325>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.665397,-1.535000,2.289672>}
box{<0,0,-0.127000><2.039347,0.035000,0.127000> rotate<0,90.000000,0> translate<40.665397,-1.535000,2.289672> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.665397,-1.535000,0.254000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.792978,-1.535000,0.254000>}
box{<0,0,-0.127000><0.127581,0.035000,0.127000> rotate<0,0.000000,0> translate<40.665397,-1.535000,0.254000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.665397,-1.535000,0.508000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.767000,-1.535000,0.508000>}
box{<0,0,-0.127000><0.101603,0.035000,0.127000> rotate<0,0.000000,0> translate<40.665397,-1.535000,0.508000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.665397,-1.535000,0.762000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.767000,-1.535000,0.762000>}
box{<0,0,-0.127000><0.101603,0.035000,0.127000> rotate<0,0.000000,0> translate<40.665397,-1.535000,0.762000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.665397,-1.535000,1.016000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.767000,-1.535000,1.016000>}
box{<0,0,-0.127000><0.101603,0.035000,0.127000> rotate<0,0.000000,0> translate<40.665397,-1.535000,1.016000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.665397,-1.535000,1.270000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.782984,-1.535000,1.270000>}
box{<0,0,-0.127000><1.117588,0.035000,0.127000> rotate<0,0.000000,0> translate<40.665397,-1.535000,1.270000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.665397,-1.535000,1.524000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.767000,-1.535000,1.524000>}
box{<0,0,-0.127000><0.101603,0.035000,0.127000> rotate<0,0.000000,0> translate<40.665397,-1.535000,1.524000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.665397,-1.535000,1.778000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.767000,-1.535000,1.778000>}
box{<0,0,-0.127000><0.101603,0.035000,0.127000> rotate<0,0.000000,0> translate<40.665397,-1.535000,1.778000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.665397,-1.535000,2.032000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.767000,-1.535000,2.032000>}
box{<0,0,-0.127000><0.101603,0.035000,0.127000> rotate<0,0.000000,0> translate<40.665397,-1.535000,2.032000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.665397,-1.535000,2.286000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.792984,-1.535000,2.286000>}
box{<0,0,-0.127000><0.127588,0.035000,0.127000> rotate<0,0.000000,0> translate<40.665397,-1.535000,2.286000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.709238,-1.535000,6.560741>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.880344,-1.535000,6.505144>}
box{<0,0,-0.127000><0.179912,0.035000,0.127000> rotate<0,17.999140,0> translate<40.709238,-1.535000,6.560741> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.709238,-1.535000,8.679256>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.880344,-1.535000,8.734853>}
box{<0,0,-0.127000><0.179912,0.035000,0.127000> rotate<0,-17.999140,0> translate<40.709238,-1.535000,8.679256> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.767000,-1.535000,0.418041>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.795144,-1.535000,0.240344>}
box{<0,0,-0.127000><0.179912,0.035000,0.127000> rotate<0,80.994865,0> translate<40.767000,-1.535000,0.418041> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.767000,-1.535000,1.143000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.767000,-1.535000,0.418041>}
box{<0,0,-0.127000><0.724959,0.035000,0.127000> rotate<0,-90.000000,0> translate<40.767000,-1.535000,0.418041> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.767000,-1.535000,1.143000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.782984,-1.535000,1.143000>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,0.000000,0> translate<40.767000,-1.535000,1.143000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.767000,-1.535000,1.396994>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.782984,-1.535000,1.396994>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,0.000000,0> translate<40.767000,-1.535000,1.396994> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.767000,-1.535000,2.121956>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.767000,-1.535000,1.396994>}
box{<0,0,-0.127000><0.724963,0.035000,0.127000> rotate<0,-90.000000,0> translate<40.767000,-1.535000,1.396994> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.767000,-1.535000,2.121956>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.795144,-1.535000,2.299653>}
box{<0,0,-0.127000><0.179912,0.035000,0.127000> rotate<0,-80.994865,0> translate<40.767000,-1.535000,2.121956> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.795144,-1.535000,0.240344>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.850741,-1.535000,0.069238>}
box{<0,0,-0.127000><0.179912,0.035000,0.127000> rotate<0,71.994920,0> translate<40.795144,-1.535000,0.240344> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.795144,-1.535000,2.299653>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.850741,-1.535000,2.470759>}
box{<0,0,-0.127000><0.179912,0.035000,0.127000> rotate<0,-71.994920,0> translate<40.795144,-1.535000,2.299653> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.850741,-1.535000,0.069238>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.932419,-1.535000,-0.091059>}
box{<0,0,-0.127000><0.179907,0.035000,0.127000> rotate<0,62.995051,0> translate<40.850741,-1.535000,0.069238> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.850741,-1.535000,2.470759>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.932419,-1.535000,2.631059>}
box{<0,0,-0.127000><0.179909,0.035000,0.127000> rotate<0,-62.995503,0> translate<40.850741,-1.535000,2.470759> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.880344,-1.535000,6.505144>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.058041,-1.535000,6.477000>}
box{<0,0,-0.127000><0.179912,0.035000,0.127000> rotate<0,8.999195,0> translate<40.880344,-1.535000,6.505144> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.880344,-1.535000,8.734853>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.058041,-1.535000,8.762997>}
box{<0,0,-0.127000><0.179912,0.035000,0.127000> rotate<0,-8.999195,0> translate<40.880344,-1.535000,8.734853> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.890325,-1.535000,8.864600>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.929672,-1.535000,8.864600>}
box{<0,0,-0.127000><2.039347,0.035000,0.127000> rotate<0,0.000000,0> translate<40.890325,-1.535000,8.864600> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.890325,-1.535000,13.995397>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.929672,-1.535000,13.995397>}
box{<0,0,-0.127000><2.039347,0.035000,0.127000> rotate<0,0.000000,0> translate<40.890325,-1.535000,13.995397> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.932419,-1.535000,-0.091059>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.038169,-1.535000,-0.236613>}
box{<0,0,-0.127000><0.179913,0.035000,0.127000> rotate<0,53.996574,0> translate<40.932419,-1.535000,-0.091059> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.932419,-1.535000,2.631059>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.038169,-1.535000,2.776613>}
box{<0,0,-0.127000><0.179913,0.035000,0.127000> rotate<0,-53.996574,0> translate<40.932419,-1.535000,2.631059> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.038169,-1.535000,-0.236613>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.165384,-1.535000,-0.363828>}
box{<0,0,-0.127000><0.179910,0.035000,0.127000> rotate<0,44.997030,0> translate<41.038169,-1.535000,-0.236613> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.038169,-1.535000,2.776613>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.165384,-1.535000,2.903828>}
box{<0,0,-0.127000><0.179910,0.035000,0.127000> rotate<0,-44.997030,0> translate<41.038169,-1.535000,2.776613> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.046600,-1.535000,18.625637>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.371391,-1.535000,17.841525>}
box{<0,0,-0.127000><0.848717,0.035000,0.127000> rotate<0,67.495508,0> translate<41.046600,-1.535000,18.625637> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.046600,-1.535000,19.474359>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.046600,-1.535000,18.625637>}
box{<0,0,-0.127000><0.848722,0.035000,0.127000> rotate<0,-90.000000,0> translate<41.046600,-1.535000,18.625637> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.046600,-1.535000,19.474359>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.371391,-1.535000,20.258472>}
box{<0,0,-0.127000><0.848717,0.035000,0.127000> rotate<0,-67.495508,0> translate<41.046600,-1.535000,19.474359> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.046600,-1.535000,26.245638>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.371391,-1.535000,25.461525>}
box{<0,0,-0.127000><0.848717,0.035000,0.127000> rotate<0,67.495508,0> translate<41.046600,-1.535000,26.245638> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.046600,-1.535000,27.094359>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.046600,-1.535000,26.245638>}
box{<0,0,-0.127000><0.848722,0.035000,0.127000> rotate<0,-90.000000,0> translate<41.046600,-1.535000,26.245638> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.046600,-1.535000,27.094359>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.371391,-1.535000,27.878472>}
box{<0,0,-0.127000><0.848717,0.035000,0.127000> rotate<0,-67.495508,0> translate<41.046600,-1.535000,27.094359> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.058041,-1.535000,6.477000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.783000,-1.535000,6.477000>}
box{<0,0,-0.127000><0.724959,0.035000,0.127000> rotate<0,0.000000,0> translate<41.058041,-1.535000,6.477000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.058041,-1.535000,8.762997>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.783000,-1.535000,8.762997>}
box{<0,0,-0.127000><0.724959,0.035000,0.127000> rotate<0,0.000000,0> translate<41.058041,-1.535000,8.762997> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.165384,-1.535000,-0.363828>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.310938,-1.535000,-0.469578>}
box{<0,0,-0.127000><0.179913,0.035000,0.127000> rotate<0,35.997486,0> translate<41.165384,-1.535000,-0.363828> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.165384,-1.535000,2.903828>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.310938,-1.535000,3.009578>}
box{<0,0,-0.127000><0.179913,0.035000,0.127000> rotate<0,-35.997486,0> translate<41.165384,-1.535000,2.903828> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.310938,-1.535000,-0.469578>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.471238,-1.535000,-0.551256>}
box{<0,0,-0.127000><0.179909,0.035000,0.127000> rotate<0,26.998557,0> translate<41.310938,-1.535000,-0.469578> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.310938,-1.535000,3.009578>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.471238,-1.535000,3.091256>}
box{<0,0,-0.127000><0.179909,0.035000,0.127000> rotate<0,-26.998557,0> translate<41.310938,-1.535000,3.009578> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.371391,-1.535000,17.841525>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.971525,-1.535000,17.241391>}
box{<0,0,-0.127000><0.848718,0.035000,0.127000> rotate<0,44.997030,0> translate<41.371391,-1.535000,17.841525> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.371391,-1.535000,20.258472>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.971525,-1.535000,20.858606>}
box{<0,0,-0.127000><0.848718,0.035000,0.127000> rotate<0,-44.997030,0> translate<41.371391,-1.535000,20.258472> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.371391,-1.535000,25.461525>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.971525,-1.535000,24.861391>}
box{<0,0,-0.127000><0.848718,0.035000,0.127000> rotate<0,44.997030,0> translate<41.371391,-1.535000,25.461525> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.371391,-1.535000,27.878472>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.971525,-1.535000,28.478606>}
box{<0,0,-0.127000><0.848718,0.035000,0.127000> rotate<0,-44.997030,0> translate<41.371391,-1.535000,27.878472> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.471238,-1.535000,-0.551256>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.642344,-1.535000,-0.606853>}
box{<0,0,-0.127000><0.179912,0.035000,0.127000> rotate<0,17.999140,0> translate<41.471238,-1.535000,-0.551256> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.471238,-1.535000,3.091256>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.642344,-1.535000,3.146853>}
box{<0,0,-0.127000><0.179912,0.035000,0.127000> rotate<0,-17.999140,0> translate<41.471238,-1.535000,3.091256> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.636453,-1.535000,4.470397>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.789600,-1.535000,6.623544>}
box{<0,0,-0.127000><3.045010,0.035000,0.127000> rotate<0,-44.997030,0> translate<41.636453,-1.535000,4.470397> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.642344,-1.535000,-0.606853>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.783000,-1.535000,-0.629128>}
box{<0,0,-0.127000><0.142409,0.035000,0.127000> rotate<0,8.998309,0> translate<41.642344,-1.535000,-0.606853> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.642344,-1.535000,3.146853>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.659697,-1.535000,3.149600>}
box{<0,0,-0.127000><0.017569,0.035000,0.127000> rotate<0,-8.994285,0> translate<41.642344,-1.535000,3.146853> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.782984,-1.535000,1.396994>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.782984,-1.535000,1.143000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,-90.000000,0> translate<41.782984,-1.535000,1.143000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.782984,-1.535000,7.746994>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.782984,-1.535000,7.493000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,-90.000000,0> translate<41.782984,-1.535000,7.493000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.783000,-1.535000,-0.629128>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.783000,-1.535000,1.142984>}
box{<0,0,-0.127000><1.772113,0.035000,0.127000> rotate<0,90.000000,0> translate<41.783000,-1.535000,1.142984> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.783000,-1.535000,-0.508000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.036994,-1.535000,-0.508000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<41.783000,-1.535000,-0.508000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.783000,-1.535000,-0.254000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.036994,-1.535000,-0.254000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<41.783000,-1.535000,-0.254000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.783000,-1.535000,0.000000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.036994,-1.535000,0.000000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<41.783000,-1.535000,0.000000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.783000,-1.535000,0.254000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.036994,-1.535000,0.254000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<41.783000,-1.535000,0.254000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.783000,-1.535000,0.508000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.036994,-1.535000,0.508000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<41.783000,-1.535000,0.508000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.783000,-1.535000,0.762000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.036994,-1.535000,0.762000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<41.783000,-1.535000,0.762000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.783000,-1.535000,1.016000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.036994,-1.535000,1.016000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<41.783000,-1.535000,1.016000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.783000,-1.535000,1.142984>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.036994,-1.535000,1.142984>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<41.783000,-1.535000,1.142984> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.783000,-1.535000,6.477000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.783000,-1.535000,7.492984>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,90.000000,0> translate<41.783000,-1.535000,7.492984> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.783000,-1.535000,6.604000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.036994,-1.535000,6.604000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<41.783000,-1.535000,6.604000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.783000,-1.535000,6.858000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.036994,-1.535000,6.858000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<41.783000,-1.535000,6.858000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.783000,-1.535000,7.112000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.036994,-1.535000,7.112000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<41.783000,-1.535000,7.112000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.783000,-1.535000,7.366000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.036994,-1.535000,7.366000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<41.783000,-1.535000,7.366000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.783000,-1.535000,7.492984>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.036994,-1.535000,7.492984>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<41.783000,-1.535000,7.492984> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.783000,-1.535000,7.747013>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.783000,-1.535000,8.762997>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,90.000000,0> translate<41.783000,-1.535000,8.762997> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.783000,-1.535000,7.747013>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.036994,-1.535000,7.747013>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<41.783000,-1.535000,7.747013> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.783000,-1.535000,7.874000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.036994,-1.535000,7.874000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<41.783000,-1.535000,7.874000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.783000,-1.535000,8.128000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.036994,-1.535000,8.128000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<41.783000,-1.535000,8.128000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.783000,-1.535000,8.382000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.036994,-1.535000,8.382000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<41.783000,-1.535000,8.382000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.783000,-1.535000,8.636000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.036994,-1.535000,8.636000>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,0.000000,0> translate<41.783000,-1.535000,8.636000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.971525,-1.535000,17.241391>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.755637,-1.535000,16.916600>}
box{<0,0,-0.127000><0.848717,0.035000,0.127000> rotate<0,22.498552,0> translate<41.971525,-1.535000,17.241391> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.971525,-1.535000,20.858606>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.755637,-1.535000,21.183397>}
box{<0,0,-0.127000><0.848717,0.035000,0.127000> rotate<0,-22.498552,0> translate<41.971525,-1.535000,20.858606> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.971525,-1.535000,24.861391>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.755637,-1.535000,24.536600>}
box{<0,0,-0.127000><0.848717,0.035000,0.127000> rotate<0,22.498552,0> translate<41.971525,-1.535000,24.861391> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.971525,-1.535000,28.478606>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.425387,-1.535000,28.666600>}
box{<0,0,-0.127000><0.491256,0.035000,0.127000> rotate<0,-22.498272,0> translate<41.971525,-1.535000,28.478606> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.036994,-1.535000,-0.629128>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.177653,-1.535000,-0.606853>}
box{<0,0,-0.127000><0.142412,0.035000,0.127000> rotate<0,-8.998112,0> translate<42.036994,-1.535000,-0.629128> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.036994,-1.535000,1.142984>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.036994,-1.535000,-0.629128>}
box{<0,0,-0.127000><1.772113,0.035000,0.127000> rotate<0,-90.000000,0> translate<42.036994,-1.535000,-0.629128> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.036994,-1.535000,6.477000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.761956,-1.535000,6.477000>}
box{<0,0,-0.127000><0.724963,0.035000,0.127000> rotate<0,0.000000,0> translate<42.036994,-1.535000,6.477000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.036994,-1.535000,7.492984>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.036994,-1.535000,6.477000>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,-90.000000,0> translate<42.036994,-1.535000,6.477000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.036994,-1.535000,8.762997>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.036994,-1.535000,7.747013>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,-90.000000,0> translate<42.036994,-1.535000,7.747013> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.036994,-1.535000,8.762997>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.761956,-1.535000,8.762997>}
box{<0,0,-0.127000><0.724963,0.035000,0.127000> rotate<0,0.000000,0> translate<42.036994,-1.535000,8.762997> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.037013,-1.535000,1.143000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.037013,-1.535000,1.396994>}
box{<0,0,-0.127000><0.253994,0.035000,0.127000> rotate<0,90.000000,0> translate<42.037013,-1.535000,1.396994> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.037013,-1.535000,1.143000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.052997,-1.535000,1.143000>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,0.000000,0> translate<42.037013,-1.535000,1.143000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.037013,-1.535000,1.270000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,1.270000>}
box{<0,0,-0.127000><2.412987,0.035000,0.127000> rotate<0,0.000000,0> translate<42.037013,-1.535000,1.270000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.037013,-1.535000,1.396994>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.052997,-1.535000,1.396994>}
box{<0,0,-0.127000><1.015984,0.035000,0.127000> rotate<0,0.000000,0> translate<42.037013,-1.535000,1.396994> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.074256,-1.535000,3.163225>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.177653,-1.535000,3.146853>}
box{<0,0,-0.127000><0.104685,0.035000,0.127000> rotate<0,8.996930,0> translate<42.074256,-1.535000,3.163225> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.074256,-1.535000,3.163225>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.284084,-1.535000,3.250141>}
box{<0,0,-0.127000><0.227117,0.035000,0.127000> rotate<0,-22.498974,0> translate<42.074256,-1.535000,3.163225> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.177653,-1.535000,-0.606853>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.348759,-1.535000,-0.551256>}
box{<0,0,-0.127000><0.179912,0.035000,0.127000> rotate<0,-17.999140,0> translate<42.177653,-1.535000,-0.606853> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.177653,-1.535000,3.146853>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.348759,-1.535000,3.091256>}
box{<0,0,-0.127000><0.179912,0.035000,0.127000> rotate<0,17.999140,0> translate<42.177653,-1.535000,3.146853> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.284084,-1.535000,3.250141>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,5.416056>}
box{<0,0,-0.127000><3.063067,0.035000,0.127000> rotate<0,-44.997030,0> translate<42.284084,-1.535000,3.250141> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.335944,-1.535000,3.302000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,3.302000>}
box{<0,0,-0.127000><2.114056,0.035000,0.127000> rotate<0,0.000000,0> translate<42.335944,-1.535000,3.302000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.348759,-1.535000,-0.551256>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.509059,-1.535000,-0.469578>}
box{<0,0,-0.127000><0.179909,0.035000,0.127000> rotate<0,-26.998557,0> translate<42.348759,-1.535000,-0.551256> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.348759,-1.535000,3.091256>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.509059,-1.535000,3.009578>}
box{<0,0,-0.127000><0.179909,0.035000,0.127000> rotate<0,26.998557,0> translate<42.348759,-1.535000,3.091256> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.433653,-1.535000,-0.508000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,-0.508000>}
box{<0,0,-0.127000><2.016347,0.035000,0.127000> rotate<0,0.000000,0> translate<42.433653,-1.535000,-0.508000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.433656,-1.535000,3.048000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,3.048000>}
box{<0,0,-0.127000><2.016344,0.035000,0.127000> rotate<0,0.000000,0> translate<42.433656,-1.535000,3.048000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.509059,-1.535000,-0.469578>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.654612,-1.535000,-0.363828>}
box{<0,0,-0.127000><0.179913,0.035000,0.127000> rotate<0,-35.997486,0> translate<42.509059,-1.535000,-0.469578> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.509059,-1.535000,3.009578>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.654612,-1.535000,2.903828>}
box{<0,0,-0.127000><0.179913,0.035000,0.127000> rotate<0,35.997486,0> translate<42.509059,-1.535000,3.009578> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.589944,-1.535000,3.556000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,3.556000>}
box{<0,0,-0.127000><1.860056,0.035000,0.127000> rotate<0,0.000000,0> translate<42.589944,-1.535000,3.556000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.654612,-1.535000,-0.363828>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.781828,-1.535000,-0.236613>}
box{<0,0,-0.127000><0.179910,0.035000,0.127000> rotate<0,-44.997030,0> translate<42.654612,-1.535000,-0.363828> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.654612,-1.535000,2.903828>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.781828,-1.535000,2.776613>}
box{<0,0,-0.127000><0.179910,0.035000,0.127000> rotate<0,44.997030,0> translate<42.654612,-1.535000,2.903828> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.755637,-1.535000,16.916600>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.604359,-1.535000,16.916600>}
box{<0,0,-0.127000><0.848722,0.035000,0.127000> rotate<0,0.000000,0> translate<42.755637,-1.535000,16.916600> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.755637,-1.535000,21.183397>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.604359,-1.535000,21.183397>}
box{<0,0,-0.127000><0.848722,0.035000,0.127000> rotate<0,0.000000,0> translate<42.755637,-1.535000,21.183397> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.755637,-1.535000,24.536600>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.604359,-1.535000,24.536600>}
box{<0,0,-0.127000><0.848722,0.035000,0.127000> rotate<0,0.000000,0> translate<42.755637,-1.535000,24.536600> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.761956,-1.535000,6.477000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.939653,-1.535000,6.505144>}
box{<0,0,-0.127000><0.179912,0.035000,0.127000> rotate<0,-8.999195,0> translate<42.761956,-1.535000,6.477000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.761956,-1.535000,8.762997>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.939653,-1.535000,8.734853>}
box{<0,0,-0.127000><0.179912,0.035000,0.127000> rotate<0,8.999195,0> translate<42.761956,-1.535000,8.762997> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.764441,-1.535000,-0.254000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,-0.254000>}
box{<0,0,-0.127000><1.685559,0.035000,0.127000> rotate<0,0.000000,0> translate<42.764441,-1.535000,-0.254000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.764441,-1.535000,2.794000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,2.794000>}
box{<0,0,-0.127000><1.685559,0.035000,0.127000> rotate<0,0.000000,0> translate<42.764441,-1.535000,2.794000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.781828,-1.535000,-0.236613>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.887578,-1.535000,-0.091059>}
box{<0,0,-0.127000><0.179913,0.035000,0.127000> rotate<0,-53.996574,0> translate<42.781828,-1.535000,-0.236613> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.781828,-1.535000,2.776613>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.887578,-1.535000,2.631059>}
box{<0,0,-0.127000><0.179913,0.035000,0.127000> rotate<0,53.996574,0> translate<42.781828,-1.535000,2.776613> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.843944,-1.535000,3.810000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,3.810000>}
box{<0,0,-0.127000><1.606056,0.035000,0.127000> rotate<0,0.000000,0> translate<42.843944,-1.535000,3.810000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.887578,-1.535000,-0.091059>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.969256,-1.535000,0.069238>}
box{<0,0,-0.127000><0.179907,0.035000,0.127000> rotate<0,-62.995051,0> translate<42.887578,-1.535000,-0.091059> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.887578,-1.535000,2.631059>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.969256,-1.535000,2.470759>}
box{<0,0,-0.127000><0.179909,0.035000,0.127000> rotate<0,62.995503,0> translate<42.887578,-1.535000,2.631059> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.929672,-1.535000,8.864600>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.405784,-1.535000,9.061813>}
box{<0,0,-0.127000><0.515341,0.035000,0.127000> rotate<0,-22.498540,0> translate<42.929672,-1.535000,8.864600> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.929672,-1.535000,13.995397>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.405784,-1.535000,13.798184>}
box{<0,0,-0.127000><0.515341,0.035000,0.127000> rotate<0,22.498540,0> translate<42.929672,-1.535000,13.995397> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.933975,-1.535000,0.000000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,0.000000>}
box{<0,0,-0.127000><1.516025,0.035000,0.127000> rotate<0,0.000000,0> translate<42.933975,-1.535000,0.000000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.933978,-1.535000,2.540000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,2.540000>}
box{<0,0,-0.127000><1.516022,0.035000,0.127000> rotate<0,0.000000,0> translate<42.933978,-1.535000,2.540000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.939653,-1.535000,6.505144>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.110759,-1.535000,6.560741>}
box{<0,0,-0.127000><0.179912,0.035000,0.127000> rotate<0,-17.999140,0> translate<42.939653,-1.535000,6.505144> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.939653,-1.535000,8.734853>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.110759,-1.535000,8.679256>}
box{<0,0,-0.127000><0.179912,0.035000,0.127000> rotate<0,17.999140,0> translate<42.939653,-1.535000,8.734853> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.969256,-1.535000,0.069238>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.024853,-1.535000,0.240344>}
box{<0,0,-0.127000><0.179912,0.035000,0.127000> rotate<0,-71.994920,0> translate<42.969256,-1.535000,0.069238> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.969256,-1.535000,2.470759>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.024853,-1.535000,2.299653>}
box{<0,0,-0.127000><0.179912,0.035000,0.127000> rotate<0,71.994920,0> translate<42.969256,-1.535000,2.470759> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.990988,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,13.970000>}
box{<0,0,-0.127000><1.459013,0.035000,0.127000> rotate<0,0.000000,0> translate<42.990988,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<42.990991,-1.535000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.789600,-1.535000,8.890000>}
box{<0,0,-0.127000><0.798609,0.035000,0.127000> rotate<0,0.000000,0> translate<42.990991,-1.535000,8.890000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.024853,-1.535000,0.240344>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.052997,-1.535000,0.418041>}
box{<0,0,-0.127000><0.179912,0.035000,0.127000> rotate<0,-80.994865,0> translate<43.024853,-1.535000,0.240344> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.024853,-1.535000,2.299653>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.052997,-1.535000,2.121956>}
box{<0,0,-0.127000><0.179912,0.035000,0.127000> rotate<0,80.994865,0> translate<43.024853,-1.535000,2.299653> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.027016,-1.535000,0.254000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,0.254000>}
box{<0,0,-0.127000><1.422984,0.035000,0.127000> rotate<0,0.000000,0> translate<43.027016,-1.535000,0.254000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.027016,-1.535000,2.286000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,2.286000>}
box{<0,0,-0.127000><1.422984,0.035000,0.127000> rotate<0,0.000000,0> translate<43.027016,-1.535000,2.286000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.052997,-1.535000,0.418041>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.052997,-1.535000,1.143000>}
box{<0,0,-0.127000><0.724959,0.035000,0.127000> rotate<0,90.000000,0> translate<43.052997,-1.535000,1.143000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.052997,-1.535000,0.508000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,0.508000>}
box{<0,0,-0.127000><1.397003,0.035000,0.127000> rotate<0,0.000000,0> translate<43.052997,-1.535000,0.508000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.052997,-1.535000,0.762000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,0.762000>}
box{<0,0,-0.127000><1.397003,0.035000,0.127000> rotate<0,0.000000,0> translate<43.052997,-1.535000,0.762000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.052997,-1.535000,1.016000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,1.016000>}
box{<0,0,-0.127000><1.397003,0.035000,0.127000> rotate<0,0.000000,0> translate<43.052997,-1.535000,1.016000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.052997,-1.535000,1.396994>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.052997,-1.535000,2.121956>}
box{<0,0,-0.127000><0.724963,0.035000,0.127000> rotate<0,90.000000,0> translate<43.052997,-1.535000,2.121956> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.052997,-1.535000,1.524000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,1.524000>}
box{<0,0,-0.127000><1.397003,0.035000,0.127000> rotate<0,0.000000,0> translate<43.052997,-1.535000,1.524000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.052997,-1.535000,1.778000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,1.778000>}
box{<0,0,-0.127000><1.397003,0.035000,0.127000> rotate<0,0.000000,0> translate<43.052997,-1.535000,1.778000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.052997,-1.535000,2.032000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,2.032000>}
box{<0,0,-0.127000><1.397003,0.035000,0.127000> rotate<0,0.000000,0> translate<43.052997,-1.535000,2.032000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.097944,-1.535000,4.064000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,4.064000>}
box{<0,0,-0.127000><1.352056,0.035000,0.127000> rotate<0,0.000000,0> translate<43.097944,-1.535000,4.064000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.110759,-1.535000,6.560741>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.271059,-1.535000,6.642419>}
box{<0,0,-0.127000><0.179909,0.035000,0.127000> rotate<0,-26.998557,0> translate<43.110759,-1.535000,6.560741> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.110759,-1.535000,8.679256>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.271059,-1.535000,8.597578>}
box{<0,0,-0.127000><0.179909,0.035000,0.127000> rotate<0,26.998557,0> translate<43.110759,-1.535000,8.679256> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.195656,-1.535000,8.636000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.789600,-1.535000,8.636000>}
box{<0,0,-0.127000><0.593944,0.035000,0.127000> rotate<0,0.000000,0> translate<43.195656,-1.535000,8.636000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.195659,-1.535000,6.604000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.770056,-1.535000,6.604000>}
box{<0,0,-0.127000><0.574397,0.035000,0.127000> rotate<0,0.000000,0> translate<43.195659,-1.535000,6.604000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.271059,-1.535000,6.642419>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.416612,-1.535000,6.748169>}
box{<0,0,-0.127000><0.179913,0.035000,0.127000> rotate<0,-35.997486,0> translate<43.271059,-1.535000,6.642419> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.271059,-1.535000,8.597578>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.416612,-1.535000,8.491828>}
box{<0,0,-0.127000><0.179913,0.035000,0.127000> rotate<0,35.997486,0> translate<43.271059,-1.535000,8.597578> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.351944,-1.535000,4.318000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,4.318000>}
box{<0,0,-0.127000><1.098056,0.035000,0.127000> rotate<0,0.000000,0> translate<43.351944,-1.535000,4.318000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.405784,-1.535000,9.061813>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.770184,-1.535000,9.426213>}
box{<0,0,-0.127000><0.515339,0.035000,0.127000> rotate<0,-44.997030,0> translate<43.405784,-1.535000,9.061813> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.405784,-1.535000,13.798184>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.770184,-1.535000,13.433784>}
box{<0,0,-0.127000><0.515339,0.035000,0.127000> rotate<0,44.997030,0> translate<43.405784,-1.535000,13.798184> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.416612,-1.535000,6.748169>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.543828,-1.535000,6.875384>}
box{<0,0,-0.127000><0.179910,0.035000,0.127000> rotate<0,-44.997030,0> translate<43.416612,-1.535000,6.748169> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.416612,-1.535000,8.491828>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.543828,-1.535000,8.364612>}
box{<0,0,-0.127000><0.179910,0.035000,0.127000> rotate<0,44.997030,0> translate<43.416612,-1.535000,8.491828> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.487969,-1.535000,13.716000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,13.716000>}
box{<0,0,-0.127000><0.962031,0.035000,0.127000> rotate<0,0.000000,0> translate<43.487969,-1.535000,13.716000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.487972,-1.535000,9.144000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.789600,-1.535000,9.144000>}
box{<0,0,-0.127000><0.301628,0.035000,0.127000> rotate<0,0.000000,0> translate<43.487972,-1.535000,9.144000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.526441,-1.535000,8.382000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.789600,-1.535000,8.382000>}
box{<0,0,-0.127000><0.263159,0.035000,0.127000> rotate<0,0.000000,0> translate<43.526441,-1.535000,8.382000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.526444,-1.535000,6.858000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.789600,-1.535000,6.858000>}
box{<0,0,-0.127000><0.263156,0.035000,0.127000> rotate<0,0.000000,0> translate<43.526444,-1.535000,6.858000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.543828,-1.535000,6.875384>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.649578,-1.535000,7.020938>}
box{<0,0,-0.127000><0.179913,0.035000,0.127000> rotate<0,-53.996574,0> translate<43.543828,-1.535000,6.875384> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.543828,-1.535000,8.364612>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.649578,-1.535000,8.219059>}
box{<0,0,-0.127000><0.179913,0.035000,0.127000> rotate<0,53.996574,0> translate<43.543828,-1.535000,8.364612> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.604359,-1.535000,16.916600>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.388472,-1.535000,17.241391>}
box{<0,0,-0.127000><0.848717,0.035000,0.127000> rotate<0,-22.498552,0> translate<43.604359,-1.535000,16.916600> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.604359,-1.535000,21.183397>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.388472,-1.535000,20.858606>}
box{<0,0,-0.127000><0.848717,0.035000,0.127000> rotate<0,22.498552,0> translate<43.604359,-1.535000,21.183397> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.604359,-1.535000,24.536600>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.388472,-1.535000,24.861391>}
box{<0,0,-0.127000><0.848717,0.035000,0.127000> rotate<0,-22.498552,0> translate<43.604359,-1.535000,24.536600> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.605944,-1.535000,4.572000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,4.572000>}
box{<0,0,-0.127000><0.844056,0.035000,0.127000> rotate<0,0.000000,0> translate<43.605944,-1.535000,4.572000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.649578,-1.535000,7.020938>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.731256,-1.535000,7.181237>}
box{<0,0,-0.127000><0.179909,0.035000,0.127000> rotate<0,-62.995503,0> translate<43.649578,-1.535000,7.020938> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.649578,-1.535000,8.219059>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.731256,-1.535000,8.058759>}
box{<0,0,-0.127000><0.179909,0.035000,0.127000> rotate<0,62.995503,0> translate<43.649578,-1.535000,8.219059> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.695975,-1.535000,7.112000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.789600,-1.535000,7.112000>}
box{<0,0,-0.127000><0.093625,0.035000,0.127000> rotate<0,0.000000,0> translate<43.695975,-1.535000,7.112000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.695978,-1.535000,8.128000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.789600,-1.535000,8.128000>}
box{<0,0,-0.127000><0.093622,0.035000,0.127000> rotate<0,0.000000,0> translate<43.695978,-1.535000,8.128000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.731256,-1.535000,7.181237>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.786853,-1.535000,7.352344>}
box{<0,0,-0.127000><0.179912,0.035000,0.127000> rotate<0,-71.994920,0> translate<43.731256,-1.535000,7.181237> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.731256,-1.535000,8.058759>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.786853,-1.535000,7.887653>}
box{<0,0,-0.127000><0.179912,0.035000,0.127000> rotate<0,71.994920,0> translate<43.731256,-1.535000,8.058759> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.741969,-1.535000,13.462000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,13.462000>}
box{<0,0,-0.127000><0.708031,0.035000,0.127000> rotate<0,0.000000,0> translate<43.741969,-1.535000,13.462000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.741972,-1.535000,9.398000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.789600,-1.535000,9.398000>}
box{<0,0,-0.127000><0.047628,0.035000,0.127000> rotate<0,0.000000,0> translate<43.741972,-1.535000,9.398000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.770184,-1.535000,9.426213>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.789600,-1.535000,9.473094>}
box{<0,0,-0.127000><0.050743,0.035000,0.127000> rotate<0,-67.498909,0> translate<43.770184,-1.535000,9.426213> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.770184,-1.535000,13.433784>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.967397,-1.535000,12.957672>}
box{<0,0,-0.127000><0.515341,0.035000,0.127000> rotate<0,67.495520,0> translate<43.770184,-1.535000,13.433784> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.786853,-1.535000,7.352344>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.789600,-1.535000,7.369697>}
box{<0,0,-0.127000><0.017569,0.035000,0.127000> rotate<0,-80.999775,0> translate<43.786853,-1.535000,7.352344> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.786853,-1.535000,7.887653>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.789600,-1.535000,7.870300>}
box{<0,0,-0.127000><0.017569,0.035000,0.127000> rotate<0,80.999775,0> translate<43.786853,-1.535000,7.887653> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.789013,-1.535000,7.366000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.789600,-1.535000,7.366000>}
box{<0,0,-0.127000><0.000587,0.035000,0.127000> rotate<0,0.000000,0> translate<43.789013,-1.535000,7.366000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.789016,-1.535000,7.874000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.789600,-1.535000,7.874000>}
box{<0,0,-0.127000><0.000584,0.035000,0.127000> rotate<0,0.000000,0> translate<43.789016,-1.535000,7.874000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.789600,-1.535000,7.369697>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.789600,-1.535000,6.623544>}
box{<0,0,-0.127000><0.746153,0.035000,0.127000> rotate<0,-90.000000,0> translate<43.789600,-1.535000,6.623544> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.789600,-1.535000,9.473094>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.789600,-1.535000,7.870300>}
box{<0,0,-0.127000><1.602794,0.035000,0.127000> rotate<0,-90.000000,0> translate<43.789600,-1.535000,7.870300> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.849153,-1.535000,21.082000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,21.082000>}
box{<0,0,-0.127000><0.600847,0.035000,0.127000> rotate<0,0.000000,0> translate<43.849153,-1.535000,21.082000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.849159,-1.535000,17.018000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,17.018000>}
box{<0,0,-0.127000><0.600841,0.035000,0.127000> rotate<0,0.000000,0> translate<43.849159,-1.535000,17.018000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.849159,-1.535000,24.638000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,24.638000>}
box{<0,0,-0.127000><0.600841,0.035000,0.127000> rotate<0,0.000000,0> translate<43.849159,-1.535000,24.638000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.859944,-1.535000,4.826000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,4.826000>}
box{<0,0,-0.127000><0.590056,0.035000,0.127000> rotate<0,0.000000,0> translate<43.859944,-1.535000,4.826000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.863709,-1.535000,13.208000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,13.208000>}
box{<0,0,-0.127000><0.586291,0.035000,0.127000> rotate<0,0.000000,0> translate<43.863709,-1.535000,13.208000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.967397,-1.535000,12.846544>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.967397,-1.535000,12.957672>}
box{<0,0,-0.127000><0.111128,0.035000,0.127000> rotate<0,90.000000,0> translate<43.967397,-1.535000,12.957672> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.967397,-1.535000,12.846544>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,12.363941>}
box{<0,0,-0.127000><0.682504,0.035000,0.127000> rotate<0,44.997030,0> translate<43.967397,-1.535000,12.846544> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.967397,-1.535000,12.954000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,12.954000>}
box{<0,0,-0.127000><0.482603,0.035000,0.127000> rotate<0,0.000000,0> translate<43.967397,-1.535000,12.954000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.113941,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,12.700000>}
box{<0,0,-0.127000><0.336059,0.035000,0.127000> rotate<0,0.000000,0> translate<44.113941,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.113944,-1.535000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,5.080000>}
box{<0,0,-0.127000><0.336056,0.035000,0.127000> rotate<0,0.000000,0> translate<44.113944,-1.535000,5.080000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.367941,-1.535000,12.446000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,12.446000>}
box{<0,0,-0.127000><0.082059,0.035000,0.127000> rotate<0,0.000000,0> translate<44.367941,-1.535000,12.446000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.367944,-1.535000,5.334000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,5.334000>}
box{<0,0,-0.127000><0.082056,0.035000,0.127000> rotate<0,0.000000,0> translate<44.367944,-1.535000,5.334000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.388472,-1.535000,17.241391>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,17.302919>}
box{<0,0,-0.127000><0.087014,0.035000,0.127000> rotate<0,-44.997030,0> translate<44.388472,-1.535000,17.241391> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.388472,-1.535000,20.858606>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,20.797078>}
box{<0,0,-0.127000><0.087014,0.035000,0.127000> rotate<0,44.997030,0> translate<44.388472,-1.535000,20.858606> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.388472,-1.535000,24.861391>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,24.922919>}
box{<0,0,-0.127000><0.087014,0.035000,0.127000> rotate<0,-44.997030,0> translate<44.388472,-1.535000,24.861391> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.419078,-1.535000,20.828000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,20.828000>}
box{<0,0,-0.127000><0.030922,0.035000,0.127000> rotate<0,0.000000,0> translate<44.419078,-1.535000,20.828000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.419081,-1.535000,17.272000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,17.272000>}
box{<0,0,-0.127000><0.030919,0.035000,0.127000> rotate<0,0.000000,0> translate<44.419081,-1.535000,17.272000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.419081,-1.535000,24.892000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,24.892000>}
box{<0,0,-0.127000><0.030919,0.035000,0.127000> rotate<0,0.000000,0> translate<44.419081,-1.535000,24.892000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,5.416056>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,-0.736600>}
box{<0,0,-0.127000><6.152656,0.035000,0.127000> rotate<0,-90.000000,0> translate<44.450000,-1.535000,-0.736600> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,17.302919>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,12.363941>}
box{<0,0,-0.127000><4.938978,0.035000,0.127000> rotate<0,-90.000000,0> translate<44.450000,-1.535000,12.363941> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,24.922919>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<44.450000,-1.535000,20.797078>}
box{<0,0,-0.127000><4.125841,0.035000,0.127000> rotate<0,-90.000000,0> translate<44.450000,-1.535000,20.797078> }
texture{col_pol}
}
#end
union{
cylinder{<1.270000,0.038000,1.270000><1.270000,-1.538000,1.270000>0.508000}
cylinder{<3.810000,0.038000,1.270000><3.810000,-1.538000,1.270000>0.508000}
cylinder{<6.350000,0.038000,1.270000><6.350000,-1.538000,1.270000>0.508000}
cylinder{<8.890000,0.038000,1.270000><8.890000,-1.538000,1.270000>0.508000}
cylinder{<34.290000,0.038000,1.270000><34.290000,-1.538000,1.270000>0.508000}
cylinder{<36.830000,0.038000,1.270000><36.830000,-1.538000,1.270000>0.508000}
cylinder{<39.370000,0.038000,1.270000><39.370000,-1.538000,1.270000>0.508000}
cylinder{<41.910000,0.038000,1.270000><41.910000,-1.538000,1.270000>0.508000}
cylinder{<41.910000,0.038000,7.620000><41.910000,-1.538000,7.620000>0.508000}
cylinder{<41.910000,0.038000,10.160000><41.910000,-1.538000,10.160000>0.508000}
cylinder{<41.910000,0.038000,12.700000><41.910000,-1.538000,12.700000>0.508000}
cylinder{<7.620000,0.038000,34.290000><7.620000,-1.538000,34.290000>0.508000}
cylinder{<10.160000,0.038000,34.290000><10.160000,-1.538000,34.290000>0.508000}
cylinder{<12.700000,0.038000,34.290000><12.700000,-1.538000,34.290000>0.508000}
cylinder{<15.240000,0.038000,34.290000><15.240000,-1.538000,34.290000>0.508000}
cylinder{<17.780000,0.038000,34.290000><17.780000,-1.538000,34.290000>0.508000}
cylinder{<20.320000,0.038000,34.290000><20.320000,-1.538000,34.290000>0.508000}
cylinder{<22.860000,0.038000,34.290000><22.860000,-1.538000,34.290000>0.508000}
cylinder{<25.400000,0.038000,34.290000><25.400000,-1.538000,34.290000>0.508000}
cylinder{<27.940000,0.038000,34.290000><27.940000,-1.538000,34.290000>0.508000}
cylinder{<30.480000,0.038000,34.290000><30.480000,-1.538000,34.290000>0.508000}
cylinder{<33.020000,0.038000,34.290000><33.020000,-1.538000,34.290000>0.508000}
cylinder{<31.750000,0.038000,20.320000><31.750000,-1.538000,20.320000>0.508000}
cylinder{<31.750000,0.038000,17.780000><31.750000,-1.538000,17.780000>0.508000}
cylinder{<29.210000,0.038000,20.320000><29.210000,-1.538000,20.320000>0.508000}
cylinder{<29.210000,0.038000,17.780000><29.210000,-1.538000,17.780000>0.508000}
cylinder{<26.670000,0.038000,20.320000><26.670000,-1.538000,20.320000>0.508000}
cylinder{<26.670000,0.038000,17.780000><26.670000,-1.538000,17.780000>0.508000}
cylinder{<24.130000,0.038000,20.320000><24.130000,-1.538000,20.320000>0.508000}
cylinder{<24.130000,0.038000,17.780000><24.130000,-1.538000,17.780000>0.508000}
cylinder{<21.590000,0.038000,20.320000><21.590000,-1.538000,20.320000>0.508000}
cylinder{<21.590000,0.038000,17.780000><21.590000,-1.538000,17.780000>0.508000}
cylinder{<19.050000,0.038000,20.320000><19.050000,-1.538000,20.320000>0.508000}
cylinder{<19.050000,0.038000,17.780000><19.050000,-1.538000,17.780000>0.508000}
cylinder{<16.510000,0.038000,20.320000><16.510000,-1.538000,20.320000>0.508000}
cylinder{<16.510000,0.038000,17.780000><16.510000,-1.538000,17.780000>0.508000}
cylinder{<13.970000,0.038000,20.320000><13.970000,-1.538000,20.320000>0.508000}
cylinder{<13.970000,0.038000,17.780000><13.970000,-1.538000,17.780000>0.508000}
cylinder{<11.430000,0.038000,20.320000><11.430000,-1.538000,20.320000>0.508000}
cylinder{<11.430000,0.038000,17.780000><11.430000,-1.538000,17.780000>0.508000}
cylinder{<8.890000,0.038000,20.320000><8.890000,-1.538000,20.320000>0.508000}
cylinder{<8.890000,0.038000,17.780000><8.890000,-1.538000,17.780000>0.508000}
cylinder{<6.350000,0.038000,20.320000><6.350000,-1.538000,20.320000>0.508000}
cylinder{<6.350000,0.038000,17.780000><6.350000,-1.538000,17.780000>0.508000}
cylinder{<3.810000,0.038000,20.320000><3.810000,-1.538000,20.320000>0.508000}
cylinder{<3.810000,0.038000,17.780000><3.810000,-1.538000,17.780000>0.508000}
cylinder{<1.270000,0.038000,20.320000><1.270000,-1.538000,20.320000>0.508000}
cylinder{<1.270000,0.038000,17.780000><1.270000,-1.538000,17.780000>0.508000}
cylinder{<31.750000,0.038000,26.670000><31.750000,-1.538000,26.670000>0.508000}
cylinder{<31.750000,0.038000,24.130000><31.750000,-1.538000,24.130000>0.508000}
cylinder{<29.210000,0.038000,26.670000><29.210000,-1.538000,26.670000>0.508000}
cylinder{<29.210000,0.038000,24.130000><29.210000,-1.538000,24.130000>0.508000}
cylinder{<26.670000,0.038000,26.670000><26.670000,-1.538000,26.670000>0.508000}
cylinder{<26.670000,0.038000,24.130000><26.670000,-1.538000,24.130000>0.508000}
cylinder{<24.130000,0.038000,26.670000><24.130000,-1.538000,26.670000>0.508000}
cylinder{<24.130000,0.038000,24.130000><24.130000,-1.538000,24.130000>0.508000}
cylinder{<21.590000,0.038000,26.670000><21.590000,-1.538000,26.670000>0.508000}
cylinder{<21.590000,0.038000,24.130000><21.590000,-1.538000,24.130000>0.508000}
cylinder{<19.050000,0.038000,26.670000><19.050000,-1.538000,26.670000>0.508000}
cylinder{<19.050000,0.038000,24.130000><19.050000,-1.538000,24.130000>0.508000}
cylinder{<16.510000,0.038000,26.670000><16.510000,-1.538000,26.670000>0.508000}
cylinder{<16.510000,0.038000,24.130000><16.510000,-1.538000,24.130000>0.508000}
cylinder{<13.970000,0.038000,26.670000><13.970000,-1.538000,26.670000>0.508000}
cylinder{<13.970000,0.038000,24.130000><13.970000,-1.538000,24.130000>0.508000}
cylinder{<11.430000,0.038000,26.670000><11.430000,-1.538000,26.670000>0.508000}
cylinder{<11.430000,0.038000,24.130000><11.430000,-1.538000,24.130000>0.508000}
cylinder{<8.890000,0.038000,26.670000><8.890000,-1.538000,26.670000>0.508000}
cylinder{<8.890000,0.038000,24.130000><8.890000,-1.538000,24.130000>0.508000}
cylinder{<6.350000,0.038000,26.670000><6.350000,-1.538000,26.670000>0.508000}
cylinder{<6.350000,0.038000,24.130000><6.350000,-1.538000,24.130000>0.508000}
cylinder{<3.810000,0.038000,26.670000><3.810000,-1.538000,26.670000>0.508000}
cylinder{<3.810000,0.038000,24.130000><3.810000,-1.538000,24.130000>0.508000}
cylinder{<1.270000,0.038000,26.670000><1.270000,-1.538000,26.670000>0.508000}
cylinder{<1.270000,0.038000,24.130000><1.270000,-1.538000,24.130000>0.508000}
cylinder{<36.830000,0.038000,20.955000><36.830000,-1.538000,20.955000>0.450000}
cylinder{<34.290000,0.038000,22.225000><34.290000,-1.538000,22.225000>0.450000}
cylinder{<36.830000,0.038000,23.495000><36.830000,-1.538000,23.495000>0.450000}
cylinder{<34.290000,0.038000,24.765000><34.290000,-1.538000,24.765000>0.450000}
//Holes(fast)/Vias
cylinder{<1.270000,0.038000,11.430000><1.270000,-1.538000,11.430000>0.300000 }
cylinder{<30.480000,0.038000,2.540000><30.480000,-1.538000,2.540000>0.300000 }
cylinder{<22.860000,0.038000,8.890000><22.860000,-1.538000,8.890000>0.300000 }
cylinder{<35.560000,0.038000,19.050000><35.560000,-1.538000,19.050000>0.300000 }
cylinder{<25.400000,0.038000,3.810000><25.400000,-1.538000,3.810000>0.300000 }
cylinder{<33.020000,0.038000,3.810000><33.020000,-1.538000,3.810000>0.300000 }
cylinder{<5.080000,0.038000,11.430000><5.080000,-1.538000,11.430000>0.300000 }
cylinder{<5.080000,0.038000,15.240000><5.080000,-1.538000,15.240000>0.300000 }
cylinder{<21.590000,0.038000,7.620000><21.590000,-1.538000,7.620000>0.300000 }
cylinder{<21.590000,0.038000,2.540000><21.590000,-1.538000,2.540000>0.300000 }
cylinder{<2.540000,0.038000,5.080000><2.540000,-1.538000,5.080000>0.300000 }
cylinder{<8.890000,0.038000,11.430000><8.890000,-1.538000,11.430000>0.300000 }
cylinder{<15.240000,0.038000,6.350000><15.240000,-1.538000,6.350000>0.300000 }
cylinder{<33.020000,0.038000,16.510000><33.020000,-1.538000,16.510000>0.300000 }
cylinder{<35.560000,0.038000,16.510000><35.560000,-1.538000,16.510000>0.300000 }
cylinder{<30.480000,0.038000,8.890000><30.480000,-1.538000,8.890000>0.300000 }
cylinder{<25.400000,0.038000,13.970000><25.400000,-1.538000,13.970000>0.300000 }
cylinder{<34.290000,0.038000,13.970000><34.290000,-1.538000,13.970000>0.300000 }
//Holes(fast)/Board
texture{col_hls}
}
#if(pcb_silkscreen=on)
//Silk Screen
union{
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.138100,0.000000,13.208400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.765169,0.000000,13.208400>}
box{<0,0,-0.038100><0.627069,0.036000,0.038100> rotate<0,0.000000,0> translate<38.138100,0.000000,13.208400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.451634,0.000000,13.521934>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.451634,0.000000,12.894866>}
box{<0,0,-0.038100><0.627069,0.036000,0.038100> rotate<0,-90.000000,0> translate<38.451634,0.000000,12.894866> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<39.700688,0.000000,13.678703>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<39.073619,0.000000,13.678703>}
box{<0,0,-0.038100><0.627069,0.036000,0.038100> rotate<0,0.000000,0> translate<39.073619,0.000000,13.678703> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<39.073619,0.000000,13.678703>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<39.073619,0.000000,13.208400>}
box{<0,0,-0.038100><0.470303,0.036000,0.038100> rotate<0,-90.000000,0> translate<39.073619,0.000000,13.208400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<39.073619,0.000000,13.208400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<39.387153,0.000000,13.365169>}
box{<0,0,-0.038100><0.350543,0.036000,0.038100> rotate<0,-26.563526,0> translate<39.073619,0.000000,13.208400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<39.387153,0.000000,13.365169>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<39.543919,0.000000,13.365169>}
box{<0,0,-0.038100><0.156766,0.036000,0.038100> rotate<0,0.000000,0> translate<39.387153,0.000000,13.365169> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<39.543919,0.000000,13.365169>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<39.700688,0.000000,13.208400>}
box{<0,0,-0.038100><0.221704,0.036000,0.038100> rotate<0,44.997030,0> translate<39.543919,0.000000,13.365169> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<39.700688,0.000000,13.208400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<39.700688,0.000000,12.894866>}
box{<0,0,-0.038100><0.313534,0.036000,0.038100> rotate<0,-90.000000,0> translate<39.700688,0.000000,12.894866> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<39.700688,0.000000,12.894866>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<39.543919,0.000000,12.738100>}
box{<0,0,-0.038100><0.221702,0.036000,0.038100> rotate<0,-44.996459,0> translate<39.543919,0.000000,12.738100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<39.543919,0.000000,12.738100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<39.230384,0.000000,12.738100>}
box{<0,0,-0.038100><0.313534,0.036000,0.038100> rotate<0,0.000000,0> translate<39.230384,0.000000,12.738100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<39.230384,0.000000,12.738100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<39.073619,0.000000,12.894866>}
box{<0,0,-0.038100><0.221700,0.036000,0.038100> rotate<0,44.997030,0> translate<39.073619,0.000000,12.894866> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.009138,0.000000,13.678703>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.009138,0.000000,13.051634>}
box{<0,0,-0.038100><0.627069,0.036000,0.038100> rotate<0,-90.000000,0> translate<40.009138,0.000000,13.051634> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.009138,0.000000,13.051634>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.322672,0.000000,12.738100>}
box{<0,0,-0.038100><0.443405,0.036000,0.038100> rotate<0,44.997030,0> translate<40.009138,0.000000,13.051634> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.322672,0.000000,12.738100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.636206,0.000000,13.051634>}
box{<0,0,-0.038100><0.443405,0.036000,0.038100> rotate<0,-44.997030,0> translate<40.322672,0.000000,12.738100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.636206,0.000000,13.051634>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.636206,0.000000,13.678703>}
box{<0,0,-0.038100><0.627069,0.036000,0.038100> rotate<0,90.000000,0> translate<40.636206,0.000000,13.678703> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.138100,0.000000,9.868703>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.138100,0.000000,8.928100>}
box{<0,0,-0.038100><0.940603,0.036000,0.038100> rotate<0,-90.000000,0> translate<38.138100,0.000000,8.928100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.138100,0.000000,8.928100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.608400,0.000000,8.928100>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,0.000000,0> translate<38.138100,0.000000,8.928100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.608400,0.000000,8.928100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.765169,0.000000,9.084866>}
box{<0,0,-0.038100><0.221702,0.036000,0.038100> rotate<0,-44.996459,0> translate<38.608400,0.000000,8.928100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.765169,0.000000,9.084866>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.765169,0.000000,9.711934>}
box{<0,0,-0.038100><0.627069,0.036000,0.038100> rotate<0,90.000000,0> translate<38.765169,0.000000,9.711934> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.765169,0.000000,9.711934>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.608400,0.000000,9.868703>}
box{<0,0,-0.038100><0.221704,0.036000,0.038100> rotate<0,44.997030,0> translate<38.608400,0.000000,9.868703> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.608400,0.000000,9.868703>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.138100,0.000000,9.868703>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,0.000000,0> translate<38.138100,0.000000,9.868703> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<39.230384,0.000000,9.555169>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<39.543919,0.000000,9.555169>}
box{<0,0,-0.038100><0.313534,0.036000,0.038100> rotate<0,0.000000,0> translate<39.230384,0.000000,9.555169> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<39.543919,0.000000,9.555169>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<39.700688,0.000000,9.398400>}
box{<0,0,-0.038100><0.221704,0.036000,0.038100> rotate<0,44.997030,0> translate<39.543919,0.000000,9.555169> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<39.700688,0.000000,9.398400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<39.700688,0.000000,8.928100>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,-90.000000,0> translate<39.700688,0.000000,8.928100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<39.700688,0.000000,8.928100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<39.230384,0.000000,8.928100>}
box{<0,0,-0.038100><0.470303,0.036000,0.038100> rotate<0,0.000000,0> translate<39.230384,0.000000,8.928100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<39.230384,0.000000,8.928100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<39.073619,0.000000,9.084866>}
box{<0,0,-0.038100><0.221700,0.036000,0.038100> rotate<0,44.997030,0> translate<39.073619,0.000000,9.084866> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<39.073619,0.000000,9.084866>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<39.230384,0.000000,9.241634>}
box{<0,0,-0.038100><0.221702,0.036000,0.038100> rotate<0,-44.997601,0> translate<39.073619,0.000000,9.084866> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<39.230384,0.000000,9.241634>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<39.700688,0.000000,9.241634>}
box{<0,0,-0.038100><0.470303,0.036000,0.038100> rotate<0,0.000000,0> translate<39.230384,0.000000,9.241634> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.165903,0.000000,9.711934>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.165903,0.000000,9.084866>}
box{<0,0,-0.038100><0.627069,0.036000,0.038100> rotate<0,-90.000000,0> translate<40.165903,0.000000,9.084866> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.165903,0.000000,9.084866>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.322672,0.000000,8.928100>}
box{<0,0,-0.038100><0.221702,0.036000,0.038100> rotate<0,44.996459,0> translate<40.165903,0.000000,9.084866> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.009138,0.000000,9.555169>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.322672,0.000000,9.555169>}
box{<0,0,-0.038100><0.313534,0.036000,0.038100> rotate<0,0.000000,0> translate<40.009138,0.000000,9.555169> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.789581,0.000000,9.555169>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<41.103116,0.000000,9.555169>}
box{<0,0,-0.038100><0.313534,0.036000,0.038100> rotate<0,0.000000,0> translate<40.789581,0.000000,9.555169> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<41.103116,0.000000,9.555169>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<41.259884,0.000000,9.398400>}
box{<0,0,-0.038100><0.221704,0.036000,0.038100> rotate<0,44.997030,0> translate<41.103116,0.000000,9.555169> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<41.259884,0.000000,9.398400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<41.259884,0.000000,8.928100>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,-90.000000,0> translate<41.259884,0.000000,8.928100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<41.259884,0.000000,8.928100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.789581,0.000000,8.928100>}
box{<0,0,-0.038100><0.470303,0.036000,0.038100> rotate<0,0.000000,0> translate<40.789581,0.000000,8.928100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.789581,0.000000,8.928100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.632816,0.000000,9.084866>}
box{<0,0,-0.038100><0.221700,0.036000,0.038100> rotate<0,44.997030,0> translate<40.632816,0.000000,9.084866> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.632816,0.000000,9.084866>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.789581,0.000000,9.241634>}
box{<0,0,-0.038100><0.221702,0.036000,0.038100> rotate<0,-44.997601,0> translate<40.632816,0.000000,9.084866> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.789581,0.000000,9.241634>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<41.259884,0.000000,9.241634>}
box{<0,0,-0.038100><0.470303,0.036000,0.038100> rotate<0,0.000000,0> translate<40.789581,0.000000,9.241634> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.765169,0.000000,7.171934>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.608400,0.000000,7.328703>}
box{<0,0,-0.038100><0.221704,0.036000,0.038100> rotate<0,44.997030,0> translate<38.608400,0.000000,7.328703> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.608400,0.000000,7.328703>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.294866,0.000000,7.328703>}
box{<0,0,-0.038100><0.313534,0.036000,0.038100> rotate<0,0.000000,0> translate<38.294866,0.000000,7.328703> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.294866,0.000000,7.328703>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.138100,0.000000,7.171934>}
box{<0,0,-0.038100><0.221702,0.036000,0.038100> rotate<0,-44.997601,0> translate<38.138100,0.000000,7.171934> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.138100,0.000000,7.171934>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.138100,0.000000,6.544866>}
box{<0,0,-0.038100><0.627069,0.036000,0.038100> rotate<0,-90.000000,0> translate<38.138100,0.000000,6.544866> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.138100,0.000000,6.544866>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.294866,0.000000,6.388100>}
box{<0,0,-0.038100><0.221700,0.036000,0.038100> rotate<0,44.997030,0> translate<38.138100,0.000000,6.544866> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.294866,0.000000,6.388100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.608400,0.000000,6.388100>}
box{<0,0,-0.038100><0.313534,0.036000,0.038100> rotate<0,0.000000,0> translate<38.294866,0.000000,6.388100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.608400,0.000000,6.388100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.765169,0.000000,6.544866>}
box{<0,0,-0.038100><0.221702,0.036000,0.038100> rotate<0,-44.996459,0> translate<38.608400,0.000000,6.388100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.765169,0.000000,6.544866>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.765169,0.000000,6.858400>}
box{<0,0,-0.038100><0.313534,0.036000,0.038100> rotate<0,90.000000,0> translate<38.765169,0.000000,6.858400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.765169,0.000000,6.858400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.451634,0.000000,6.858400>}
box{<0,0,-0.038100><0.313534,0.036000,0.038100> rotate<0,0.000000,0> translate<38.451634,0.000000,6.858400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<39.073619,0.000000,6.388100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<39.073619,0.000000,7.328703>}
box{<0,0,-0.038100><0.940603,0.036000,0.038100> rotate<0,90.000000,0> translate<39.073619,0.000000,7.328703> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<39.073619,0.000000,7.328703>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<39.700688,0.000000,6.388100>}
box{<0,0,-0.038100><1.130464,0.036000,0.038100> rotate<0,56.306216,0> translate<39.073619,0.000000,7.328703> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<39.700688,0.000000,6.388100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<39.700688,0.000000,7.328703>}
box{<0,0,-0.038100><0.940603,0.036000,0.038100> rotate<0,90.000000,0> translate<39.700688,0.000000,7.328703> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.009138,0.000000,7.328703>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.009138,0.000000,6.388100>}
box{<0,0,-0.038100><0.940603,0.036000,0.038100> rotate<0,-90.000000,0> translate<40.009138,0.000000,6.388100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.009138,0.000000,6.388100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.479438,0.000000,6.388100>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,0.000000,0> translate<40.009138,0.000000,6.388100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.479438,0.000000,6.388100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.636206,0.000000,6.544866>}
box{<0,0,-0.038100><0.221702,0.036000,0.038100> rotate<0,-44.996459,0> translate<40.479438,0.000000,6.388100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.636206,0.000000,6.544866>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.636206,0.000000,7.171934>}
box{<0,0,-0.038100><0.627069,0.036000,0.038100> rotate<0,90.000000,0> translate<40.636206,0.000000,7.171934> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.636206,0.000000,7.171934>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.479438,0.000000,7.328703>}
box{<0,0,-0.038100><0.221704,0.036000,0.038100> rotate<0,44.997030,0> translate<40.479438,0.000000,7.328703> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.479438,0.000000,7.328703>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.009138,0.000000,7.328703>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,0.000000,0> translate<40.009138,0.000000,7.328703> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.358066,0.000000,3.205169>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.201297,0.000000,3.048400>}
box{<0,0,-0.038100><0.221704,0.036000,0.038100> rotate<0,-44.997030,0> translate<42.201297,0.000000,3.048400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.201297,0.000000,3.048400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.201297,0.000000,2.734866>}
box{<0,0,-0.038100><0.313534,0.036000,0.038100> rotate<0,-90.000000,0> translate<42.201297,0.000000,2.734866> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.201297,0.000000,2.734866>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.358066,0.000000,2.578100>}
box{<0,0,-0.038100><0.221702,0.036000,0.038100> rotate<0,44.996459,0> translate<42.201297,0.000000,2.734866> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.358066,0.000000,2.578100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.985134,0.000000,2.578100>}
box{<0,0,-0.038100><0.627069,0.036000,0.038100> rotate<0,0.000000,0> translate<42.358066,0.000000,2.578100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.985134,0.000000,2.578100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.141900,0.000000,2.734866>}
box{<0,0,-0.038100><0.221700,0.036000,0.038100> rotate<0,-44.997030,0> translate<42.985134,0.000000,2.578100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.141900,0.000000,2.734866>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.141900,0.000000,3.048400>}
box{<0,0,-0.038100><0.313534,0.036000,0.038100> rotate<0,90.000000,0> translate<43.141900,0.000000,3.048400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.141900,0.000000,3.048400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.985134,0.000000,3.205169>}
box{<0,0,-0.038100><0.221702,0.036000,0.038100> rotate<0,44.997601,0> translate<42.985134,0.000000,3.205169> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.985134,0.000000,3.205169>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.671600,0.000000,3.205169>}
box{<0,0,-0.038100><0.313534,0.036000,0.038100> rotate<0,0.000000,0> translate<42.671600,0.000000,3.205169> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.671600,0.000000,3.205169>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.671600,0.000000,2.891634>}
box{<0,0,-0.038100><0.313534,0.036000,0.038100> rotate<0,-90.000000,0> translate<42.671600,0.000000,2.891634> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.141900,0.000000,3.513619>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.201297,0.000000,3.513619>}
box{<0,0,-0.038100><0.940603,0.036000,0.038100> rotate<0,0.000000,0> translate<42.201297,0.000000,3.513619> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.201297,0.000000,3.513619>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.141900,0.000000,4.140688>}
box{<0,0,-0.038100><1.130464,0.036000,0.038100> rotate<0,-33.687844,0> translate<42.201297,0.000000,3.513619> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.141900,0.000000,4.140688>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.201297,0.000000,4.140688>}
box{<0,0,-0.038100><0.940603,0.036000,0.038100> rotate<0,0.000000,0> translate<42.201297,0.000000,4.140688> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.201297,0.000000,4.449137>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.141900,0.000000,4.449137>}
box{<0,0,-0.038100><0.940603,0.036000,0.038100> rotate<0,0.000000,0> translate<42.201297,0.000000,4.449137> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.141900,0.000000,4.449137>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.141900,0.000000,4.919437>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,90.000000,0> translate<43.141900,0.000000,4.919437> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.141900,0.000000,4.919437>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.985134,0.000000,5.076206>}
box{<0,0,-0.038100><0.221702,0.036000,0.038100> rotate<0,44.997601,0> translate<42.985134,0.000000,5.076206> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.985134,0.000000,5.076206>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.358066,0.000000,5.076206>}
box{<0,0,-0.038100><0.627069,0.036000,0.038100> rotate<0,0.000000,0> translate<42.358066,0.000000,5.076206> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.358066,0.000000,5.076206>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.201297,0.000000,4.919437>}
box{<0,0,-0.038100><0.221704,0.036000,0.038100> rotate<0,-44.997030,0> translate<42.201297,0.000000,4.919437> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.201297,0.000000,4.919437>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.201297,0.000000,4.449137>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,-90.000000,0> translate<42.201297,0.000000,4.449137> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<39.661297,0.000000,2.578100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.601900,0.000000,2.578100>}
box{<0,0,-0.038100><0.940603,0.036000,0.038100> rotate<0,0.000000,0> translate<39.661297,0.000000,2.578100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.601900,0.000000,2.578100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.601900,0.000000,3.048400>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,90.000000,0> translate<40.601900,0.000000,3.048400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.601900,0.000000,3.048400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.445134,0.000000,3.205169>}
box{<0,0,-0.038100><0.221702,0.036000,0.038100> rotate<0,44.997601,0> translate<40.445134,0.000000,3.205169> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.445134,0.000000,3.205169>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<39.818066,0.000000,3.205169>}
box{<0,0,-0.038100><0.627069,0.036000,0.038100> rotate<0,0.000000,0> translate<39.818066,0.000000,3.205169> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<39.818066,0.000000,3.205169>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<39.661297,0.000000,3.048400>}
box{<0,0,-0.038100><0.221704,0.036000,0.038100> rotate<0,-44.997030,0> translate<39.661297,0.000000,3.048400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<39.661297,0.000000,3.048400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<39.661297,0.000000,2.578100>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,-90.000000,0> translate<39.661297,0.000000,2.578100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<39.974831,0.000000,3.670384>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<39.974831,0.000000,3.983919>}
box{<0,0,-0.038100><0.313534,0.036000,0.038100> rotate<0,90.000000,0> translate<39.974831,0.000000,3.983919> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<39.974831,0.000000,3.983919>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.131600,0.000000,4.140688>}
box{<0,0,-0.038100><0.221704,0.036000,0.038100> rotate<0,-44.997030,0> translate<39.974831,0.000000,3.983919> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.131600,0.000000,4.140688>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.601900,0.000000,4.140688>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,0.000000,0> translate<40.131600,0.000000,4.140688> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.601900,0.000000,4.140688>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.601900,0.000000,3.670384>}
box{<0,0,-0.038100><0.470303,0.036000,0.038100> rotate<0,-90.000000,0> translate<40.601900,0.000000,3.670384> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.601900,0.000000,3.670384>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.445134,0.000000,3.513619>}
box{<0,0,-0.038100><0.221700,0.036000,0.038100> rotate<0,-44.997030,0> translate<40.445134,0.000000,3.513619> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.445134,0.000000,3.513619>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.288366,0.000000,3.670384>}
box{<0,0,-0.038100><0.221702,0.036000,0.038100> rotate<0,44.996459,0> translate<40.288366,0.000000,3.670384> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.288366,0.000000,3.670384>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.288366,0.000000,4.140688>}
box{<0,0,-0.038100><0.470303,0.036000,0.038100> rotate<0,90.000000,0> translate<40.288366,0.000000,4.140688> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<39.818066,0.000000,4.605903>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.445134,0.000000,4.605903>}
box{<0,0,-0.038100><0.627069,0.036000,0.038100> rotate<0,0.000000,0> translate<39.818066,0.000000,4.605903> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.445134,0.000000,4.605903>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.601900,0.000000,4.762672>}
box{<0,0,-0.038100><0.221702,0.036000,0.038100> rotate<0,-44.997601,0> translate<40.445134,0.000000,4.605903> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<39.974831,0.000000,4.449137>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<39.974831,0.000000,4.762672>}
box{<0,0,-0.038100><0.313534,0.036000,0.038100> rotate<0,90.000000,0> translate<39.974831,0.000000,4.762672> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<39.974831,0.000000,5.229581>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<39.974831,0.000000,5.543116>}
box{<0,0,-0.038100><0.313534,0.036000,0.038100> rotate<0,90.000000,0> translate<39.974831,0.000000,5.543116> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<39.974831,0.000000,5.543116>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.131600,0.000000,5.699884>}
box{<0,0,-0.038100><0.221704,0.036000,0.038100> rotate<0,-44.997030,0> translate<39.974831,0.000000,5.543116> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.131600,0.000000,5.699884>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.601900,0.000000,5.699884>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,0.000000,0> translate<40.131600,0.000000,5.699884> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.601900,0.000000,5.699884>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.601900,0.000000,5.229581>}
box{<0,0,-0.038100><0.470303,0.036000,0.038100> rotate<0,-90.000000,0> translate<40.601900,0.000000,5.229581> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.601900,0.000000,5.229581>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.445134,0.000000,5.072816>}
box{<0,0,-0.038100><0.221700,0.036000,0.038100> rotate<0,-44.997030,0> translate<40.445134,0.000000,5.072816> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.445134,0.000000,5.072816>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.288366,0.000000,5.229581>}
box{<0,0,-0.038100><0.221702,0.036000,0.038100> rotate<0,44.996459,0> translate<40.288366,0.000000,5.229581> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.288366,0.000000,5.229581>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.288366,0.000000,5.699884>}
box{<0,0,-0.038100><0.470303,0.036000,0.038100> rotate<0,90.000000,0> translate<40.288366,0.000000,5.699884> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.121297,0.000000,2.578100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.061900,0.000000,2.578100>}
box{<0,0,-0.038100><0.940603,0.036000,0.038100> rotate<0,0.000000,0> translate<37.121297,0.000000,2.578100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.061900,0.000000,2.578100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.061900,0.000000,3.048400>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,90.000000,0> translate<38.061900,0.000000,3.048400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.061900,0.000000,3.048400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.905134,0.000000,3.205169>}
box{<0,0,-0.038100><0.221702,0.036000,0.038100> rotate<0,44.997601,0> translate<37.905134,0.000000,3.205169> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.905134,0.000000,3.205169>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.278066,0.000000,3.205169>}
box{<0,0,-0.038100><0.627069,0.036000,0.038100> rotate<0,0.000000,0> translate<37.278066,0.000000,3.205169> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.278066,0.000000,3.205169>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.121297,0.000000,3.048400>}
box{<0,0,-0.038100><0.221704,0.036000,0.038100> rotate<0,-44.997030,0> translate<37.121297,0.000000,3.048400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.121297,0.000000,3.048400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.121297,0.000000,2.578100>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,-90.000000,0> translate<37.121297,0.000000,2.578100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.434831,0.000000,3.670384>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.434831,0.000000,3.983919>}
box{<0,0,-0.038100><0.313534,0.036000,0.038100> rotate<0,90.000000,0> translate<37.434831,0.000000,3.983919> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.434831,0.000000,3.983919>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.591600,0.000000,4.140688>}
box{<0,0,-0.038100><0.221704,0.036000,0.038100> rotate<0,-44.997030,0> translate<37.434831,0.000000,3.983919> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.591600,0.000000,4.140688>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.061900,0.000000,4.140688>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,0.000000,0> translate<37.591600,0.000000,4.140688> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.061900,0.000000,4.140688>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.061900,0.000000,3.670384>}
box{<0,0,-0.038100><0.470303,0.036000,0.038100> rotate<0,-90.000000,0> translate<38.061900,0.000000,3.670384> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.061900,0.000000,3.670384>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.905134,0.000000,3.513619>}
box{<0,0,-0.038100><0.221700,0.036000,0.038100> rotate<0,-44.997030,0> translate<37.905134,0.000000,3.513619> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.905134,0.000000,3.513619>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.748366,0.000000,3.670384>}
box{<0,0,-0.038100><0.221702,0.036000,0.038100> rotate<0,44.996459,0> translate<37.748366,0.000000,3.670384> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.748366,0.000000,3.670384>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.748366,0.000000,4.140688>}
box{<0,0,-0.038100><0.470303,0.036000,0.038100> rotate<0,90.000000,0> translate<37.748366,0.000000,4.140688> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.278066,0.000000,4.605903>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.905134,0.000000,4.605903>}
box{<0,0,-0.038100><0.627069,0.036000,0.038100> rotate<0,0.000000,0> translate<37.278066,0.000000,4.605903> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.905134,0.000000,4.605903>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.061900,0.000000,4.762672>}
box{<0,0,-0.038100><0.221702,0.036000,0.038100> rotate<0,-44.997601,0> translate<37.905134,0.000000,4.605903> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.434831,0.000000,4.449137>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.434831,0.000000,4.762672>}
box{<0,0,-0.038100><0.313534,0.036000,0.038100> rotate<0,90.000000,0> translate<37.434831,0.000000,4.762672> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.434831,0.000000,5.229581>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.434831,0.000000,5.543116>}
box{<0,0,-0.038100><0.313534,0.036000,0.038100> rotate<0,90.000000,0> translate<37.434831,0.000000,5.543116> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.434831,0.000000,5.543116>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.591600,0.000000,5.699884>}
box{<0,0,-0.038100><0.221704,0.036000,0.038100> rotate<0,-44.997030,0> translate<37.434831,0.000000,5.543116> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.591600,0.000000,5.699884>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.061900,0.000000,5.699884>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,0.000000,0> translate<37.591600,0.000000,5.699884> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.061900,0.000000,5.699884>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.061900,0.000000,5.229581>}
box{<0,0,-0.038100><0.470303,0.036000,0.038100> rotate<0,-90.000000,0> translate<38.061900,0.000000,5.229581> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.061900,0.000000,5.229581>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.905134,0.000000,5.072816>}
box{<0,0,-0.038100><0.221700,0.036000,0.038100> rotate<0,-44.997030,0> translate<37.905134,0.000000,5.072816> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.905134,0.000000,5.072816>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.748366,0.000000,5.229581>}
box{<0,0,-0.038100><0.221702,0.036000,0.038100> rotate<0,44.996459,0> translate<37.748366,0.000000,5.229581> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.748366,0.000000,5.229581>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.748366,0.000000,5.699884>}
box{<0,0,-0.038100><0.470303,0.036000,0.038100> rotate<0,90.000000,0> translate<37.748366,0.000000,5.699884> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.051600,0.000000,2.578100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.051600,0.000000,3.205169>}
box{<0,0,-0.038100><0.627069,0.036000,0.038100> rotate<0,90.000000,0> translate<35.051600,0.000000,3.205169> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<34.738066,0.000000,2.891634>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.365134,0.000000,2.891634>}
box{<0,0,-0.038100><0.627069,0.036000,0.038100> rotate<0,0.000000,0> translate<34.738066,0.000000,2.891634> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<34.581297,0.000000,4.140688>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<34.581297,0.000000,3.513619>}
box{<0,0,-0.038100><0.627069,0.036000,0.038100> rotate<0,-90.000000,0> translate<34.581297,0.000000,3.513619> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<34.581297,0.000000,3.513619>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.051600,0.000000,3.513619>}
box{<0,0,-0.038100><0.470303,0.036000,0.038100> rotate<0,0.000000,0> translate<34.581297,0.000000,3.513619> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.051600,0.000000,3.513619>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<34.894831,0.000000,3.827153>}
box{<0,0,-0.038100><0.350543,0.036000,0.038100> rotate<0,63.430534,0> translate<34.894831,0.000000,3.827153> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<34.894831,0.000000,3.827153>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<34.894831,0.000000,3.983919>}
box{<0,0,-0.038100><0.156766,0.036000,0.038100> rotate<0,90.000000,0> translate<34.894831,0.000000,3.983919> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<34.894831,0.000000,3.983919>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.051600,0.000000,4.140688>}
box{<0,0,-0.038100><0.221704,0.036000,0.038100> rotate<0,-44.997030,0> translate<34.894831,0.000000,3.983919> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.051600,0.000000,4.140688>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.365134,0.000000,4.140688>}
box{<0,0,-0.038100><0.313534,0.036000,0.038100> rotate<0,0.000000,0> translate<35.051600,0.000000,4.140688> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.365134,0.000000,4.140688>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.521900,0.000000,3.983919>}
box{<0,0,-0.038100><0.221702,0.036000,0.038100> rotate<0,44.997601,0> translate<35.365134,0.000000,4.140688> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.521900,0.000000,3.983919>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.521900,0.000000,3.670384>}
box{<0,0,-0.038100><0.313534,0.036000,0.038100> rotate<0,-90.000000,0> translate<35.521900,0.000000,3.670384> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.521900,0.000000,3.670384>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.365134,0.000000,3.513619>}
box{<0,0,-0.038100><0.221700,0.036000,0.038100> rotate<0,-44.997030,0> translate<35.365134,0.000000,3.513619> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<34.581297,0.000000,4.449137>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.208366,0.000000,4.449137>}
box{<0,0,-0.038100><0.627069,0.036000,0.038100> rotate<0,0.000000,0> translate<34.581297,0.000000,4.449137> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.208366,0.000000,4.449137>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.521900,0.000000,4.762672>}
box{<0,0,-0.038100><0.443405,0.036000,0.038100> rotate<0,-44.997030,0> translate<35.208366,0.000000,4.449137> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.521900,0.000000,4.762672>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.208366,0.000000,5.076206>}
box{<0,0,-0.038100><0.443405,0.036000,0.038100> rotate<0,44.997030,0> translate<35.208366,0.000000,5.076206> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.208366,0.000000,5.076206>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<34.581297,0.000000,5.076206>}
box{<0,0,-0.038100><0.627069,0.036000,0.038100> rotate<0,0.000000,0> translate<34.581297,0.000000,5.076206> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<9.651600,0.000000,2.578100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<9.651600,0.000000,3.205169>}
box{<0,0,-0.038100><0.627069,0.036000,0.038100> rotate<0,90.000000,0> translate<9.651600,0.000000,3.205169> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<9.338066,0.000000,2.891634>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<9.965134,0.000000,2.891634>}
box{<0,0,-0.038100><0.627069,0.036000,0.038100> rotate<0,0.000000,0> translate<9.338066,0.000000,2.891634> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<9.181297,0.000000,4.140688>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<9.181297,0.000000,3.513619>}
box{<0,0,-0.038100><0.627069,0.036000,0.038100> rotate<0,-90.000000,0> translate<9.181297,0.000000,3.513619> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<9.181297,0.000000,3.513619>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<9.651600,0.000000,3.513619>}
box{<0,0,-0.038100><0.470303,0.036000,0.038100> rotate<0,0.000000,0> translate<9.181297,0.000000,3.513619> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<9.651600,0.000000,3.513619>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<9.494831,0.000000,3.827153>}
box{<0,0,-0.038100><0.350543,0.036000,0.038100> rotate<0,63.430534,0> translate<9.494831,0.000000,3.827153> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<9.494831,0.000000,3.827153>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<9.494831,0.000000,3.983919>}
box{<0,0,-0.038100><0.156766,0.036000,0.038100> rotate<0,90.000000,0> translate<9.494831,0.000000,3.983919> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<9.494831,0.000000,3.983919>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<9.651600,0.000000,4.140688>}
box{<0,0,-0.038100><0.221704,0.036000,0.038100> rotate<0,-44.997030,0> translate<9.494831,0.000000,3.983919> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<9.651600,0.000000,4.140688>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<9.965134,0.000000,4.140688>}
box{<0,0,-0.038100><0.313534,0.036000,0.038100> rotate<0,0.000000,0> translate<9.651600,0.000000,4.140688> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<9.965134,0.000000,4.140688>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<10.121900,0.000000,3.983919>}
box{<0,0,-0.038100><0.221702,0.036000,0.038100> rotate<0,44.997601,0> translate<9.965134,0.000000,4.140688> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<10.121900,0.000000,3.983919>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<10.121900,0.000000,3.670384>}
box{<0,0,-0.038100><0.313534,0.036000,0.038100> rotate<0,-90.000000,0> translate<10.121900,0.000000,3.670384> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<10.121900,0.000000,3.670384>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<9.965134,0.000000,3.513619>}
box{<0,0,-0.038100><0.221700,0.036000,0.038100> rotate<0,-44.997030,0> translate<9.965134,0.000000,3.513619> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<9.181297,0.000000,4.449137>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<9.808366,0.000000,4.449137>}
box{<0,0,-0.038100><0.627069,0.036000,0.038100> rotate<0,0.000000,0> translate<9.181297,0.000000,4.449137> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<9.808366,0.000000,4.449137>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<10.121900,0.000000,4.762672>}
box{<0,0,-0.038100><0.443405,0.036000,0.038100> rotate<0,-44.997030,0> translate<9.808366,0.000000,4.449137> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<10.121900,0.000000,4.762672>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<9.808366,0.000000,5.076206>}
box{<0,0,-0.038100><0.443405,0.036000,0.038100> rotate<0,44.997030,0> translate<9.808366,0.000000,5.076206> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<9.808366,0.000000,5.076206>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<9.181297,0.000000,5.076206>}
box{<0,0,-0.038100><0.627069,0.036000,0.038100> rotate<0,0.000000,0> translate<9.181297,0.000000,5.076206> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<6.798066,0.000000,3.205169>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<6.641297,0.000000,3.048400>}
box{<0,0,-0.038100><0.221704,0.036000,0.038100> rotate<0,-44.997030,0> translate<6.641297,0.000000,3.048400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<6.641297,0.000000,3.048400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<6.641297,0.000000,2.734866>}
box{<0,0,-0.038100><0.313534,0.036000,0.038100> rotate<0,-90.000000,0> translate<6.641297,0.000000,2.734866> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<6.641297,0.000000,2.734866>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<6.798066,0.000000,2.578100>}
box{<0,0,-0.038100><0.221702,0.036000,0.038100> rotate<0,44.996459,0> translate<6.641297,0.000000,2.734866> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<6.798066,0.000000,2.578100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<7.425134,0.000000,2.578100>}
box{<0,0,-0.038100><0.627069,0.036000,0.038100> rotate<0,0.000000,0> translate<6.798066,0.000000,2.578100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<7.425134,0.000000,2.578100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<7.581900,0.000000,2.734866>}
box{<0,0,-0.038100><0.221700,0.036000,0.038100> rotate<0,-44.997030,0> translate<7.425134,0.000000,2.578100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<7.581900,0.000000,2.734866>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<7.581900,0.000000,3.048400>}
box{<0,0,-0.038100><0.313534,0.036000,0.038100> rotate<0,90.000000,0> translate<7.581900,0.000000,3.048400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<7.581900,0.000000,3.048400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<7.425134,0.000000,3.205169>}
box{<0,0,-0.038100><0.221702,0.036000,0.038100> rotate<0,44.997601,0> translate<7.425134,0.000000,3.205169> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<7.425134,0.000000,3.205169>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<7.111600,0.000000,3.205169>}
box{<0,0,-0.038100><0.313534,0.036000,0.038100> rotate<0,0.000000,0> translate<7.111600,0.000000,3.205169> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<7.111600,0.000000,3.205169>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<7.111600,0.000000,2.891634>}
box{<0,0,-0.038100><0.313534,0.036000,0.038100> rotate<0,-90.000000,0> translate<7.111600,0.000000,2.891634> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<7.581900,0.000000,3.513619>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<6.641297,0.000000,3.513619>}
box{<0,0,-0.038100><0.940603,0.036000,0.038100> rotate<0,0.000000,0> translate<6.641297,0.000000,3.513619> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<6.641297,0.000000,3.513619>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<7.581900,0.000000,4.140688>}
box{<0,0,-0.038100><1.130464,0.036000,0.038100> rotate<0,-33.687844,0> translate<6.641297,0.000000,3.513619> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<7.581900,0.000000,4.140688>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<6.641297,0.000000,4.140688>}
box{<0,0,-0.038100><0.940603,0.036000,0.038100> rotate<0,0.000000,0> translate<6.641297,0.000000,4.140688> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<6.641297,0.000000,4.449137>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<7.581900,0.000000,4.449137>}
box{<0,0,-0.038100><0.940603,0.036000,0.038100> rotate<0,0.000000,0> translate<6.641297,0.000000,4.449137> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<7.581900,0.000000,4.449137>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<7.581900,0.000000,4.919437>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,90.000000,0> translate<7.581900,0.000000,4.919437> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<7.581900,0.000000,4.919437>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<7.425134,0.000000,5.076206>}
box{<0,0,-0.038100><0.221702,0.036000,0.038100> rotate<0,44.997601,0> translate<7.425134,0.000000,5.076206> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<7.425134,0.000000,5.076206>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<6.798066,0.000000,5.076206>}
box{<0,0,-0.038100><0.627069,0.036000,0.038100> rotate<0,0.000000,0> translate<6.798066,0.000000,5.076206> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<6.798066,0.000000,5.076206>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<6.641297,0.000000,4.919437>}
box{<0,0,-0.038100><0.221704,0.036000,0.038100> rotate<0,-44.997030,0> translate<6.641297,0.000000,4.919437> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<6.641297,0.000000,4.919437>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<6.641297,0.000000,4.449137>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,-90.000000,0> translate<6.641297,0.000000,4.449137> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<4.258066,0.000000,3.205169>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<4.101297,0.000000,3.048400>}
box{<0,0,-0.038100><0.221704,0.036000,0.038100> rotate<0,-44.997030,0> translate<4.101297,0.000000,3.048400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<4.101297,0.000000,3.048400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<4.101297,0.000000,2.734866>}
box{<0,0,-0.038100><0.313534,0.036000,0.038100> rotate<0,-90.000000,0> translate<4.101297,0.000000,2.734866> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<4.101297,0.000000,2.734866>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<4.258066,0.000000,2.578100>}
box{<0,0,-0.038100><0.221702,0.036000,0.038100> rotate<0,44.996459,0> translate<4.101297,0.000000,2.734866> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<4.258066,0.000000,2.578100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<4.885134,0.000000,2.578100>}
box{<0,0,-0.038100><0.627069,0.036000,0.038100> rotate<0,0.000000,0> translate<4.258066,0.000000,2.578100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<4.885134,0.000000,2.578100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<5.041900,0.000000,2.734866>}
box{<0,0,-0.038100><0.221700,0.036000,0.038100> rotate<0,-44.997030,0> translate<4.885134,0.000000,2.578100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<5.041900,0.000000,2.734866>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<5.041900,0.000000,3.048400>}
box{<0,0,-0.038100><0.313534,0.036000,0.038100> rotate<0,90.000000,0> translate<5.041900,0.000000,3.048400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<5.041900,0.000000,3.048400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<4.885134,0.000000,3.205169>}
box{<0,0,-0.038100><0.221702,0.036000,0.038100> rotate<0,44.997601,0> translate<4.885134,0.000000,3.205169> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<4.885134,0.000000,3.205169>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<4.571600,0.000000,3.205169>}
box{<0,0,-0.038100><0.313534,0.036000,0.038100> rotate<0,0.000000,0> translate<4.571600,0.000000,3.205169> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<4.571600,0.000000,3.205169>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<4.571600,0.000000,2.891634>}
box{<0,0,-0.038100><0.313534,0.036000,0.038100> rotate<0,-90.000000,0> translate<4.571600,0.000000,2.891634> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<5.041900,0.000000,3.513619>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<4.101297,0.000000,3.513619>}
box{<0,0,-0.038100><0.940603,0.036000,0.038100> rotate<0,0.000000,0> translate<4.101297,0.000000,3.513619> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<4.101297,0.000000,3.513619>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<5.041900,0.000000,4.140688>}
box{<0,0,-0.038100><1.130464,0.036000,0.038100> rotate<0,-33.687844,0> translate<4.101297,0.000000,3.513619> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<5.041900,0.000000,4.140688>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<4.101297,0.000000,4.140688>}
box{<0,0,-0.038100><0.940603,0.036000,0.038100> rotate<0,0.000000,0> translate<4.101297,0.000000,4.140688> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<4.101297,0.000000,4.449137>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<5.041900,0.000000,4.449137>}
box{<0,0,-0.038100><0.940603,0.036000,0.038100> rotate<0,0.000000,0> translate<4.101297,0.000000,4.449137> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<5.041900,0.000000,4.449137>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<5.041900,0.000000,4.919437>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,90.000000,0> translate<5.041900,0.000000,4.919437> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<5.041900,0.000000,4.919437>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<4.885134,0.000000,5.076206>}
box{<0,0,-0.038100><0.221702,0.036000,0.038100> rotate<0,44.997601,0> translate<4.885134,0.000000,5.076206> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<4.885134,0.000000,5.076206>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<4.258066,0.000000,5.076206>}
box{<0,0,-0.038100><0.627069,0.036000,0.038100> rotate<0,0.000000,0> translate<4.258066,0.000000,5.076206> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<4.258066,0.000000,5.076206>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<4.101297,0.000000,4.919437>}
box{<0,0,-0.038100><0.221704,0.036000,0.038100> rotate<0,-44.997030,0> translate<4.101297,0.000000,4.919437> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<4.101297,0.000000,4.919437>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<4.101297,0.000000,4.449137>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,-90.000000,0> translate<4.101297,0.000000,4.449137> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<2.501900,0.000000,2.578100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<1.874831,0.000000,2.578100>}
box{<0,0,-0.038100><0.627069,0.036000,0.038100> rotate<0,0.000000,0> translate<1.874831,0.000000,2.578100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<1.874831,0.000000,2.578100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<1.561297,0.000000,2.891634>}
box{<0,0,-0.038100><0.443405,0.036000,0.038100> rotate<0,44.997030,0> translate<1.561297,0.000000,2.891634> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<1.561297,0.000000,2.891634>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<1.874831,0.000000,3.205169>}
box{<0,0,-0.038100><0.443405,0.036000,0.038100> rotate<0,-44.997030,0> translate<1.561297,0.000000,2.891634> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<1.874831,0.000000,3.205169>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<2.501900,0.000000,3.205169>}
box{<0,0,-0.038100><0.627069,0.036000,0.038100> rotate<0,0.000000,0> translate<1.874831,0.000000,3.205169> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<2.031600,0.000000,2.578100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<2.031600,0.000000,3.205169>}
box{<0,0,-0.038100><0.627069,0.036000,0.038100> rotate<0,90.000000,0> translate<2.031600,0.000000,3.205169> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<2.501900,0.000000,3.513619>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<1.874831,0.000000,3.513619>}
box{<0,0,-0.038100><0.627069,0.036000,0.038100> rotate<0,0.000000,0> translate<1.874831,0.000000,3.513619> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<1.874831,0.000000,3.513619>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<1.874831,0.000000,3.983919>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,90.000000,0> translate<1.874831,0.000000,3.983919> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<1.874831,0.000000,3.983919>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<2.031600,0.000000,4.140688>}
box{<0,0,-0.038100><0.221704,0.036000,0.038100> rotate<0,-44.997030,0> translate<1.874831,0.000000,3.983919> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<2.031600,0.000000,4.140688>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<2.501900,0.000000,4.140688>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,0.000000,0> translate<2.031600,0.000000,4.140688> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<1.718066,0.000000,4.605903>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<2.345134,0.000000,4.605903>}
box{<0,0,-0.038100><0.627069,0.036000,0.038100> rotate<0,0.000000,0> translate<1.718066,0.000000,4.605903> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<2.345134,0.000000,4.605903>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<2.501900,0.000000,4.762672>}
box{<0,0,-0.038100><0.221702,0.036000,0.038100> rotate<0,-44.997601,0> translate<2.345134,0.000000,4.605903> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<1.874831,0.000000,4.449137>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<1.874831,0.000000,4.762672>}
box{<0,0,-0.038100><0.313534,0.036000,0.038100> rotate<0,90.000000,0> translate<1.874831,0.000000,4.762672> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<2.501900,0.000000,5.543116>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<2.501900,0.000000,5.229581>}
box{<0,0,-0.038100><0.313534,0.036000,0.038100> rotate<0,-90.000000,0> translate<2.501900,0.000000,5.229581> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<2.501900,0.000000,5.229581>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<2.345134,0.000000,5.072816>}
box{<0,0,-0.038100><0.221700,0.036000,0.038100> rotate<0,-44.997030,0> translate<2.345134,0.000000,5.072816> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<2.345134,0.000000,5.072816>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<2.031600,0.000000,5.072816>}
box{<0,0,-0.038100><0.313534,0.036000,0.038100> rotate<0,0.000000,0> translate<2.031600,0.000000,5.072816> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<2.031600,0.000000,5.072816>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<1.874831,0.000000,5.229581>}
box{<0,0,-0.038100><0.221702,0.036000,0.038100> rotate<0,44.996459,0> translate<1.874831,0.000000,5.229581> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<1.874831,0.000000,5.229581>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<1.874831,0.000000,5.543116>}
box{<0,0,-0.038100><0.313534,0.036000,0.038100> rotate<0,90.000000,0> translate<1.874831,0.000000,5.543116> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<1.874831,0.000000,5.543116>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<2.031600,0.000000,5.699884>}
box{<0,0,-0.038100><0.221704,0.036000,0.038100> rotate<0,-44.997030,0> translate<1.874831,0.000000,5.543116> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<2.031600,0.000000,5.699884>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<2.188366,0.000000,5.699884>}
box{<0,0,-0.038100><0.156766,0.036000,0.038100> rotate<0,0.000000,0> translate<2.031600,0.000000,5.699884> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<2.188366,0.000000,5.699884>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<2.188366,0.000000,5.072816>}
box{<0,0,-0.038100><0.627069,0.036000,0.038100> rotate<0,-90.000000,0> translate<2.188366,0.000000,5.072816> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<2.501900,0.000000,6.008334>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<1.874831,0.000000,6.008334>}
box{<0,0,-0.038100><0.627069,0.036000,0.038100> rotate<0,0.000000,0> translate<1.874831,0.000000,6.008334> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<1.874831,0.000000,6.008334>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<1.874831,0.000000,6.478634>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,90.000000,0> translate<1.874831,0.000000,6.478634> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<1.874831,0.000000,6.478634>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<2.031600,0.000000,6.635403>}
box{<0,0,-0.038100><0.221704,0.036000,0.038100> rotate<0,-44.997030,0> translate<1.874831,0.000000,6.478634> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<2.031600,0.000000,6.635403>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<2.501900,0.000000,6.635403>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,0.000000,0> translate<2.031600,0.000000,6.635403> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<2.501900,0.000000,6.943853>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<1.874831,0.000000,6.943853>}
box{<0,0,-0.038100><0.627069,0.036000,0.038100> rotate<0,0.000000,0> translate<1.874831,0.000000,6.943853> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<1.874831,0.000000,6.943853>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<1.874831,0.000000,7.414153>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,90.000000,0> translate<1.874831,0.000000,7.414153> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<1.874831,0.000000,7.414153>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<2.031600,0.000000,7.570922>}
box{<0,0,-0.038100><0.221704,0.036000,0.038100> rotate<0,-44.997030,0> translate<1.874831,0.000000,7.414153> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<2.031600,0.000000,7.570922>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<2.501900,0.000000,7.570922>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,0.000000,0> translate<2.031600,0.000000,7.570922> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<1.874831,0.000000,8.036138>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<1.874831,0.000000,8.349672>}
box{<0,0,-0.038100><0.313534,0.036000,0.038100> rotate<0,90.000000,0> translate<1.874831,0.000000,8.349672> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<1.874831,0.000000,8.349672>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<2.031600,0.000000,8.506441>}
box{<0,0,-0.038100><0.221704,0.036000,0.038100> rotate<0,-44.997030,0> translate<1.874831,0.000000,8.349672> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<2.031600,0.000000,8.506441>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<2.501900,0.000000,8.506441>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,0.000000,0> translate<2.031600,0.000000,8.506441> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<2.501900,0.000000,8.506441>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<2.501900,0.000000,8.036138>}
box{<0,0,-0.038100><0.470303,0.036000,0.038100> rotate<0,-90.000000,0> translate<2.501900,0.000000,8.036138> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<2.501900,0.000000,8.036138>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<2.345134,0.000000,7.879372>}
box{<0,0,-0.038100><0.221700,0.036000,0.038100> rotate<0,-44.997030,0> translate<2.345134,0.000000,7.879372> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<2.345134,0.000000,7.879372>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<2.188366,0.000000,8.036138>}
box{<0,0,-0.038100><0.221702,0.036000,0.038100> rotate<0,44.996459,0> translate<2.188366,0.000000,8.036138> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<2.188366,0.000000,8.036138>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<2.188366,0.000000,8.506441>}
box{<0,0,-0.038100><0.470303,0.036000,0.038100> rotate<0,90.000000,0> translate<2.188366,0.000000,8.506441> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<10.566713,0.000000,2.476500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<10.566713,0.000000,3.213728>}
box{<0,0,-0.038100><0.737228,0.036000,0.038100> rotate<0,90.000000,0> translate<10.566713,0.000000,3.213728> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<10.566713,0.000000,3.213728>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<10.198100,0.000000,2.845112>}
box{<0,0,-0.038100><0.521299,0.036000,0.038100> rotate<0,-44.997273,0> translate<10.198100,0.000000,2.845112> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<10.198100,0.000000,2.845112>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<10.689584,0.000000,2.845112>}
box{<0,0,-0.038100><0.491484,0.036000,0.038100> rotate<0,0.000000,0> translate<10.198100,0.000000,2.845112> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<10.946516,0.000000,3.090856>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<11.069384,0.000000,3.213728>}
box{<0,0,-0.038100><0.173765,0.036000,0.038100> rotate<0,-44.997759,0> translate<10.946516,0.000000,3.090856> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<11.069384,0.000000,3.213728>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<11.315128,0.000000,3.213728>}
box{<0,0,-0.038100><0.245744,0.036000,0.038100> rotate<0,0.000000,0> translate<11.069384,0.000000,3.213728> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<11.315128,0.000000,3.213728>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<11.438000,0.000000,3.090856>}
box{<0,0,-0.038100><0.173767,0.036000,0.038100> rotate<0,44.997030,0> translate<11.315128,0.000000,3.213728> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<11.438000,0.000000,3.090856>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<11.438000,0.000000,2.967984>}
box{<0,0,-0.038100><0.122872,0.036000,0.038100> rotate<0,-90.000000,0> translate<11.438000,0.000000,2.967984> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<11.438000,0.000000,2.967984>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<11.315128,0.000000,2.845112>}
box{<0,0,-0.038100><0.173767,0.036000,0.038100> rotate<0,-44.997030,0> translate<11.315128,0.000000,2.845112> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<11.315128,0.000000,2.845112>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<11.192256,0.000000,2.845112>}
box{<0,0,-0.038100><0.122872,0.036000,0.038100> rotate<0,0.000000,0> translate<11.192256,0.000000,2.845112> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<11.315128,0.000000,2.845112>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<11.438000,0.000000,2.722241>}
box{<0,0,-0.038100><0.173767,0.036000,0.038100> rotate<0,44.997030,0> translate<11.315128,0.000000,2.845112> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<11.438000,0.000000,2.722241>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<11.438000,0.000000,2.599369>}
box{<0,0,-0.038100><0.122872,0.036000,0.038100> rotate<0,-90.000000,0> translate<11.438000,0.000000,2.599369> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<11.438000,0.000000,2.599369>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<11.315128,0.000000,2.476500>}
box{<0,0,-0.038100><0.173765,0.036000,0.038100> rotate<0,-44.996302,0> translate<11.315128,0.000000,2.476500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<11.315128,0.000000,2.476500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<11.069384,0.000000,2.476500>}
box{<0,0,-0.038100><0.245744,0.036000,0.038100> rotate<0,0.000000,0> translate<11.069384,0.000000,2.476500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<11.069384,0.000000,2.476500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<10.946516,0.000000,2.599369>}
box{<0,0,-0.038100><0.173763,0.036000,0.038100> rotate<0,44.997030,0> translate<10.946516,0.000000,2.599369> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<11.694931,0.000000,3.090856>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<11.817800,0.000000,3.213728>}
box{<0,0,-0.038100><0.173765,0.036000,0.038100> rotate<0,-44.997759,0> translate<11.694931,0.000000,3.090856> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<11.817800,0.000000,3.213728>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<12.063544,0.000000,3.213728>}
box{<0,0,-0.038100><0.245744,0.036000,0.038100> rotate<0,0.000000,0> translate<11.817800,0.000000,3.213728> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<12.063544,0.000000,3.213728>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<12.186416,0.000000,3.090856>}
box{<0,0,-0.038100><0.173767,0.036000,0.038100> rotate<0,44.997030,0> translate<12.063544,0.000000,3.213728> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<12.186416,0.000000,3.090856>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<12.186416,0.000000,2.967984>}
box{<0,0,-0.038100><0.122872,0.036000,0.038100> rotate<0,-90.000000,0> translate<12.186416,0.000000,2.967984> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<12.186416,0.000000,2.967984>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<12.063544,0.000000,2.845112>}
box{<0,0,-0.038100><0.173767,0.036000,0.038100> rotate<0,-44.997030,0> translate<12.063544,0.000000,2.845112> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<12.063544,0.000000,2.845112>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<11.940672,0.000000,2.845112>}
box{<0,0,-0.038100><0.122872,0.036000,0.038100> rotate<0,0.000000,0> translate<11.940672,0.000000,2.845112> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<12.063544,0.000000,2.845112>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<12.186416,0.000000,2.722241>}
box{<0,0,-0.038100><0.173767,0.036000,0.038100> rotate<0,44.997030,0> translate<12.063544,0.000000,2.845112> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<12.186416,0.000000,2.722241>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<12.186416,0.000000,2.599369>}
box{<0,0,-0.038100><0.122872,0.036000,0.038100> rotate<0,-90.000000,0> translate<12.186416,0.000000,2.599369> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<12.186416,0.000000,2.599369>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<12.063544,0.000000,2.476500>}
box{<0,0,-0.038100><0.173765,0.036000,0.038100> rotate<0,-44.996302,0> translate<12.063544,0.000000,2.476500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<12.063544,0.000000,2.476500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<11.817800,0.000000,2.476500>}
box{<0,0,-0.038100><0.245744,0.036000,0.038100> rotate<0,0.000000,0> translate<11.817800,0.000000,2.476500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<11.817800,0.000000,2.476500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<11.694931,0.000000,2.599369>}
box{<0,0,-0.038100><0.173763,0.036000,0.038100> rotate<0,44.997030,0> translate<11.694931,0.000000,2.599369> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<12.443347,0.000000,2.476500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<12.443347,0.000000,2.599369>}
box{<0,0,-0.038100><0.122869,0.036000,0.038100> rotate<0,90.000000,0> translate<12.443347,0.000000,2.599369> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<12.443347,0.000000,2.599369>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<12.566216,0.000000,2.599369>}
box{<0,0,-0.038100><0.122869,0.036000,0.038100> rotate<0,0.000000,0> translate<12.443347,0.000000,2.599369> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<12.566216,0.000000,2.599369>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<12.566216,0.000000,2.476500>}
box{<0,0,-0.038100><0.122869,0.036000,0.038100> rotate<0,-90.000000,0> translate<12.566216,0.000000,2.476500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<12.566216,0.000000,2.476500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<12.443347,0.000000,2.476500>}
box{<0,0,-0.038100><0.122869,0.036000,0.038100> rotate<0,0.000000,0> translate<12.443347,0.000000,2.476500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<12.817553,0.000000,2.599369>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<12.940422,0.000000,2.476500>}
box{<0,0,-0.038100><0.173763,0.036000,0.038100> rotate<0,44.997030,0> translate<12.817553,0.000000,2.599369> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<12.940422,0.000000,2.476500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<13.186166,0.000000,2.476500>}
box{<0,0,-0.038100><0.245744,0.036000,0.038100> rotate<0,0.000000,0> translate<12.940422,0.000000,2.476500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<13.186166,0.000000,2.476500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<13.309038,0.000000,2.599369>}
box{<0,0,-0.038100><0.173765,0.036000,0.038100> rotate<0,-44.996302,0> translate<13.186166,0.000000,2.476500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<13.309038,0.000000,2.599369>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<13.309038,0.000000,3.090856>}
box{<0,0,-0.038100><0.491488,0.036000,0.038100> rotate<0,90.000000,0> translate<13.309038,0.000000,3.090856> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<13.309038,0.000000,3.090856>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<13.186166,0.000000,3.213728>}
box{<0,0,-0.038100><0.173767,0.036000,0.038100> rotate<0,44.997030,0> translate<13.186166,0.000000,3.213728> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<13.186166,0.000000,3.213728>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<12.940422,0.000000,3.213728>}
box{<0,0,-0.038100><0.245744,0.036000,0.038100> rotate<0,0.000000,0> translate<12.940422,0.000000,3.213728> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<12.940422,0.000000,3.213728>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<12.817553,0.000000,3.090856>}
box{<0,0,-0.038100><0.173765,0.036000,0.038100> rotate<0,-44.997759,0> translate<12.817553,0.000000,3.090856> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<12.817553,0.000000,3.090856>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<12.817553,0.000000,2.967984>}
box{<0,0,-0.038100><0.122872,0.036000,0.038100> rotate<0,-90.000000,0> translate<12.817553,0.000000,2.967984> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<12.817553,0.000000,2.967984>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<12.940422,0.000000,2.845112>}
box{<0,0,-0.038100><0.173765,0.036000,0.038100> rotate<0,44.997759,0> translate<12.817553,0.000000,2.967984> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<12.940422,0.000000,2.845112>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<13.309038,0.000000,2.845112>}
box{<0,0,-0.038100><0.368616,0.036000,0.038100> rotate<0,0.000000,0> translate<12.940422,0.000000,2.845112> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<14.057453,0.000000,2.476500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<13.565969,0.000000,2.476500>}
box{<0,0,-0.038100><0.491484,0.036000,0.038100> rotate<0,0.000000,0> translate<13.565969,0.000000,2.476500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<13.565969,0.000000,2.476500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<14.057453,0.000000,2.967984>}
box{<0,0,-0.038100><0.695064,0.036000,0.038100> rotate<0,-44.997030,0> translate<13.565969,0.000000,2.476500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<14.057453,0.000000,2.967984>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<14.057453,0.000000,3.090856>}
box{<0,0,-0.038100><0.122872,0.036000,0.038100> rotate<0,90.000000,0> translate<14.057453,0.000000,3.090856> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<14.057453,0.000000,3.090856>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<13.934581,0.000000,3.213728>}
box{<0,0,-0.038100><0.173767,0.036000,0.038100> rotate<0,44.997030,0> translate<13.934581,0.000000,3.213728> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<13.934581,0.000000,3.213728>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<13.688837,0.000000,3.213728>}
box{<0,0,-0.038100><0.245744,0.036000,0.038100> rotate<0,0.000000,0> translate<13.688837,0.000000,3.213728> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<13.688837,0.000000,3.213728>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<13.565969,0.000000,3.090856>}
box{<0,0,-0.038100><0.173765,0.036000,0.038100> rotate<0,-44.997759,0> translate<13.565969,0.000000,3.090856> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<14.314384,0.000000,2.476500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<14.314384,0.000000,3.213728>}
box{<0,0,-0.038100><0.737228,0.036000,0.038100> rotate<0,90.000000,0> translate<14.314384,0.000000,3.213728> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<14.314384,0.000000,3.213728>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<14.560125,0.000000,2.967984>}
box{<0,0,-0.038100><0.347532,0.036000,0.038100> rotate<0,44.997394,0> translate<14.314384,0.000000,3.213728> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<14.560125,0.000000,2.967984>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<14.805869,0.000000,3.213728>}
box{<0,0,-0.038100><0.347534,0.036000,0.038100> rotate<0,-44.997030,0> translate<14.560125,0.000000,2.967984> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<14.805869,0.000000,3.213728>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<14.805869,0.000000,2.476500>}
box{<0,0,-0.038100><0.737228,0.036000,0.038100> rotate<0,-90.000000,0> translate<14.805869,0.000000,2.476500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<15.062800,0.000000,2.476500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<15.062800,0.000000,3.213728>}
box{<0,0,-0.038100><0.737228,0.036000,0.038100> rotate<0,90.000000,0> translate<15.062800,0.000000,3.213728> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<15.062800,0.000000,2.845112>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<15.554284,0.000000,2.845112>}
box{<0,0,-0.038100><0.491484,0.036000,0.038100> rotate<0,0.000000,0> translate<15.062800,0.000000,2.845112> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<15.554284,0.000000,3.213728>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<15.554284,0.000000,2.476500>}
box{<0,0,-0.038100><0.737228,0.036000,0.038100> rotate<0,-90.000000,0> translate<15.554284,0.000000,2.476500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<15.811216,0.000000,2.967984>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<16.302700,0.000000,2.967984>}
box{<0,0,-0.038100><0.491484,0.036000,0.038100> rotate<0,0.000000,0> translate<15.811216,0.000000,2.967984> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<16.302700,0.000000,2.967984>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<15.811216,0.000000,2.476500>}
box{<0,0,-0.038100><0.695064,0.036000,0.038100> rotate<0,-44.997030,0> translate<15.811216,0.000000,2.476500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<15.811216,0.000000,2.476500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<16.302700,0.000000,2.476500>}
box{<0,0,-0.038100><0.491484,0.036000,0.038100> rotate<0,0.000000,0> translate<15.811216,0.000000,2.476500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<17.308047,0.000000,3.213728>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<17.430916,0.000000,3.213728>}
box{<0,0,-0.038100><0.122869,0.036000,0.038100> rotate<0,0.000000,0> translate<17.308047,0.000000,3.213728> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<17.430916,0.000000,3.213728>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<17.430916,0.000000,2.476500>}
box{<0,0,-0.038100><0.737228,0.036000,0.038100> rotate<0,-90.000000,0> translate<17.430916,0.000000,2.476500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<17.308047,0.000000,2.476500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<17.553788,0.000000,2.476500>}
box{<0,0,-0.038100><0.245741,0.036000,0.038100> rotate<0,0.000000,0> translate<17.308047,0.000000,2.476500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<17.929859,0.000000,2.476500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<18.175603,0.000000,2.476500>}
box{<0,0,-0.038100><0.245744,0.036000,0.038100> rotate<0,0.000000,0> translate<17.929859,0.000000,2.476500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<18.175603,0.000000,2.476500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<18.298475,0.000000,2.599369>}
box{<0,0,-0.038100><0.173765,0.036000,0.038100> rotate<0,-44.996302,0> translate<18.175603,0.000000,2.476500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<18.298475,0.000000,2.599369>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<18.298475,0.000000,2.845112>}
box{<0,0,-0.038100><0.245744,0.036000,0.038100> rotate<0,90.000000,0> translate<18.298475,0.000000,2.845112> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<18.298475,0.000000,2.845112>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<18.175603,0.000000,2.967984>}
box{<0,0,-0.038100><0.173767,0.036000,0.038100> rotate<0,44.997030,0> translate<18.175603,0.000000,2.967984> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<18.175603,0.000000,2.967984>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<17.929859,0.000000,2.967984>}
box{<0,0,-0.038100><0.245744,0.036000,0.038100> rotate<0,0.000000,0> translate<17.929859,0.000000,2.967984> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<17.929859,0.000000,2.967984>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<17.806991,0.000000,2.845112>}
box{<0,0,-0.038100><0.173765,0.036000,0.038100> rotate<0,-44.997759,0> translate<17.806991,0.000000,2.845112> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<17.806991,0.000000,2.845112>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<17.806991,0.000000,2.599369>}
box{<0,0,-0.038100><0.245744,0.036000,0.038100> rotate<0,-90.000000,0> translate<17.806991,0.000000,2.599369> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<17.806991,0.000000,2.599369>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<17.929859,0.000000,2.476500>}
box{<0,0,-0.038100><0.173763,0.036000,0.038100> rotate<0,44.997030,0> translate<17.806991,0.000000,2.599369> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<18.555406,0.000000,2.967984>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<18.555406,0.000000,2.599369>}
box{<0,0,-0.038100><0.368616,0.036000,0.038100> rotate<0,-90.000000,0> translate<18.555406,0.000000,2.599369> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<18.555406,0.000000,2.599369>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<18.678275,0.000000,2.476500>}
box{<0,0,-0.038100><0.173763,0.036000,0.038100> rotate<0,44.997030,0> translate<18.555406,0.000000,2.599369> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<18.678275,0.000000,2.476500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<18.801147,0.000000,2.599369>}
box{<0,0,-0.038100><0.173765,0.036000,0.038100> rotate<0,-44.996302,0> translate<18.678275,0.000000,2.476500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<18.801147,0.000000,2.599369>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<18.924019,0.000000,2.476500>}
box{<0,0,-0.038100><0.173765,0.036000,0.038100> rotate<0,44.996302,0> translate<18.801147,0.000000,2.599369> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<18.924019,0.000000,2.476500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<19.046891,0.000000,2.599369>}
box{<0,0,-0.038100><0.173765,0.036000,0.038100> rotate<0,-44.996302,0> translate<18.924019,0.000000,2.476500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<19.046891,0.000000,2.599369>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<19.046891,0.000000,2.967984>}
box{<0,0,-0.038100><0.368616,0.036000,0.038100> rotate<0,90.000000,0> translate<19.046891,0.000000,2.967984> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<20.052238,0.000000,2.230759>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<20.052238,0.000000,2.967984>}
box{<0,0,-0.038100><0.737225,0.036000,0.038100> rotate<0,90.000000,0> translate<20.052238,0.000000,2.967984> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<20.052238,0.000000,2.967984>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<20.420850,0.000000,2.967984>}
box{<0,0,-0.038100><0.368613,0.036000,0.038100> rotate<0,0.000000,0> translate<20.052238,0.000000,2.967984> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<20.420850,0.000000,2.967984>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<20.543722,0.000000,2.845112>}
box{<0,0,-0.038100><0.173767,0.036000,0.038100> rotate<0,44.997030,0> translate<20.420850,0.000000,2.967984> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<20.543722,0.000000,2.845112>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<20.543722,0.000000,2.599369>}
box{<0,0,-0.038100><0.245744,0.036000,0.038100> rotate<0,-90.000000,0> translate<20.543722,0.000000,2.599369> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<20.543722,0.000000,2.599369>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<20.420850,0.000000,2.476500>}
box{<0,0,-0.038100><0.173765,0.036000,0.038100> rotate<0,-44.996302,0> translate<20.420850,0.000000,2.476500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<20.420850,0.000000,2.476500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<20.052238,0.000000,2.476500>}
box{<0,0,-0.038100><0.368613,0.036000,0.038100> rotate<0,0.000000,0> translate<20.052238,0.000000,2.476500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<20.923522,0.000000,2.967984>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<21.169266,0.000000,2.967984>}
box{<0,0,-0.038100><0.245744,0.036000,0.038100> rotate<0,0.000000,0> translate<20.923522,0.000000,2.967984> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<21.169266,0.000000,2.967984>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<21.292138,0.000000,2.845112>}
box{<0,0,-0.038100><0.173767,0.036000,0.038100> rotate<0,44.997030,0> translate<21.169266,0.000000,2.967984> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<21.292138,0.000000,2.845112>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<21.292138,0.000000,2.476500>}
box{<0,0,-0.038100><0.368612,0.036000,0.038100> rotate<0,-90.000000,0> translate<21.292138,0.000000,2.476500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<21.292138,0.000000,2.476500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<20.923522,0.000000,2.476500>}
box{<0,0,-0.038100><0.368616,0.036000,0.038100> rotate<0,0.000000,0> translate<20.923522,0.000000,2.476500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<20.923522,0.000000,2.476500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<20.800653,0.000000,2.599369>}
box{<0,0,-0.038100><0.173763,0.036000,0.038100> rotate<0,44.997030,0> translate<20.800653,0.000000,2.599369> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<20.800653,0.000000,2.599369>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<20.923522,0.000000,2.722241>}
box{<0,0,-0.038100><0.173765,0.036000,0.038100> rotate<0,-44.997759,0> translate<20.800653,0.000000,2.599369> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<20.923522,0.000000,2.722241>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<21.292138,0.000000,2.722241>}
box{<0,0,-0.038100><0.368616,0.036000,0.038100> rotate<0,0.000000,0> translate<20.923522,0.000000,2.722241> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<21.549069,0.000000,2.476500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<21.917681,0.000000,2.476500>}
box{<0,0,-0.038100><0.368613,0.036000,0.038100> rotate<0,0.000000,0> translate<21.549069,0.000000,2.476500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<21.917681,0.000000,2.476500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<22.040553,0.000000,2.599369>}
box{<0,0,-0.038100><0.173765,0.036000,0.038100> rotate<0,-44.996302,0> translate<21.917681,0.000000,2.476500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<22.040553,0.000000,2.599369>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<21.917681,0.000000,2.722241>}
box{<0,0,-0.038100><0.173767,0.036000,0.038100> rotate<0,44.997030,0> translate<21.917681,0.000000,2.722241> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<21.917681,0.000000,2.722241>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<21.671938,0.000000,2.722241>}
box{<0,0,-0.038100><0.245744,0.036000,0.038100> rotate<0,0.000000,0> translate<21.671938,0.000000,2.722241> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<21.671938,0.000000,2.722241>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<21.549069,0.000000,2.845112>}
box{<0,0,-0.038100><0.173765,0.036000,0.038100> rotate<0,44.997759,0> translate<21.549069,0.000000,2.845112> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<21.549069,0.000000,2.845112>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<21.671938,0.000000,2.967984>}
box{<0,0,-0.038100><0.173765,0.036000,0.038100> rotate<0,-44.997759,0> translate<21.549069,0.000000,2.845112> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<21.671938,0.000000,2.967984>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<22.040553,0.000000,2.967984>}
box{<0,0,-0.038100><0.368616,0.036000,0.038100> rotate<0,0.000000,0> translate<21.671938,0.000000,2.967984> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<22.297484,0.000000,2.476500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<22.666097,0.000000,2.476500>}
box{<0,0,-0.038100><0.368613,0.036000,0.038100> rotate<0,0.000000,0> translate<22.297484,0.000000,2.476500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<22.666097,0.000000,2.476500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<22.788969,0.000000,2.599369>}
box{<0,0,-0.038100><0.173765,0.036000,0.038100> rotate<0,-44.996302,0> translate<22.666097,0.000000,2.476500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<22.788969,0.000000,2.599369>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<22.666097,0.000000,2.722241>}
box{<0,0,-0.038100><0.173767,0.036000,0.038100> rotate<0,44.997030,0> translate<22.666097,0.000000,2.722241> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<22.666097,0.000000,2.722241>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<22.420353,0.000000,2.722241>}
box{<0,0,-0.038100><0.245744,0.036000,0.038100> rotate<0,0.000000,0> translate<22.420353,0.000000,2.722241> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<22.420353,0.000000,2.722241>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<22.297484,0.000000,2.845112>}
box{<0,0,-0.038100><0.173765,0.036000,0.038100> rotate<0,44.997759,0> translate<22.297484,0.000000,2.845112> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<22.297484,0.000000,2.845112>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<22.420353,0.000000,2.967984>}
box{<0,0,-0.038100><0.173765,0.036000,0.038100> rotate<0,-44.997759,0> translate<22.297484,0.000000,2.845112> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<22.420353,0.000000,2.967984>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<22.788969,0.000000,2.967984>}
box{<0,0,-0.038100><0.368616,0.036000,0.038100> rotate<0,0.000000,0> translate<22.420353,0.000000,2.967984> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<23.917184,0.000000,2.476500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<23.917184,0.000000,3.090856>}
box{<0,0,-0.038100><0.614356,0.036000,0.038100> rotate<0,90.000000,0> translate<23.917184,0.000000,3.090856> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<23.917184,0.000000,3.090856>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<24.040056,0.000000,3.213728>}
box{<0,0,-0.038100><0.173767,0.036000,0.038100> rotate<0,-44.997030,0> translate<23.917184,0.000000,3.090856> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<23.794316,0.000000,2.845112>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<24.040056,0.000000,2.845112>}
box{<0,0,-0.038100><0.245741,0.036000,0.038100> rotate<0,0.000000,0> translate<23.794316,0.000000,2.845112> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<24.293259,0.000000,2.967984>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<24.416128,0.000000,2.967984>}
box{<0,0,-0.038100><0.122869,0.036000,0.038100> rotate<0,0.000000,0> translate<24.293259,0.000000,2.967984> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<24.416128,0.000000,2.967984>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<24.416128,0.000000,2.476500>}
box{<0,0,-0.038100><0.491484,0.036000,0.038100> rotate<0,-90.000000,0> translate<24.416128,0.000000,2.476500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<24.293259,0.000000,2.476500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<24.539000,0.000000,2.476500>}
box{<0,0,-0.038100><0.245741,0.036000,0.038100> rotate<0,0.000000,0> translate<24.293259,0.000000,2.476500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<24.416128,0.000000,3.336600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<24.416128,0.000000,3.213728>}
box{<0,0,-0.038100><0.122872,0.036000,0.038100> rotate<0,-90.000000,0> translate<24.416128,0.000000,3.213728> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<24.792203,0.000000,3.213728>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<24.915072,0.000000,3.213728>}
box{<0,0,-0.038100><0.122869,0.036000,0.038100> rotate<0,0.000000,0> translate<24.792203,0.000000,3.213728> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<24.915072,0.000000,3.213728>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<24.915072,0.000000,2.476500>}
box{<0,0,-0.038100><0.737228,0.036000,0.038100> rotate<0,-90.000000,0> translate<24.915072,0.000000,2.476500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<24.792203,0.000000,2.476500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<25.037944,0.000000,2.476500>}
box{<0,0,-0.038100><0.245741,0.036000,0.038100> rotate<0,0.000000,0> translate<24.792203,0.000000,2.476500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<25.414016,0.000000,3.090856>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<25.414016,0.000000,2.599369>}
box{<0,0,-0.038100><0.491488,0.036000,0.038100> rotate<0,-90.000000,0> translate<25.414016,0.000000,2.599369> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<25.414016,0.000000,2.599369>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<25.536888,0.000000,2.476500>}
box{<0,0,-0.038100><0.173765,0.036000,0.038100> rotate<0,44.996302,0> translate<25.414016,0.000000,2.599369> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<25.291147,0.000000,2.967984>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<25.536888,0.000000,2.967984>}
box{<0,0,-0.038100><0.245741,0.036000,0.038100> rotate<0,0.000000,0> translate<25.291147,0.000000,2.967984> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<26.158703,0.000000,2.476500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<25.912959,0.000000,2.476500>}
box{<0,0,-0.038100><0.245744,0.036000,0.038100> rotate<0,0.000000,0> translate<25.912959,0.000000,2.476500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<25.912959,0.000000,2.476500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<25.790091,0.000000,2.599369>}
box{<0,0,-0.038100><0.173763,0.036000,0.038100> rotate<0,44.997030,0> translate<25.790091,0.000000,2.599369> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<25.790091,0.000000,2.599369>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<25.790091,0.000000,2.845112>}
box{<0,0,-0.038100><0.245744,0.036000,0.038100> rotate<0,90.000000,0> translate<25.790091,0.000000,2.845112> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<25.790091,0.000000,2.845112>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<25.912959,0.000000,2.967984>}
box{<0,0,-0.038100><0.173765,0.036000,0.038100> rotate<0,-44.997759,0> translate<25.790091,0.000000,2.845112> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<25.912959,0.000000,2.967984>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<26.158703,0.000000,2.967984>}
box{<0,0,-0.038100><0.245744,0.036000,0.038100> rotate<0,0.000000,0> translate<25.912959,0.000000,2.967984> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<26.158703,0.000000,2.967984>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<26.281575,0.000000,2.845112>}
box{<0,0,-0.038100><0.173767,0.036000,0.038100> rotate<0,44.997030,0> translate<26.158703,0.000000,2.967984> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<26.281575,0.000000,2.845112>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<26.281575,0.000000,2.722241>}
box{<0,0,-0.038100><0.122872,0.036000,0.038100> rotate<0,-90.000000,0> translate<26.281575,0.000000,2.722241> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<26.281575,0.000000,2.722241>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<25.790091,0.000000,2.722241>}
box{<0,0,-0.038100><0.491484,0.036000,0.038100> rotate<0,0.000000,0> translate<25.790091,0.000000,2.722241> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<26.538506,0.000000,2.476500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<26.538506,0.000000,2.967984>}
box{<0,0,-0.038100><0.491484,0.036000,0.038100> rotate<0,90.000000,0> translate<26.538506,0.000000,2.967984> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<26.538506,0.000000,2.722241>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<26.784247,0.000000,2.967984>}
box{<0,0,-0.038100><0.347532,0.036000,0.038100> rotate<0,-44.997394,0> translate<26.538506,0.000000,2.722241> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<26.784247,0.000000,2.967984>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<26.907119,0.000000,2.967984>}
box{<0,0,-0.038100><0.122872,0.036000,0.038100> rotate<0,0.000000,0> translate<26.784247,0.000000,2.967984> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<10.689584,0.000000,1.871656>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<10.566713,0.000000,1.994528>}
box{<0,0,-0.038100><0.173767,0.036000,0.038100> rotate<0,44.997030,0> translate<10.566713,0.000000,1.994528> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<10.566713,0.000000,1.994528>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<10.320969,0.000000,1.994528>}
box{<0,0,-0.038100><0.245744,0.036000,0.038100> rotate<0,0.000000,0> translate<10.320969,0.000000,1.994528> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<10.320969,0.000000,1.994528>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<10.198100,0.000000,1.871656>}
box{<0,0,-0.038100><0.173765,0.036000,0.038100> rotate<0,-44.997759,0> translate<10.198100,0.000000,1.871656> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<10.198100,0.000000,1.871656>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<10.198100,0.000000,1.748784>}
box{<0,0,-0.038100><0.122872,0.036000,0.038100> rotate<0,-90.000000,0> translate<10.198100,0.000000,1.748784> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<10.198100,0.000000,1.748784>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<10.320969,0.000000,1.625913>}
box{<0,0,-0.038100><0.173765,0.036000,0.038100> rotate<0,44.997759,0> translate<10.198100,0.000000,1.748784> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<10.320969,0.000000,1.625913>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<10.566713,0.000000,1.625913>}
box{<0,0,-0.038100><0.245744,0.036000,0.038100> rotate<0,0.000000,0> translate<10.320969,0.000000,1.625913> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<10.566713,0.000000,1.625913>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<10.689584,0.000000,1.503041>}
box{<0,0,-0.038100><0.173767,0.036000,0.038100> rotate<0,44.997030,0> translate<10.566713,0.000000,1.625913> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<10.689584,0.000000,1.503041>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<10.689584,0.000000,1.380169>}
box{<0,0,-0.038100><0.122872,0.036000,0.038100> rotate<0,-90.000000,0> translate<10.689584,0.000000,1.380169> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<10.689584,0.000000,1.380169>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<10.566713,0.000000,1.257300>}
box{<0,0,-0.038100><0.173765,0.036000,0.038100> rotate<0,-44.996302,0> translate<10.566713,0.000000,1.257300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<10.566713,0.000000,1.257300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<10.320969,0.000000,1.257300>}
box{<0,0,-0.038100><0.245744,0.036000,0.038100> rotate<0,0.000000,0> translate<10.320969,0.000000,1.257300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<10.320969,0.000000,1.257300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<10.198100,0.000000,1.380169>}
box{<0,0,-0.038100><0.173763,0.036000,0.038100> rotate<0,44.997030,0> translate<10.198100,0.000000,1.380169> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<11.438000,0.000000,1.748784>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<11.069384,0.000000,1.748784>}
box{<0,0,-0.038100><0.368616,0.036000,0.038100> rotate<0,0.000000,0> translate<11.069384,0.000000,1.748784> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<11.069384,0.000000,1.748784>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<10.946516,0.000000,1.625913>}
box{<0,0,-0.038100><0.173765,0.036000,0.038100> rotate<0,-44.997759,0> translate<10.946516,0.000000,1.625913> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<10.946516,0.000000,1.625913>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<10.946516,0.000000,1.380169>}
box{<0,0,-0.038100><0.245744,0.036000,0.038100> rotate<0,-90.000000,0> translate<10.946516,0.000000,1.380169> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<10.946516,0.000000,1.380169>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<11.069384,0.000000,1.257300>}
box{<0,0,-0.038100><0.173763,0.036000,0.038100> rotate<0,44.997030,0> translate<10.946516,0.000000,1.380169> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<11.069384,0.000000,1.257300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<11.438000,0.000000,1.257300>}
box{<0,0,-0.038100><0.368616,0.036000,0.038100> rotate<0,0.000000,0> translate<11.069384,0.000000,1.257300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<11.694931,0.000000,1.994528>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<11.694931,0.000000,1.257300>}
box{<0,0,-0.038100><0.737228,0.036000,0.038100> rotate<0,-90.000000,0> translate<11.694931,0.000000,1.257300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<11.694931,0.000000,1.625913>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<11.817800,0.000000,1.748784>}
box{<0,0,-0.038100><0.173765,0.036000,0.038100> rotate<0,-44.997759,0> translate<11.694931,0.000000,1.625913> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<11.817800,0.000000,1.748784>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<12.063544,0.000000,1.748784>}
box{<0,0,-0.038100><0.245744,0.036000,0.038100> rotate<0,0.000000,0> translate<11.817800,0.000000,1.748784> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<12.063544,0.000000,1.748784>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<12.186416,0.000000,1.625913>}
box{<0,0,-0.038100><0.173767,0.036000,0.038100> rotate<0,44.997030,0> translate<12.063544,0.000000,1.748784> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<12.186416,0.000000,1.625913>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<12.186416,0.000000,1.257300>}
box{<0,0,-0.038100><0.368613,0.036000,0.038100> rotate<0,-90.000000,0> translate<12.186416,0.000000,1.257300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<12.811959,0.000000,1.257300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<12.566216,0.000000,1.257300>}
box{<0,0,-0.038100><0.245744,0.036000,0.038100> rotate<0,0.000000,0> translate<12.566216,0.000000,1.257300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<12.566216,0.000000,1.257300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<12.443347,0.000000,1.380169>}
box{<0,0,-0.038100><0.173763,0.036000,0.038100> rotate<0,44.997030,0> translate<12.443347,0.000000,1.380169> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<12.443347,0.000000,1.380169>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<12.443347,0.000000,1.625913>}
box{<0,0,-0.038100><0.245744,0.036000,0.038100> rotate<0,90.000000,0> translate<12.443347,0.000000,1.625913> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<12.443347,0.000000,1.625913>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<12.566216,0.000000,1.748784>}
box{<0,0,-0.038100><0.173765,0.036000,0.038100> rotate<0,-44.997759,0> translate<12.443347,0.000000,1.625913> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<12.566216,0.000000,1.748784>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<12.811959,0.000000,1.748784>}
box{<0,0,-0.038100><0.245744,0.036000,0.038100> rotate<0,0.000000,0> translate<12.566216,0.000000,1.748784> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<12.811959,0.000000,1.748784>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<12.934831,0.000000,1.625913>}
box{<0,0,-0.038100><0.173767,0.036000,0.038100> rotate<0,44.997030,0> translate<12.811959,0.000000,1.748784> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<12.934831,0.000000,1.625913>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<12.934831,0.000000,1.503041>}
box{<0,0,-0.038100><0.122872,0.036000,0.038100> rotate<0,-90.000000,0> translate<12.934831,0.000000,1.503041> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<12.934831,0.000000,1.503041>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<12.443347,0.000000,1.503041>}
box{<0,0,-0.038100><0.491484,0.036000,0.038100> rotate<0,0.000000,0> translate<12.443347,0.000000,1.503041> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<13.191763,0.000000,1.257300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<13.191763,0.000000,1.748784>}
box{<0,0,-0.038100><0.491484,0.036000,0.038100> rotate<0,90.000000,0> translate<13.191763,0.000000,1.748784> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<13.191763,0.000000,1.748784>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<13.314631,0.000000,1.748784>}
box{<0,0,-0.038100><0.122869,0.036000,0.038100> rotate<0,0.000000,0> translate<13.191763,0.000000,1.748784> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<13.314631,0.000000,1.748784>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<13.437503,0.000000,1.625913>}
box{<0,0,-0.038100><0.173767,0.036000,0.038100> rotate<0,44.997030,0> translate<13.314631,0.000000,1.748784> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<13.437503,0.000000,1.625913>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<13.437503,0.000000,1.257300>}
box{<0,0,-0.038100><0.368613,0.036000,0.038100> rotate<0,-90.000000,0> translate<13.437503,0.000000,1.257300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<13.437503,0.000000,1.625913>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<13.560375,0.000000,1.748784>}
box{<0,0,-0.038100><0.173767,0.036000,0.038100> rotate<0,-44.997030,0> translate<13.437503,0.000000,1.625913> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<13.560375,0.000000,1.748784>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<13.683247,0.000000,1.625913>}
box{<0,0,-0.038100><0.173767,0.036000,0.038100> rotate<0,44.997030,0> translate<13.560375,0.000000,1.748784> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<13.683247,0.000000,1.625913>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<13.683247,0.000000,1.257300>}
box{<0,0,-0.038100><0.368613,0.036000,0.038100> rotate<0,-90.000000,0> translate<13.683247,0.000000,1.257300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<14.063047,0.000000,1.748784>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<14.308791,0.000000,1.748784>}
box{<0,0,-0.038100><0.245744,0.036000,0.038100> rotate<0,0.000000,0> translate<14.063047,0.000000,1.748784> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<14.308791,0.000000,1.748784>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<14.431662,0.000000,1.625913>}
box{<0,0,-0.038100><0.173767,0.036000,0.038100> rotate<0,44.997030,0> translate<14.308791,0.000000,1.748784> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<14.431662,0.000000,1.625913>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<14.431662,0.000000,1.257300>}
box{<0,0,-0.038100><0.368613,0.036000,0.038100> rotate<0,-90.000000,0> translate<14.431662,0.000000,1.257300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<14.431662,0.000000,1.257300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<14.063047,0.000000,1.257300>}
box{<0,0,-0.038100><0.368616,0.036000,0.038100> rotate<0,0.000000,0> translate<14.063047,0.000000,1.257300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<14.063047,0.000000,1.257300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<13.940178,0.000000,1.380169>}
box{<0,0,-0.038100><0.173763,0.036000,0.038100> rotate<0,44.997030,0> translate<13.940178,0.000000,1.380169> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<13.940178,0.000000,1.380169>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<14.063047,0.000000,1.503041>}
box{<0,0,-0.038100><0.173765,0.036000,0.038100> rotate<0,-44.997759,0> translate<13.940178,0.000000,1.380169> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<14.063047,0.000000,1.503041>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<14.431662,0.000000,1.503041>}
box{<0,0,-0.038100><0.368616,0.036000,0.038100> rotate<0,0.000000,0> translate<14.063047,0.000000,1.503041> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<15.559878,0.000000,1.748784>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<15.805622,0.000000,1.748784>}
box{<0,0,-0.038100><0.245744,0.036000,0.038100> rotate<0,0.000000,0> translate<15.559878,0.000000,1.748784> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<15.805622,0.000000,1.748784>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<15.928494,0.000000,1.625913>}
box{<0,0,-0.038100><0.173767,0.036000,0.038100> rotate<0,44.997030,0> translate<15.805622,0.000000,1.748784> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<15.928494,0.000000,1.625913>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<15.928494,0.000000,1.257300>}
box{<0,0,-0.038100><0.368613,0.036000,0.038100> rotate<0,-90.000000,0> translate<15.928494,0.000000,1.257300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<15.928494,0.000000,1.257300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<15.559878,0.000000,1.257300>}
box{<0,0,-0.038100><0.368616,0.036000,0.038100> rotate<0,0.000000,0> translate<15.559878,0.000000,1.257300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<15.559878,0.000000,1.257300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<15.437009,0.000000,1.380169>}
box{<0,0,-0.038100><0.173763,0.036000,0.038100> rotate<0,44.997030,0> translate<15.437009,0.000000,1.380169> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<15.437009,0.000000,1.380169>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<15.559878,0.000000,1.503041>}
box{<0,0,-0.038100><0.173765,0.036000,0.038100> rotate<0,-44.997759,0> translate<15.437009,0.000000,1.380169> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<15.559878,0.000000,1.503041>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<15.928494,0.000000,1.503041>}
box{<0,0,-0.038100><0.368616,0.036000,0.038100> rotate<0,0.000000,0> translate<15.559878,0.000000,1.503041> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<16.185425,0.000000,1.257300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<16.185425,0.000000,1.748784>}
box{<0,0,-0.038100><0.491484,0.036000,0.038100> rotate<0,90.000000,0> translate<16.185425,0.000000,1.748784> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<16.185425,0.000000,1.748784>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<16.554037,0.000000,1.748784>}
box{<0,0,-0.038100><0.368612,0.036000,0.038100> rotate<0,0.000000,0> translate<16.185425,0.000000,1.748784> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<16.554037,0.000000,1.748784>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<16.676909,0.000000,1.625913>}
box{<0,0,-0.038100><0.173767,0.036000,0.038100> rotate<0,44.997030,0> translate<16.554037,0.000000,1.748784> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<16.676909,0.000000,1.625913>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<16.676909,0.000000,1.257300>}
box{<0,0,-0.038100><0.368613,0.036000,0.038100> rotate<0,-90.000000,0> translate<16.676909,0.000000,1.257300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<17.425325,0.000000,1.994528>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<17.425325,0.000000,1.257300>}
box{<0,0,-0.038100><0.737228,0.036000,0.038100> rotate<0,-90.000000,0> translate<17.425325,0.000000,1.257300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<17.425325,0.000000,1.257300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<17.056709,0.000000,1.257300>}
box{<0,0,-0.038100><0.368616,0.036000,0.038100> rotate<0,0.000000,0> translate<17.056709,0.000000,1.257300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<17.056709,0.000000,1.257300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<16.933841,0.000000,1.380169>}
box{<0,0,-0.038100><0.173763,0.036000,0.038100> rotate<0,44.997030,0> translate<16.933841,0.000000,1.380169> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<16.933841,0.000000,1.380169>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<16.933841,0.000000,1.625913>}
box{<0,0,-0.038100><0.245744,0.036000,0.038100> rotate<0,90.000000,0> translate<16.933841,0.000000,1.625913> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<16.933841,0.000000,1.625913>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<17.056709,0.000000,1.748784>}
box{<0,0,-0.038100><0.173765,0.036000,0.038100> rotate<0,-44.997759,0> translate<16.933841,0.000000,1.625913> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<17.056709,0.000000,1.748784>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<17.425325,0.000000,1.748784>}
box{<0,0,-0.038100><0.368616,0.036000,0.038100> rotate<0,0.000000,0> translate<17.056709,0.000000,1.748784> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<18.430672,0.000000,1.748784>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<18.553541,0.000000,1.748784>}
box{<0,0,-0.038100><0.122869,0.036000,0.038100> rotate<0,0.000000,0> translate<18.430672,0.000000,1.748784> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<18.553541,0.000000,1.748784>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<18.553541,0.000000,1.257300>}
box{<0,0,-0.038100><0.491484,0.036000,0.038100> rotate<0,-90.000000,0> translate<18.553541,0.000000,1.257300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<18.430672,0.000000,1.257300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<18.676413,0.000000,1.257300>}
box{<0,0,-0.038100><0.245741,0.036000,0.038100> rotate<0,0.000000,0> translate<18.430672,0.000000,1.257300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<18.553541,0.000000,2.117400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<18.553541,0.000000,1.994528>}
box{<0,0,-0.038100><0.122872,0.036000,0.038100> rotate<0,-90.000000,0> translate<18.553541,0.000000,1.994528> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<19.421100,0.000000,1.994528>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<19.421100,0.000000,1.257300>}
box{<0,0,-0.038100><0.737228,0.036000,0.038100> rotate<0,-90.000000,0> translate<19.421100,0.000000,1.257300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<19.421100,0.000000,1.257300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<19.052484,0.000000,1.257300>}
box{<0,0,-0.038100><0.368616,0.036000,0.038100> rotate<0,0.000000,0> translate<19.052484,0.000000,1.257300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<19.052484,0.000000,1.257300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<18.929616,0.000000,1.380169>}
box{<0,0,-0.038100><0.173763,0.036000,0.038100> rotate<0,44.997030,0> translate<18.929616,0.000000,1.380169> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<18.929616,0.000000,1.380169>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<18.929616,0.000000,1.625913>}
box{<0,0,-0.038100><0.245744,0.036000,0.038100> rotate<0,90.000000,0> translate<18.929616,0.000000,1.625913> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<18.929616,0.000000,1.625913>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<19.052484,0.000000,1.748784>}
box{<0,0,-0.038100><0.173765,0.036000,0.038100> rotate<0,-44.997759,0> translate<18.929616,0.000000,1.625913> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<19.052484,0.000000,1.748784>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<19.421100,0.000000,1.748784>}
box{<0,0,-0.038100><0.368616,0.036000,0.038100> rotate<0,0.000000,0> translate<19.052484,0.000000,1.748784> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<20.046644,0.000000,1.257300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<19.800900,0.000000,1.257300>}
box{<0,0,-0.038100><0.245744,0.036000,0.038100> rotate<0,0.000000,0> translate<19.800900,0.000000,1.257300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<19.800900,0.000000,1.257300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<19.678031,0.000000,1.380169>}
box{<0,0,-0.038100><0.173763,0.036000,0.038100> rotate<0,44.997030,0> translate<19.678031,0.000000,1.380169> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<19.678031,0.000000,1.380169>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<19.678031,0.000000,1.625913>}
box{<0,0,-0.038100><0.245744,0.036000,0.038100> rotate<0,90.000000,0> translate<19.678031,0.000000,1.625913> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<19.678031,0.000000,1.625913>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<19.800900,0.000000,1.748784>}
box{<0,0,-0.038100><0.173765,0.036000,0.038100> rotate<0,-44.997759,0> translate<19.678031,0.000000,1.625913> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<19.800900,0.000000,1.748784>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<20.046644,0.000000,1.748784>}
box{<0,0,-0.038100><0.245744,0.036000,0.038100> rotate<0,0.000000,0> translate<19.800900,0.000000,1.748784> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<20.046644,0.000000,1.748784>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<20.169516,0.000000,1.625913>}
box{<0,0,-0.038100><0.173767,0.036000,0.038100> rotate<0,44.997030,0> translate<20.046644,0.000000,1.748784> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<20.169516,0.000000,1.625913>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<20.169516,0.000000,1.503041>}
box{<0,0,-0.038100><0.122872,0.036000,0.038100> rotate<0,-90.000000,0> translate<20.169516,0.000000,1.503041> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<20.169516,0.000000,1.503041>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<19.678031,0.000000,1.503041>}
box{<0,0,-0.038100><0.491484,0.036000,0.038100> rotate<0,0.000000,0> translate<19.678031,0.000000,1.503041> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<20.549316,0.000000,1.748784>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<20.795059,0.000000,1.748784>}
box{<0,0,-0.038100><0.245744,0.036000,0.038100> rotate<0,0.000000,0> translate<20.549316,0.000000,1.748784> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<20.795059,0.000000,1.748784>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<20.917931,0.000000,1.625913>}
box{<0,0,-0.038100><0.173767,0.036000,0.038100> rotate<0,44.997030,0> translate<20.795059,0.000000,1.748784> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<20.917931,0.000000,1.625913>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<20.917931,0.000000,1.257300>}
box{<0,0,-0.038100><0.368613,0.036000,0.038100> rotate<0,-90.000000,0> translate<20.917931,0.000000,1.257300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<20.917931,0.000000,1.257300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<20.549316,0.000000,1.257300>}
box{<0,0,-0.038100><0.368616,0.036000,0.038100> rotate<0,0.000000,0> translate<20.549316,0.000000,1.257300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<20.549316,0.000000,1.257300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<20.426447,0.000000,1.380169>}
box{<0,0,-0.038100><0.173763,0.036000,0.038100> rotate<0,44.997030,0> translate<20.426447,0.000000,1.380169> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<20.426447,0.000000,1.380169>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<20.549316,0.000000,1.503041>}
box{<0,0,-0.038100><0.173765,0.036000,0.038100> rotate<0,-44.997759,0> translate<20.426447,0.000000,1.380169> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<20.549316,0.000000,1.503041>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<20.917931,0.000000,1.503041>}
box{<0,0,-0.038100><0.368616,0.036000,0.038100> rotate<0,0.000000,0> translate<20.549316,0.000000,1.503041> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<22.169019,0.000000,1.257300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<21.923278,0.000000,1.503041>}
box{<0,0,-0.038100><0.347530,0.036000,0.038100> rotate<0,44.997030,0> translate<21.923278,0.000000,1.503041> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<21.923278,0.000000,1.503041>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<21.923278,0.000000,1.748784>}
box{<0,0,-0.038100><0.245744,0.036000,0.038100> rotate<0,90.000000,0> translate<21.923278,0.000000,1.748784> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<21.923278,0.000000,1.748784>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<22.169019,0.000000,1.994528>}
box{<0,0,-0.038100><0.347532,0.036000,0.038100> rotate<0,-44.997394,0> translate<21.923278,0.000000,1.748784> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<22.913706,0.000000,1.871656>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<22.790834,0.000000,1.994528>}
box{<0,0,-0.038100><0.173767,0.036000,0.038100> rotate<0,44.997030,0> translate<22.790834,0.000000,1.994528> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<22.790834,0.000000,1.994528>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<22.545091,0.000000,1.994528>}
box{<0,0,-0.038100><0.245744,0.036000,0.038100> rotate<0,0.000000,0> translate<22.545091,0.000000,1.994528> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<22.545091,0.000000,1.994528>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<22.422222,0.000000,1.871656>}
box{<0,0,-0.038100><0.173765,0.036000,0.038100> rotate<0,-44.997759,0> translate<22.422222,0.000000,1.871656> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<22.422222,0.000000,1.871656>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<22.422222,0.000000,1.380169>}
box{<0,0,-0.038100><0.491487,0.036000,0.038100> rotate<0,-90.000000,0> translate<22.422222,0.000000,1.380169> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<22.422222,0.000000,1.380169>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<22.545091,0.000000,1.257300>}
box{<0,0,-0.038100><0.173763,0.036000,0.038100> rotate<0,44.997030,0> translate<22.422222,0.000000,1.380169> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<22.545091,0.000000,1.257300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<22.790834,0.000000,1.257300>}
box{<0,0,-0.038100><0.245744,0.036000,0.038100> rotate<0,0.000000,0> translate<22.545091,0.000000,1.257300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<22.790834,0.000000,1.257300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<22.913706,0.000000,1.380169>}
box{<0,0,-0.038100><0.173765,0.036000,0.038100> rotate<0,-44.996302,0> translate<22.790834,0.000000,1.257300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<23.170638,0.000000,1.257300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<23.416378,0.000000,1.503041>}
box{<0,0,-0.038100><0.347530,0.036000,0.038100> rotate<0,-44.997030,0> translate<23.170638,0.000000,1.257300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<23.416378,0.000000,1.503041>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<23.416378,0.000000,1.748784>}
box{<0,0,-0.038100><0.245744,0.036000,0.038100> rotate<0,90.000000,0> translate<23.416378,0.000000,1.748784> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<23.416378,0.000000,1.748784>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<23.170638,0.000000,1.994528>}
box{<0,0,-0.038100><0.347532,0.036000,0.038100> rotate<0,44.997394,0> translate<23.170638,0.000000,1.994528> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<24.909481,0.000000,1.871656>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<24.786609,0.000000,1.994528>}
box{<0,0,-0.038100><0.173767,0.036000,0.038100> rotate<0,44.997030,0> translate<24.786609,0.000000,1.994528> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<24.786609,0.000000,1.994528>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<24.540866,0.000000,1.994528>}
box{<0,0,-0.038100><0.245744,0.036000,0.038100> rotate<0,0.000000,0> translate<24.540866,0.000000,1.994528> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<24.540866,0.000000,1.994528>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<24.417997,0.000000,1.871656>}
box{<0,0,-0.038100><0.173765,0.036000,0.038100> rotate<0,-44.997759,0> translate<24.417997,0.000000,1.871656> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<24.417997,0.000000,1.871656>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<24.417997,0.000000,1.380169>}
box{<0,0,-0.038100><0.491487,0.036000,0.038100> rotate<0,-90.000000,0> translate<24.417997,0.000000,1.380169> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<24.417997,0.000000,1.380169>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<24.540866,0.000000,1.257300>}
box{<0,0,-0.038100><0.173763,0.036000,0.038100> rotate<0,44.997030,0> translate<24.417997,0.000000,1.380169> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<24.540866,0.000000,1.257300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<24.786609,0.000000,1.257300>}
box{<0,0,-0.038100><0.245744,0.036000,0.038100> rotate<0,0.000000,0> translate<24.540866,0.000000,1.257300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<24.786609,0.000000,1.257300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<24.909481,0.000000,1.380169>}
box{<0,0,-0.038100><0.173765,0.036000,0.038100> rotate<0,-44.996302,0> translate<24.786609,0.000000,1.257300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<25.166412,0.000000,1.748784>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<25.166412,0.000000,1.380169>}
box{<0,0,-0.038100><0.368616,0.036000,0.038100> rotate<0,-90.000000,0> translate<25.166412,0.000000,1.380169> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<25.166412,0.000000,1.380169>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<25.289281,0.000000,1.257300>}
box{<0,0,-0.038100><0.173763,0.036000,0.038100> rotate<0,44.997030,0> translate<25.166412,0.000000,1.380169> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<25.289281,0.000000,1.257300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<25.657897,0.000000,1.257300>}
box{<0,0,-0.038100><0.368616,0.036000,0.038100> rotate<0,0.000000,0> translate<25.289281,0.000000,1.257300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<25.657897,0.000000,1.257300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<25.657897,0.000000,1.748784>}
box{<0,0,-0.038100><0.491484,0.036000,0.038100> rotate<0,90.000000,0> translate<25.657897,0.000000,1.748784> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<25.914828,0.000000,1.257300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<25.914828,0.000000,1.748784>}
box{<0,0,-0.038100><0.491484,0.036000,0.038100> rotate<0,90.000000,0> translate<25.914828,0.000000,1.748784> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<25.914828,0.000000,1.503041>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<26.160569,0.000000,1.748784>}
box{<0,0,-0.038100><0.347532,0.036000,0.038100> rotate<0,-44.997394,0> translate<25.914828,0.000000,1.503041> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<26.160569,0.000000,1.748784>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<26.283441,0.000000,1.748784>}
box{<0,0,-0.038100><0.122872,0.036000,0.038100> rotate<0,0.000000,0> translate<26.160569,0.000000,1.748784> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<26.538506,0.000000,1.994528>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<26.661375,0.000000,1.994528>}
box{<0,0,-0.038100><0.122869,0.036000,0.038100> rotate<0,0.000000,0> translate<26.538506,0.000000,1.994528> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<26.661375,0.000000,1.994528>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<26.661375,0.000000,1.257300>}
box{<0,0,-0.038100><0.737228,0.036000,0.038100> rotate<0,-90.000000,0> translate<26.661375,0.000000,1.257300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<26.538506,0.000000,1.257300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<26.784247,0.000000,1.257300>}
box{<0,0,-0.038100><0.245741,0.036000,0.038100> rotate<0,0.000000,0> translate<26.538506,0.000000,1.257300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<27.037450,0.000000,1.748784>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<27.037450,0.000000,1.380169>}
box{<0,0,-0.038100><0.368616,0.036000,0.038100> rotate<0,-90.000000,0> translate<27.037450,0.000000,1.380169> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<27.037450,0.000000,1.380169>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<27.160319,0.000000,1.257300>}
box{<0,0,-0.038100><0.173763,0.036000,0.038100> rotate<0,44.997030,0> translate<27.037450,0.000000,1.380169> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<27.160319,0.000000,1.257300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<27.528934,0.000000,1.257300>}
box{<0,0,-0.038100><0.368616,0.036000,0.038100> rotate<0,0.000000,0> translate<27.160319,0.000000,1.257300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<27.528934,0.000000,1.748784>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<27.528934,0.000000,1.134431>}
box{<0,0,-0.038100><0.614353,0.036000,0.038100> rotate<0,-90.000000,0> translate<27.528934,0.000000,1.134431> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<27.528934,0.000000,1.134431>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<27.406063,0.000000,1.011559>}
box{<0,0,-0.038100><0.173767,0.036000,0.038100> rotate<0,-44.997030,0> translate<27.406063,0.000000,1.011559> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<27.406063,0.000000,1.011559>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<27.283191,0.000000,1.011559>}
box{<0,0,-0.038100><0.122872,0.036000,0.038100> rotate<0,0.000000,0> translate<27.283191,0.000000,1.011559> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<27.785866,0.000000,1.257300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<27.785866,0.000000,1.994528>}
box{<0,0,-0.038100><0.737228,0.036000,0.038100> rotate<0,90.000000,0> translate<27.785866,0.000000,1.994528> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<27.785866,0.000000,1.994528>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<28.031606,0.000000,1.748784>}
box{<0,0,-0.038100><0.347532,0.036000,0.038100> rotate<0,44.997394,0> translate<27.785866,0.000000,1.994528> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<28.031606,0.000000,1.748784>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<28.277350,0.000000,1.994528>}
box{<0,0,-0.038100><0.347534,0.036000,0.038100> rotate<0,-44.997030,0> translate<28.031606,0.000000,1.748784> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<28.277350,0.000000,1.994528>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<28.277350,0.000000,1.257300>}
box{<0,0,-0.038100><0.737228,0.036000,0.038100> rotate<0,-90.000000,0> translate<28.277350,0.000000,1.257300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<28.657150,0.000000,1.257300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<28.902894,0.000000,1.257300>}
box{<0,0,-0.038100><0.245744,0.036000,0.038100> rotate<0,0.000000,0> translate<28.657150,0.000000,1.257300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<28.902894,0.000000,1.257300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<29.025766,0.000000,1.380169>}
box{<0,0,-0.038100><0.173765,0.036000,0.038100> rotate<0,-44.996302,0> translate<28.902894,0.000000,1.257300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<29.025766,0.000000,1.380169>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<29.025766,0.000000,1.625913>}
box{<0,0,-0.038100><0.245744,0.036000,0.038100> rotate<0,90.000000,0> translate<29.025766,0.000000,1.625913> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<29.025766,0.000000,1.625913>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<28.902894,0.000000,1.748784>}
box{<0,0,-0.038100><0.173767,0.036000,0.038100> rotate<0,44.997030,0> translate<28.902894,0.000000,1.748784> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<28.902894,0.000000,1.748784>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<28.657150,0.000000,1.748784>}
box{<0,0,-0.038100><0.245744,0.036000,0.038100> rotate<0,0.000000,0> translate<28.657150,0.000000,1.748784> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<28.657150,0.000000,1.748784>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<28.534281,0.000000,1.625913>}
box{<0,0,-0.038100><0.173765,0.036000,0.038100> rotate<0,-44.997759,0> translate<28.534281,0.000000,1.625913> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<28.534281,0.000000,1.625913>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<28.534281,0.000000,1.380169>}
box{<0,0,-0.038100><0.245744,0.036000,0.038100> rotate<0,-90.000000,0> translate<28.534281,0.000000,1.380169> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<28.534281,0.000000,1.380169>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<28.657150,0.000000,1.257300>}
box{<0,0,-0.038100><0.173763,0.036000,0.038100> rotate<0,44.997030,0> translate<28.534281,0.000000,1.380169> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<29.282697,0.000000,1.011559>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<29.528438,0.000000,1.257300>}
box{<0,0,-0.038100><0.347530,0.036000,0.038100> rotate<0,-44.997030,0> translate<29.282697,0.000000,1.011559> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<29.528438,0.000000,1.257300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<29.528438,0.000000,1.380169>}
box{<0,0,-0.038100><0.122869,0.036000,0.038100> rotate<0,90.000000,0> translate<29.528438,0.000000,1.380169> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<29.528438,0.000000,1.380169>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<29.405566,0.000000,1.380169>}
box{<0,0,-0.038100><0.122872,0.036000,0.038100> rotate<0,0.000000,0> translate<29.405566,0.000000,1.380169> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<29.405566,0.000000,1.380169>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<29.405566,0.000000,1.257300>}
box{<0,0,-0.038100><0.122869,0.036000,0.038100> rotate<0,-90.000000,0> translate<29.405566,0.000000,1.257300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<29.405566,0.000000,1.257300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<29.528438,0.000000,1.257300>}
box{<0,0,-0.038100><0.122872,0.036000,0.038100> rotate<0,0.000000,0> translate<29.405566,0.000000,1.257300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.021541,0.000000,1.257300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<30.530056,0.000000,1.257300>}
box{<0,0,-0.038100><0.491484,0.036000,0.038100> rotate<0,0.000000,0> translate<30.530056,0.000000,1.257300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<30.530056,0.000000,1.257300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.021541,0.000000,1.748784>}
box{<0,0,-0.038100><0.695064,0.036000,0.038100> rotate<0,-44.997030,0> translate<30.530056,0.000000,1.257300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.021541,0.000000,1.748784>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.021541,0.000000,1.871656>}
box{<0,0,-0.038100><0.122872,0.036000,0.038100> rotate<0,90.000000,0> translate<31.021541,0.000000,1.871656> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.021541,0.000000,1.871656>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<30.898669,0.000000,1.994528>}
box{<0,0,-0.038100><0.173767,0.036000,0.038100> rotate<0,44.997030,0> translate<30.898669,0.000000,1.994528> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<30.898669,0.000000,1.994528>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<30.652925,0.000000,1.994528>}
box{<0,0,-0.038100><0.245744,0.036000,0.038100> rotate<0,0.000000,0> translate<30.652925,0.000000,1.994528> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<30.652925,0.000000,1.994528>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<30.530056,0.000000,1.871656>}
box{<0,0,-0.038100><0.173765,0.036000,0.038100> rotate<0,-44.997759,0> translate<30.530056,0.000000,1.871656> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.278472,0.000000,1.380169>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.278472,0.000000,1.871656>}
box{<0,0,-0.038100><0.491487,0.036000,0.038100> rotate<0,90.000000,0> translate<31.278472,0.000000,1.871656> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.278472,0.000000,1.871656>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.401341,0.000000,1.994528>}
box{<0,0,-0.038100><0.173765,0.036000,0.038100> rotate<0,-44.997759,0> translate<31.278472,0.000000,1.871656> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.401341,0.000000,1.994528>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.647084,0.000000,1.994528>}
box{<0,0,-0.038100><0.245744,0.036000,0.038100> rotate<0,0.000000,0> translate<31.401341,0.000000,1.994528> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.647084,0.000000,1.994528>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.769956,0.000000,1.871656>}
box{<0,0,-0.038100><0.173767,0.036000,0.038100> rotate<0,44.997030,0> translate<31.647084,0.000000,1.994528> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.769956,0.000000,1.871656>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.769956,0.000000,1.380169>}
box{<0,0,-0.038100><0.491487,0.036000,0.038100> rotate<0,-90.000000,0> translate<31.769956,0.000000,1.380169> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.769956,0.000000,1.380169>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.647084,0.000000,1.257300>}
box{<0,0,-0.038100><0.173765,0.036000,0.038100> rotate<0,-44.996302,0> translate<31.647084,0.000000,1.257300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.647084,0.000000,1.257300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.401341,0.000000,1.257300>}
box{<0,0,-0.038100><0.245744,0.036000,0.038100> rotate<0,0.000000,0> translate<31.401341,0.000000,1.257300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.401341,0.000000,1.257300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.278472,0.000000,1.380169>}
box{<0,0,-0.038100><0.173763,0.036000,0.038100> rotate<0,44.997030,0> translate<31.278472,0.000000,1.380169> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.278472,0.000000,1.380169>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.769956,0.000000,1.871656>}
box{<0,0,-0.038100><0.695066,0.036000,0.038100> rotate<0,-44.997212,0> translate<31.278472,0.000000,1.380169> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.026888,0.000000,1.748784>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.272628,0.000000,1.994528>}
box{<0,0,-0.038100><0.347532,0.036000,0.038100> rotate<0,-44.997394,0> translate<32.026888,0.000000,1.748784> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.272628,0.000000,1.994528>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.272628,0.000000,1.257300>}
box{<0,0,-0.038100><0.737228,0.036000,0.038100> rotate<0,-90.000000,0> translate<32.272628,0.000000,1.257300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.026888,0.000000,1.257300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.518372,0.000000,1.257300>}
box{<0,0,-0.038100><0.491484,0.036000,0.038100> rotate<0,0.000000,0> translate<32.026888,0.000000,1.257300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.775303,0.000000,1.871656>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.898172,0.000000,1.994528>}
box{<0,0,-0.038100><0.173765,0.036000,0.038100> rotate<0,-44.997759,0> translate<32.775303,0.000000,1.871656> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.898172,0.000000,1.994528>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<33.143916,0.000000,1.994528>}
box{<0,0,-0.038100><0.245744,0.036000,0.038100> rotate<0,0.000000,0> translate<32.898172,0.000000,1.994528> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<33.143916,0.000000,1.994528>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<33.266787,0.000000,1.871656>}
box{<0,0,-0.038100><0.173767,0.036000,0.038100> rotate<0,44.997030,0> translate<33.143916,0.000000,1.994528> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<33.266787,0.000000,1.871656>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<33.266787,0.000000,1.748784>}
box{<0,0,-0.038100><0.122872,0.036000,0.038100> rotate<0,-90.000000,0> translate<33.266787,0.000000,1.748784> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<33.266787,0.000000,1.748784>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<33.143916,0.000000,1.625913>}
box{<0,0,-0.038100><0.173767,0.036000,0.038100> rotate<0,-44.997030,0> translate<33.143916,0.000000,1.625913> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<33.143916,0.000000,1.625913>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<33.021044,0.000000,1.625913>}
box{<0,0,-0.038100><0.122872,0.036000,0.038100> rotate<0,0.000000,0> translate<33.021044,0.000000,1.625913> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<33.143916,0.000000,1.625913>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<33.266787,0.000000,1.503041>}
box{<0,0,-0.038100><0.173767,0.036000,0.038100> rotate<0,44.997030,0> translate<33.143916,0.000000,1.625913> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<33.266787,0.000000,1.503041>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<33.266787,0.000000,1.380169>}
box{<0,0,-0.038100><0.122872,0.036000,0.038100> rotate<0,-90.000000,0> translate<33.266787,0.000000,1.380169> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<33.266787,0.000000,1.380169>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<33.143916,0.000000,1.257300>}
box{<0,0,-0.038100><0.173765,0.036000,0.038100> rotate<0,-44.996302,0> translate<33.143916,0.000000,1.257300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<33.143916,0.000000,1.257300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.898172,0.000000,1.257300>}
box{<0,0,-0.038100><0.245744,0.036000,0.038100> rotate<0,0.000000,0> translate<32.898172,0.000000,1.257300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.898172,0.000000,1.257300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.775303,0.000000,1.380169>}
box{<0,0,-0.038100><0.173763,0.036000,0.038100> rotate<0,44.997030,0> translate<32.775303,0.000000,1.380169> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<10.198100,0.000000,0.038100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<10.198100,0.000000,0.775328>}
box{<0,0,-0.038100><0.737228,0.036000,0.038100> rotate<0,90.000000,0> translate<10.198100,0.000000,0.775328> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<10.198100,0.000000,0.775328>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<10.566713,0.000000,0.775328>}
box{<0,0,-0.038100><0.368613,0.036000,0.038100> rotate<0,0.000000,0> translate<10.198100,0.000000,0.775328> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<10.566713,0.000000,0.775328>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<10.689584,0.000000,0.652456>}
box{<0,0,-0.038100><0.173767,0.036000,0.038100> rotate<0,44.997030,0> translate<10.566713,0.000000,0.775328> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<10.689584,0.000000,0.652456>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<10.689584,0.000000,0.406713>}
box{<0,0,-0.038100><0.245744,0.036000,0.038100> rotate<0,-90.000000,0> translate<10.689584,0.000000,0.406713> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<10.689584,0.000000,0.406713>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<10.566713,0.000000,0.283841>}
box{<0,0,-0.038100><0.173767,0.036000,0.038100> rotate<0,-44.997030,0> translate<10.566713,0.000000,0.283841> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<10.566713,0.000000,0.283841>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<10.198100,0.000000,0.283841>}
box{<0,0,-0.038100><0.368613,0.036000,0.038100> rotate<0,0.000000,0> translate<10.198100,0.000000,0.283841> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<11.438000,0.000000,0.652456>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<11.315128,0.000000,0.775328>}
box{<0,0,-0.038100><0.173767,0.036000,0.038100> rotate<0,44.997030,0> translate<11.315128,0.000000,0.775328> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<11.315128,0.000000,0.775328>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<11.069384,0.000000,0.775328>}
box{<0,0,-0.038100><0.245744,0.036000,0.038100> rotate<0,0.000000,0> translate<11.069384,0.000000,0.775328> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<11.069384,0.000000,0.775328>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<10.946516,0.000000,0.652456>}
box{<0,0,-0.038100><0.173765,0.036000,0.038100> rotate<0,-44.997759,0> translate<10.946516,0.000000,0.652456> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<10.946516,0.000000,0.652456>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<10.946516,0.000000,0.160969>}
box{<0,0,-0.038100><0.491488,0.036000,0.038100> rotate<0,-90.000000,0> translate<10.946516,0.000000,0.160969> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<10.946516,0.000000,0.160969>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<11.069384,0.000000,0.038100>}
box{<0,0,-0.038100><0.173763,0.036000,0.038100> rotate<0,44.997030,0> translate<10.946516,0.000000,0.160969> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<11.069384,0.000000,0.038100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<11.315128,0.000000,0.038100>}
box{<0,0,-0.038100><0.245744,0.036000,0.038100> rotate<0,0.000000,0> translate<11.069384,0.000000,0.038100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<11.315128,0.000000,0.038100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<11.438000,0.000000,0.160969>}
box{<0,0,-0.038100><0.173765,0.036000,0.038100> rotate<0,-44.996302,0> translate<11.315128,0.000000,0.038100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<11.694931,0.000000,0.038100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<11.694931,0.000000,0.775328>}
box{<0,0,-0.038100><0.737228,0.036000,0.038100> rotate<0,90.000000,0> translate<11.694931,0.000000,0.775328> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<11.694931,0.000000,0.775328>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<12.063544,0.000000,0.775328>}
box{<0,0,-0.038100><0.368613,0.036000,0.038100> rotate<0,0.000000,0> translate<11.694931,0.000000,0.775328> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<12.063544,0.000000,0.775328>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<12.186416,0.000000,0.652456>}
box{<0,0,-0.038100><0.173767,0.036000,0.038100> rotate<0,44.997030,0> translate<12.063544,0.000000,0.775328> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<12.186416,0.000000,0.652456>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<12.186416,0.000000,0.529584>}
box{<0,0,-0.038100><0.122872,0.036000,0.038100> rotate<0,-90.000000,0> translate<12.186416,0.000000,0.529584> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<12.186416,0.000000,0.529584>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<12.063544,0.000000,0.406713>}
box{<0,0,-0.038100><0.173767,0.036000,0.038100> rotate<0,-44.997030,0> translate<12.063544,0.000000,0.406713> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<12.063544,0.000000,0.406713>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<12.186416,0.000000,0.283841>}
box{<0,0,-0.038100><0.173767,0.036000,0.038100> rotate<0,44.997030,0> translate<12.063544,0.000000,0.406713> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<12.186416,0.000000,0.283841>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<12.186416,0.000000,0.160969>}
box{<0,0,-0.038100><0.122872,0.036000,0.038100> rotate<0,-90.000000,0> translate<12.186416,0.000000,0.160969> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<12.186416,0.000000,0.160969>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<12.063544,0.000000,0.038100>}
box{<0,0,-0.038100><0.173765,0.036000,0.038100> rotate<0,-44.996302,0> translate<12.063544,0.000000,0.038100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<12.063544,0.000000,0.038100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<11.694931,0.000000,0.038100>}
box{<0,0,-0.038100><0.368613,0.036000,0.038100> rotate<0,0.000000,0> translate<11.694931,0.000000,0.038100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<11.694931,0.000000,0.406713>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<12.063544,0.000000,0.406713>}
box{<0,0,-0.038100><0.368613,0.036000,0.038100> rotate<0,0.000000,0> translate<11.694931,0.000000,0.406713> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<13.191763,0.000000,0.775328>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<13.191763,0.000000,0.038100>}
box{<0,0,-0.038100><0.737228,0.036000,0.038100> rotate<0,-90.000000,0> translate<13.191763,0.000000,0.038100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<13.191763,0.000000,0.038100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<13.560375,0.000000,0.038100>}
box{<0,0,-0.038100><0.368612,0.036000,0.038100> rotate<0,0.000000,0> translate<13.191763,0.000000,0.038100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<13.560375,0.000000,0.038100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<13.683247,0.000000,0.160969>}
box{<0,0,-0.038100><0.173765,0.036000,0.038100> rotate<0,-44.996302,0> translate<13.560375,0.000000,0.038100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<13.683247,0.000000,0.160969>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<13.683247,0.000000,0.406713>}
box{<0,0,-0.038100><0.245744,0.036000,0.038100> rotate<0,90.000000,0> translate<13.683247,0.000000,0.406713> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<13.683247,0.000000,0.406713>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<13.560375,0.000000,0.529584>}
box{<0,0,-0.038100><0.173767,0.036000,0.038100> rotate<0,44.997030,0> translate<13.560375,0.000000,0.529584> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<13.560375,0.000000,0.529584>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<13.191763,0.000000,0.529584>}
box{<0,0,-0.038100><0.368612,0.036000,0.038100> rotate<0,0.000000,0> translate<13.191763,0.000000,0.529584> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<13.940178,0.000000,0.529584>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<13.940178,0.000000,0.160969>}
box{<0,0,-0.038100><0.368616,0.036000,0.038100> rotate<0,-90.000000,0> translate<13.940178,0.000000,0.160969> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<13.940178,0.000000,0.160969>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<14.063047,0.000000,0.038100>}
box{<0,0,-0.038100><0.173763,0.036000,0.038100> rotate<0,44.997030,0> translate<13.940178,0.000000,0.160969> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<14.063047,0.000000,0.038100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<14.431662,0.000000,0.038100>}
box{<0,0,-0.038100><0.368616,0.036000,0.038100> rotate<0,0.000000,0> translate<14.063047,0.000000,0.038100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<14.431662,0.000000,0.529584>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<14.431662,0.000000,-0.084769>}
box{<0,0,-0.038100><0.614353,0.036000,0.038100> rotate<0,-90.000000,0> translate<14.431662,0.000000,-0.084769> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<14.431662,0.000000,-0.084769>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<14.308791,0.000000,-0.207641>}
box{<0,0,-0.038100><0.173767,0.036000,0.038100> rotate<0,-44.997030,0> translate<14.308791,0.000000,-0.207641> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<14.308791,0.000000,-0.207641>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<14.185919,0.000000,-0.207641>}
box{<0,0,-0.038100><0.122872,0.036000,0.038100> rotate<0,0.000000,0> translate<14.185919,0.000000,-0.207641> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<15.437009,0.000000,0.038100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<15.437009,0.000000,0.775328>}
box{<0,0,-0.038100><0.737228,0.036000,0.038100> rotate<0,90.000000,0> translate<15.437009,0.000000,0.775328> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<15.437009,0.000000,0.775328>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<15.805622,0.000000,0.775328>}
box{<0,0,-0.038100><0.368612,0.036000,0.038100> rotate<0,0.000000,0> translate<15.437009,0.000000,0.775328> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<15.805622,0.000000,0.775328>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<15.928494,0.000000,0.652456>}
box{<0,0,-0.038100><0.173767,0.036000,0.038100> rotate<0,44.997030,0> translate<15.805622,0.000000,0.775328> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<15.928494,0.000000,0.652456>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<15.928494,0.000000,0.406713>}
box{<0,0,-0.038100><0.245744,0.036000,0.038100> rotate<0,-90.000000,0> translate<15.928494,0.000000,0.406713> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<15.928494,0.000000,0.406713>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<15.805622,0.000000,0.283841>}
box{<0,0,-0.038100><0.173767,0.036000,0.038100> rotate<0,-44.997030,0> translate<15.805622,0.000000,0.283841> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<15.805622,0.000000,0.283841>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<15.437009,0.000000,0.283841>}
box{<0,0,-0.038100><0.368612,0.036000,0.038100> rotate<0,0.000000,0> translate<15.437009,0.000000,0.283841> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<16.308294,0.000000,0.529584>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<16.554037,0.000000,0.529584>}
box{<0,0,-0.038100><0.245744,0.036000,0.038100> rotate<0,0.000000,0> translate<16.308294,0.000000,0.529584> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<16.554037,0.000000,0.529584>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<16.676909,0.000000,0.406713>}
box{<0,0,-0.038100><0.173767,0.036000,0.038100> rotate<0,44.997030,0> translate<16.554037,0.000000,0.529584> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<16.676909,0.000000,0.406713>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<16.676909,0.000000,0.038100>}
box{<0,0,-0.038100><0.368613,0.036000,0.038100> rotate<0,-90.000000,0> translate<16.676909,0.000000,0.038100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<16.676909,0.000000,0.038100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<16.308294,0.000000,0.038100>}
box{<0,0,-0.038100><0.368616,0.036000,0.038100> rotate<0,0.000000,0> translate<16.308294,0.000000,0.038100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<16.308294,0.000000,0.038100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<16.185425,0.000000,0.160969>}
box{<0,0,-0.038100><0.173763,0.036000,0.038100> rotate<0,44.997030,0> translate<16.185425,0.000000,0.160969> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<16.185425,0.000000,0.160969>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<16.308294,0.000000,0.283841>}
box{<0,0,-0.038100><0.173765,0.036000,0.038100> rotate<0,-44.997759,0> translate<16.185425,0.000000,0.160969> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<16.308294,0.000000,0.283841>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<16.676909,0.000000,0.283841>}
box{<0,0,-0.038100><0.368616,0.036000,0.038100> rotate<0,0.000000,0> translate<16.308294,0.000000,0.283841> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<16.933841,0.000000,0.529584>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<16.933841,0.000000,0.160969>}
box{<0,0,-0.038100><0.368616,0.036000,0.038100> rotate<0,-90.000000,0> translate<16.933841,0.000000,0.160969> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<16.933841,0.000000,0.160969>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<17.056709,0.000000,0.038100>}
box{<0,0,-0.038100><0.173763,0.036000,0.038100> rotate<0,44.997030,0> translate<16.933841,0.000000,0.160969> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<17.056709,0.000000,0.038100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<17.425325,0.000000,0.038100>}
box{<0,0,-0.038100><0.368616,0.036000,0.038100> rotate<0,0.000000,0> translate<17.056709,0.000000,0.038100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<17.425325,0.000000,0.038100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<17.425325,0.000000,0.529584>}
box{<0,0,-0.038100><0.491484,0.036000,0.038100> rotate<0,90.000000,0> translate<17.425325,0.000000,0.529584> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<17.682256,0.000000,0.775328>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<17.805125,0.000000,0.775328>}
box{<0,0,-0.038100><0.122869,0.036000,0.038100> rotate<0,0.000000,0> translate<17.682256,0.000000,0.775328> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<17.805125,0.000000,0.775328>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<17.805125,0.000000,0.038100>}
box{<0,0,-0.038100><0.737228,0.036000,0.038100> rotate<0,-90.000000,0> translate<17.805125,0.000000,0.038100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<17.682256,0.000000,0.038100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<17.927997,0.000000,0.038100>}
box{<0,0,-0.038100><0.245741,0.036000,0.038100> rotate<0,0.000000,0> translate<17.682256,0.000000,0.038100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<19.421100,0.000000,0.652456>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<19.298228,0.000000,0.775328>}
box{<0,0,-0.038100><0.173767,0.036000,0.038100> rotate<0,44.997030,0> translate<19.298228,0.000000,0.775328> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<19.298228,0.000000,0.775328>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<19.052484,0.000000,0.775328>}
box{<0,0,-0.038100><0.245744,0.036000,0.038100> rotate<0,0.000000,0> translate<19.052484,0.000000,0.775328> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<19.052484,0.000000,0.775328>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<18.929616,0.000000,0.652456>}
box{<0,0,-0.038100><0.173765,0.036000,0.038100> rotate<0,-44.997759,0> translate<18.929616,0.000000,0.652456> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<18.929616,0.000000,0.652456>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<18.929616,0.000000,0.529584>}
box{<0,0,-0.038100><0.122872,0.036000,0.038100> rotate<0,-90.000000,0> translate<18.929616,0.000000,0.529584> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<18.929616,0.000000,0.529584>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<19.052484,0.000000,0.406713>}
box{<0,0,-0.038100><0.173765,0.036000,0.038100> rotate<0,44.997759,0> translate<18.929616,0.000000,0.529584> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<19.052484,0.000000,0.406713>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<19.298228,0.000000,0.406713>}
box{<0,0,-0.038100><0.245744,0.036000,0.038100> rotate<0,0.000000,0> translate<19.052484,0.000000,0.406713> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<19.298228,0.000000,0.406713>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<19.421100,0.000000,0.283841>}
box{<0,0,-0.038100><0.173767,0.036000,0.038100> rotate<0,44.997030,0> translate<19.298228,0.000000,0.406713> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<19.421100,0.000000,0.283841>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<19.421100,0.000000,0.160969>}
box{<0,0,-0.038100><0.122872,0.036000,0.038100> rotate<0,-90.000000,0> translate<19.421100,0.000000,0.160969> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<19.421100,0.000000,0.160969>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<19.298228,0.000000,0.038100>}
box{<0,0,-0.038100><0.173765,0.036000,0.038100> rotate<0,-44.996302,0> translate<19.298228,0.000000,0.038100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<19.298228,0.000000,0.038100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<19.052484,0.000000,0.038100>}
box{<0,0,-0.038100><0.245744,0.036000,0.038100> rotate<0,0.000000,0> translate<19.052484,0.000000,0.038100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<19.052484,0.000000,0.038100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<18.929616,0.000000,0.160969>}
box{<0,0,-0.038100><0.173763,0.036000,0.038100> rotate<0,44.997030,0> translate<18.929616,0.000000,0.160969> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<19.800900,0.000000,0.038100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<20.046644,0.000000,0.038100>}
box{<0,0,-0.038100><0.245744,0.036000,0.038100> rotate<0,0.000000,0> translate<19.800900,0.000000,0.038100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<20.046644,0.000000,0.038100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<20.169516,0.000000,0.160969>}
box{<0,0,-0.038100><0.173765,0.036000,0.038100> rotate<0,-44.996302,0> translate<20.046644,0.000000,0.038100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<20.169516,0.000000,0.160969>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<20.169516,0.000000,0.406713>}
box{<0,0,-0.038100><0.245744,0.036000,0.038100> rotate<0,90.000000,0> translate<20.169516,0.000000,0.406713> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<20.169516,0.000000,0.406713>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<20.046644,0.000000,0.529584>}
box{<0,0,-0.038100><0.173767,0.036000,0.038100> rotate<0,44.997030,0> translate<20.046644,0.000000,0.529584> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<20.046644,0.000000,0.529584>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<19.800900,0.000000,0.529584>}
box{<0,0,-0.038100><0.245744,0.036000,0.038100> rotate<0,0.000000,0> translate<19.800900,0.000000,0.529584> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<19.800900,0.000000,0.529584>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<19.678031,0.000000,0.406713>}
box{<0,0,-0.038100><0.173765,0.036000,0.038100> rotate<0,-44.997759,0> translate<19.678031,0.000000,0.406713> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<19.678031,0.000000,0.406713>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<19.678031,0.000000,0.160969>}
box{<0,0,-0.038100><0.245744,0.036000,0.038100> rotate<0,-90.000000,0> translate<19.678031,0.000000,0.160969> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<19.678031,0.000000,0.160969>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<19.800900,0.000000,0.038100>}
box{<0,0,-0.038100><0.173763,0.036000,0.038100> rotate<0,44.997030,0> translate<19.678031,0.000000,0.160969> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<20.426447,0.000000,0.775328>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<20.426447,0.000000,0.038100>}
box{<0,0,-0.038100><0.737228,0.036000,0.038100> rotate<0,-90.000000,0> translate<20.426447,0.000000,0.038100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<20.426447,0.000000,0.406713>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<20.549316,0.000000,0.529584>}
box{<0,0,-0.038100><0.173765,0.036000,0.038100> rotate<0,-44.997759,0> translate<20.426447,0.000000,0.406713> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<20.549316,0.000000,0.529584>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<20.795059,0.000000,0.529584>}
box{<0,0,-0.038100><0.245744,0.036000,0.038100> rotate<0,0.000000,0> translate<20.549316,0.000000,0.529584> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<20.795059,0.000000,0.529584>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<20.917931,0.000000,0.406713>}
box{<0,0,-0.038100><0.173767,0.036000,0.038100> rotate<0,44.997030,0> translate<20.795059,0.000000,0.529584> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<20.917931,0.000000,0.406713>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<20.917931,0.000000,0.038100>}
box{<0,0,-0.038100><0.368613,0.036000,0.038100> rotate<0,-90.000000,0> translate<20.917931,0.000000,0.038100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<21.174862,0.000000,0.529584>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<21.297731,0.000000,0.529584>}
box{<0,0,-0.038100><0.122869,0.036000,0.038100> rotate<0,0.000000,0> translate<21.174862,0.000000,0.529584> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<21.297731,0.000000,0.529584>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<21.297731,0.000000,0.038100>}
box{<0,0,-0.038100><0.491484,0.036000,0.038100> rotate<0,-90.000000,0> translate<21.297731,0.000000,0.038100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<21.174862,0.000000,0.038100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<21.420603,0.000000,0.038100>}
box{<0,0,-0.038100><0.245741,0.036000,0.038100> rotate<0,0.000000,0> translate<21.174862,0.000000,0.038100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<21.297731,0.000000,0.898200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<21.297731,0.000000,0.775328>}
box{<0,0,-0.038100><0.122872,0.036000,0.038100> rotate<0,-90.000000,0> translate<21.297731,0.000000,0.775328> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<22.042419,0.000000,0.038100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<21.796675,0.000000,0.038100>}
box{<0,0,-0.038100><0.245744,0.036000,0.038100> rotate<0,0.000000,0> translate<21.796675,0.000000,0.038100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<21.796675,0.000000,0.038100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<21.673806,0.000000,0.160969>}
box{<0,0,-0.038100><0.173763,0.036000,0.038100> rotate<0,44.997030,0> translate<21.673806,0.000000,0.160969> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<21.673806,0.000000,0.160969>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<21.673806,0.000000,0.406713>}
box{<0,0,-0.038100><0.245744,0.036000,0.038100> rotate<0,90.000000,0> translate<21.673806,0.000000,0.406713> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<21.673806,0.000000,0.406713>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<21.796675,0.000000,0.529584>}
box{<0,0,-0.038100><0.173765,0.036000,0.038100> rotate<0,-44.997759,0> translate<21.673806,0.000000,0.406713> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<21.796675,0.000000,0.529584>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<22.042419,0.000000,0.529584>}
box{<0,0,-0.038100><0.245744,0.036000,0.038100> rotate<0,0.000000,0> translate<21.796675,0.000000,0.529584> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<22.042419,0.000000,0.529584>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<22.165291,0.000000,0.406713>}
box{<0,0,-0.038100><0.173767,0.036000,0.038100> rotate<0,44.997030,0> translate<22.042419,0.000000,0.529584> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<22.165291,0.000000,0.406713>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<22.165291,0.000000,0.283841>}
box{<0,0,-0.038100><0.122872,0.036000,0.038100> rotate<0,-90.000000,0> translate<22.165291,0.000000,0.283841> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<22.165291,0.000000,0.283841>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<21.673806,0.000000,0.283841>}
box{<0,0,-0.038100><0.491484,0.036000,0.038100> rotate<0,0.000000,0> translate<21.673806,0.000000,0.283841> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<22.422222,0.000000,0.038100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<22.422222,0.000000,0.529584>}
box{<0,0,-0.038100><0.491484,0.036000,0.038100> rotate<0,90.000000,0> translate<22.422222,0.000000,0.529584> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<22.422222,0.000000,0.283841>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<22.667963,0.000000,0.529584>}
box{<0,0,-0.038100><0.347532,0.036000,0.038100> rotate<0,-44.997394,0> translate<22.422222,0.000000,0.283841> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<22.667963,0.000000,0.529584>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<22.790834,0.000000,0.529584>}
box{<0,0,-0.038100><0.122872,0.036000,0.038100> rotate<0,0.000000,0> translate<22.667963,0.000000,0.529584> }
//C1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<2.680000,0.000000,12.190000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<8.380000,0.000000,12.190000>}
box{<0,0,-0.101600><5.700000,0.036000,0.101600> rotate<0,0.000000,0> translate<2.680000,0.000000,12.190000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<8.380000,0.000000,12.190000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<8.380000,0.000000,9.990000>}
box{<0,0,-0.101600><2.200000,0.036000,0.101600> rotate<0,-90.000000,0> translate<8.380000,0.000000,9.990000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<8.380000,0.000000,9.990000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<8.380000,0.000000,7.790000>}
box{<0,0,-0.101600><2.200000,0.036000,0.101600> rotate<0,-90.000000,0> translate<8.380000,0.000000,7.790000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<8.380000,0.000000,7.790000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<8.380000,0.000000,5.590000>}
box{<0,0,-0.101600><2.200000,0.036000,0.101600> rotate<0,-90.000000,0> translate<8.380000,0.000000,5.590000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<8.380000,0.000000,5.590000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<2.680000,0.000000,5.590000>}
box{<0,0,-0.101600><5.700000,0.036000,0.101600> rotate<0,0.000000,0> translate<2.680000,0.000000,5.590000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<1.780000,0.000000,6.490000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<1.780000,0.000000,7.790000>}
box{<0,0,-0.101600><1.300000,0.036000,0.101600> rotate<0,90.000000,0> translate<1.780000,0.000000,7.790000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<1.780000,0.000000,7.790000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<1.780000,0.000000,9.990000>}
box{<0,0,-0.101600><2.200000,0.036000,0.101600> rotate<0,90.000000,0> translate<1.780000,0.000000,9.990000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<1.780000,0.000000,9.990000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<1.780000,0.000000,11.290000>}
box{<0,0,-0.101600><1.300000,0.036000,0.101600> rotate<0,90.000000,0> translate<1.780000,0.000000,11.290000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<1.780000,0.000000,11.290000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<2.680000,0.000000,12.190000>}
box{<0,0,-0.101600><1.272792,0.036000,0.101600> rotate<0,-44.997030,0> translate<1.780000,0.000000,11.290000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<2.680000,0.000000,5.590000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<1.780000,0.000000,6.490000>}
box{<0,0,-0.101600><1.272792,0.036000,0.101600> rotate<0,44.997030,0> translate<1.780000,0.000000,6.490000> }
object{ARC(3.091731,0.203200,16.923757,162.105152,0.036000) translate<5.072163,0.000000,8.890000>}
object{ARC(3.091622,0.203200,342.590697,377.409303,0.036000) translate<5.080000,0.000000,8.865000>}
object{ARC(3.091731,0.203200,196.923757,342.105152,0.036000) translate<5.087838,0.000000,8.890000>}
object{ARC(3.091622,0.203200,162.590698,197.409302,0.036000) translate<5.080000,0.000000,8.915000>}
//C2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<16.891000,0.000000,12.040000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<16.129000,0.000000,12.040000>}
box{<0,0,-0.050800><0.762000,0.036000,0.050800> rotate<0,0.000000,0> translate<16.129000,0.000000,12.040000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<16.866000,0.000000,13.360000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<16.129000,0.000000,13.360000>}
box{<0,0,-0.050800><0.737000,0.036000,0.050800> rotate<0,0.000000,0> translate<16.129000,0.000000,13.360000> }
box{<-0.375050,0,-0.725050><0.375050,0.036000,0.725050> rotate<0,-180.000000,0> translate<17.227150,0.000000,12.698850>}
box{<-0.375050,0,-0.725050><0.375050,0.036000,0.725050> rotate<0,-180.000000,0> translate<15.779350,0.000000,12.698850>}
//C3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<23.520000,0.000000,11.811000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<23.520000,0.000000,11.049000>}
box{<0,0,-0.050800><0.762000,0.036000,0.050800> rotate<0,-90.000000,0> translate<23.520000,0.000000,11.049000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<22.200000,0.000000,11.786000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<22.200000,0.000000,11.049000>}
box{<0,0,-0.050800><0.737000,0.036000,0.050800> rotate<0,-90.000000,0> translate<22.200000,0.000000,11.049000> }
box{<-0.375050,0,-0.725050><0.375050,0.036000,0.725050> rotate<0,-270.000000,0> translate<22.861150,0.000000,12.147150>}
box{<-0.375050,0,-0.725050><0.375050,0.036000,0.725050> rotate<0,-270.000000,0> translate<22.861150,0.000000,10.699350>}
//IC1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.274000,0.000000,10.845800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.146000,0.000000,10.845800>}
box{<0,0,-0.076200><8.128000,0.036000,0.076200> rotate<0,0.000000,0> translate<25.146000,0.000000,10.845800> }
object{ARC(0.381000,0.152400,270.000000,360.000000,0.036000) translate<33.274000,0.000000,7.315200>}
object{ARC(0.381000,0.152400,90.000000,180.000000,0.036000) translate<25.146000,0.000000,10.464800>}
object{ARC(0.381000,0.152400,0.000000,90.000000,0.036000) translate<33.274000,0.000000,10.464800>}
object{ARC(0.381000,0.152400,180.000000,270.000000,0.036000) translate<25.146000,0.000000,7.315200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.146000,0.000000,6.934200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.274000,0.000000,6.934200>}
box{<0,0,-0.076200><8.128000,0.036000,0.076200> rotate<0,0.000000,0> translate<25.146000,0.000000,6.934200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.655000,0.000000,7.315200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.655000,0.000000,10.464800>}
box{<0,0,-0.076200><3.149600,0.036000,0.076200> rotate<0,90.000000,0> translate<33.655000,0.000000,10.464800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.765000,0.000000,10.464800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.765000,0.000000,9.398000>}
box{<0,0,-0.076200><1.066800,0.036000,0.076200> rotate<0,-90.000000,0> translate<24.765000,0.000000,9.398000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.765000,0.000000,9.398000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.765000,0.000000,8.382000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,-90.000000,0> translate<24.765000,0.000000,8.382000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.765000,0.000000,8.382000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.765000,0.000000,7.315200>}
box{<0,0,-0.076200><1.066800,0.036000,0.076200> rotate<0,-90.000000,0> translate<24.765000,0.000000,7.315200> }
object{ARC(0.508000,0.152400,270.000000,450.000000,0.036000) translate<24.765000,0.000000,8.890000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<24.765000,0.000000,7.289800>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<33.655000,0.000000,7.289800>}
box{<0,0,-0.025400><8.890000,0.036000,0.025400> rotate<0,0.000000,0> translate<24.765000,0.000000,7.289800> }
box{<-0.254000,0,-0.571500><0.254000,0.036000,0.571500> rotate<0,-0.000000,0> translate<29.210000,0.000000,11.417300>}
box{<-0.254000,0,-0.571500><0.254000,0.036000,0.571500> rotate<0,-0.000000,0> translate<25.400000,0.000000,6.362700>}
box{<-0.254000,0,-0.571500><0.254000,0.036000,0.571500> rotate<0,-0.000000,0> translate<26.670000,0.000000,6.362700>}
box{<-0.254000,0,-0.571500><0.254000,0.036000,0.571500> rotate<0,-0.000000,0> translate<27.940000,0.000000,6.388100>}
box{<-0.254000,0,-0.571500><0.254000,0.036000,0.571500> rotate<0,-0.000000,0> translate<29.210000,0.000000,6.362700>}
box{<-0.254000,0,-0.571500><0.254000,0.036000,0.571500> rotate<0,-0.000000,0> translate<27.940000,0.000000,11.417300>}
box{<-0.254000,0,-0.571500><0.254000,0.036000,0.571500> rotate<0,-0.000000,0> translate<26.670000,0.000000,11.417300>}
box{<-0.254000,0,-0.571500><0.254000,0.036000,0.571500> rotate<0,-0.000000,0> translate<25.400000,0.000000,11.417300>}
box{<-0.254000,0,-0.571500><0.254000,0.036000,0.571500> rotate<0,-0.000000,0> translate<30.480000,0.000000,11.417300>}
box{<-0.254000,0,-0.571500><0.254000,0.036000,0.571500> rotate<0,-0.000000,0> translate<31.750000,0.000000,11.417300>}
box{<-0.254000,0,-0.571500><0.254000,0.036000,0.571500> rotate<0,-0.000000,0> translate<33.020000,0.000000,11.417300>}
box{<-0.254000,0,-0.571500><0.254000,0.036000,0.571500> rotate<0,-0.000000,0> translate<30.480000,0.000000,6.362700>}
box{<-0.254000,0,-0.571500><0.254000,0.036000,0.571500> rotate<0,-0.000000,0> translate<31.750000,0.000000,6.362700>}
box{<-0.254000,0,-0.571500><0.254000,0.036000,0.571500> rotate<0,-0.000000,0> translate<33.020000,0.000000,6.362700>}
//JP1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,1.905000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.715000,0.000000,2.540000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<5.080000,0.000000,1.905000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.715000,0.000000,2.540000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.985000,0.000000,2.540000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.715000,0.000000,2.540000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.985000,0.000000,2.540000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.620000,0.000000,1.905000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<6.985000,0.000000,2.540000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.620000,0.000000,1.905000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.620000,0.000000,0.635000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<7.620000,0.000000,0.635000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.620000,0.000000,0.635000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.985000,0.000000,0.000000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<6.985000,0.000000,0.000000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.985000,0.000000,0.000000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.715000,0.000000,0.000000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.715000,0.000000,0.000000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.715000,0.000000,0.000000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,0.635000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<5.080000,0.000000,0.635000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<0.635000,0.000000,2.540000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.905000,0.000000,2.540000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<0.635000,0.000000,2.540000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.905000,0.000000,2.540000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.540000,0.000000,1.905000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<1.905000,0.000000,2.540000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.540000,0.000000,1.905000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.540000,0.000000,0.635000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<2.540000,0.000000,0.635000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.540000,0.000000,0.635000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.905000,0.000000,0.000000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<1.905000,0.000000,0.000000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.540000,0.000000,1.905000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.175000,0.000000,2.540000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<2.540000,0.000000,1.905000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.175000,0.000000,2.540000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.445000,0.000000,2.540000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<3.175000,0.000000,2.540000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.445000,0.000000,2.540000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,1.905000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<4.445000,0.000000,2.540000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,1.905000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,0.635000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<5.080000,0.000000,0.635000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,0.635000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.445000,0.000000,0.000000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<4.445000,0.000000,0.000000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.445000,0.000000,0.000000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.175000,0.000000,0.000000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<3.175000,0.000000,0.000000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.175000,0.000000,0.000000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.540000,0.000000,0.635000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<2.540000,0.000000,0.635000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<0.000000,0.000000,1.905000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<0.000000,0.000000,0.635000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<0.000000,0.000000,0.635000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<0.635000,0.000000,2.540000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<0.000000,0.000000,1.905000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<0.000000,0.000000,1.905000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<0.000000,0.000000,0.635000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<0.635000,0.000000,0.000000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<0.000000,0.000000,0.635000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.905000,0.000000,0.000000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<0.635000,0.000000,0.000000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<0.635000,0.000000,0.000000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.255000,0.000000,2.540000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.525000,0.000000,2.540000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.255000,0.000000,2.540000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.525000,0.000000,2.540000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,1.905000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<9.525000,0.000000,2.540000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,1.905000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,0.635000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<10.160000,0.000000,0.635000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,0.635000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.525000,0.000000,0.000000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<9.525000,0.000000,0.000000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.255000,0.000000,2.540000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.620000,0.000000,1.905000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<7.620000,0.000000,1.905000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.620000,0.000000,0.635000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.255000,0.000000,0.000000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<7.620000,0.000000,0.635000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.525000,0.000000,0.000000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.255000,0.000000,0.000000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.255000,0.000000,0.000000> }
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<6.350000,0.000000,1.270000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<3.810000,0.000000,1.270000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<1.270000,0.000000,1.270000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<8.890000,0.000000,1.270000>}
//JP2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.100000,0.000000,1.905000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.735000,0.000000,2.540000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<38.100000,0.000000,1.905000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.735000,0.000000,2.540000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.005000,0.000000,2.540000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<38.735000,0.000000,2.540000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.005000,0.000000,2.540000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.640000,0.000000,1.905000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<40.005000,0.000000,2.540000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.640000,0.000000,1.905000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.640000,0.000000,0.635000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<40.640000,0.000000,0.635000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.640000,0.000000,0.635000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.005000,0.000000,0.000000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<40.005000,0.000000,0.000000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.005000,0.000000,0.000000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.735000,0.000000,0.000000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<38.735000,0.000000,0.000000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.735000,0.000000,0.000000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.100000,0.000000,0.635000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<38.100000,0.000000,0.635000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.655000,0.000000,2.540000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.925000,0.000000,2.540000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<33.655000,0.000000,2.540000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.925000,0.000000,2.540000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.560000,0.000000,1.905000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<34.925000,0.000000,2.540000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.560000,0.000000,1.905000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.560000,0.000000,0.635000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<35.560000,0.000000,0.635000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.560000,0.000000,0.635000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.925000,0.000000,0.000000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<34.925000,0.000000,0.000000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.560000,0.000000,1.905000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.195000,0.000000,2.540000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<35.560000,0.000000,1.905000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.195000,0.000000,2.540000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.465000,0.000000,2.540000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<36.195000,0.000000,2.540000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.465000,0.000000,2.540000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.100000,0.000000,1.905000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<37.465000,0.000000,2.540000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.100000,0.000000,1.905000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.100000,0.000000,0.635000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<38.100000,0.000000,0.635000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.100000,0.000000,0.635000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.465000,0.000000,0.000000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<37.465000,0.000000,0.000000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.465000,0.000000,0.000000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.195000,0.000000,0.000000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<36.195000,0.000000,0.000000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.195000,0.000000,0.000000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.560000,0.000000,0.635000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<35.560000,0.000000,0.635000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.020000,0.000000,1.905000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.020000,0.000000,0.635000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<33.020000,0.000000,0.635000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.655000,0.000000,2.540000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.020000,0.000000,1.905000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<33.020000,0.000000,1.905000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.020000,0.000000,0.635000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.655000,0.000000,0.000000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<33.020000,0.000000,0.635000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.925000,0.000000,0.000000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.655000,0.000000,0.000000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<33.655000,0.000000,0.000000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.275000,0.000000,2.540000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.545000,0.000000,2.540000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<41.275000,0.000000,2.540000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.545000,0.000000,2.540000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.180000,0.000000,1.905000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<42.545000,0.000000,2.540000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.180000,0.000000,1.905000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.180000,0.000000,0.635000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<43.180000,0.000000,0.635000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.180000,0.000000,0.635000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.545000,0.000000,0.000000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<42.545000,0.000000,0.000000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.275000,0.000000,2.540000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.640000,0.000000,1.905000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<40.640000,0.000000,1.905000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.640000,0.000000,0.635000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.275000,0.000000,0.000000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<40.640000,0.000000,0.635000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.545000,0.000000,0.000000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.275000,0.000000,0.000000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<41.275000,0.000000,0.000000> }
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<39.370000,0.000000,1.270000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<36.830000,0.000000,1.270000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<34.290000,0.000000,1.270000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<41.910000,0.000000,1.270000>}
//JP3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.640000,0.000000,6.985000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.640000,0.000000,8.255000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<40.640000,0.000000,8.255000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.640000,0.000000,8.255000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.275000,0.000000,8.890000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<40.640000,0.000000,8.255000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.275000,0.000000,8.890000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.545000,0.000000,8.890000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<41.275000,0.000000,8.890000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.545000,0.000000,8.890000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.180000,0.000000,8.255000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<42.545000,0.000000,8.890000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.275000,0.000000,8.890000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.640000,0.000000,9.525000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<40.640000,0.000000,9.525000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.640000,0.000000,9.525000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.640000,0.000000,10.795000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<40.640000,0.000000,10.795000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.640000,0.000000,10.795000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.275000,0.000000,11.430000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<40.640000,0.000000,10.795000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.275000,0.000000,11.430000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.545000,0.000000,11.430000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<41.275000,0.000000,11.430000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.545000,0.000000,11.430000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.180000,0.000000,10.795000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<42.545000,0.000000,11.430000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.180000,0.000000,10.795000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.180000,0.000000,9.525000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<43.180000,0.000000,9.525000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.180000,0.000000,9.525000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.545000,0.000000,8.890000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<42.545000,0.000000,8.890000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.275000,0.000000,6.350000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.545000,0.000000,6.350000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<41.275000,0.000000,6.350000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.640000,0.000000,6.985000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.275000,0.000000,6.350000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<40.640000,0.000000,6.985000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.545000,0.000000,6.350000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.180000,0.000000,6.985000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<42.545000,0.000000,6.350000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.180000,0.000000,8.255000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.180000,0.000000,6.985000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<43.180000,0.000000,6.985000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.275000,0.000000,11.430000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.640000,0.000000,12.065000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<40.640000,0.000000,12.065000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.640000,0.000000,12.065000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.640000,0.000000,13.335000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<40.640000,0.000000,13.335000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.640000,0.000000,13.335000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.275000,0.000000,13.970000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<40.640000,0.000000,13.335000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.275000,0.000000,13.970000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.545000,0.000000,13.970000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<41.275000,0.000000,13.970000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.545000,0.000000,13.970000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.180000,0.000000,13.335000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<42.545000,0.000000,13.970000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.180000,0.000000,13.335000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.180000,0.000000,12.065000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<43.180000,0.000000,12.065000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.180000,0.000000,12.065000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.545000,0.000000,11.430000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<42.545000,0.000000,11.430000> }
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-90.000000,0> translate<41.910000,0.000000,10.160000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-90.000000,0> translate<41.910000,0.000000,7.620000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-90.000000,0> translate<41.910000,0.000000,12.700000>}
//JP4 silk screen
//LED1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<37.650000,0.000000,18.425000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<38.550000,0.000000,18.425000>}
box{<0,0,-0.050800><0.900000,0.036000,0.050800> rotate<0,0.000000,0> translate<37.650000,0.000000,18.425000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<37.650000,0.000000,19.675000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<38.575000,0.000000,19.675000>}
box{<0,0,-0.050800><0.925000,0.036000,0.050800> rotate<0,0.000000,0> translate<37.650000,0.000000,19.675000> }
box{<-0.075000,0,-0.150000><0.075000,0.036000,0.150000> rotate<0,-90.000000,0> translate<37.950000,0.000000,18.450000>}
box{<-0.075000,0,-0.150000><0.075000,0.036000,0.150000> rotate<0,-90.000000,0> translate<37.950000,0.000000,19.650000>}
box{<-0.150000,0,-0.150000><0.150000,0.036000,0.150000> rotate<0,-90.000000,0> translate<37.950000,0.000000,19.050000>}
box{<-0.675000,0,-0.300000><0.675000,0.036000,0.300000> rotate<0,-90.000000,0> translate<37.350000,0.000000,19.050000>}
box{<-0.675000,0,-0.300000><0.675000,0.036000,0.300000> rotate<0,-90.000000,0> translate<38.850000,0.000000,19.050000>}
//LED2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<34.935000,0.000000,6.800000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<34.935000,0.000000,5.900000>}
box{<0,0,-0.050800><0.900000,0.036000,0.050800> rotate<0,-90.000000,0> translate<34.935000,0.000000,5.900000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<36.185000,0.000000,6.800000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<36.185000,0.000000,5.875000>}
box{<0,0,-0.050800><0.925000,0.036000,0.050800> rotate<0,-90.000000,0> translate<36.185000,0.000000,5.875000> }
box{<-0.075000,0,-0.150000><0.075000,0.036000,0.150000> rotate<0,-0.000000,0> translate<34.960000,0.000000,6.500000>}
box{<-0.075000,0,-0.150000><0.075000,0.036000,0.150000> rotate<0,-0.000000,0> translate<36.160000,0.000000,6.500000>}
box{<-0.150000,0,-0.150000><0.150000,0.036000,0.150000> rotate<0,-0.000000,0> translate<35.560000,0.000000,6.500000>}
box{<-0.675000,0,-0.300000><0.675000,0.036000,0.300000> rotate<0,-0.000000,0> translate<35.560000,0.000000,7.100000>}
box{<-0.675000,0,-0.300000><0.675000,0.036000,0.300000> rotate<0,-0.000000,0> translate<35.560000,0.000000,5.600000>}
//R1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.130000,0.000000,14.605000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.950000,0.000000,14.605000>}
box{<0,0,-0.076200><0.820000,0.036000,0.076200> rotate<0,0.000000,0> translate<2.130000,0.000000,14.605000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.130000,0.000000,13.335000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.950000,0.000000,13.335000>}
box{<0,0,-0.076200><0.820000,0.036000,0.076200> rotate<0,0.000000,0> translate<2.130000,0.000000,13.335000> }
box{<-0.325000,0,-0.700000><0.325000,0.036000,0.700000> rotate<0,-0.000000,0> translate<3.271400,0.000000,13.971500>}
box{<-0.325000,0,-0.700000><0.325000,0.036000,0.700000> rotate<0,-0.000000,0> translate<1.798200,0.000000,13.971500>}
//R2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.210000,0.000000,14.605000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.030000,0.000000,14.605000>}
box{<0,0,-0.076200><0.820000,0.036000,0.076200> rotate<0,0.000000,0> translate<7.210000,0.000000,14.605000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.210000,0.000000,13.335000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.030000,0.000000,13.335000>}
box{<0,0,-0.076200><0.820000,0.036000,0.076200> rotate<0,0.000000,0> translate<7.210000,0.000000,13.335000> }
box{<-0.325000,0,-0.700000><0.325000,0.036000,0.700000> rotate<0,-0.000000,0> translate<8.351400,0.000000,13.971500>}
box{<-0.325000,0,-0.700000><0.325000,0.036000,0.700000> rotate<0,-0.000000,0> translate<6.878200,0.000000,13.971500>}
//R3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.005000,0.000000,16.920000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.005000,0.000000,16.100000>}
box{<0,0,-0.076200><0.820000,0.036000,0.076200> rotate<0,-90.000000,0> translate<40.005000,0.000000,16.100000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.735000,0.000000,16.920000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.735000,0.000000,16.100000>}
box{<0,0,-0.076200><0.820000,0.036000,0.076200> rotate<0,-90.000000,0> translate<38.735000,0.000000,16.100000> }
box{<-0.325000,0,-0.700000><0.325000,0.036000,0.700000> rotate<0,-270.000000,0> translate<39.371500,0.000000,15.778600>}
box{<-0.325000,0,-0.700000><0.325000,0.036000,0.700000> rotate<0,-270.000000,0> translate<39.371500,0.000000,17.251800>}
//R4 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.465000,0.000000,7.210000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.465000,0.000000,8.030000>}
box{<0,0,-0.076200><0.820000,0.036000,0.076200> rotate<0,90.000000,0> translate<37.465000,0.000000,8.030000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.735000,0.000000,7.210000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.735000,0.000000,8.030000>}
box{<0,0,-0.076200><0.820000,0.036000,0.076200> rotate<0,90.000000,0> translate<38.735000,0.000000,8.030000> }
box{<-0.325000,0,-0.700000><0.325000,0.036000,0.700000> rotate<0,-90.000000,0> translate<38.098500,0.000000,8.351400>}
box{<-0.325000,0,-0.700000><0.325000,0.036000,0.700000> rotate<0,-90.000000,0> translate<38.098500,0.000000,6.878200>}
//SV1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.020000,0.000000,20.955000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.385000,0.000000,21.590000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<32.385000,0.000000,21.590000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.385000,0.000000,21.590000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.115000,0.000000,21.590000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<31.115000,0.000000,21.590000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.115000,0.000000,21.590000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.480000,0.000000,20.955000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<30.480000,0.000000,20.955000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.480000,0.000000,20.955000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.845000,0.000000,21.590000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<29.845000,0.000000,21.590000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.845000,0.000000,21.590000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.575000,0.000000,21.590000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<28.575000,0.000000,21.590000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.575000,0.000000,21.590000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.940000,0.000000,20.955000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<27.940000,0.000000,20.955000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.940000,0.000000,20.955000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.305000,0.000000,21.590000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<27.305000,0.000000,21.590000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.305000,0.000000,21.590000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.035000,0.000000,21.590000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<26.035000,0.000000,21.590000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.035000,0.000000,21.590000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.400000,0.000000,20.955000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<25.400000,0.000000,20.955000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.400000,0.000000,20.955000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.765000,0.000000,21.590000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<24.765000,0.000000,21.590000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.765000,0.000000,21.590000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.495000,0.000000,21.590000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<23.495000,0.000000,21.590000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.495000,0.000000,21.590000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.860000,0.000000,20.955000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<22.860000,0.000000,20.955000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.860000,0.000000,20.955000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.225000,0.000000,21.590000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<22.225000,0.000000,21.590000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.225000,0.000000,21.590000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.955000,0.000000,21.590000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<20.955000,0.000000,21.590000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.955000,0.000000,21.590000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.320000,0.000000,20.955000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<20.320000,0.000000,20.955000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.320000,0.000000,20.955000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.685000,0.000000,21.590000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<19.685000,0.000000,21.590000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.685000,0.000000,21.590000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.415000,0.000000,21.590000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<18.415000,0.000000,21.590000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.415000,0.000000,21.590000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.780000,0.000000,20.955000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<17.780000,0.000000,20.955000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.020000,0.000000,20.955000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.020000,0.000000,17.145000>}
box{<0,0,-0.076200><3.810000,0.036000,0.076200> rotate<0,-90.000000,0> translate<33.020000,0.000000,17.145000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.020000,0.000000,17.145000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.385000,0.000000,16.510000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<32.385000,0.000000,16.510000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.385000,0.000000,16.510000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.115000,0.000000,16.510000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<31.115000,0.000000,16.510000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.115000,0.000000,16.510000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.480000,0.000000,17.145000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<30.480000,0.000000,17.145000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.480000,0.000000,17.145000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.845000,0.000000,16.510000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<29.845000,0.000000,16.510000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.845000,0.000000,16.510000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.575000,0.000000,16.510000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<28.575000,0.000000,16.510000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.575000,0.000000,16.510000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.940000,0.000000,17.145000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<27.940000,0.000000,17.145000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.940000,0.000000,17.145000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.305000,0.000000,16.510000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<27.305000,0.000000,16.510000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.305000,0.000000,16.510000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.035000,0.000000,16.510000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<26.035000,0.000000,16.510000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.035000,0.000000,16.510000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.400000,0.000000,17.145000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<25.400000,0.000000,17.145000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.400000,0.000000,17.145000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.765000,0.000000,16.510000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<24.765000,0.000000,16.510000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.765000,0.000000,16.510000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.495000,0.000000,16.510000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<23.495000,0.000000,16.510000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.495000,0.000000,16.510000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.860000,0.000000,17.145000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<22.860000,0.000000,17.145000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.860000,0.000000,17.145000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.225000,0.000000,16.510000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<22.225000,0.000000,16.510000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.225000,0.000000,16.510000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.955000,0.000000,16.510000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<20.955000,0.000000,16.510000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.955000,0.000000,16.510000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.320000,0.000000,17.145000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<20.320000,0.000000,17.145000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.320000,0.000000,17.145000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.685000,0.000000,16.510000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<19.685000,0.000000,16.510000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.685000,0.000000,16.510000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.415000,0.000000,16.510000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<18.415000,0.000000,16.510000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.415000,0.000000,16.510000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.780000,0.000000,17.145000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<17.780000,0.000000,17.145000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.780000,0.000000,17.145000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.145000,0.000000,16.510000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<17.145000,0.000000,16.510000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.145000,0.000000,16.510000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.875000,0.000000,16.510000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<15.875000,0.000000,16.510000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.875000,0.000000,16.510000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.240000,0.000000,17.145000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<15.240000,0.000000,17.145000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.240000,0.000000,17.145000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.605000,0.000000,16.510000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<14.605000,0.000000,16.510000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.605000,0.000000,16.510000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.335000,0.000000,16.510000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.335000,0.000000,16.510000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.335000,0.000000,16.510000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.700000,0.000000,17.145000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<12.700000,0.000000,17.145000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.700000,0.000000,17.145000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.065000,0.000000,16.510000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<12.065000,0.000000,16.510000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.065000,0.000000,16.510000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.795000,0.000000,16.510000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.795000,0.000000,16.510000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.795000,0.000000,16.510000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,17.145000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<10.160000,0.000000,17.145000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,17.145000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.525000,0.000000,16.510000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<9.525000,0.000000,16.510000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.525000,0.000000,16.510000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.255000,0.000000,16.510000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.255000,0.000000,16.510000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.255000,0.000000,16.510000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.620000,0.000000,17.145000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<7.620000,0.000000,17.145000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.620000,0.000000,17.145000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.985000,0.000000,16.510000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<6.985000,0.000000,16.510000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.985000,0.000000,16.510000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.715000,0.000000,16.510000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.715000,0.000000,16.510000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.715000,0.000000,16.510000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,17.145000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<5.080000,0.000000,17.145000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,17.145000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.445000,0.000000,16.510000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<4.445000,0.000000,16.510000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.445000,0.000000,16.510000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.175000,0.000000,16.510000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<3.175000,0.000000,16.510000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.540000,0.000000,17.145000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.175000,0.000000,16.510000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<2.540000,0.000000,17.145000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.540000,0.000000,20.955000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.175000,0.000000,21.590000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<2.540000,0.000000,20.955000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.175000,0.000000,21.590000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.445000,0.000000,21.590000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<3.175000,0.000000,21.590000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,20.955000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.445000,0.000000,21.590000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<4.445000,0.000000,21.590000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,20.955000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.715000,0.000000,21.590000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<5.080000,0.000000,20.955000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.715000,0.000000,21.590000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.985000,0.000000,21.590000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.715000,0.000000,21.590000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.620000,0.000000,20.955000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.985000,0.000000,21.590000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<6.985000,0.000000,21.590000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.620000,0.000000,20.955000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.255000,0.000000,21.590000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<7.620000,0.000000,20.955000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.255000,0.000000,21.590000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.525000,0.000000,21.590000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.255000,0.000000,21.590000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,20.955000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.525000,0.000000,21.590000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<9.525000,0.000000,21.590000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,20.955000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.795000,0.000000,21.590000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<10.160000,0.000000,20.955000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.795000,0.000000,21.590000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.065000,0.000000,21.590000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.795000,0.000000,21.590000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.700000,0.000000,20.955000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.065000,0.000000,21.590000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<12.065000,0.000000,21.590000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.700000,0.000000,20.955000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.335000,0.000000,21.590000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<12.700000,0.000000,20.955000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.335000,0.000000,21.590000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.605000,0.000000,21.590000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.335000,0.000000,21.590000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.240000,0.000000,20.955000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.605000,0.000000,21.590000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<14.605000,0.000000,21.590000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.240000,0.000000,20.955000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.875000,0.000000,21.590000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<15.240000,0.000000,20.955000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.875000,0.000000,21.590000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.145000,0.000000,21.590000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<15.875000,0.000000,21.590000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.780000,0.000000,20.955000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.145000,0.000000,21.590000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<17.145000,0.000000,21.590000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.480000,0.000000,17.145000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.480000,0.000000,20.955000>}
box{<0,0,-0.076200><3.810000,0.036000,0.076200> rotate<0,90.000000,0> translate<30.480000,0.000000,20.955000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.940000,0.000000,17.145000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.940000,0.000000,20.955000>}
box{<0,0,-0.076200><3.810000,0.036000,0.076200> rotate<0,90.000000,0> translate<27.940000,0.000000,20.955000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.400000,0.000000,17.145000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.400000,0.000000,20.955000>}
box{<0,0,-0.076200><3.810000,0.036000,0.076200> rotate<0,90.000000,0> translate<25.400000,0.000000,20.955000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.860000,0.000000,17.145000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.860000,0.000000,20.955000>}
box{<0,0,-0.076200><3.810000,0.036000,0.076200> rotate<0,90.000000,0> translate<22.860000,0.000000,20.955000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.320000,0.000000,17.145000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.320000,0.000000,20.955000>}
box{<0,0,-0.076200><3.810000,0.036000,0.076200> rotate<0,90.000000,0> translate<20.320000,0.000000,20.955000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.780000,0.000000,17.145000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.780000,0.000000,20.955000>}
box{<0,0,-0.076200><3.810000,0.036000,0.076200> rotate<0,90.000000,0> translate<17.780000,0.000000,20.955000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.240000,0.000000,17.145000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.240000,0.000000,20.955000>}
box{<0,0,-0.076200><3.810000,0.036000,0.076200> rotate<0,90.000000,0> translate<15.240000,0.000000,20.955000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.700000,0.000000,17.145000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.700000,0.000000,20.955000>}
box{<0,0,-0.076200><3.810000,0.036000,0.076200> rotate<0,90.000000,0> translate<12.700000,0.000000,20.955000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,17.145000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,20.955000>}
box{<0,0,-0.076200><3.810000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.160000,0.000000,20.955000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.620000,0.000000,17.145000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.620000,0.000000,20.955000>}
box{<0,0,-0.076200><3.810000,0.036000,0.076200> rotate<0,90.000000,0> translate<7.620000,0.000000,20.955000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,17.145000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,20.955000>}
box{<0,0,-0.076200><3.810000,0.036000,0.076200> rotate<0,90.000000,0> translate<5.080000,0.000000,20.955000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.540000,0.000000,17.145000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.540000,0.000000,20.955000>}
box{<0,0,-0.076200><3.810000,0.036000,0.076200> rotate<0,90.000000,0> translate<2.540000,0.000000,20.955000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.540000,0.000000,17.145000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.905000,0.000000,16.510000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<1.905000,0.000000,16.510000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.905000,0.000000,16.510000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<0.635000,0.000000,16.510000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<0.635000,0.000000,16.510000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<0.000000,0.000000,17.145000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<0.635000,0.000000,16.510000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<0.000000,0.000000,17.145000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<0.000000,0.000000,20.955000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<0.635000,0.000000,21.590000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<0.000000,0.000000,20.955000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<0.635000,0.000000,21.590000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.905000,0.000000,21.590000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<0.635000,0.000000,21.590000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.540000,0.000000,20.955000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.905000,0.000000,21.590000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<1.905000,0.000000,21.590000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<0.000000,0.000000,17.145000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<0.000000,0.000000,20.955000>}
box{<0,0,-0.076200><3.810000,0.036000,0.076200> rotate<0,90.000000,0> translate<0.000000,0.000000,20.955000> }
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<31.750000,0.000000,20.320000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<31.750000,0.000000,17.780000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<29.210000,0.000000,17.780000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<29.210000,0.000000,20.320000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<26.670000,0.000000,17.780000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<26.670000,0.000000,20.320000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<24.130000,0.000000,17.780000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<21.590000,0.000000,17.780000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<19.050000,0.000000,17.780000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<24.130000,0.000000,20.320000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<21.590000,0.000000,20.320000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<19.050000,0.000000,20.320000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<16.510000,0.000000,17.780000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<16.510000,0.000000,20.320000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<13.970000,0.000000,17.780000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<13.970000,0.000000,20.320000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<11.430000,0.000000,17.780000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<11.430000,0.000000,20.320000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<8.890000,0.000000,17.780000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<8.890000,0.000000,20.320000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<6.350000,0.000000,17.780000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<6.350000,0.000000,20.320000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<3.810000,0.000000,17.780000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<3.810000,0.000000,20.320000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<1.270000,0.000000,17.780000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<1.270000,0.000000,20.320000>}
//SV2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.020000,0.000000,27.305000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.385000,0.000000,27.940000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<32.385000,0.000000,27.940000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.385000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.115000,0.000000,27.940000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<31.115000,0.000000,27.940000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.115000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.480000,0.000000,27.305000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<30.480000,0.000000,27.305000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.480000,0.000000,27.305000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.845000,0.000000,27.940000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<29.845000,0.000000,27.940000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.845000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.575000,0.000000,27.940000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<28.575000,0.000000,27.940000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.575000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.940000,0.000000,27.305000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<27.940000,0.000000,27.305000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.940000,0.000000,27.305000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.305000,0.000000,27.940000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<27.305000,0.000000,27.940000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.305000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.035000,0.000000,27.940000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<26.035000,0.000000,27.940000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.035000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.400000,0.000000,27.305000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<25.400000,0.000000,27.305000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.400000,0.000000,27.305000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.765000,0.000000,27.940000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<24.765000,0.000000,27.940000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.765000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.495000,0.000000,27.940000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<23.495000,0.000000,27.940000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.495000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.860000,0.000000,27.305000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<22.860000,0.000000,27.305000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.860000,0.000000,27.305000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.225000,0.000000,27.940000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<22.225000,0.000000,27.940000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.225000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.955000,0.000000,27.940000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<20.955000,0.000000,27.940000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.955000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.320000,0.000000,27.305000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<20.320000,0.000000,27.305000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.320000,0.000000,27.305000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.685000,0.000000,27.940000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<19.685000,0.000000,27.940000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.685000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.415000,0.000000,27.940000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<18.415000,0.000000,27.940000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.415000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.780000,0.000000,27.305000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<17.780000,0.000000,27.305000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.020000,0.000000,27.305000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.020000,0.000000,23.495000>}
box{<0,0,-0.076200><3.810000,0.036000,0.076200> rotate<0,-90.000000,0> translate<33.020000,0.000000,23.495000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.020000,0.000000,23.495000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.385000,0.000000,22.860000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<32.385000,0.000000,22.860000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.385000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.115000,0.000000,22.860000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<31.115000,0.000000,22.860000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.115000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.480000,0.000000,23.495000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<30.480000,0.000000,23.495000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.480000,0.000000,23.495000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.845000,0.000000,22.860000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<29.845000,0.000000,22.860000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.845000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.575000,0.000000,22.860000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<28.575000,0.000000,22.860000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.575000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.940000,0.000000,23.495000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<27.940000,0.000000,23.495000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.940000,0.000000,23.495000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.305000,0.000000,22.860000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<27.305000,0.000000,22.860000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.305000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.035000,0.000000,22.860000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<26.035000,0.000000,22.860000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.035000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.400000,0.000000,23.495000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<25.400000,0.000000,23.495000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.400000,0.000000,23.495000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.765000,0.000000,22.860000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<24.765000,0.000000,22.860000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.765000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.495000,0.000000,22.860000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<23.495000,0.000000,22.860000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.495000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.860000,0.000000,23.495000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<22.860000,0.000000,23.495000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.860000,0.000000,23.495000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.225000,0.000000,22.860000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<22.225000,0.000000,22.860000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.225000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.955000,0.000000,22.860000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<20.955000,0.000000,22.860000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.955000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.320000,0.000000,23.495000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<20.320000,0.000000,23.495000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.320000,0.000000,23.495000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.685000,0.000000,22.860000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<19.685000,0.000000,22.860000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.685000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.415000,0.000000,22.860000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<18.415000,0.000000,22.860000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.415000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.780000,0.000000,23.495000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<17.780000,0.000000,23.495000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.780000,0.000000,23.495000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.145000,0.000000,22.860000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<17.145000,0.000000,22.860000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.145000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.875000,0.000000,22.860000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<15.875000,0.000000,22.860000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.875000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.240000,0.000000,23.495000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<15.240000,0.000000,23.495000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.240000,0.000000,23.495000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.605000,0.000000,22.860000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<14.605000,0.000000,22.860000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.605000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.335000,0.000000,22.860000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.335000,0.000000,22.860000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.335000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.700000,0.000000,23.495000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<12.700000,0.000000,23.495000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.700000,0.000000,23.495000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.065000,0.000000,22.860000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<12.065000,0.000000,22.860000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.065000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.795000,0.000000,22.860000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.795000,0.000000,22.860000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.795000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,23.495000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<10.160000,0.000000,23.495000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,23.495000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.525000,0.000000,22.860000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<9.525000,0.000000,22.860000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.525000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.255000,0.000000,22.860000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.255000,0.000000,22.860000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.255000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.620000,0.000000,23.495000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<7.620000,0.000000,23.495000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.620000,0.000000,23.495000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.985000,0.000000,22.860000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<6.985000,0.000000,22.860000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.985000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.715000,0.000000,22.860000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.715000,0.000000,22.860000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.715000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,23.495000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<5.080000,0.000000,23.495000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,23.495000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.445000,0.000000,22.860000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<4.445000,0.000000,22.860000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.445000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.175000,0.000000,22.860000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<3.175000,0.000000,22.860000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.540000,0.000000,23.495000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.175000,0.000000,22.860000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<2.540000,0.000000,23.495000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.540000,0.000000,27.305000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.175000,0.000000,27.940000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<2.540000,0.000000,27.305000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.175000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.445000,0.000000,27.940000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<3.175000,0.000000,27.940000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,27.305000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.445000,0.000000,27.940000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<4.445000,0.000000,27.940000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,27.305000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.715000,0.000000,27.940000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<5.080000,0.000000,27.305000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.715000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.985000,0.000000,27.940000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.715000,0.000000,27.940000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.620000,0.000000,27.305000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.985000,0.000000,27.940000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<6.985000,0.000000,27.940000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.620000,0.000000,27.305000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.255000,0.000000,27.940000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<7.620000,0.000000,27.305000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.255000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.525000,0.000000,27.940000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.255000,0.000000,27.940000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,27.305000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.525000,0.000000,27.940000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<9.525000,0.000000,27.940000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,27.305000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.795000,0.000000,27.940000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<10.160000,0.000000,27.305000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.795000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.065000,0.000000,27.940000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.795000,0.000000,27.940000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.700000,0.000000,27.305000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.065000,0.000000,27.940000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<12.065000,0.000000,27.940000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.700000,0.000000,27.305000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.335000,0.000000,27.940000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<12.700000,0.000000,27.305000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.335000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.605000,0.000000,27.940000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.335000,0.000000,27.940000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.240000,0.000000,27.305000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.605000,0.000000,27.940000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<14.605000,0.000000,27.940000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.240000,0.000000,27.305000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.875000,0.000000,27.940000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<15.240000,0.000000,27.305000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.875000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.145000,0.000000,27.940000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<15.875000,0.000000,27.940000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.780000,0.000000,27.305000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.145000,0.000000,27.940000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<17.145000,0.000000,27.940000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.480000,0.000000,23.495000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.480000,0.000000,27.305000>}
box{<0,0,-0.076200><3.810000,0.036000,0.076200> rotate<0,90.000000,0> translate<30.480000,0.000000,27.305000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.940000,0.000000,23.495000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.940000,0.000000,27.305000>}
box{<0,0,-0.076200><3.810000,0.036000,0.076200> rotate<0,90.000000,0> translate<27.940000,0.000000,27.305000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.400000,0.000000,23.495000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.400000,0.000000,27.305000>}
box{<0,0,-0.076200><3.810000,0.036000,0.076200> rotate<0,90.000000,0> translate<25.400000,0.000000,27.305000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.860000,0.000000,23.495000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.860000,0.000000,27.305000>}
box{<0,0,-0.076200><3.810000,0.036000,0.076200> rotate<0,90.000000,0> translate<22.860000,0.000000,27.305000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.320000,0.000000,23.495000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.320000,0.000000,27.305000>}
box{<0,0,-0.076200><3.810000,0.036000,0.076200> rotate<0,90.000000,0> translate<20.320000,0.000000,27.305000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.780000,0.000000,23.495000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.780000,0.000000,27.305000>}
box{<0,0,-0.076200><3.810000,0.036000,0.076200> rotate<0,90.000000,0> translate<17.780000,0.000000,27.305000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.240000,0.000000,23.495000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.240000,0.000000,27.305000>}
box{<0,0,-0.076200><3.810000,0.036000,0.076200> rotate<0,90.000000,0> translate<15.240000,0.000000,27.305000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.700000,0.000000,23.495000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.700000,0.000000,27.305000>}
box{<0,0,-0.076200><3.810000,0.036000,0.076200> rotate<0,90.000000,0> translate<12.700000,0.000000,27.305000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,23.495000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.160000,0.000000,27.305000>}
box{<0,0,-0.076200><3.810000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.160000,0.000000,27.305000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.620000,0.000000,23.495000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.620000,0.000000,27.305000>}
box{<0,0,-0.076200><3.810000,0.036000,0.076200> rotate<0,90.000000,0> translate<7.620000,0.000000,27.305000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,23.495000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,27.305000>}
box{<0,0,-0.076200><3.810000,0.036000,0.076200> rotate<0,90.000000,0> translate<5.080000,0.000000,27.305000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.540000,0.000000,23.495000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.540000,0.000000,27.305000>}
box{<0,0,-0.076200><3.810000,0.036000,0.076200> rotate<0,90.000000,0> translate<2.540000,0.000000,27.305000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.540000,0.000000,23.495000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.905000,0.000000,22.860000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<1.905000,0.000000,22.860000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.905000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<0.635000,0.000000,22.860000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<0.635000,0.000000,22.860000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<0.000000,0.000000,23.495000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<0.635000,0.000000,22.860000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<0.000000,0.000000,23.495000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<0.000000,0.000000,27.305000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<0.635000,0.000000,27.940000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<0.000000,0.000000,27.305000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<0.635000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.905000,0.000000,27.940000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<0.635000,0.000000,27.940000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.540000,0.000000,27.305000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.905000,0.000000,27.940000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<1.905000,0.000000,27.940000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<0.000000,0.000000,23.495000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<0.000000,0.000000,27.305000>}
box{<0,0,-0.076200><3.810000,0.036000,0.076200> rotate<0,90.000000,0> translate<0.000000,0.000000,27.305000> }
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<31.750000,0.000000,26.670000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<31.750000,0.000000,24.130000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<29.210000,0.000000,24.130000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<29.210000,0.000000,26.670000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<26.670000,0.000000,24.130000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<26.670000,0.000000,26.670000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<24.130000,0.000000,24.130000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<21.590000,0.000000,24.130000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<19.050000,0.000000,24.130000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<24.130000,0.000000,26.670000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<21.590000,0.000000,26.670000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<19.050000,0.000000,26.670000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<16.510000,0.000000,24.130000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<16.510000,0.000000,26.670000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<13.970000,0.000000,24.130000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<13.970000,0.000000,26.670000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<11.430000,0.000000,24.130000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<11.430000,0.000000,26.670000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<8.890000,0.000000,24.130000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<8.890000,0.000000,26.670000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<6.350000,0.000000,24.130000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<6.350000,0.000000,26.670000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<3.810000,0.000000,24.130000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<3.810000,0.000000,26.670000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<1.270000,0.000000,24.130000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<1.270000,0.000000,26.670000>}
//U1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.249400,0.000000,10.972800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.249400,0.000000,11.277600>}
box{<0,0,-0.076200><0.304800,0.036000,0.076200> rotate<0,90.000000,0> translate<14.249400,0.000000,11.277600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.249400,0.000000,11.277600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.208000,0.000000,11.277600>}
box{<0,0,-0.076200><1.041400,0.036000,0.076200> rotate<0,0.000000,0> translate<13.208000,0.000000,11.277600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.208000,0.000000,11.277600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.208000,0.000000,10.972800>}
box{<0,0,-0.076200><0.304800,0.036000,0.076200> rotate<0,-90.000000,0> translate<13.208000,0.000000,10.972800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.208000,0.000000,10.972800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.249400,0.000000,10.972800>}
box{<0,0,-0.076200><1.041400,0.036000,0.076200> rotate<0,0.000000,0> translate<13.208000,0.000000,10.972800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.249400,0.000000,10.337800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.249400,0.000000,10.642600>}
box{<0,0,-0.076200><0.304800,0.036000,0.076200> rotate<0,90.000000,0> translate<14.249400,0.000000,10.642600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.249400,0.000000,10.642600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.208000,0.000000,10.642600>}
box{<0,0,-0.076200><1.041400,0.036000,0.076200> rotate<0,0.000000,0> translate<13.208000,0.000000,10.642600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.208000,0.000000,10.642600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.208000,0.000000,10.337800>}
box{<0,0,-0.076200><0.304800,0.036000,0.076200> rotate<0,-90.000000,0> translate<13.208000,0.000000,10.337800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.208000,0.000000,10.337800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.249400,0.000000,10.337800>}
box{<0,0,-0.076200><1.041400,0.036000,0.076200> rotate<0,0.000000,0> translate<13.208000,0.000000,10.337800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.249400,0.000000,9.677400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.249400,0.000000,9.982200>}
box{<0,0,-0.076200><0.304800,0.036000,0.076200> rotate<0,90.000000,0> translate<14.249400,0.000000,9.982200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.249400,0.000000,9.982200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.208000,0.000000,9.982200>}
box{<0,0,-0.076200><1.041400,0.036000,0.076200> rotate<0,0.000000,0> translate<13.208000,0.000000,9.982200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.208000,0.000000,9.982200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.208000,0.000000,9.677400>}
box{<0,0,-0.076200><0.304800,0.036000,0.076200> rotate<0,-90.000000,0> translate<13.208000,0.000000,9.677400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.208000,0.000000,9.677400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.249400,0.000000,9.677400>}
box{<0,0,-0.076200><1.041400,0.036000,0.076200> rotate<0,0.000000,0> translate<13.208000,0.000000,9.677400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.249400,0.000000,9.042400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.249400,0.000000,9.347200>}
box{<0,0,-0.076200><0.304800,0.036000,0.076200> rotate<0,90.000000,0> translate<14.249400,0.000000,9.347200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.249400,0.000000,9.347200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.208000,0.000000,9.347200>}
box{<0,0,-0.076200><1.041400,0.036000,0.076200> rotate<0,0.000000,0> translate<13.208000,0.000000,9.347200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.208000,0.000000,9.347200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.208000,0.000000,9.042400>}
box{<0,0,-0.076200><0.304800,0.036000,0.076200> rotate<0,-90.000000,0> translate<13.208000,0.000000,9.042400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.208000,0.000000,9.042400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.249400,0.000000,9.042400>}
box{<0,0,-0.076200><1.041400,0.036000,0.076200> rotate<0,0.000000,0> translate<13.208000,0.000000,9.042400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.770600,0.000000,9.347200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.770600,0.000000,9.042400>}
box{<0,0,-0.076200><0.304800,0.036000,0.076200> rotate<0,-90.000000,0> translate<18.770600,0.000000,9.042400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.770600,0.000000,9.042400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.812000,0.000000,9.042400>}
box{<0,0,-0.076200><1.041400,0.036000,0.076200> rotate<0,0.000000,0> translate<18.770600,0.000000,9.042400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.812000,0.000000,9.042400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.812000,0.000000,9.347200>}
box{<0,0,-0.076200><0.304800,0.036000,0.076200> rotate<0,90.000000,0> translate<19.812000,0.000000,9.347200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.812000,0.000000,9.347200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.770600,0.000000,9.347200>}
box{<0,0,-0.076200><1.041400,0.036000,0.076200> rotate<0,0.000000,0> translate<18.770600,0.000000,9.347200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.770600,0.000000,9.982200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.770600,0.000000,9.677400>}
box{<0,0,-0.076200><0.304800,0.036000,0.076200> rotate<0,-90.000000,0> translate<18.770600,0.000000,9.677400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.770600,0.000000,9.677400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.812000,0.000000,9.677400>}
box{<0,0,-0.076200><1.041400,0.036000,0.076200> rotate<0,0.000000,0> translate<18.770600,0.000000,9.677400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.812000,0.000000,9.677400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.812000,0.000000,9.982200>}
box{<0,0,-0.076200><0.304800,0.036000,0.076200> rotate<0,90.000000,0> translate<19.812000,0.000000,9.982200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.812000,0.000000,9.982200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.770600,0.000000,9.982200>}
box{<0,0,-0.076200><1.041400,0.036000,0.076200> rotate<0,0.000000,0> translate<18.770600,0.000000,9.982200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.770600,0.000000,10.642600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.770600,0.000000,10.337800>}
box{<0,0,-0.076200><0.304800,0.036000,0.076200> rotate<0,-90.000000,0> translate<18.770600,0.000000,10.337800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.770600,0.000000,10.337800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.812000,0.000000,10.337800>}
box{<0,0,-0.076200><1.041400,0.036000,0.076200> rotate<0,0.000000,0> translate<18.770600,0.000000,10.337800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.812000,0.000000,10.337800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.812000,0.000000,10.642600>}
box{<0,0,-0.076200><0.304800,0.036000,0.076200> rotate<0,90.000000,0> translate<19.812000,0.000000,10.642600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.812000,0.000000,10.642600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.770600,0.000000,10.642600>}
box{<0,0,-0.076200><1.041400,0.036000,0.076200> rotate<0,0.000000,0> translate<18.770600,0.000000,10.642600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.770600,0.000000,11.277600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.770600,0.000000,10.972800>}
box{<0,0,-0.076200><0.304800,0.036000,0.076200> rotate<0,-90.000000,0> translate<18.770600,0.000000,10.972800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.770600,0.000000,10.972800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.812000,0.000000,10.972800>}
box{<0,0,-0.076200><1.041400,0.036000,0.076200> rotate<0,0.000000,0> translate<18.770600,0.000000,10.972800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.812000,0.000000,10.972800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.812000,0.000000,11.277600>}
box{<0,0,-0.076200><0.304800,0.036000,0.076200> rotate<0,90.000000,0> translate<19.812000,0.000000,11.277600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.812000,0.000000,11.277600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.770600,0.000000,11.277600>}
box{<0,0,-0.076200><1.041400,0.036000,0.076200> rotate<0,0.000000,0> translate<18.770600,0.000000,11.277600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.249400,0.000000,8.610600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.770600,0.000000,8.610600>}
box{<0,0,-0.076200><4.521200,0.036000,0.076200> rotate<0,0.000000,0> translate<14.249400,0.000000,8.610600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.770600,0.000000,8.610600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.770600,0.000000,11.709400>}
box{<0,0,-0.076200><3.098800,0.036000,0.076200> rotate<0,90.000000,0> translate<18.770600,0.000000,11.709400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.770600,0.000000,11.709400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.814800,0.000000,11.709400>}
box{<0,0,-0.076200><1.955800,0.036000,0.076200> rotate<0,0.000000,0> translate<16.814800,0.000000,11.709400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.814800,0.000000,11.709400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.205200,0.000000,11.709400>}
box{<0,0,-0.076200><0.609600,0.036000,0.076200> rotate<0,0.000000,0> translate<16.205200,0.000000,11.709400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.205200,0.000000,11.709400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.249400,0.000000,11.709400>}
box{<0,0,-0.076200><1.955800,0.036000,0.076200> rotate<0,0.000000,0> translate<14.249400,0.000000,11.709400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.249400,0.000000,11.709400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.249400,0.000000,8.610600>}
box{<0,0,-0.076200><3.098800,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.249400,0.000000,8.610600> }
object{ARC(0.304800,0.000000,180.000000,360.000000,0.036000) translate<16.510000,0.000000,11.709400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.249400,0.000000,8.610600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.770600,0.000000,8.610600>}
box{<0,0,-0.076200><4.521200,0.036000,0.076200> rotate<0,0.000000,0> translate<14.249400,0.000000,8.610600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.770600,0.000000,11.709400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.814800,0.000000,11.709400>}
box{<0,0,-0.076200><1.955800,0.036000,0.076200> rotate<0,0.000000,0> translate<16.814800,0.000000,11.709400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.814800,0.000000,11.709400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.205200,0.000000,11.709400>}
box{<0,0,-0.076200><0.609600,0.036000,0.076200> rotate<0,0.000000,0> translate<16.205200,0.000000,11.709400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.205200,0.000000,11.709400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.249400,0.000000,11.709400>}
box{<0,0,-0.076200><1.955800,0.036000,0.076200> rotate<0,0.000000,0> translate<14.249400,0.000000,11.709400> }
object{ARC(0.304800,0.000000,180.000000,360.000000,0.036000) translate<16.510000,0.000000,11.709400>}
//X1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<33.110000,0.000000,17.325000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<33.110000,0.000000,28.395000>}
box{<0,0,-0.101600><11.070000,0.036000,0.101600> rotate<0,90.000000,0> translate<33.110000,0.000000,28.395000> }
texture{col_slk}
}
#end
translate<mac_x_ver,mac_y_ver,mac_z_ver>
rotate<mac_x_rot,mac_y_rot,mac_z_rot>
}//End union
#end

#if(use_file_as_inc=off)
object{  MAIN_LOW_PASS(-22.695000,0,-13.965000,pcb_rotate_x,pcb_rotate_y,pcb_rotate_z)
#if(pcb_upsidedown=on)
rotate pcb_rotdir*180
#end
}
#end


//Parts not found in 3dpack.dat or 3dusrpac.dat are:
//U1		SOP65P640X120-8N
//X1	14867	14867
