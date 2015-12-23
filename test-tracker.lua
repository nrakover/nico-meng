dofile('project/pretrained-word-models.lua');

word_models = {}
word_models['car'] = getCarDetector()
word_models['black'] = getBlackDetector()
word_models['yellow'] = getYellowDetector()
word_models['white'] = getWhiteDetector()

sentence = {}
sentence[1] = {word='yellow', roles={1}}
sentence[2] = {word='car', roles={1}}


dofile('project/sentence-hmm.lua');
dofile('track-to-mat.lua')
sentence = SentenceTracker:new(sentence, 'script_in/yellow-white-cars.mat', 'script_in/yellow-white-cars_features.t7', 'script_in/yellow-white-cars_opticalflow.t7', word_models)
track = sentence:getBestTrack()

trackToMat(track, 'script_out/yellow-white-cars-YELLOW_CAR_TRACK.mat')


-- require 'nn';
-- torch.setdefaulttensortype('torch.FloatTensor');
-- require 'loadcaffe';
-- dofile('load-and-process-img.lua');

-- function normalizeImage(im)
-- 	local mean_img = torch.FloatTensor(im:size())
-- 	mean_img[{{1},{},{}}] = -123.68
-- 	mean_img[{{2},{},{}}] = -116.779
-- 	mean_img[{{3},{},{}}] = -103.939
-- 	mean_img = mean_img:float()
-- 	return torch.add(im,mean_img):float()
-- end

-- IMG_DIM = 224
-- LAYER_TO_EXTRACT = 43
-- function extractFeatures(img, net)
-- 	local processed_img = processImage(img, IMG_DIM)
-- 	local normd_img = normalizeImage(processed_img)
-- 	net:forward(normd_img)
-- 	local features = net:get(LAYER_TO_EXTRACT).output:clone()
-- 	return nn.View(1):forward(features)
-- end

-- net = loadcaffe.load('networks/VGG/VGG_ILSVRC_19_layers_deploy.prototxt', 'networks/VGG/VGG_ILSVRC_19_layers.caffemodel', 'nn');

-- require 'ffmpeg';
-- v = ffmpeg.Video{path='script_in/nico_small.avi', fps=30, length=0.3, width=480, height=270};
-- frames = v:totensor(1,1,8);
-- f1 = frames[1]

-- goodRegion = f1[{{},{30,240},{5,70}}]:clone()
-- badRegion = f1[{{},{130,260},{225,425}}]:clone()
-- allRegion = f1[{{},{5,250},{5,460}}]:clone()

-- goodFeatures = extractFeatures(goodRegion, net)
-- badFeatures = extractFeatures(badRegion, net)
-- allFeatures = extractFeatures(allRegion, net)

-- test_d = t7ToSvmlight({goodFeatures, badFeatures, allFeatures}, torch.ByteTensor(3))
-- labels,accuracy,prob = liblinear.predict(test_d, classifier, '-b 1');

print('==> FINISHED TESTING')