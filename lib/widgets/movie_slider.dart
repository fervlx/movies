
import 'package:flutter/material.dart';
import 'package:movies/models/models.dart';


class MovieSlider extends StatefulWidget {

  final List<Movie> movies;
  final String? sectionTitle;
  final void Function() onNextPage;

  const MovieSlider({ Key? key, required this.movies, required this.onNextPage, this.sectionTitle }) : super( key: key );

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}


class _MovieSliderState extends State<MovieSlider> {

  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() { 

      if ( _controller.position.pixels >= _controller.position.maxScrollExtent - 500 ) {
        widget.onNextPage();
      }
    });
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build( BuildContext context ) {

    return SizedBox(
      width  : double.infinity,
      height : 260.0,
      child  : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          if ( widget.sectionTitle != null )
            Padding(
              padding : const EdgeInsets.symmetric( horizontal: 16.0, vertical: 8.0 ),
              child   : Text( widget.sectionTitle!, style: const TextStyle( fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black87 )),
            ),
          
          Expanded(
            child: ListView.builder(
              controller: _controller,
              itemCount: widget.movies.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: ( _, i ) => _MoviePoster( movie: widget.movies[i] )
            )
          )
          
        ],
      ),
    );
  }
}


class _MoviePoster extends StatelessWidget {

  final String? sectionTitle;
  final Movie movie;

  const _MoviePoster({ Key? key, required this.movie, this.sectionTitle }) : super( key: key );


  @override
  Widget build( BuildContext context ) {

    movie.tagId = sectionTitle != null ? '$sectionTitle-${movie.id}' : '${DateTime.now().toString()}-${movie.id}';

    return Container(
      width: 130,
      height: 190,
      margin: const EdgeInsets.symmetric( vertical: 8.0, horizontal: 16.0 ),
      //color: Colors.green,
      child: Column(
        children: [
          
          GestureDetector(
            onTap: () => Navigator.pushNamed( context, 'details', arguments: movie ),
            child: Hero(
              tag: movie.tagId!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular( 12 ),
                child: FadeInImage(
                  width: 130.0,
                  height: 170.0,
                  fit: BoxFit.cover,
                  placeholder: const AssetImage('assets/no-image.jpg'), 
                  image: NetworkImage( movie.getPosterPath() ),
                ),
              ),
            ),
          ),

          const SizedBox( height: 5.0 ),

          Text( movie.title, 
            overflow: TextOverflow.ellipsis, maxLines: 2, textAlign: TextAlign.center,
            style: const TextStyle( fontSize: 11.0, fontWeight: FontWeight.bold, color: Colors.black54 ),
          )
        ],
      ),
    );
  }
}