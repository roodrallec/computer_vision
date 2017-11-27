function fig = segmentation(img, alphaTweak, betaTweak, kappaTweak, lambdaTweak, maxstepTweak, loadInitialValues)
  %% Initial values
  [x,y,alpha,beta,kappa,lambda,fx,fy,maxstep] = loadInitialValues(img);
  %% Initial contour
  fig = figure('Name', 'Active contour segmentation parameter variations');
  subplotIdx = addSubplot(img, 'Initial Contour', x, y, 1);
  %% Snake with initial values
  [x,y]=snake(x,y,alpha,beta,kappa,lambda,fx,fy,maxstep,0,img);
  subplotIdx = addSubplot(img, 'Default Values', x, y, subplotIdx) + 3;
  %% Modifying alpha
  subplotIdx = tweakParam('alpha', 1, img, subplotIdx);
  %% Modifying beta
  subplotIdx = tweakParam('beta', 5, img, subplotIdx);
  %% Modifying kappa
  subplotIdx = tweakParam('kappa', 1, img, subplotIdx);
  %% Modifying lambda
  subplotIdx = tweakParam('lambda', 1, img, subplotIdx);
  %% Modifying maxstep
  subplotIdx = tweakParam('maxstep', 0.5, img, subplotIdx);
  %% Function to tweak an argument of the snake function
  function subplotIdx = tweakParam(paramName, paramStepModifier, img, subplotIdx)
    [x,y,alpha,beta,kappa,lambda,fx,fy,maxstep] = loadInitialValues(img);
    eval(['paramStep=', paramName, ';']);
    paramStep = paramStepModifier*paramStep;
    min = paramStep - (2*paramStep);
    max = paramStep + (2*paramStep);
    for paramMod = (min:paramStep:max)
      modTitle = [paramName, '=', num2str(paramMod)];
      disp(modTitle);
      [x,y,alpha,beta,kappa,lambda,fx,fy,maxstep] = loadInitialValues(img);
      eval([paramName, '=', num2str(paramMod), ';']);
      try
        [x,y]=snake(x,y,alpha,beta,kappa,lambda,fx,fy,maxstep,0,img);
        subplotIdx = addSubplot(img, modTitle, x, y, subplotIdx);
      catch ME
        disp(ME);
        subplotIdx = subplotIdx + 1;
      end
    end
  end
  %% Function to perform subplot
  function subplotIdx = addSubplot(img, name, x, y, subplotIdx)
    subplot(6,5,subplotIdx); imagesc(img); colormap(gray); hold on; title(name);
    subplotIdx = subplotIdx + 1;
    plot([x;x(1)],[y;y(1)],'r','LineWidth',2); hold off;
  end
end
