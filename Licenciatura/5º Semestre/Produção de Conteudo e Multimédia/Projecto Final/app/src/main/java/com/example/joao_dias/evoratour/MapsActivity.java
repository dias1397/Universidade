package com.example.joao_dias.evoratour;

        import android.Manifest;
        import android.content.pm.PackageManager;
        import android.graphics.Color;
        import android.location.Location;
        import android.os.AsyncTask;
        import android.os.Build;
        import android.support.v4.app.ActivityCompat;
        import android.support.v4.app.FragmentActivity;
        import android.os.Bundle;
        import android.support.v4.content.ContextCompat;
        import android.text.Html;
        import android.text.method.LinkMovementMethod;
        import android.util.Log;
        import android.view.View;
        import android.widget.Button;
        import android.widget.TextView;
        import android.widget.Toast;

        import com.google.android.gms.common.ConnectionResult;
        import com.google.android.gms.common.api.GoogleApiClient;
        import com.google.android.gms.location.LocationListener;
        import com.google.android.gms.location.LocationRequest;
        import com.google.android.gms.location.LocationServices;
        import com.google.android.gms.maps.CameraUpdateFactory;
        import com.google.android.gms.maps.GoogleMap;
        import com.google.android.gms.maps.OnMapReadyCallback;
        import com.google.android.gms.maps.SupportMapFragment;
        import com.google.android.gms.maps.model.BitmapDescriptorFactory;
        import com.google.android.gms.maps.model.Circle;
        import com.google.android.gms.maps.model.CircleOptions;
        import com.google.android.gms.maps.model.LatLng;
        import com.google.android.gms.maps.model.Marker;
        import com.google.android.gms.maps.model.MarkerOptions;
        import com.google.android.gms.maps.model.MapStyleOptions;

        import java.util.ArrayList;

