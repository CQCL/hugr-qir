use anyhow::{anyhow, Result};
use hugr::algorithms::call_graph::{CallGraph, CallGraphEdge};
use hugr::hugr::hugrmut::HugrMut;
use hugr::hugr::rewrite::inline_call::InlineCall;
use hugr::Node;
use petgraph::algo::toposort;
use petgraph::visit::{EdgeFiltered, IntoEdges};

pub fn inline(hugr: &mut impl HugrMut, nodes: Vec<Node>) -> Result<()> {
    // Check all nodes are call nodes
    for node in &nodes {
        if !hugr.get_optype(*node).is_call() {
            return Err(anyhow!("node type mismatch"));
        }
    }
    // Construct a call graph for HUGR and filter out calls not in nodes
    let call_graph = CallGraph::new(hugr);
    let filtered_call_graph = EdgeFiltered::from_fn(call_graph.graph(), |e| match e.weight() {
        CallGraphEdge::Call(n) => nodes.contains(n),
        _ => false,
    });
    // We visit each call in reverse topological order, so that we always inline a call
    // before its parent function
    let to_inline = toposort(&filtered_call_graph, None)
        .map_err(|e| anyhow!("Call graph is recursive: {e:?}"))?;
    for func_index in to_inline.iter().rev() {
        for call in filtered_call_graph.edges(*func_index) {
            if let CallGraphEdge::Call(n) = call.weight() {
                let rewrite = InlineCall::new(*n);
                hugr.apply_rewrite(rewrite)?;
            }
        }
    }
    Ok(())
}
