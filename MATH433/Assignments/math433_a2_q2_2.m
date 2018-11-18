b = [1, -0.5, 0, 1];
a = [1, 0.5, 0, 0.75];
[H,w] = freqz(b,a,2001);
plot(w/pi, db(H));
xlabel('Normalized Frequency (\times\pi rad/sample)');
ylabel('Magnitude (dB)');
grid on;