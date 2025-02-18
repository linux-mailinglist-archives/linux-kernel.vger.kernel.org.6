Return-Path: <linux-kernel+bounces-519874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE447A3A304
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B52453A649A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70EF326B2D3;
	Tue, 18 Feb 2025 16:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sxquo0ol";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F29KfG2U"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF1414A4E7
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 16:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739896783; cv=none; b=ss4GVdBV/zL3nfkGUtWppNTRDW3lLvl/nGyfCH16RDg0tpFXt/STzOEKuE7rHX5CTwWbdILNGzaCOKji8g6dPpf1vg81MjMERazRxZCXAeGEiiQYfrui/SCwIMJcKI+3Nolh4JfqZFCzuYO1QTygGXD0HrtCYlCNEzQmEyrdW30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739896783; c=relaxed/simple;
	bh=HDJc7RtypDDPooB5e73rQOHBIRa4tufRX1lQCVmM6hg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jgJN7syuKoV22ZZOgjq1NGsqRZ8FzWf1FCSv6pNXv5Qq8dQO+s8+EMFw4mpVwePjXoHEoV0qN4Pom3jyvSw+dTygirFpcek31Pux499L/XiG0yjf3/L13waDdWzMUyFUkvwx6h8J2xrIPFhR4/ig4yNy0EL5tf48n2DHObr/LEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sxquo0ol; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F29KfG2U; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 17:39:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739896780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jplqvq9GdJOIcNd8y7Q+I1v34nlxrE0UMCPpI6JRAy0=;
	b=sxquo0olvHfg6ZLQrRK9a6jV+isPC4AxTWxinAp2m2c4goW35qpSsfIiKRDJr2CTxYJKlY
	vVX2FzOHE15XN+G1Mig7kARR46t0Q3nXP7SJAjdVzLq16VOUlNJG25bGlMOMxNjXsA3j8r
	p2azbaP1EmLb29MM9HwNSpAXelpQK4WoYHGb+DoUV/1vUXV31os0jF0VoPfEgDg7gFuC2g
	43t0mHMFKB+Cgu6Rd3ta2y4YbL2ZxA2Kd5weaijtwPm9tbRiVh786NGl653th0RL0wGQVL
	sz62KRWUJ9Po8+9SL64FFZfz4sFV826wfN4kWaidDSpBnNVQhVFyL2Bi+NXigw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739896780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jplqvq9GdJOIcNd8y7Q+I1v34nlxrE0UMCPpI6JRAy0=;
	b=F29KfG2U2uBQZdShRtGAIZfnCAHMy6m9mIPCAMKQQICoceeUlHJCESeun0as5H87r1xar4
	/cjY+2G+/LBTWqAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: syzbot <syzbot+ecccecbc636b455f9084@syzkaller.appspotmail.com>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, tj@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] kernfs: Drop kernfs_rwsem while invoking
 lookup_positive_unlocked().
Message-ID: <20250218163938.xmvjlJ0K@linutronix.de>
References: <67b45276.050a0220.173698.004f.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <67b45276.050a0220.173698.004f.GAE@google.com>

syzbot reported two warnings:
- kernfs_node::name was accessed outside of a RCU section so it created
  warning. The kernfs_rwsem was held so it was okay but it wasn't seen.

- While kernfs_rwsem was held invoked lookup_positive_unlocked()->
  kernfs_dop_revalidate() which acquired kernfs_rwsem.

kernfs_rwsem was both acquired as a read lock so it can be acquired
twice. However if a writer acquires the lock after the first reader then
neither the writer nor the second reader can obtain the lock so it
deadlocks.

The reason for the lock is to ensure that kernfs_node::name remain
stable during lookup_positive_unlocked()'s invocation. The function can
not be invoked within a RCU section because it may sleep.

Make a temporary copy of the kernfs_node::name under the lock so
GFP_KERNEL can be used and use this instead.

Reported-by: syzbot+ecccecbc636b455f9084@syzkaller.appspotmail.com
Fixes: 5b2fabf7fe8f ("kernfs: Acquire kernfs_rwsem in kernfs_node_dentry().")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 fs/kernfs/mount.c | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index d1f512b7bf867..f1cea282aae32 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -220,12 +220,19 @@ struct dentry *kernfs_node_dentry(struct kernfs_node *kn,
 		return dentry;
 
 	root = kernfs_root(kn);
-	guard(rwsem_read)(&root->kernfs_rwsem);
-
-	knparent = find_next_ancestor(kn, NULL);
-	if (WARN_ON(!knparent)) {
-		dput(dentry);
+	/*
+	 * As long as kn is valid, its parent can not vanish. This is cgroup's
+	 * kn so it not have its parent replaced. Therefore it is safe to use
+	 * the ancestor node outside of the RCU or locked section.
+	 */
+	if (WARN_ON_ONCE(!(root->flags & KERNFS_ROOT_INVARIANT_PARENT)))
 		return ERR_PTR(-EINVAL);
+	scoped_guard(rcu) {
+		knparent = find_next_ancestor(kn, NULL);
+		if (WARN_ON(!knparent)) {
+			dput(dentry);
+			return ERR_PTR(-EINVAL);
+		}
 	}
 
 	do {
@@ -235,14 +242,22 @@ struct dentry *kernfs_node_dentry(struct kernfs_node *kn,
 
 		if (kn == knparent)
 			return dentry;
-		kntmp = find_next_ancestor(kn, knparent);
-		if (WARN_ON(!kntmp)) {
-			dput(dentry);
-			return ERR_PTR(-EINVAL);
+
+		scoped_guard(rwsem_read, &root->kernfs_rwsem) {
+			kntmp = find_next_ancestor(kn, knparent);
+			if (WARN_ON(!kntmp)) {
+				dput(dentry);
+				return ERR_PTR(-EINVAL);
+			}
+			name = kstrdup(kernfs_rcu_name(kntmp), GFP_KERNEL);
+		}
+		if (!name) {
+			dput(dentry);
+			return ERR_PTR(-ENOMEM);
 		}
-		name = rcu_dereference(kntmp->name);
 		dtmp = lookup_positive_unlocked(name, dentry, strlen(name));
 		dput(dentry);
+		kfree(name);
 		if (IS_ERR(dtmp))
 			return dtmp;
 		knparent = kntmp;
-- 
2.47.2


