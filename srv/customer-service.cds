using {com.lf as lf} from '../db/schema';

service CustomerService {
    entity CustomerSrv as projection on lf.Customer;
}
