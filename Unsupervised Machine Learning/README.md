Finding similar songs the human way
The data that you will use in order to group songs are Spotify’s audio features. Obviously, then, the playlists that will emerge from the clustering algorithm that you will apply are going to be completely determined by whatever information these audio features capture from a song.

A human might find a stark difference between two songs because one has lyrics in English and the other in Portuguese, but as long as you do not capture this information (lyrics’ language) and feed it to the clustering algorithm, these two songs will not be distinguished by that. Inversely, if we were to measure something absurd like the length of the song’s name and include it into the algorithm, it would group songs with short names together, and it is highly likely this similarity would make no sense to a human listening to those short-named songs.

In conclusion, it is important to understand what data is available to you, get a feeling for what it is measuring and try to relate these measures to your own human perceptions.

You can start by reading the descriptions that Spotify provides about their audio features. You will see how some of these measures are well established musical properties (key, mode, tempo…) while others have been created by Spotify’s team of Data Science and Sound Engineering (danceability, energy, valence…).

acousticness
A confidence measure from 0.0 to 1.0 of whether the track is acoustic. 1.0 represents high confidence the track is acoustic.	Float
danceability
Danceability describes how suitable a track is for dancing based on a combination of musical elements including tempo, rhythm stability, beat strength, and overall regularity. A value of 0.0 is least danceable and 1.0 is most danceable.	Float
duration_ms
The duration of the track in milliseconds.	Integer
energy
Energy is a measure from 0.0 to 1.0 and represents a perceptual measure of intensity and activity. Typically, energetic tracks feel fast, loud, and noisy. For example, death metal has high energy, while a Bach prelude scores low on the scale. Perceptual features contributing to this attribute include dynamic range, perceived loudness, timbre, onset rate, and general entropy.	Float
instrumentalness
Predicts whether a track contains no vocals. “Ooh” and “aah” sounds are treated as instrumental in this context. Rap or spoken word tracks are clearly “vocal”. The closer the instrumentalness value is to 1.0, the greater likelihood the track contains no vocal content. Values above 0.5 are intended to represent instrumental tracks, but confidence is higher as the value approaches 1.0.	Float
key
The key the track is in. Integers map to pitches using standard Pitch Class notation . E.g. 0 = C, 1 = C♯/D♭, 2 = D, and so on.	Integer
liveness
Detects the presence of an audience in the recording. Higher liveness values represent an increased probability that the track was performed live. A value above 0.8 provides strong likelihood that the track is live.	Float
loudness
The overall loudness of a track in decibels (dB). Loudness values are averaged across the entire track and are useful for comparing relative loudness of tracks. Loudness is the quality of a sound that is the primary psychological correlate of physical strength (amplitude). Values typically range between -60 and 0 db.	Float
mode
Mode indicates the modality (major or minor) of a track, the type of scale from which its melodic content is derived. Major is represented by 1 and minor is 0.	Integer
speechiness
Speechiness detects the presence of spoken words in a track. The more exclusively speech-like the recording (e.g. talk show, audio book, poetry), the closer to 1.0 the attribute value. Values above 0.66 describe tracks that are probably made entirely of spoken words. Values between 0.33 and 0.66 describe tracks that may contain both music and speech, either in sections or layered, including such cases as rap music. Values below 0.33 most likely represent music and other non-speech-like tracks.	Float
tempo
The overall estimated tempo of a track in beats per minute (BPM). In musical terminology, tempo is the speed or pace of a given piece and derives directly from the average beat duration.	Float
time_signature
An estimated overall time signature of a track. The time signature (meter) is a notational convention to specify how many beats are in each bar (or measure).	Integer
valence
A measure from 0.0 to 1.0 describing the musical positiveness conveyed by a track. Tracks with high valence sound more positive (e.g. happy, cheerful, euphoric), while tracks with low valence sound more negative (e.g. sad, depressed, angry).	Float
Finding similar songs the machine way
After a close, human exploration of the raw data, it is time to start looking at how a computer would differentiate these songs from one another. This is calculated using linear algebra, data science’s favourite kind of maths. But don’t let this fancy term put you off, we’re simply calculating the distances between songs. It’s the same as plotting the songs on a graph and measuring how far apart they are.

Take a look at the example below. We’ve plotted 2 songs based on 2 columns of the dataframe. The pink song scored a 1 for acousticness, and a 5 for loudness. The blue song scored a 3 for acousticness, and a 1 for loudness. Now, for those of you who remember pythagoras theorem from school, we can calculate the distance between the songs using a² + b² = c², which translates to √((1 – 3)² + (5 – 1)²) ≈ 4.47



Now let’s plot a 3rd song on the graph with a black dot, and measure all the distances.



