module my::debug::dbg;
import std::io;

bool debugging = false;

macro void eprintfn(String format, ...){
    if(debugging){
        io::eprintfn(format, $vasplat);
        (void)io::stderr().flush();
    }
}

macro void printfn(String format, ...){
    if(debugging){
        io::printfn(format, $vasplat);
        (void)io::stderr().flush();
    }
}
