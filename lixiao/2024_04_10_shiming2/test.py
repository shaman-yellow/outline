
import predict

test = predict.predict('/tmp/RtmpeaNMPy/smiles79bcda6d99f.txt',
        radius = 1,
        property = False,   #True if drug-likeness is known 
        dim = 52 ,
        layer_hidden = 4,
        layer_output = 10,
        dropout = 0.45,
        batch_train = 8,
        batch_test = 8,
        lr = 3e-4,
        lr_decay = 0.85,
        decay_interval = 25 ,
        iteration = 140,
        N = 5000)