As you can see, the distance between the black song and the blue song is the smallest distance, so we can conclude that these songs are the most similar. Whereas the pink song and the blue song are the most dissimilar as they have the greatest distance between them. It’s as easy as that, the shorter the distance, the more similar we believe the songs are.

You may have noticed from the examples above that we used 2 columns of our dataframe to make a two dimensional graph. If we wanted to plot the values of 3 columns for the songs, we would need to use three dimensions to represent this. One dimension for each column. You’ll find quite often in Machine Learning that columns are referred to as dimensions for this reason. Even with an extra dimension, the maths stays pretty much the same, we just need to add an extra letter for the new dimension: a² + b² + c² = d².

Now that you’ve seen how to add one extra dimension, you can add as many as you like. The maths will stay the same, just keep adding an extra letter for every extra dimension that you add. The only problem is, after three dimensions we can no longer accurately represent the data on graphs as we only exist in three dimensional space. Try to accurately and clearly represent 13 dimensions on a piece of paper and you’ll see what I mean. We can, however, perform multi-dimensional maths by simply following the formula above, maths doesn’t always have to obey reality.

In the end, with 10 songs and 13 dimensions, we simply compute the distances from each song to all the rest, and find the smallest distances. The closer one song is to another, the more similar we believe they are.

There is more than one way to measure a distance
In the examples above we drew a straight line between the points on the graph, which is known as the euclidean distance. The clustering algorithm we will use in this project, KMeans, only uses the euclidean distance to measure the distance, and we won’t experiment further than this as we only have one week. However, it’s good to know that mathematically, and in other machine learning models, we are not restricted to using only the euclidean distance.

Another popular way of measuring distance is the Manhattan distance. The Manhattan is the distance between 2 points when moving only horizontally and vertically, like a knight in chess. The Manhattan distance is named after the grid system of the roads in america: you cannot move diagonally through buildings to connect points, you may only move vertically and horizontally across the grid of roads.
Euclidean	Manhattan
	
	
When clustering, we can utilise the different ways of measuring distances to form different shape clusters. This leads to certain points, generally on the fringes of a cluster, being reclassified. From this we often only make small alterations, but by being able to redesign the borders, we gain another parameter that we can use to tune our algorithm.

If you’re interested in learning more about why and how distances affect the maths behind our clusters, this is a good video to watch.
Intro to sklearn: transform your data with Transformers
As we discussed briefly at the end of the previous page, some of the data is on a significantly larger scale, which can have a massive impact on measuring distances. Loudness ranges from -33 to 0, whereas energy ranges from 0 to 1. This means that a 10% increase in loudness will produce a distance of 3.3, and a 10% increase in energy will only produce a distance of 0.1. As we use distance to calculate similarity, our model will be very sensitive to changes in loudness, but not in energy. To correct this we scale our data, so that everything fits within the same range, meaning that a 10% increase in loudness will affect our distances the same as a 10% increase in energy. To scale our data we will transform it using Scikit-Learn.

Scikit-Learn is Python’s most popular module to get started with Machine Learning. Virtually any data transformation and any algorithm that a Data Science learner might want to implement is available on Scikit-Learn. Just like Pandas, it has been built on top of Numpy and Matplotlib, and that means it generally will have a good integration with our main exploratory tools, as well as a speedy performance.

We will start by using Scikit-Learn to scale the data, so that we don’t have to write custom code like in the previous lesson and we have access to a broader range of transformations.

Look at this code and the detailed descriptions below to understand how we transform the data:
Import the transformer from sklearn. Since Scikit-Learn is such a big module, it is common to import exclusively the functions that you are going to use, which are located in submodules. In the case of the MinMaxScaler, it is part of the preprocessing submodule. It is always useful to take a look at the transformer documentation: you will quickly see that the title of the article follows the structure module.submodule.transformer.
Initialize the transformer. Transformers are not regular functions, they are its own class of object with its own methods. To use a transformer on a particular dataset, it first has to be initialized (or “declared”) with the desired parameters. In this case, we are passing the parameter feature_range as (0,1), so that all of the features get scaled between 0 and 1. Those are the default values, so we really did not need to pass the parameter, but it never hurts to be explicit.
Fit the transformer. The transformer that you have initialized needs to be passed the raw data and do some calculations so that it can transform it. This is what the fit method does here. In this case, the transformer will store the minimum and maximum values of each feature.
Transform the data. Use the fitted transformer to actually transform the data. Here we are storing the transformed data into a new object. If you print it, you will see that it is not a Pandas dataframe, but a Numpy array. Scikit-Learn uses Numpy arrays because they are lighter and faster than Pandas Dataframes.
Back to DataFrame. Reconvert the transformed data back to a Pandas DataFrame. You can recover the column and index names from the original dataframe. This step is not going to be needed once the modelling pipeline is finished, but right now you might want to explore the scaled data, and using Pandas is the best way to do it.
