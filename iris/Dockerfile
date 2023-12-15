ARG IMAGE=containers.intersystems.com/intersystems/iris-community:latest-cd
FROM $IMAGE

USER root

WORKDIR /opt/irisapp
RUN chown -R irisowner:irisowner /opt/irisapp

USER irisowner

# copy files to image
WORKDIR /opt/irisapp
COPY --chown=irisowner:irisowner src src

COPY --chown=$ISC_PACKAGE_MGRUSER:$ISC_PACKAGE_IRISGROUP /iris/irissession.sh /
RUN chmod +x /irissession.sh

COPY --chown=$ISC_PACKAGE_MGRUSER:$ISC_PACKAGE_IRISGROUP /iris/webapp.xml /
RUN chmod +x /webapp.xml

SHELL ["/irissession.sh"]

RUN \
zn "%SYS" \
set sc = $SYSTEM.OBJ.LoadDir("/opt/irisapp/src/Config", "ck", , 1) \
if sc do ##class(Config.Installer).Install() \
zn "LEARNING" \
do ##class(Ens.Util.LookupTable).%Import("/opt/irisapp/src/Lookup/ValorZona.xml") \
set sc = $SYSTEM.OBJ.LoadDir("/opt/irisapp/src/LEARNING", "ck", , 1) \
# start production
set production = "LEARNING.Production" \
set ^Ens.Configuration("csp","LastProduction") = production \
do ##class(Ens.Director).SetAutoStart(production) \
set sc = 1 \ 
zn "%SYS" \
do ##class(Security.Applications).Import("/webapp.xml",.n) \