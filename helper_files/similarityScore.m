function [ score ] = similarityScore( bow1, bow2 )
%Calculates Similarity Score of two bag of words histograms
dotprod = dot(bow1, bow2);
denom = norm(bow1)*norm(bow2);
score = dotprod/denom;

end

