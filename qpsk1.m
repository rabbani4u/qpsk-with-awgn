clear all;
close all;
l = 1e6;
EbNodB = 0:2:10;
EbNo = 10.^(EbNodB/10);
for n = 1:length(EbNodB)
    si = 2*(round(rand(1,l)) -0.5);
    sq = 2*(round(rand(1,l)) -0.5);
    s = si + j*sq;
    w = (1/sqrt(2 + EbNo(n))) * (randn(1,l) + j*randn(1,l));
    r = s + w;
    si_ = sign(real(r));
    sq_ = sign(imag(r));
    ber1 = (l - sum(si == si_))/l;
    ber2 = (l - sum(sq == sq_))/l;
    ber(n) = mean([ber1 ber2]);
end
semilogy(EbNodB, ber, 'o-')
xlabel('EbNo(db)')
ylabel('BER')
grid on
    