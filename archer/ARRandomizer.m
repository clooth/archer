//
//  ARRandomGenerator.m
//  archer
//
//  Created by Nico Hämäläinen on 26/05/14.
//  Copyright (c) 2014 YouLapse Oy. All rights reserved.
//

#import "ARRandomizer.h"

#define ARC4RANDOM_MAX 0x100000000

NSString * const kARRandomizerNameList = @"Aaron,Abby,Adel,Abbot,Abigail,Adell,Abdul,Adriana,Adieu,Abe,Aerith,Agares,Abel,Agnes,Ainsley,Abelard,Agora,Akey,Abigor,Ahya,Akiblo,Able,Aisha,Akibo,Abraham,Alexa,Aldis,Ace,Alexandra,Alex,Achilles,Alexandria,Alexis,Acid,Alice,Andie,Adam,Alison,Andy,Adolf,Allison,Anzu,Adrian,Alllietta,Aramis,Aegis,Allocen,Ash,Agaliarept,Alquen,Ashley,Agnew,Alsace,Astarte,Agrippa,Alumina,Athena,Ahmed,Alyssa,Athetosis,Ajikage,Amber,Aubrey,Akira,Amdusias,Avery,Al,Amia,Axis,Alan,Amnelis,Bailey,Albert,Amulet,Bakala,Alexander,Amy,Beatrix,Alfred,Ana,Biggs,Algoreo,Anabell,Billie,Allen,Anastasia,Birru,Alpha,Andrea,Blair,Alto,Angela,Blank,Alucard,Angeline,Bo,Amon,Anita,Boko,Anderson,Ann,Boo,Andras,Anna,Boss,Andre,Annerose,Boxy,Andrealphus,Annette,Brady,Andrew,Annie,Brand,Andromalius,Annis,Brook,Angus,Aphrodite,Brooke,Animus,Apple,Byung,Ansbach,April,Cait,Antaios,Aqua,Cam,Anthony,Aria,Cameron,Antonio,Arias,Cannon,Antony,Ariel,Carey,Apollo,Arina,Casey,Apu,Arion,Cass,Aragorn,Artemis,Cassidy,Arbaux,Arwen,Chapeau,Arc,Arylon,Charley,Archie,Astrid,Charlie,Arg,Asura,Chase,Argelmach,Audry,Chen,Argo,Aura,Chiangley,Argus,Aurelia,Chicori,Ark,Auslese,Chlordane,Arlen,Austin,Cinna,Armand,Avan,Cleo,Armaros,Balalaika,Cloud,Arnie,Ballad,Clutch,Arnold,Barb,Coby,Art,Barbara,Codeine,Arthas,Barbie,Cooke,Arthur,Bea,Cookie,Artie,Beatrice,Cotton,Artur,Beauchette,Croissant,Astos,Becky,Dale,Athos,Belinus,Dana,Augh,Bellatrix,Darby,August,Belle,Darci,Augustine,Bertha,Darcy,Augustus,Bess,Daria,Axel,Bessy,Darian,Azazel,Beth,Darryl,Baggins,Betsy,Daryl,Baghi,Betty,Dawson,Baldr,Bianca,Dax,Baldwin,Blonde,Devon,Balin,Blondie,Dig,Baltis,Bobbie,Dio,Bane,Bonita,Dorro,Barak,Bouquet,Drew,Barret,Brandi,Dusty,Barry,Brandine,Dylan,Barsom,Brandy,Elian,Bart,Bree,Emery,Bartz,Brenda,Enigma,Basil,Briana,Epsilon,Batiatus,Bridget,Erin,Beaufort,Brigit,Eryn,Belphegor,Brittany,Escargo,Ben,Brunhild,Ethos,Bender,Brunhilde,Etwas,Benedict,Buelle,Faraday,Benjamin,Caitlin,Fixer,Benten,Cameo,Font,Beowulf,Cammy,Foon,Bereth,Candy,Francis,Bernard,Carmalide,Friday,Bernie,Carmen,Fubuki,Bert,Carol,Gabriel,Bertram,Carole,Gadget,Bertrand,Carrie,Gair,Betelgeuse,Cassandra,Galaxy,Bic,Cassie,Garnet,Bifrons,Cassy,Gash,Bigby,Cate,Geist,Bikke,Cathy,Gig,Bilbo,Cecila,Giko,Bill,Cecilia,Gimp,Billy,Celcia,Gingham,Bismarck,Celes,Gogo,Bob,Celeste,Gray,Bobby,Celestia,Hack,Bonaparte,Celestine,Hagar,Boon,Charlene,Hanako,Bossanova,Charlotte,Haris,Brad,Charmane,Harley,Bradley,Chelsea,Harly,Bradly,Cheryl,Hayden,Brannigan,Christina,Hong,Bravo,Christine,Id,Brent,Ciel,Idea,Brian,Cinderella,Ipos,Brock,Cindy,Jam,Brocken,Claire,Jax,Brody,Clara,Jet,Bruce,Clarion,Jo,Bruno,Claris,Jody,Brutus,Cleopatra,Jojo,Bub,Connie,Jordan,Buba,Cora,Jude,Bubba,Coral,Justice,Buck,Coralie,Kanna,Bucky,Coraline,Keim,Bud,Cornelia,Kelsey,Buddy,Cornet,Kerry,Burke,Coronet,Kit,Cadmus,Corriedale,Kiwi,Caesar,Corsage,Koko,Cagliostro,Courtney,Komugi,Cain,Couturiere,Kong,Canard,Crescentia,Laguna,Caradoc,Crissy,Lang,Carbide,Crystal,Lark,Carl,Cymbal,Layton,Carlos,Cynthia,Lee,Carlton,Dahlia,Leigh,Carson,Daisy,Lemon,Caulang,Dandelion,Lex,Cecil,Dandy,Lexx,Chad,Daphne,Limbo,Charles,Dawn,Ling,Charmant,Debbie,Linos,Chester,Debonair,Logan,Choux,Dee,Loot,Chris,Delia,Lorin,Christian,Delilah,Love,Christoph,Delphine,Lucky,Christopher,Delta,Lufia,Chuck,Diana,Lune,Chucky,Diane,Lux,Cid,Dianna,Macky,Cinzano,Dido,Madison,Clefford,Dilan,Makka,Cletus,Dixie,Marl,Cliff,Dolce,Marley,Clint,Dora,Mattie,Clinton,Doreen,Mel,Clipton,Doris,Merle,Clive,Dorothy,Metiee,Cloak,Druuna,Mirage,Clove,Ebonite,Misha,Clyde,Eclair,Mo,Cognac,Ecole,Mocchus,Colby,Edna,Mocci,Cole,Edwina,Modero,Comet,Eida,Mog,Conan,Eigendorf,Mohawk,Connor,Eiji,Muzari,Conrad,Eileen,Myrddin,Cooper,Elaine,Nebula,Corey,Eleanor,Neige,Cornelius,Elena,Neo,Cornerius,Elfir,Neta,Cortez,Elfriede,Nikita,Cory,Elisa,Nirva,Costello,Elise,Noam,Craig,Eliza,Non,Creed,Elizabeth,Nuka,Crouton,Ella,Oath,Dagwood,Eloise,Oce,Daish,Elphin,Olias,Dakka,Elsa,Olympia,Damian,Ema,Padma,Dan,Emily,Palmiro,Daniel,Emma,Pan,Danny,Emmy,Pann,Dave,Eowyn,Parker,David,Erica,Pat,Dean,Esmerelda,Pattie,Deimos,Esparanto,Pattie,Dennis,Esprit,Pax,Derrick,Estel,Peetan,Desch,Ethel,Penn,Desmond,Etna,Peyton,Dewey,Eva,Phobos,Dietrich,Evangeline,Phoenix,Digby,Eve,Pippin,Dirk,Evelyn,Pleinair,Dixon,Fabrizia,Potter,Doga,Faith,Praxis,Dogen,Falfie,Prinny,Dolph,Falquenne,Pritny,Dominic,Farah,Puck,Domitus,Fatima,Qwerty,Don,Faustina,Rage,Donnie,Fay,Rain,Doobie,Felicia,Rainn,Doogie,Fenella,Ran,Doug,Ferne,Rana,Douglas,Ferri,Random,Douglass,Fiador,Red,Draco,Fiona,Reilly,Drake,Flauros,Rem,Dudley,Fleur,Remiel,Duke,Flo,Riley,Duncan,Flonne,Rio,Dustin,Flora,Ripley,Dwayne,Florence,Rory,Dwight,Fondue,Rudy,Dynamo,Francine,Samus,Echo,Freda,Sandy,Ed,Frederica,Scotch,Eddie,Freida,Sector,Edgar,Freya,Seimei,Edge,Frill,Seito,Edmund,Frilla,Sela,Edward,Frille,Shade,Edwin,Frilly,Shadow,Eisbein,Gabby,Sigma,Eisenach,Gabi,Silver,Eisenerz,Gabriele,Slash,Eko,Gabriella,Sludge,Eligor,Gabrielle,Smoke,Elrond,Gaby,Souffle,Elsheimer,Gawein,Spanky,Elzar,Gayle,Sparky,Emilio,Gesellschaft,Spiral,Engarde,Gillian,Star,Erg,Gin,Sunday,Eric,Gina,Sushi,Erik,Ginger,Suzuki,Ernie,Giselle,Taki,Ernst,Glenda,Tamarin,Ethan,Gloria,Tandoori,Etranger,Goldie,Tanpopo,Exocet,Grace,Tao,Falco,Grammy,Taro,Falus,Greta,Tayler,Felix,Gretchen,Taylor,Ferris,Gretel,Terry,Fin,Grune,Thursday,Finn,Guenever,Tink,Fiz,Gwen,Toby,Flea,Gwendolyn,Trace,Flint,Hadrian,Tracey,Ford,Hailey,Tracy,Frank,Hannah,Tristan,Frankie,Harlequin,Tyler,Franklin,Hartwin,Uranus,Fred,Haydn,Uriel,Frederick,Hazuki,Van,Friedrich,Heidi,Verrier,Fritz,Helen,Vodka,Frodo,Helena,Waffle,Fry,Helga,Wasabi,Fuke,Hellicios,Wesker,Fyz,Hermina,Wing,Gabbot,Hilda,Wing,Gabe,Hilde,Wolf,Gainer,Hillary,Wong,Gairu,Holly,X-1,Gallant,Hope,X-14D0,Gambit,Hun,X-14D1,Gandalf,Idola,X-2,Gansel,Ilumina,X-21,Garcon,Ingrid,X-23,Gareth,Ingvar,X-3,Gargamel,Ippril,X-3E3,Garland,Iris,Xe,Garon,Irma,Yanyan,Garosh,Isabel,Yeardley,Garret,Isabella,Ygerne,Gary,Isobel,York,Gaston,Ivy,Yuki,Gau,Jackie,Yukimaru,Gaufres,Jade,Z,Gaws,Jaina,Zebra,Gazette,James,Zeolite,Geddon,Jan,Zero,Geese,Jane,Zetta,Gemeiner,Jasmine,Zodiac,George,Jeanne,Geraint,Jen,Gerald,Jenna,Gerard,Jennifer,Gerhard,Jenny,Geronimo,Jessica,Gestalt,Jessie,Gewalt,Jill,Gil,Joan,Gilbert,Joanna,Gilgamesh,Joclyn,Gimlet,Joy,Gimli,Judith,Gino,Julia,Glen,Julie,Glenn,Julienne,Gnocchi,Juliet,Goblet,Julietta,Godo,Julius,Goemon,June,Gordo,Kaitlin,Gordon,Karen,Gorn,Karin,Greg,Karla,Gregory,Karrey,Gremory,Kary,Griffon,Kasekuchen,Guile,Kasuba,Gunter,Kasumi,Gus,Kate,Gustav,Katelyn,Guy,Katerine,Haken,Katherine,Halver,Kathleen,Han,Kathy,Hank,Katie,Hans,Katrina,Hansel,Kayleigh,Hanso,Keira,Hanzo,Kelly,Harold,Kim,Harrison,Kimberly,Harry,Kinkan,Hector,Kitty,Hedwig,Klara,Hein,Klimina,Heinrich,Kristin,Heinz,Lachesis,Helmut,Laelia,Henry,Lafeene,Herb,Lana,Herbert,Lancia,Herbie,Lao,Herman,Lara,Hermes,Larissa,Herzog,Latisha,Hickory,Laura,Hogger,Lauren,Homer,Laverna,Homeros,Layla,Horace,Leela,Horchata,Leia,Howard,Leila,Howie,Lena,Hrothgar,Leslie,Hubert,Leticia,Huck,Liane,Hugh,Lianne,Hugo,Liberty,Hulloc,Liese,Hume,Ligia,Hurley,Lili,Husky,Lilith,Ian,Lillian,Ingus,Lily,Isaac,Lime,Ishtar,Linda,Isolde,Lindsey,Ivan,Lisa,Jaccard,Lita,Jack,Lois,Jackal,Lola,Jackson,Lorelei,Jacob,Lottie,Jake,Luca,Jarble,Lucille,Jason,Lucinda,Jeb,Lucretia,Jebediah,Lucy,Jerremy,Lulu,Jerry,Luna,Jesse,Lundi,Jeyal,Lunista,Jim,Luphina,Jimbo,Lynn,Jimmy,Lynne,Jin,Macie,Job,Maddeline,Joe,Maddie,Joel,Madonna,Johann,Magdalena,Johannes,Magenta,Johanson,Maggie,John,Maggiore,Johney,Magnolia,Johnny,Mallory,Johnson,Mandy,Joker,Margarita,Jon,Marge,Josef,Margo,Joseph,Maria,Josh,Mariah,Joshua,Mariell,Jruu,Marin,Juan,Marissa,Jubei,Marius,Judas,Marjoly,Jughead,Marla,Justin,Marlone,Kain,Marona,Kain,Marsha,Kaiser,Marta,Kang,Martha,Karl,Mary,Keith,Matilda,Ken,Maude,Kennel,Maureen,Kenny,May,Kessler,Maya,Kevin,Mayden,Khmer,Mazurka,Kif,Medea,Kirk,Meena,Klomn,Meg,Kocher,Megan,Kodos,Meimu,Kojack,Melissa,Kojo,Melody,Kong,Memory,Konga,Menuette,Kosmos,Mercia,Krajicek,Merium,Kriemhild,Meryl,Kumar,Mia,Kurt,Michelle,Kurtis,Mihail,Kyle,Milan,Kyrielich,Miley,Laharl,Millia,Lambda,Mindy,Lance,Minerva,Lancelot,Ming,Lando,Minnie,Lank,Mint,Lapiz,Mira,Lars,Misti,Larugo,Misty,Laslo,Mograine,Laudigan,Moira,Launceor,Moire,Leeroy,Molly,Legolas,Mona,Leighton,Monica,Len,Moon,Lenn,Morgan,Lenny,Mourvin,Leo,Muireann,Leon,Myra,Leonard,Nadia,Leopold,Nancy,Leroy,Naomi,Lewis,Natalie,Lexlort,Natty,Liam,Neirin,Link,Nel,Linker,Nell,Linus,Nelly,Lionel,Nicky,Lloyd,Nicole,Lock,Nida,Locke,Nikki,Lou,Nina,Louis,Noelle,Lowell,Noin,Lucan,Noir,Lucas,Norma,Ludwig,Nyah,Luigi,Octavia,Luke,Odessia,Lutius,Olga,Mac,Olive,Magni,Olivia,Magnus,Orivea,Malachi,Ozmyere,Malcolm,Paige,Malthus,Pam,Manny,Pamela,Mao,Pamille,Marchocias,Panna,Marco,Paris,Marcus,Pastel,Mark,Patricia,Mars,Paula,Marshall,Payton,Martin,Peach,Marvin,Pearl,Mat,Peggy,Mathew,Penelope,Matt,Penny,Matthias,Perfume,Max,Persephone,Maximilian,Petite,Maximillian,Petra,Maximus,Phyllis,Meindorf,Pia,Melchior,Pierina,Melvin,Poette,Mephisto,Polly,Merlin,Pollyanna,Merv,Portia,Meyer,Pram,Michael,Pratima,Mickey,Priere,Midas,Primula,Mike,Pris,Miles,Prudence,Milhouse,Pucelle,Milo,Quess,Mitch,Quilt,Mitchell,Quinine,Moby,Rachel,Moe,Raspberyl,Moloch,Rebeca,Monar,Remy,Montezuma,Rena,Morbo,Rhea,Mordred,Rhett,Morpheus,Riali,Mort,Ribbon,Musashi,Rikku,Mustafa,Robin,Napoleon,Robyn,Ned,Robyn,Neidhardt,Rocielle,Neil,Ronica,Nelson,Rosa,Nero,Rose,Nessler,Rosetta,Nicholas,Rosewood,Nick,Rouge,Nigel,Roxanne,Nimrod,Roxy,Nitro,Rozalin,Noah,Rubashka,Norbert,Ruby,Obama,Ruth,Oidepus,Sabrina,Oliver,Sabrosa,Olivier,Sakura,Omar,Salina,Opie,Sally,Orson,Salma,Osama,Salvia,Oscar,Samantha,Osric,Sandra,Otis,Sapphire,Otto,Sara,Ouzo,Sarafan,Owen,Sarah,Paco,Saratoga,Page,Saria,Pancho,Sarome,Patrick,Sascha,Paul,Sasha,Paulman,Sasuke,Paulo,Scarlet,Pavel,Scarlett,Percival,Schia,Percivale,Seila,Percy,Selena,Perrin,Selene,Peter,Selma,Phil,Sepia,Phillip,Shannon,Pierce,Sharon,Pizzicato,Shauna,Pock,Shelly,Polo,Sherry,Poncho,Shirley,Port,Si,Quentin,Sialon,Quinn,Sibyl,Radley,Silica,Radly,Silvia,Raelene,Siren,Rakka,Sofia,Ralph,Solaris,Rammstein,Soleil,Randy,Solis,Rango,Sonata,Rangue,Sonette,Raoul,Sonya,Rastel,Sophia,Ray,Stacey,Rayrord,Stacy,Razz,Stella,Reckendorf,Strawberry,Relm,Sue,Remnus,Sun,Rex,Suri,Ricardo,Susan,Rich,Suzanna,Richard,Suzie,Rick,Suzu,Ricky,Svana,Rigby,Sweet,Ringo,Sylvanas,Ritchie,Tamara,Rob,Tamia,Robert,Tamiel,Robinson,Tammy,Rocco,Tanya,Rockwell,Tarte,Rocky,Teagan,Rod,Teresa,Rodd,Terra,Roddy,Terrine,Roderick,Tesse,Rody,Theresa,Roger,Theta,Rolan,Thora,Roland,Tifa,Rolf,Tiffany,Roman,Tigre,Romeo,Tilda,Romulus,Tina,Ron,Torquay,Ronnie,Tranza,Ronny,Trianna,Ross,Trinity,Rowan,Tyra,Roy,Ualan,Rufus,Uma,Ruger,Undine,Rupert,Ursula,Russell,Va,Rusty,Valencia,Ryan,Valerius,Ryu,Vanessa,Sabin,Vanna,Saladin,Vediva,Salmaan,Velma,Salman,Venice,Salmun,Venus,Salsburg,Vera,Sam,Veritace,Samchay,Veronica,Samson,Vicky,Samuel,Victoria,Savarin,Vilma,Sawyer,Vine,Sayid,Viola,Scherzo,Violet,Scott,Violette,Sean,Viva,Sebastian,Wendy,Selman,Wilma,Seth,Windy,Seymour,Winney,Shamrock,Xabia,Shaun,Xandria,Shelby,Xena,Shelden,Yuki,Sherbert,Yuna,Shidoshi,Yvette,Shredder,Yvonne,Siegfried,Zelda,Sigmund,Zenia,Sigurd,Ziska,Siniud,Zoe,Sirius,Zoey,Skald,Skip,Smith,Soliton,Sombart,Sonic,Sonny,Spade,Spartan,Spencer,Spenny,Spock,Staden,Stan,Stanley,Steilhang,Stephen,Steve,Steven,Stewart,Stigma,Stinger,Stout,Stu,Stuart,Tad,Takka,Tate,Ted,Teddy,Thaddeus,Theo,Theoden,Theodore,Thomas,Thrall,Tiger,Tim,Timmy,Timothy,Tip,Tirion,Titan,Tobias,Tobul,Tod,Todd,Tom,Tony,Trevor,Tristram,Troy,Turbo,Ty,Tycho,Tyron,Ulric,Ulrich,Valgus,Vasquez,Vega,Verne,Victor,Vincent,Vladimir,Volac,Waldo,Wally,Walt,Walter,Ward,Warren,Wayne,Wedge,Werner,Wilhelm,Will,Willaby,William,Willie,Willock,Willy,Winston,Woody,Xavier,Xenon,Xig,Yoda,Yorick,Yorrick,Zac,Zach,Zachary,Zack,Zanac,Zapp,Zeeman,Zeke,Zeus,Zeveck,Zisakuzien";

