#/usr/bin/python
""" 
Author: David Benson (dbenson@tssg.org)
Date: 02/09/2013

Description: This python module is responsible for storing information about all
systems within the eve universe.
"""
import system
import datetime
import evelink.api

class EveUniverse:
    """ This class acts as a storage class for the all the space systems in Eve Online.
    A very simple version control system is implemented using timestamps.
    """
    def __init__(self):
        # Constructor intialises empty array, the last updated timestamp and the connection to Eve APIs.
        self.systems = {}
        self.api = evelink.api.API()
        self.current_timestamp = datetime.datetime.now()

    def retrieve_systems(self):
        # Method returns a list of all systems from eve api.
        response = self.api.get('map/Sovereignty')
        for item in response.iter('row'):
            temp = system.System(item.attrib['solarSystemName'],
                item.attrib['allianceID'], item.attrib['factionID'], item.attrib['corporationID'])
            self.systems[item.attrib['solarSystemID']] = temp
        self.current_timestamp = datetime.datetime.now()

    def __repr__(self):
        # Presents a string representation of the object.
        result = "Last Updated: %s \n" % self.current_timestamp
        result += self.systems.__str__() 
        return result     

sys = EveUniverse()
sys.retrieve_systems()
print(sys.__repr__())