%starter code for project 2: linear classification
%pattern recognition, CSE583/EE552
%Weina Ge, Aug 2008
%Christopher Funk, Jan 2017
%Bharadwaj Ravichandran, Jan 2020

%Your Details: (The below details should be included in every matlab script
%file that you create)
%{
    Name: Pramod Kumar
    PSU Email ID: pjk5502
    Description: (A short description of what this script does).
%}

close all;
clear all;
addpath export_fig
% Choose which dataset to use (choices wine, wallpaper, taiji) :

%% Fisher Wine dataset
disp("**********************************Fisher Wine**************************************");
close all;
clear all;
addpath export_fig
wi_dataset = 'wine';

[train_featureVector, train_labels, test_featureVector, test_labels] = loadDataset(wi_dataset);


numGroups = length(countcats(test_labels));
% Uncomment the following line to use all features
feature_idx = 1:size(train_featureVector,2);

train_featureVector = train_featureVector(:,feature_idx);
test_featureVector = test_featureVector(:,feature_idx);

W_star = train_Fisher(train_featureVector, train_labels, numGroups)

train_pred_label = train_featureVector*W_star;

train_pred = predict_Fisher(train_pred_label, train_labels, train_pred_label, 10);


% Create confusion matrix
train_ConfMat = confusionmat(train_labels,categorical(train_pred));
% Create classification matrix (rows should sum to 1)
train_ClassMat = train_ConfMat./(meshgrid(countcats(train_labels))')
% mean group accuracy and std
train_acc = mean(diag(train_ClassMat))
train_std = std(diag(train_ClassMat))

figure(2);
cm = confusionchart(train_ConfMat);
st = " Training Conf Matrix("+wi_dataset+"), Acu = " + string(train_acc*100) + "%, SD = " + string(train_std);
cm.Title =  st;
export_fig Fish_wine_all_feature_train -png -transparent

test_pred_label = test_featureVector*W_star;

test_pred = predict_Fisher(train_pred_label, train_labels, test_pred_label, 5);
% Create confusion matrix
test_ConfMat = confusionmat(test_labels,categorical(test_pred));
% Create classification matrix (rows should sum to 1)
test_ClassMat = test_ConfMat./(meshgrid(countcats(test_labels))')
% mean group accuracy and std
test_acc = mean(diag(test_ClassMat))
test_std = std(diag(test_ClassMat))

figure(2);
cm = confusionchart(test_ConfMat);
st = " Testing Conf Matrix("+wi_dataset+"), Acu = " + string(test_acc*100) + "%, SD = " + string(test_std);
cm.Title =  st;
export_fig Fish_wine_all_feature_test -png -transparent
