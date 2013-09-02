#/usr/bin/python
""" 
Author: David Benson (dbenson@tssg.org)
Date: 02/09/2013

Description: This python module is responsible for storing information about all
solar systems within the eve universe.
"""

class System:
    """
    Class representation of Eve Solar Systems.

    @Variable solar_system_name the string name of a system.
    @Variable alliance_id eve unique identifier for player alliances holding sovereignty.
    @Variable faction_id eve unique identifier for npc factions holding sovereignty.
    @Variable corporation_id eve unique identifier for player corporation holding sovereignty.
    @Variable ship_kills the amount of ship kills in the last hour.
    @Variable pod_kills the amount of pod kills in the last hour.
    @Variable system_jumps the amount of ingress/egress jumps in the system in the last hour.
    """
    def __init__(self, solar_system_name, alliance_id, faction_id, corporation_id):
        # Constructor that populates system information.
        self.solar_system_name = solar_system_name
        self.corporation_id = corporation_id
        self.alliance_id = alliance_id
        self.faction_id = faction_id

    def __repr__(self):
        # Return a string representation of the object.
        return "{%s, %s, %s, %s}" % (self.solar_system_name, self.corporation_id, self.alliance_id, 
            self.faction_id)
