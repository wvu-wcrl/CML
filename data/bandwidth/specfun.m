function y = specfun(x,M,h)


fei = sin(pi*M*h)/M/sin(pi*h);
y=0;
for n =1 : M
    y = y +  1/M * (sinc( x - 0.5*( 2*n -1-M)*h)).^2;
    for m = 1:M
        alpha(n,m) = pi*h*( m+ n-1-M);
        B = (cos( 2*pi*x - alpha(n,m) ) - fei*cos( alpha(n,m)) )./( 1+ fei^2 - 2*fei*cos(2*pi*x));
        y = y + 2/M/M * (sinc( x - 0.5*( 2*n -1-M)*h)).*(sinc( x - 0.5*( 2*m -1-M)*h)).*B;
    end
end



