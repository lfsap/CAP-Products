using { sapbackend as external } from './external/sapbackend';

service SAPBackendExit{
    @cds.persistence: {
        table,
        skip: false
    }
    
    @cds.autoexpose
    entity Incidents as
        select from external.ZGW_INCIDENTS;
}