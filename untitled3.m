% Example input signal
x = [1, 2, 3, 4];

% Compute the DFT
X = DFT(x);

% Compute the IDFT
x_reconstructed = IDFT(X);

% Display the results
disp('Original signal x:');
disp(x);
disp('Reconstructed signal x_reconstructed:');
disp(x_reconstructed);

% Verify if original and reconstructed signals are approximately equal
if max(abs(x - x_reconstructed)) < 1e-10
    disp('DFT and IDFT are inverses of each other!');
else
    disp('There is an error: DFT and IDFT are not exact inverses.');
end