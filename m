Return-Path: <linux-kernel+bounces-562770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9540FA6329D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 22:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7CC716D6A4
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 21:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887591A0BE0;
	Sat, 15 Mar 2025 21:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="e2qyhJAi"
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A3D19CCFC
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 21:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742075313; cv=none; b=G1gaviPz/9s/PeAzHAOZUPvuAgcZ4QEBPE8IVmLsaHDGvmAnQaJeEjV7oSeOhRelzfEYTKpBxQn/3w76cikSbfxGyhTVvmDrHcz+vASEDzRtWQDyAYxV6BJEaPoXCPsO1p7R9pEgI2wMJSBe8X4rdoa6LUClprisBHuLOqNVx7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742075313; c=relaxed/simple;
	bh=DPEr7dKBqwOvfdAJaiq7ssYD2lRbnJRZa052tQbVmm0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gAi8PkG+4lRZ/M3ljm0UNN5ejmIZALHS/6wthk1KzpSnb6hieUNQ0vnR5nUA0SRjlS+nIx3QsK9IWswqK/3J6M9zT0wSbs7OfOG9OuOH/4LqJXi8kUXAoenBwKg3/mHCEt/HA7kpNDsqCQQC7WsfUiMdBik/pKAaiLOpRd1SJL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=e2qyhJAi; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 24894240029
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 22:48:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1742075309; bh=DPEr7dKBqwOvfdAJaiq7ssYD2lRbnJRZa052tQbVmm0=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:From;
	b=e2qyhJAiGZQa79pWE3A5QEmm8cebE7GxWqDafr/9ijWfOmUWPH7rLjPBy6V20t1wm
	 i+fk26vSR2R0NyGQ4ks9ff+6SYF/yLWb718/IbXsqtvE58JWUtvEz+9ZC6oTcZOpLG
	 M5bd3fyhRq6d2uEucuO02EFt9FG78a2d9IZXLYg3yBQTQT/YpBdzpQP9Zf6jGgdm/G
	 e0liACJ4gBFL1gvIVhrwRyQCpPhgUk4Tp+kXRAtyBkgMXgSjFta2UrJz0yJyk5DkA1
	 nzng+OoDrWO30SIXq4oRlnzsg3+5b9EAlexzHLbnOM13EdZPDo4kmXnKHWNgOHxe2j
	 87KB3aH6wAVcA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4ZFZcC4NzJz6tw3;
	Sat, 15 Mar 2025 22:48:27 +0100 (CET)
From: Charalampos Mitrodimas <charmitro@posteo.net>
Date: Sat, 15 Mar 2025 21:48:11 +0000
Subject: [PATCH] rust: rbtree: fix comments referring to Box instead of
 KBox
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250315-rbtree-comment-fixes-v1-1-51f72c420ff0@posteo.net>
X-B4-Tracking: v=1; b=H4sIAJr11WcC/x3L3QpAQBCG4VvRHJuyWFq3Igd+PsyBpVlJyb3bH
 D69vQ8FqCBQkzykuCTI7iNMmtC49n4ByxRNeZbbrDCWdTgV4HHfNviTZ7kR2DnYqi5LZ5yluB6
 KP8Sz7d73Ay3qz9VmAAAA
X-Change-ID: 20250315-rbtree-comment-fixes-99e567449195
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742075307; l=2266;
 i=charmitro@posteo.net; s=20250315; h=from:subject:message-id;
 bh=DPEr7dKBqwOvfdAJaiq7ssYD2lRbnJRZa052tQbVmm0=;
 b=fcxvFHIeD8d3XYKp+WqpDbt3Mr9dhKWKPBhf9CZCcPUcHUZc6iotwfJhQ/ysJMbIsYzc1Ub3A
 Zp80Iq/RAy8AzUeaTahdv4bmsLnNPusOIHXjyrvGIgqlK7XOSvIF2fP
X-Developer-Key: i=charmitro@posteo.net; a=ed25519;
 pk=eTrChwENwXKiDOuJzxQN7RY0l7JF3/rO9B/pauP0ecw=

Several safety comments in the RBTree implementation still refer to
"Box::from_raw" and "Box::into_raw", but the code actually uses KBox.
These comments were not updated when the implementation transitioned
from using Box to KBox.

Fixes: 8373147ce496 ("rust: treewide: switch to our kernel `Box` type")
Signed-off-by: Charalampos Mitrodimas <charmitro@posteo.net>
---
 rust/kernel/rbtree.rs | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/rbtree.rs b/rust/kernel/rbtree.rs
index 0d1e75810664e18c0abe851ece2223d203721f79..a7ce512773563150fc2c290c544f20baad6509bf 100644
--- a/rust/kernel/rbtree.rs
+++ b/rust/kernel/rbtree.rs
@@ -1168,12 +1168,12 @@ impl<'a, K, V> RawVacantEntry<'a, K, V> {
     fn insert(self, node: RBTreeNode<K, V>) -> &'a mut V {
         let node = KBox::into_raw(node.node);
 
-        // SAFETY: `node` is valid at least until we call `Box::from_raw`, which only happens when
+        // SAFETY: `node` is valid at least until we call `KBox::from_raw`, which only happens when
         // the node is removed or replaced.
         let node_links = unsafe { addr_of_mut!((*node).links) };
 
         // INVARIANT: We are linking in a new node, which is valid. It remains valid because we
-        // "forgot" it with `Box::into_raw`.
+        // "forgot" it with `KBox::into_raw`.
         // SAFETY: The type invariants of `RawVacantEntry` are exactly the safety requirements of `rb_link_node`.
         unsafe { bindings::rb_link_node(node_links, self.parent, self.child_field_of_parent) };
 
@@ -1259,7 +1259,7 @@ pub fn remove(self) -> V {
     fn replace(self, node: RBTreeNode<K, V>) -> RBTreeNode<K, V> {
         let node = KBox::into_raw(node.node);
 
-        // SAFETY: `node` is valid at least until we call `Box::from_raw`, which only happens when
+        // SAFETY: `node` is valid at least until we call `KBox::from_raw`, which only happens when
         // the node is removed or replaced.
         let new_node_links = unsafe { addr_of_mut!((*node).links) };
 

---
base-commit: eb88e6bfbc0a975e08a18c39d1138d3e6cdc00a5
change-id: 20250315-rbtree-comment-fixes-99e567449195

Best regards,
-- 
Charalampos Mitrodimas <charmitro@posteo.net>