public class MapsActivity extends FragmentActivity implements OnMapReadyCallback,
        GoogleApiClient.ConnectionCallbacks,
        GoogleApiClient.OnConnectionFailedListener,
        LocationListener {

    private GoogleMap mMap;
    GoogleApiClient mGoogleApiClient;
    Location mLastLocation;
    Marker mCurrLocationMarker;
    LocationRequest mLocationRequest;
    ArrayList<Marker> markers_array = new ArrayList<>();
    ArrayList<String> markers_name = new ArrayList<>();
    Circle circle;
    TextView text;
    Button[] button_array = new Button[5];
    Flags[] flags_mar = new Flags[22];
    int[] flags_but = new int[5];
    boolean flag_text = false;
    String[] marker_infor = new String[]{"A Capela dos Ossos é um dos mais conhecidos monumentos de Évora, em Portugal. Está situada na Igreja de São Francisco. Foi construída no século XVII por iniciativa de três monges franciscanos que, dentro do espírito da altura (contra-reforma religiosa, de acordo com as normativas do Concílio de Trento)... \nhttps://pt.wikipedia.org/wiki/Capela_dos_Ossos",
            "O templo romano de Évora, erroneamente conhecido como Templo de Diana, está localizado na cidade de Évora, em Portugal; faz parte do centro histórico da cidade, o qual foi classificado como Patrimônio Mundial pela UNESCO... \nhttps://pt.wikipedia.org/wiki/Templo_romano_de_%C3%89vora",
            "A Basílica Sé de Nossa Senhora da Assunção, mais conhecida por Catedral de Évora, ou simplesmente Sé de Évora, apesar de iniciada em 1186 e consagrada em 1204, esta catedral de granito só ficou pronta em 1250...\nhttps://pt.wikipedia.org/wiki/S%C3%A9_Catedral_de_%C3%89vora",
            "Em Évora, todos os caminhos vão dar à Praça do Giraldo. Sempre foi assim desde a sua construção, em 1571/1573...\nhttp://www.visitevora.net/praca-do-giraldo/",
            "O Aqueduto da Água de Prata, conhecido também por Aqueduto da Água da Prata ou Aqueduto da Prata é uma complexa obra de engenharia hidráulica renascentista com o objectivo de abastecer a cidade de Évora com água. Inaugurado no ano de 1537...\nhttps://pt.wikipedia.org/wiki/Aqueduto_da_%C3%81gua_de_Prata",
            "Fundada em 1805 pelo arcebispo D. Frei Manuel do Cenáculo, um clérigo erudito, representante de vulto do Iluminismo Português, a biblioteca acumula dois séculos de história...\nhttps://pt.wikipedia.org/wiki/Biblioteca_P%C3%BAblica_de_%C3%89vora",
            "O Museu Nacional Frei Manuel do Cenáculo, vulgarmente conhecido por Museu de Évora, é um museu nacional[2] [3] situado em Évora, Portugal. Ocupa o antigo Palácio Episcopal, junto da Sé Catedral de Évora, em pleno centro histórico...\nhttps://pt.wikipedia.org/wiki/Museu_de_%C3%89vora",
            "O Palácio de Dom Manuel, sito em Évora, Portugal, outrora conhecido por Paço Real de S. Francisco foi mandado construir por D. Afonso V, que desejava ter na cidade um paço real fora do castelo para se instalar...\nhttps://pt.wikipedia.org/wiki/Pal%C3%A1cio_de_Dom_Manuel",
            "A Igreja de São Francisco em Évora é uma igreja de arquitetura gótico-manuelina. Construída entre 1480 e 1510 pelos mestres de pedraria Martim Lourenço e Pero de Trilho e decorada pelos pintores régios Francisco Henriques, Jorge Afonso e Garcia Fernandes...\nhttps://pt.wikipedia.org/wiki/Igreja_de_S%C3%A3o_Francisco_(%C3%89vora)",
            "A Igreja de Santo Antão ou Igreja Paroquial de Santo Antão é um monumento religioso da cidade de Évora, estando situado na Praça de Giraldo, freguesia de Santo Antão...\nhttps://pt.wikipedia.org/wiki/Igreja_de_Santo_Ant%C3%A3o_(%C3%89vora)",
            "A referência mais antiga que se conhece a esta porta nas muralhas da povoação é de 1381...\nhttps://pt.wikipedia.org/wiki/Porta_de_Aviz",
            "O Teatro Garcia de Resende em Évora, Portugal, é um dos mais representativos \"teatros à italiana\" existentes em Portugal (outros: Teatro de S. Carlos, Coliseu de Lisboa) e com capacidade para figurar num dos primeiros lugares de uma listagem a nível europeu, ao lado, por exemplo, do Scala de Milão...\nhttps://pt.wikipedia.org/wiki/Teatro_Garcia_de_Resende",
            "A Ermida de São Brás, situada extra-muros no Rossio de São Brás, foi mandada construir por D. João II, no local onde já existiria uma pequena gafaria provisória em madeira, erguida para tratar dos doentes afectados pela peste que assolou o país em 1479-80...\nhttp://www.patrimoniocultural.gov.pt/en/patrimonio/patrimonio-imovel/pesquisa-do-patrimonio/classificado-ou-em-vias-de-classificacao/geral/view/70294",
            "Restaurante A Choupana",
            "Restaurante Fialho",
            "Restaurante Lavrador",
            "Restaurante Dom Joaquim",
            "Enoteca Cartuxa",
            "Hotel M'ar de Ar\nhttp://www.mardearhotels.com/",
            "Hotel Vila Galé\nhttps://www.vilagale.com/pt/hoteis/alentejo/vila-gale-evora",
            "Hotel Riviera\nhttp://www.riviera-evora.com/v1/index.asp",
            "Hotel Dom Fernando\nhttp://www.hoteldomfernando.com/"
    };


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_maps);
        text = (TextView) findViewById(R.id.marker_informacion);
        button_array[0] = (Button) findViewById(R.id.button0);
        button_array[0].setVisibility(View.GONE);
        button_array[1]= (Button) findViewById(R.id.button1);
        button_array[1].setVisibility(View.GONE);
        button_array[2] = (Button) findViewById(R.id.button2);
        button_array[2].setVisibility(View.GONE);
        button_array[3] = (Button) findViewById(R.id.button3);
        button_array[3].setVisibility(View.GONE);
        button_array[4] = (Button) findViewById(R.id.button4);
        button_array[4].setVisibility(View.GONE);

        for(int i=0; i<flags_mar.length;i++)
        {
            flags_mar[i] = new Flags(false,-1);
        }

        if (android.os.Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            checkLocationPermission();
        }
        // Obtain the SupportMapFragment and get notified when the map is ready to be used.
        SupportMapFragment mapFragment = (SupportMapFragment) getSupportFragmentManager()
                .findFragmentById(R.id.map);
        mapFragment.getMapAsync(this);
    }

    public void addFixedMarkers(GoogleMap mMap, double north, double east){
        LatLng lat = new LatLng(north,east);
        MarkerOptions markerOptions = new MarkerOptions();
        markerOptions.position(lat);
        markerOptions.anchor(0.5f, 0.5f);
        markerOptions.icon(BitmapDescriptorFactory.fromResource(R.drawable.blue));
        Marker mar = mMap.addMarker(markerOptions);
        markers_array.add(mar);
    }
    /**
     * Manipulates the map once available.
     * This callback is triggered when the map is ready to be used.
     * This is where we can add markers or lines, add listeners or move the camera. In this case,
     * we just add a marker near Sydney, Australia.
     * If Google Play services is not installed on the device, the user will be prompted to install
     * it inside the SupportMapFragment. This method will only be triggered once the user has
     * installed Google Play services and returned to the app.
     */
    @Override
    public void onMapReady(GoogleMap googleMap) {
        text.setBackgroundColor(Color.WHITE);

        text.setVisibility(View.GONE);
        mMap = googleMap;
        mMap.setMapStyle(MapStyleOptions.loadRawResourceStyle(
                        this, R.raw.style_json));

        //Initialize Google Play Services
        if (android.os.Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            if (ContextCompat.checkSelfPermission(this,
                    Manifest.permission.ACCESS_FINE_LOCATION)
                    == PackageManager.PERMISSION_GRANTED) {
                buildGoogleApiClient();
                mMap.setMyLocationEnabled(true);
            }
        }
        else {
            buildGoogleApiClient();
            mMap.setMyLocationEnabled(true);
        }

        mMap.setMinZoomPreference(17.5f);
        mMap.setMaxZoomPreference(17.5f);
        mMap.setMyLocationEnabled(false);

        //Monumentos
        addFixedMarkers(mMap, 38.5690,-7.9083);     // Capela dos ossos
        markers_name.add("Capela dos Ossos");
        addFixedMarkers(mMap, 38.5726,-7.9073);     // Templo romano
        markers_name.add("Templo Romano");
        addFixedMarkers(mMap, 38.5718,-7.9070);     // Sé de Évora
        markers_name.add("Sé de Évora");
        addFixedMarkers(mMap, 38.5708,-7.90954);    // Praça do giraldo
        markers_name.add("Praça do giraldo");
        addFixedMarkers(mMap, 38.5760,-7.9129);     // Aqeduto das águas de pratas
        markers_name.add("Aqueduto das Águas de Pratas");
        addFixedMarkers(mMap, 38.5724,-7.9070);     // Biblioteca Municipal
        markers_name.add("Biblioteca Municipal");
        addFixedMarkers(mMap, 38.5721,-7.9067);     // Museu de Évora
        markers_name.add("Museu de Évora");
        addFixedMarkers(mMap, 38.5677,-7.9092);     // Palácio de Dom Manuel
        markers_name.add("Palácio de Dom Manuel");
        addFixedMarkers(mMap, 38.5690,-7.9086);     // Igreja de são francisco
        markers_name.add("Igreja de São Francisco");
        addFixedMarkers(mMap, 38.5712,-7.9099);     // Igreja de Santo Antão
        markers_name.add("Igreja de Santo Antão");
        addFixedMarkers(mMap, 38.5767,-7.9103);     // Portas de Aviz
        markers_name.add("Portas de Aviz");
        addFixedMarkers(mMap, 38.5728,-7.9132);     // Teatro Garcia de Rezende
        markers_name.add("Teatro Garcia de Rezende");
        addFixedMarkers(mMap, 38.5648,-7.9073);     // Ermida de São Brás
        markers_name.add("Ermida de São Brás");

// RESTAURANTES
        addFixedMarkers(mMap, 38.5707,-7.9099);     // Restaurante A Choupana
        markers_name.add("Restaurante A Choupana");
        addFixedMarkers(mMap, 38.5735,-7.9126);     // Restaurante Fialho
        markers_name.add("Restaurante Fialho");
        addFixedMarkers(mMap, 38.5721,-7.9030);     // Restaurante Lavrador
        markers_name.add("Restaurante Lavrador");
        addFixedMarkers(mMap, 38.5710,-7.9144);     // Restaurante Dom Joaquim
        markers_name.add("Restaurante Dom Joaquim");
        addFixedMarkers(mMap, 38.5721,-7.9076);     // Enoteca Cartuxa
        markers_name.add("Enoteca Cartuxa");

//HOTEIS
        addFixedMarkers(mMap, 38.5752,-7.9135);     // Hotel M'ar de Ar
        markers_name.add("Hotel M'ar de Ar");
        addFixedMarkers(mMap, 38.5672,-7.9155);     // Hotel Vila Galé
        markers_name.add("Hotel Vila Galé");
        addFixedMarkers(mMap, 38.5712,-7.9084);     // Hotel Riviera
        markers_name.add("Hotel Riviera");
        addFixedMarkers(mMap, 38.565,-7.9075);     // Hotel Dom Fernando
        markers_name.add("Hotel Dom Fernando");

        circle = mMap.addCircle(new CircleOptions()
                .center(new LatLng(0,0))
                .radius(84)
                .visible(false));
    }

    protected synchronized void buildGoogleApiClient() {
        mGoogleApiClient = new GoogleApiClient.Builder(this)
                .addConnectionCallbacks(this)
                .addOnConnectionFailedListener(this)
                .addApi(LocationServices.API)
                .build();
        mGoogleApiClient.connect();
    }

    @Override
    public void onConnected(Bundle bundle) {

        mLocationRequest = new LocationRequest();
        mLocationRequest.setInterval(1000);
        mLocationRequest.setFastestInterval(1000);
        mLocationRequest.setPriority(LocationRequest.PRIORITY_BALANCED_POWER_ACCURACY);
        if (ContextCompat.checkSelfPermission(this,
                Manifest.permission.ACCESS_FINE_LOCATION)
                == PackageManager.PERMISSION_GRANTED) {
            LocationServices.FusedLocationApi.requestLocationUpdates(mGoogleApiClient, mLocationRequest, this);
        }

    }

    @Override
    public void onConnectionSuspended(int i) {
    }

    @Override
    public void onLocationChanged(Location location) {
        mLastLocation = location;
        if (mCurrLocationMarker != null) {
            mCurrLocationMarker.remove();

        }

        //Place current location marker
        LatLng latLng = new LatLng(location.getLatitude(), location.getLongitude());
        MarkerOptions markerOptions = new MarkerOptions();
        markerOptions.position(latLng);
        markerOptions.icon(BitmapDescriptorFactory.fromResource(R.drawable.circle));
        markerOptions.alpha(0.6f);
        markerOptions.anchor(0.5f, 0.5f);
        //markerOptions.icon(BitmapDescriptorFactory.defaultMarker(BitmapDescriptorFactory.HUE_MAGENTA));
        mCurrLocationMarker = mMap.addMarker(markerOptions);

        //move map camera
        mMap.moveCamera(CameraUpdateFactory.newLatLng(latLng));
        mMap.animateCamera(CameraUpdateFactory.zoomTo(11));

        circle.setCenter(latLng);


        for(int i=0; i<markers_array.size(); i++){
            // Localização monumento
            Location locationA = new Location("point A");
            locationA.setLatitude(markers_array.get(i).getPosition().latitude);
            locationA.setLongitude(markers_array.get(i).getPosition().longitude);

            // Localização pessoa
            Location locationB = new Location("point B");
            locationB.setLatitude(circle.getCenter().latitude);
            locationB.setLongitude(circle.getCenter().longitude);

            float distance = locationA.distanceTo(locationB);

            int[] exit = new int[5];
            int cont=0;
            if( distance <= circle.getRadius()  ){
                markers_array.get(i).setIcon(BitmapDescriptorFactory.fromResource(R.drawable.yellow));
                markers_array.get(i).setTitle(markers_name.get(i));

                for(int j=0; j<5; j++){
                    if(!flags_mar[i].ativo && flags_but[j]==0){
                        String mDrawableName = "marker"+i;
                        int resID = getResources().getIdentifier(mDrawableName , "drawable", getPackageName());
                        button_array[j].setBackgroundResource(resID);
                        button_array[j].setVisibility(View.VISIBLE);
                        button_array[j].setOnClickListener(new View.OnClickListener() {
                            public void onClick(View view) {
                                if(flag_text)
                                {
                                    text.setVisibility(View.GONE);
                                    flag_text=false;
                                }

                                else
                                {
                                    text.setVisibility(View.VISIBLE);
                                    flag_text=true;
                                    text.setText(marker_infor[0]);
                                    LinkUtils.autoLink(text, new LinkUtils.OnClickListener() {
                                        @Override
                                        public void onLinkClicked(final String link) {
                                            Log.i("SensibleUrlSpan", "Link:" + link);
                                        }

                                        @Override
                                        public void onClicked() {
                                            Log.i("SensibleUrlSpan", "Link");
                                        }
                                    });
                                }

                            }
                        });
                        flags_mar[i].ativo=true;
                        flags_mar[i].indice_button=j;
                        flags_but[j]=1;
                        System.out.println("J: "+j);
                        break;
                    }
                }
            }else{
                flags_mar[i].ativo=false;
                if(flags_mar[i].indice_button!=-1) {
                    button_array[flags_mar[i].indice_button].setVisibility(View.GONE);
                    flags_mar[i].indice_button=-1;
                }
                markers_array.get(i).setIcon(BitmapDescriptorFactory.fromResource(R.drawable.blue));
                markers_array.get(i).setTitle("");
            }
        }



       /** mMap.setOnMarkerClickListener(new GoogleMap.OnMarkerClickListener() {
            @Override
            public boolean onMarkerClick(Marker marker) {
                System.out.println("Coords of Capela: "+markers_array.get(0).getPosition());


                return true;
            }
        });*/



        //stop location updates
        //if (mGoogleApiClient != null) {
        //    LocationServices.FusedLocationApi.removeLocationUpdates(mGoogleApiClient, this);
        //}

        //mMap.animateCamera(CameraUpdateFactory.newLatLng(new LatLng(location.getLatitude(), location.getLongitude())));

    }

    @Override
    public void onConnectionFailed(ConnectionResult connectionResult) {

    }

    public static final int MY_PERMISSIONS_REQUEST_LOCATION = 99;
    public boolean checkLocationPermission(){
        if (ContextCompat.checkSelfPermission(this,
                Manifest.permission.ACCESS_FINE_LOCATION)
                != PackageManager.PERMISSION_GRANTED) {

            // Asking user if explanation is needed
            if (ActivityCompat.shouldShowRequestPermissionRationale(this,
                    Manifest.permission.ACCESS_FINE_LOCATION)) {

                // Show an explanation to the user *asynchronously* -- don't block
                // this thread waiting for the user's response! After the user
                // sees the explanation, try again to request the permission.

                //Prompt the user once explanation has been shown
                ActivityCompat.requestPermissions(this,
                        new String[]{Manifest.permission.ACCESS_FINE_LOCATION},
                        MY_PERMISSIONS_REQUEST_LOCATION);


            } else {
                // No explanation needed, we can request the permission.
                ActivityCompat.requestPermissions(this,
                        new String[]{Manifest.permission.ACCESS_FINE_LOCATION},
                        MY_PERMISSIONS_REQUEST_LOCATION);
            }
            return false;
        } else {
            return true;
        }
    }

    @Override
    public void onRequestPermissionsResult(int requestCode,
                                           String permissions[], int[] grantResults) {
        switch (requestCode) {
            case MY_PERMISSIONS_REQUEST_LOCATION: {
                // If request is cancelled, the result arrays are empty.
                if (grantResults.length > 0
                        && grantResults[0] == PackageManager.PERMISSION_GRANTED) {

                    // permission was granted. Do the
                    // contacts-related task you need to do.
                    if (ContextCompat.checkSelfPermission(this,
                            Manifest.permission.ACCESS_FINE_LOCATION)
                            == PackageManager.PERMISSION_GRANTED) {

                        if (mGoogleApiClient == null) {
                            buildGoogleApiClient();
                        }
                        mMap.setMyLocationEnabled(true);
                    }

                } else {

                    // Permission denied, Disable the functionality that depends on this permission.
                    Toast.makeText(this, "permission denied", Toast.LENGTH_LONG).show();
                }
                return;
            }

            // other 'case' lines to check for other permissions this app might request.
            // You can add here other case statements according to your requirement.
        }
    }

}