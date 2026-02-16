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
    long   width = 64;
    long   prec  = 29;
    ArgHash named = arg::@make_map(*("pi" * any_make(&pi, $typeof(pi))), *("euler" * any_make(&e, $typeof(e))),
                                    *("width" * any_make(&width, $typeof(width))), *("prec" * any_make(&prec, $typeof(prec))));
    String? s = fmt::format("pi == {0:@^+#30.59La}\n e == {euler:*>+#0{width}.{prec}LF}\n name == {2:@^{3}.{4}}\n pi == {pi:*>+#0.{prec}E}\n pi == {pi:@^+#{width}.{prec}g}", pi, e, "fred", 30, 63, &named);
    if(catch excuse = s){
        io::eprintfn("Error: could not format string: %s", excuse);
        libc::exit(-1);
    }else{
        io::printfn("%s", s);
    }
    /* this give an error as the last spec is missing it's closing brace //
    String? s2 = fmt::format("pi == {:@^+#030.59La}\n e == {e:*>+#0{width}.{prec}LF}\n name == {2:@^{3}.{4}}\n pi == {pi:!>+#0.{prec}E", pi, e, "fred", 30, 63, named);
    if(catch excuse = s2){
        io::eprintfn("Error: could not format string %s", excuse);
        libc::exit(-1);
    }else{
        io::printfn("%s", s2);
    }
    // */
    libc::Time_t ts = libc::time(null);
    libc::Tm     tm = *libc::localtime(&ts);
    String? s3 = fmt::format(" {:@^{2}.{3} %A the %e of %B %Y, %F %T }\n {:*>{2}.{3} %Y-%m-%d %H:%M:%S %A the %e of %B %Y }", ts, tm, width, prec, &named);
    if(catch excuse3 = s3){
        io::eprintfn("Error: could not format string: %s", excuse3);
        libc::exit(-1);
    }else{
        io::printfn("%s", s3);
    }
    char[] disguised = { 'h', 'e', 'l', 'l', 'o', '\n', '\0'  };
    int[]  ints      = { 42, 1, 2, 3, 4, 5, 6, 7 };
    fmt::gdebug = true;
    String? s4       = fmt::format("{:s:^{width}.{prec}c}\n{0:ns:^{width}.{prec}Lc}\n{0:n?s:^{width}.{prec}c}\n{:?s:{width}.{prec}d}", disguised, ints, named);
    if(catch excuse4 = s4){
        io::eprintfn("Error: could not format string: %s", excuse4);
        libc::exit(-1);
    }else{
        io::printfn("%s", s4);
    }
    fmt::gdebug = false;
    String? s5       = fmt::format("{:s:^1.1c}\n{0:ns:^1.1Lc}\n{0:n?s:^1.1c}\n{:?s:1.1d}", disguised, ints, named);
    if(catch excuse5 = s5){
        io::eprintfn("Error: could not format string: %s", excuse5);
        libc::exit(-1);
    }else{
        io::printfn("%s", s5);
    }
}
