import 'package:flutter/material.dart';
import 'package:movies/providers/movies_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/models.dart';


class VideosCard extends StatelessWidget {

  final int videoId;

  const VideosCard({ Key? key, required this.videoId }) : super( key: key );


  void launchVideo( String key ) async {
    //final url = 'youtube://www.youtube.com/watch?v=$key';
    final url = 'https://www.youtube.com/watch?v=$key';

    if ( await canLaunch( url )) {
      launch( url );
    }
    
  }


  Widget _buildTitle() {

    return const Padding(
      padding: EdgeInsets.only( left: 16.0, right: 16, bottom: 16.0 ),
      child: Text( "Videos", style: TextStyle( fontSize: 18.0, fontWeight: FontWeight.w600 )),
    );
  }


  @override
  Widget build( BuildContext context ) {

    final provider = Provider.of<MoviesProviders>( context, listen: false );


    return FutureBuilder(
      future  : provider.getVideos( videoId ),
      builder : ( _ , AsyncSnapshot<List<Video>> snapshot ) {
        
        if ( !snapshot.hasData ) {
          return Container();
        }

        if ( snapshot.data!.isEmpty ) {
          
          return Container(
            height: 100.0,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTitle(),

                const Expanded(
                  child: Center(
                    child: Text('No videos found.'),
                  ),
                ),
              ],
            )
          );
        }

        List<Video> videos = snapshot.data!;

        return Container(
          height: 100.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              _buildTitle(),

              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount  : videos.length,
                  itemBuilder: ( _ , i ) {
                      
                    final video = videos[i];
                      
                    return GestureDetector(
                      child: Container(
                        margin: const EdgeInsets.only( right: 16.0, left: 16.0 ),
                        child: Column(
                          children: [
                            const Icon(Icons.ondemand_video, color: Colors.red, size: 26.0 ),
                            const SizedBox( height: 8.0 ),
                            Text( video.type ),
                          ],
                        ),
                      ),
                      onTap: () => launchVideo( video.key ),
                    );
                  }
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}