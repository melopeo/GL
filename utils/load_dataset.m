function [Wpos, Wneg, labels] = load_dataset(dataset_name)
    data   = load(dataset_name);
    Wpos   = data.Wpos;
    Wneg   = data.Wneg;
    labels = data.labels;
    