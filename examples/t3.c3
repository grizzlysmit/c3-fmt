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
    long   width = 74;
    long   prec  = 39;
    ArgHash named = arg::@make_map(*("pi" * any_make(&pi, $typeof(pi))), *("euler" * any_make(&e, $typeof(e))),
                                    *("width" * any_make(&width, $typeof(width))), *("prec" * any_make(&prec, $typeof(prec))));
    String? s = fmt::format(" pi == {:@^+#74.39Lf}\n pi == {0:*>+#{width}.{prec}Lf}\n pi == {pi:*<+#{width}.{prec}f}\n pi == {pi:@^+#{width}.{prec}F}", pi, e, "fred", 30, 63, &named);
    if(catch excuse = s){
        io::eprintfn("Error: could not format string: %s", excuse);
        libc::exit(-1);
    }else{
        io::printfn("%s", s);
    }
    String? s0 = fmt::format(" pi == {:@^+#074.39Lf}\n pi == {0:*>+#0{width}.{prec}Lf}\n pi == {pi:*<+#0{width}.{prec}f}\n pi == {pi:@^+#0{width}.{prec}F}", pi, e, "fred", 30, 63, &named);
    if(catch excuse = s0){
        io::eprintfn("Error: could not format string: %s", excuse);
        libc::exit(-1);
    }else{
        io::printfn("%s", s0);
    }
}
