
// RUN: %target-swift-frontend -module-name partial_apply_protocol_class_refinement_method -emit-silgen -enable-sil-ownership %s | %FileCheck %s

protocol P { func foo() }
protocol Q: class, P {}

// CHECK-LABEL: sil hidden @$S46partial_apply_protocol_class_refinement_method0A5ApplyyyycAA1Q_pF : $@convention
// CHECK: bb0([[ARG:%.*]] : @guaranteed $Q):
func partialApply(_ q: Q) -> () -> () {
  // CHECK: [[OPENED:%.*]] = open_existential_ref [[ARG]]
  // CHECK: [[TMP:%.*]] = alloc_stack 
  // CHECK: store_borrow [[OPENED]] to [[TMP:%.*]] :
  // CHECK: apply {{%.*}}<{{.*}}>([[TMP]])
  // CHECK-NEXT: dealloc_stack [[TMP]]
  return q.foo
}
