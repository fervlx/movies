import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:movies/models/models.dart';
import 'package:movies/providers/movies_provider.dart';


class CastingCards extends StatelessWidget {

  final int id;

  const CastingCards( this.id, { Key? key }) : super( key: key );


  @override
  Widget build( BuildContext context ) {

    final provider = Provider.of<MoviesProviders>( context, listen: false );

    return FutureBuilder(
      future: provider.getCredits( id ),
      builder: ( _ , AsyncSnapshot<List<Cast>> snapshot ) {

        if ( !snapshot.hasData ) {
          return Container(
            height: 184.0,
            child: const CupertinoActivityIndicator(),
          );
        }

        return Container(
          margin: const EdgeInsets.only( bottom: 30.0 ),
          width: double.infinity,
          height: 224.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              const Padding(
                padding: EdgeInsets.only( left: 16.0, right: 16, bottom: 16.0 ),
                child: Text( "Casting", style: TextStyle( fontSize: 18.0, fontWeight: FontWeight.w600 )),
              ),
              
              Expanded(
                child: ListView.builder(
                scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data!.length,
                  itemBuilder: ( context, i ) => _CardCast( snapshot.data![i] ) 
                ) 
              )
            ],
          ),
        );
      }
    );
  }
}


class _CardCast  extends StatelessWidget {

  final Cast cast;

  const _CardCast( this.cast, { Key? key }) : super(key: key);


  @override
  Widget build( BuildContext context ) {

    return Container(
      margin: const EdgeInsets.symmetric( horizontal: 16.0 ),
      width: 110.0,
      height: 126.0,
      //color: Colors.green,
      child: Column(
        children: [

          ClipRRect(
            borderRadius: BorderRadius.circular( 15.0 ),
            child: FadeInImage(
              placeholder: const AssetImage('assets/no-image.jpg'),
              image: NetworkImage(cast.fullProfilePath),
              height: 140.0,
              width: 100.0,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox( height: 12.0 ),

          Text(cast.name, 
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            maxLines: 2,
          )
        ],
      ),
    );
  }
}