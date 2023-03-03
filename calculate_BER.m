Bittx=de2bi( simtx,'left-msb');
Bitrx=de2bi( simrx,'left-msb');
errores= xor(Bittx,Bitrx);
Nerror=sum(errores);
format long
BER=Nerror/(length(Bittx))  %%bit  numero de errores/%% bit recibidos

