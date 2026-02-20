import my::loc;
import my::templates::fmt;
import std::io;
import libc;
import std::core::mem;
import my::collections::arg;
import std::collections::map;
import std::collections::list;
import my::debug::dbg;

alias ArgHash     = map::HashMap{String, any*};
alias ArgList     = List {any*};
alias ArgMapEntry = Entry {String, any*};

fn void main(String[] args){
    if(args[1..].contains("--debug")){
        dbg::debugging = true;
    }
    double pi    = 3.141592265;
    double e     = 2.718281828;
    long   width = 94;
    long   prec  = 59;
    ArgHash named = arg::@make_map(*("pi" * any_make(&pi, $typeof(pi))), *("euler" * any_make(&e, $typeof(e))),
                                    *("width" * any_make(&width, $typeof(width))), *("prec" * any_make(&prec, $typeof(prec))));
    String? s = fmt::format(" pi   == {:@^+#94.59Lg}\n pi   == {0:*>+#{width}.{prec}Lg}\n pi   == {pi:*<+#{width}.{prec}g}\n pi   == {pi:@^+#{width}.{prec}G}", pi, e, "fred", 30, 63, &named);
    if(catch excuse = s){
        io::eprintfn("Error: could not format string: %s", excuse);
        libc::exit(-1);
    }else{
        io::printfn("%s", s);
    }
    String? s0 = fmt::format(" pi   == {:@^+#094.59Lg}\n pi   == {0:*>+#0{width}.{prec}Lg}\n pi   == {pi:*<+#0{width}.{prec}g}\n pi   == {pi:@^+#0{width}.{prec}G}", pi, e, "fred", 30, 63, &named);
    if(catch excuse = s0){
        io::eprintfn("Error: could not format string: %s", excuse);
        libc::exit(-1);
    }else{
        io::printfn("%s", s0);
    }
    double pish = pi * 1E-20;
    String? s1 = fmt::format(" pish == {:@^+#94.59Lg}\n pish == {0:*>+#{width}.{prec}Lg}\n pish == {pish:*<+#{width}.{prec}g}\n pish == {pish:@^+#{width}.{prec}G}",
                                pish, e, "fred", 30, 63, ("width" * any_make(&width, $typeof(width))), ("prec" * any_make(&prec, $typeof(prec))), "pish" * any_make(&pish, $typeof(pish)), ("euler" * any_make(&e, $typeof(e))));
    if(catch excuse = s1){
        io::eprintfn("Error: could not format string: %s", excuse);
        libc::exit(-1);
    }else{
        io::printfn("%s", s1);
    }
    String? s2 = fmt::format(" pish == {:@^+#094.59Lg}\n pish == {0:*>+#0{width}.{prec}Lg}\n pish == {pish:*<+#0{width}.{prec}g}\n pish == {pish:@^+#0{width}.{prec}G}",
                                pish, e,  "fred", 30, 63, ("width" * any_make(&width, $typeof(width))), ("prec" * any_make(&prec, $typeof(prec))), "pish" * any_make(&pish, $typeof(pish)), ("euler" * any_make(&e, $typeof(e))));
    if(catch excuse = s2){
        io::eprintfn("Error: could not format string: %s", excuse);
        libc::exit(-1);
    }else{
        io::printfn("%s", s2);
    }
}
