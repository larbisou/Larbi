#include <iostream>
#include <sstream>
#include <string>

std::string createRequest( std::string user_patient,
                           std::string user_modalite,
                           std::string user_region) {
        
		std::stringstream requete;
        
        requete << "select serie.serie_id, patient.nom, region_anatomique.nom, type_acquisition.modalite from ";
        requete << " patient natural join etude  inner join region_anatomique on etude.region_id = region_anatomique.region_id natural join serie natural join type_acquisition where ";


        bool first = true;
        if (user_patient != "") {
                if (!first)
                        requete << " and ";
                first = false;
                requete << "  patient.nom = \"" << user_patient << "\"";
        }
        if (user_modalite != "") {
                if (!first)
                        requete << " and ";
                first = false;
                requete << " type_acquisition.modalite = \"" << user_modalite << "\"";
        }
        if (user_region != "") {
                if (!first)
                        requete << " and ";
                first = false;
                requete << " region_anatomique.nom = \"" << user_region << "\"";
        }
        
        return requete.str();

}


int main(int argc, char **argv) {

        std::string requete = createRequest("", "IRM", "Thyroide");
        std::cout << "la requête est " << std::endl;
        std::cout << requete << std::endl;

		requete = createRequest("", "", "coeur");
        std::cout << "la requête est " << std::endl;
        std::cout << requete << std::endl;

		requete = createRequest("Souhlal", "", "");
        std::cout << "la requête est " << std::endl;
        std::cout << requete << std::endl;


        return 0;
}
