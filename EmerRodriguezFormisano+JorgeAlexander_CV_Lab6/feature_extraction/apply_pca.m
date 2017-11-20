function PCAImagesDim = apply_pca(images, dim)
% APPLY_PCA 
% PCAImagesDim It returns the matrix with reduced attributes.
% Each column is an image
%% PCA
% Use princomp.m to compute:
% 4. To complete:
[PCACoefficients, PCAImages, PCAValues] = princomp(images);

%% Show the 30 first eigenfaces
% 5. To complete:
show_eigenfaces(PCACoefficients(:,1:30));
%% Plot the explained variance using 100 dimensions
% 6. To complete:
varCumsum = cumsum(PCAValues)./sum(PCAValues);
plot(varCumsum(1:100));
% title('Eigenvalues cumulative variance contribution')
% xlabel('Eigenvalue count')
% ylabel('Cumulative Contirbution to Variance (%)')
% saveas(gcf, 'Eigenvalue_dist.png')
%% Keep the first 'dim' dimensions where dim is given or computed as the
%% dimensions necessary to preserve 90% of the data variance.
disp('Dimensions used:');
if dim>0
    disp(num2str(dim));
    PCAImagesDim = PCAImages(:,1:dim);
else
    % Compute the number of dimensions necessary to preserve 95% of the data variance.
    % 7. To complete:    
    dim95 = sum(varCumsum <= 0.95);
    disp(num2str(dim95));
    PCAImagesDim = PCAImages(:,1:dim95);
end
end

