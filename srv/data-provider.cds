using { Orders as ord } from '../db/data-model';

service MaterialAnalysis {
entity Orders as projection on ord;
}