@implementation ARRandomizer

#pragma mark - Strings

+ (NSString *)randomStringWithLength:(NSUInteger)length
{
    NSMutableString *randomString = [NSMutableString stringWithCapacity:length];
    for (int i = 0; i < length; i++) {
        [randomString appendFormat:@"%C", (unichar)('a' + arc4random_uniform(25))];
    }
    return randomString;
}

#pragma mark - File names

+ (NSString *)randomFileNameWithExtension:(NSString *)extension
{
    NSString *string = [self randomStringWithLength:32];
    NSString *extensionWithPeriod = [NSString stringWithFormat:@".%@", extension];

    return [string stringByAppendingString:extensionWithPeriod];
}

#pragma mark - Names

+ (NSString *)randomName
{
    // Turn list of names into NSArray
    NSArray  *namesArray = [kARRandomizerNameList componentsSeparatedByString:@","];

    // Get a random one
    NSString *randomName = namesArray[(arc4random() % namesArray.count)];

    return randomName;
}

#pragma mark - Numbers

+ (NSUInteger)randomIntegerBetween:(NSUInteger)from and:(NSUInteger)to
{
    if (from <= to) return 0;

    return (from + arc4random_uniform(to));
}

+ (CGFloat)randomFloatBetween:(CGFloat)from and:(CGFloat)to
{
    return ((double)arc4random() / ARC4RANDOM_MAX);
}

#pragma mark - Colors

+ (UIColor *)randomColor {
    return [self randomColorWithAlpha:1.0];
}

+ (UIColor *)randomColorWithAlpha:(CGFloat)alpha {
    CGFloat red   = [self randomFloatBetween:0 and:1];
    CGFloat green = [self randomFloatBetween:0 and:1];
    CGFloat blue  = [self randomFloatBetween:0 and:1];
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

@end
