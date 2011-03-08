module lang::oberon0::l4::normalize::Normalize

import lang::oberon0::l4::ast::Oberon0;
extend lang::oberon0::l3::normalize::Normalize;


public Module normalizeL4(Module m) {
	return normalize(normalizeSelectors(m));
}

public Module normalizeSelectors(Module m) {
	return visit (m) {
		case assign(v, e) => assign(v, [], e)
		case lookup(v) => lookup(v, [])
	}
}