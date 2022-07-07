// Baffle of Solar scope for Aluminum cutting
// 04/09/2022

scale=25.4;    // Inch to mm
tol=1;

//Main disk
id_tube=6*scale; //External diamater of shield in mm
od_hole=2*32.46; //32.46; 37.80; 45.33; 54.03; 62.02; 67.96; //central hole
nbr_tabs=12; // number of tabs to keep the baffle in the tube
tab_l=15;
tab_w=10;



//Resolution for STL export only. That is for display in Openscad and 3D printing only. 
//Please do comment this before going to Freecad, or you will end up with inefficient facets.
// and will not play well with export to .step files
$fn=350;

module make_tabs(){//make nive tabs to be folded
   translate([0,-tab_w/2,0]){
   union(){
   square(size = [tab_l, tab_w]); 
   fr=4;
   r_tab=tab_w/fr;
   translate([tab_l,r_tab,0]) circle(r=r_tab);
   translate([tab_l,(fr-1)*r_tab,0]) circle(r=r_tab);
   translate([tab_l,r_tab,0]) square(size = [r_tab, tab_w-2*r_tab]);   
   }
   }
}

//the baffle
if(1){
    difference(){
    union(){
    // The main disk
    difference(){
        circle(d=id_tube); //main circle
        circle(d=od_hole);   //center hole for lens    
        }
    // The tabs
    for(j = [0 : 1 : nbr_tabs-1]){
        rotate([0,0,j*(360/nbr_tabs)]) translate([id_tube*.45,0,0]) make_tabs();
        }

    }
    // The mini holes to fold the tabs
    fudge=3.83;
    for(j = [0 : 1 : nbr_tabs-1]){
        rotate([0,0,j*(360/nbr_tabs)+fudge]) translate([0.15+id_tube/2,0,0]) circle(r=0.3);
        rotate([0,0,j*(360/nbr_tabs)-fudge]) translate([0.15+id_tube/2,0,0]) circle(r=0.3);
        }
    // The vents
    for(j = [0 : 1 : nbr_tabs-1]){
       rotate([0,0,j*(360/nbr_tabs)+(360/nbr_tabs)/2]) translate([id_tube/2,0,0]) circle(r=3);
    } 
     
    }   
}


//test individual tab
if(0){
    color("pink"){
    make_tabs();
    }
    }
