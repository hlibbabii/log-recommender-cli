from nn.lang_model import Mode

nn_params = {
    'path_to_data': '<path_to_dataset>',
    'dataset_name': '',
    'arch': {
        'bs': 0,
        'bptt': 0,
        'em_sz': 0,  # size of each embedding vector
        'nh': 0,     # number of hidden activations per layer
        'nl': 0,       # number of layers
        'min_freq': 0,
        'betas': [],
        'clip': 0,
        'reg_fn': {'alpha': 0, 'beta': 0},
        'drop': {'outi': 0, 'out': 0, 'w':0, 'oute': 0, 'outh': 0},
        'wds': 0,
        'cycle': {'n': 0, 'len': 0, 'mult': 0},
        'training_metrics': []
    },
    'lr': 0,
    'metrics': [],
    'validation_bs': 0,
    'testing': {
        'how_many_words': 0,
        'starting_words': ""
    },
    'mode': Mode.VOCAB_BUILDING
}
