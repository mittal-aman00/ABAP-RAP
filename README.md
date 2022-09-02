# ABAP-RAP
ABAP RestFul Programming Model

In this course, we will follow the naming convention of the Virtual Data Model (VDM) of the SAP S/4HANA where the name of interface or BO views begins with <namespace>I (e.g ZI_) and the name of consumption or projection views begins with the namespace followed by <namespace>C (e.g. ZC_).

One of the main **differences between CDS DDIC-based view and CDS view entity**, is that the latter does not have an associated SQL view, and the name of the Data Definition object in the Project Explorer and the name of the CDS entity specified after the keyword DEFINE VIEW ENTITY are identical. This makes the lifecycle of CDS View entities way easier

**The projection layer**(Consumption Layer) is the first layer in the development flow of the ABAP RESTful Programming Model that is service specific. It contains service-specific fine-tuning which does not belong to the general data model layer, for example UI annotations, value helps, calculations or defaulting. The projection layer also enables one business object to be exposed using different OData service types, e.g. for a SAP Fiori UI or a stable Web API.
With projection views, you can expose only those elements that are relevant for the specific service. You can de-normalize the underlying data model and also define fine-tuning such as virtual elements, value helps, search and UI semantics.

  In contrast to "normal" CDS views that read data from the database from tables or other CDS views the so called **custom entities** act as a wrapper for a code based implementation that provides the data instead of a database table or a CDS view. The **custom entity** has to be created manually and it uses a similar syntax as the abstract entity that has been created when we have created our service consumption model.
