% Read the JPG files
jpg_files = dir('*.jpg');
num_files = length(jpg_files);
stack = cell(num_files, 1);

for i = 1:num_files
    filename = jpg_files(i).name;
    try
        img = imread(filename);
        if size(img, 3) == 3 % check if image is RGB
            img = rgb2gray(img); % convert to grayscale
        end
        stack{i} = img;
    catch ME
        warning('Failed to read JPG file %s: %s', filename, ME.message);
    end
end

% Preprocessing
median_filtered_stack = cellfun(@(x) medfilt2(x, [3 3]), stack, 'UniformOutput', false);
background_stack = cellfun(@(x) imopen(x, strel('disk', 10)), median_filtered_stack, 'UniformOutput', false);
background_subtracted_stack = cellfun(@(x,y) x - y, median_filtered_stack, background_stack, 'UniformOutput', false);
equalized_stack = cellfun(@histeq, background_subtracted_stack, 'UniformOutput', false);
fft_stack = cellfun(@fft2, equalized_stack, 'UniformOutput', false);
magnitude_stack = cellfun(@abs, fft_stack, 'UniformOutput', false);
phase_stack = cellfun(@angle, fft_stack, 'UniformOutput', false);
power_spectrum_stack = cellfun(@(x) abs(fftshift(x)).^2, fft_stack, 'UniformOutput', false);
log_power_spectrum_stack = cellfun(@(x) log10(x + eps), power_spectrum_stack, 'UniformOutput', false);

% Display the original images in a figure with slider
f = figure('Position', [100 100 800 600]);
ax = axes('Parent', f, 'Position', [0.05 0.25 0.9 0.7]);
s = uicontrol('Parent', f, 'Style', 'slider', 'Position', [100 50 600 20],...
              'Value', 1, 'Min', 1, 'Max', num_files, 'SliderStep', [1/(num_files-1) 1/(num_files-1)]);
s.Callback = @(es,ed) update_slider(es, ax, stack, magnitude_stack, phase_stack, power_spectrum_stack, log_power_spectrum_stack);
update_slider(s, ax, stack, magnitude_stack, phase_stack, power_spectrum_stack, log_power_spectrum_stack);

function update_slider(s, ax, stack, magnitude_stack, phase_stack, power_spectrum_stack, log_power_spectrum_stack)
    idx = round(s.Value);
    imshow(stack{idx}, 'Parent', ax);
    title(ax, 'Original image');
    
    figure('Name', 'Processed images');
    subplot(2,2,1);
    imshow(magnitude_stack{idx}, []);
    title('Magnitude of Fourier transform');
    
    subplot(2,2,2);
    imshow(phase_stack{idx}, []);
    title('Phase of Fourier transform');
    
    subplot(2,2,3);
    imshow(power_spectrum_stack{idx}, []);
    title('Power spectrum');
    
    subplot(2,2,4);
    imshow(log_power_spectrum_stack{idx}, []);
    title('Log power spectrum');
end
