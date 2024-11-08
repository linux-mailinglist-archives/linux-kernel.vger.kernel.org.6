Return-Path: <linux-kernel+bounces-401402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E01269C19C6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 11:05:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EDB01C20C46
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 10:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3571E22ED;
	Fri,  8 Nov 2024 10:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2urPhrN3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+9ZlFlzH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006801D0BA6
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 10:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731060309; cv=none; b=JGMRg3B/r+YfCSY+0leuOWF3wCWyNi210zakIDhhN+NAIwz18RLJ8I1djVSP77GbK9hjXbf1r91q1wudgrE2p0uPPNXARUesI0TCiGecbDcgJVFcoivxL0nz+OaiSE0cWck6OspNvZiWJ6W99NAqJKJp+i/Z772Eh5pFfcl1mEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731060309; c=relaxed/simple;
	bh=uOizpovPZs2AG9vcutQhYXA+0tp1QUnBSgy+6HlOsxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QYyXy4Vxr7Femsm0WvlHIxmCODPP1oj9n81M8RicF5adxHMJmrnWHZFp3G0oH1sXUbpwsFD2IWJ1haUpCow9BmWrg0xWaavsiSaqOpCh8XFosAhe70cakCkqdQJKk7zclEQ5kkC+tIIzFoaI4iw6Mo9hZp9imWyLtmE5FQQOMcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2urPhrN3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+9ZlFlzH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 8 Nov 2024 11:05:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731060304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6ecpDK1l+RKjz/ul7Cm8X2Ur8LB7TEoY7w+OSXAPxKE=;
	b=2urPhrN3xEJXTBehPkbz11LhlALYpeJWG3mIsuV/OV6YsJg0vxsgj6qxDhGM6n2fkOmLqJ
	P/1WvGp2WwAkNiV7S5ppKLyLA824k4X/6FQmedecLZWcUAnEaHJpM6ujsS1AbN5J2TFfdP
	MDoiLiezJJIfFmJHD72gyAR+D1NktRWg3qsFxZHU4I9r0dQKs5kxCRXGFPxqYPQ3i5W82k
	d2Yj2k7ljOXg18F5igndkseLUN0KJfa29toPicvydrxY/5AhRnBzfOK4S3u1R16NL6zTix
	kn5Qo1JFuUBCa+Y2ysWhFUk6Xch0A9hl5RBBQ6ArIAVBlyGJB8vGyAaMh6cmYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731060304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6ecpDK1l+RKjz/ul7Cm8X2Ur8LB7TEoY7w+OSXAPxKE=;
	b=+9ZlFlzHuDnEji79So9216PuMUxrDB5ymj9ResA+v0758f2R052xbDPby4F/RvRAUwFiKi
	r7SQHTdJy+jnVXDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Tejun Heo <tj@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org, tglx@linutronix.de,
	syzbot <syzbot+6ea37e2e6ffccf41a7e6@syzkaller.appspotmail.com>
Subject: Re: [BUG] -next lockdep invalid wait context
Message-ID: <20241108100503.H-__545n@linutronix.de>
References: <41619255-cdc2-4573-a360-7794fc3614f7@paulmck-laptop>
 <e06d69c9-f067-45c6-b604-fd340c3bd612@suse.cz>
 <ZyK0YPgtWExT4deh@elver.google.com>
 <66a745bb-d381-471c-aeee-3800a504f87d@paulmck-laptop>
 <20241102001224.2789-1-hdanton@sina.com>
 <ZyV2DfuIPsISds-1@Boquns-Mac-mini.local>
 <ZykNhbMOrlgCXFYJ@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZykNhbMOrlgCXFYJ@slm.duckdns.org>

On 2024-11-04 08:08:05 [-1000], Tejun Heo wrote:
> Yeah, we should be able to make kn->name RCU protected and drop the usage of
> the rename lock in read paths.

Something like this maybe? There are a few rcu_dereference_check(, true)
in there because there seems not be any locking so it might not be
needed but I don't know why.
I added "down_read(&root->kernfs_rwsem)" to kernfs_notify_workfn() for
the name lookup, I don't think kernfs_supers_rwsem implies this.
I dropped up_read(&root->kernfs_rwsem) from kernfs_fop_readdir() during
dir_emit(). I *think* that a rename could happen while the lock is
dropped and I can't have RCU here because of the page fault in
dir_emit().

I didn't see anything complains with this so far. I had just a few
renames during boot for the network interfaces, so it is not excessive
testing.

---
 fs/kernfs/dir.c             | 141 +++++++++++++++++++-----------------
 fs/kernfs/file.c            |   6 +-
 fs/kernfs/kernfs-internal.h |  23 +++++-
 fs/kernfs/mount.c           |  17 +++--
 fs/kernfs/symlink.c         |  27 +++----
 include/linux/kernfs.h      |   4 +-
 6 files changed, 128 insertions(+), 90 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 458519e416fe7..a4ea5114cba2c 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -17,7 +17,6 @@
 
 #include "kernfs-internal.h"
 
-static DEFINE_RWLOCK(kernfs_rename_lock);	/* kn->parent and ->name */
 /*
  * Don't use rename_lock to piggy back on pr_cont_buf. We don't want to
  * call pr_cont() while holding rename_lock. Because sometimes pr_cont()
@@ -53,10 +52,15 @@ static bool kernfs_lockdep(struct kernfs_node *kn)
 
 static int kernfs_name_locked(struct kernfs_node *kn, char *buf, size_t buflen)
 {
+	struct kernfs_node *kn_parent;
+	const char *kn_name;
+
 	if (!kn)
 		return strscpy(buf, "(null)", buflen);
 
-	return strscpy(buf, kn->parent ? kn->name : "/", buflen);
+	kn_parent = rcu_dereference(kn->parent);
+	kn_name = rcu_dereference(kn->name);
+	return strscpy(buf, kn_parent ? kn_name : "/", buflen);
 }
 
 /* kernfs_node_depth - compute depth from @from to @to */
@@ -66,7 +70,7 @@ static size_t kernfs_depth(struct kernfs_node *from, struct kernfs_node *to)
 
 	while (to->parent && to != from) {
 		depth++;
-		to = to->parent;
+		to = rcu_dereference(to->parent);
 	}
 	return depth;
 }
@@ -84,18 +88,18 @@ static struct kernfs_node *kernfs_common_ancestor(struct kernfs_node *a,
 	db = kernfs_depth(rb->kn, b);
 
 	while (da > db) {
-		a = a->parent;
+		a = rcu_dereference(a->parent);
 		da--;
 	}
 	while (db > da) {
-		b = b->parent;
+		b = rcu_dereference(b->parent);
 		db--;
 	}
 
 	/* worst case b and a will be the same at root */
 	while (b != a) {
-		b = b->parent;
-		a = a->parent;
+		b = rcu_dereference(b->parent);
+		a = rcu_dereference(a->parent);
 	}
 
 	return a;
@@ -169,9 +173,9 @@ static int kernfs_path_from_node_locked(struct kernfs_node *kn_to,
 	/* Calculate how many bytes we need for the rest */
 	for (i = depth_to - 1; i >= 0; i--) {
 		for (kn = kn_to, j = 0; j < i; j++)
-			kn = kn->parent;
+			kn = rcu_dereference(kn->parent);
 
-		len += scnprintf(buf + len, buflen - len, "/%s", kn->name);
+		len += scnprintf(buf + len, buflen - len, "/%s", rcu_dereference(kn->name));
 	}
 
 	return len;
@@ -195,12 +199,11 @@ static int kernfs_path_from_node_locked(struct kernfs_node *kn_to,
  */
 int kernfs_name(struct kernfs_node *kn, char *buf, size_t buflen)
 {
-	unsigned long flags;
 	int ret;
 
-	read_lock_irqsave(&kernfs_rename_lock, flags);
+	rcu_read_lock();
 	ret = kernfs_name_locked(kn, buf, buflen);
-	read_unlock_irqrestore(&kernfs_rename_lock, flags);
+	rcu_read_unlock();
 	return ret;
 }
 
@@ -223,12 +226,11 @@ int kernfs_name(struct kernfs_node *kn, char *buf, size_t buflen)
 int kernfs_path_from_node(struct kernfs_node *to, struct kernfs_node *from,
 			  char *buf, size_t buflen)
 {
-	unsigned long flags;
 	int ret;
 
-	read_lock_irqsave(&kernfs_rename_lock, flags);
+	rcu_read_lock();
 	ret = kernfs_path_from_node_locked(to, from, buf, buflen);
-	read_unlock_irqrestore(&kernfs_rename_lock, flags);
+	rcu_read_unlock();
 	return ret;
 }
 EXPORT_SYMBOL_GPL(kernfs_path_from_node);
@@ -292,12 +294,11 @@ void pr_cont_kernfs_path(struct kernfs_node *kn)
 struct kernfs_node *kernfs_get_parent(struct kernfs_node *kn)
 {
 	struct kernfs_node *parent;
-	unsigned long flags;
 
-	read_lock_irqsave(&kernfs_rename_lock, flags);
-	parent = kn->parent;
+	rcu_read_lock();
+	parent = rcu_dereference(kn->parent);
 	kernfs_get(parent);
-	read_unlock_irqrestore(&kernfs_rename_lock, flags);
+	rcu_read_unlock();
 
 	return parent;
 }
@@ -336,13 +337,13 @@ static int kernfs_name_compare(unsigned int hash, const char *name,
 		return -1;
 	if (ns > kn->ns)
 		return 1;
-	return strcmp(name, kn->name);
+	return strcmp(name, kernfs_rcu_get_name(kn));
 }
 
 static int kernfs_sd_compare(const struct kernfs_node *left,
 			     const struct kernfs_node *right)
 {
-	return kernfs_name_compare(left->hash, left->name, left->ns, right);
+	return kernfs_name_compare(left->hash, kernfs_rcu_get_name(left), left->ns, right);
 }
 
 /**
@@ -360,9 +361,12 @@ static int kernfs_sd_compare(const struct kernfs_node *left,
  */
 static int kernfs_link_sibling(struct kernfs_node *kn)
 {
-	struct rb_node **node = &kn->parent->dir.children.rb_node;
+	struct kernfs_node *node_parent;
 	struct rb_node *parent = NULL;
+	struct rb_node **node;
 
+	node_parent = kernfs_rcu_get_parent(kn);
+	node = &node_parent->dir.children.rb_node;
 	while (*node) {
 		struct kernfs_node *pos;
 		int result;
@@ -380,13 +384,13 @@ static int kernfs_link_sibling(struct kernfs_node *kn)
 
 	/* add new node and rebalance the tree */
 	rb_link_node(&kn->rb, parent, node);
-	rb_insert_color(&kn->rb, &kn->parent->dir.children);
+	rb_insert_color(&kn->rb, &node_parent->dir.children);
 
 	/* successfully added, account subdir number */
 	down_write(&kernfs_root(kn)->kernfs_iattr_rwsem);
 	if (kernfs_type(kn) == KERNFS_DIR)
-		kn->parent->dir.subdirs++;
-	kernfs_inc_rev(kn->parent);
+		node_parent->dir.subdirs++;
+	kernfs_inc_rev(node_parent);
 	up_write(&kernfs_root(kn)->kernfs_iattr_rwsem);
 
 	return 0;
@@ -407,16 +411,19 @@ static int kernfs_link_sibling(struct kernfs_node *kn)
  */
 static bool kernfs_unlink_sibling(struct kernfs_node *kn)
 {
+	struct kernfs_node *node_parent;
+
 	if (RB_EMPTY_NODE(&kn->rb))
 		return false;
 
 	down_write(&kernfs_root(kn)->kernfs_iattr_rwsem);
+	node_parent = kernfs_rcu_get_parent(kn);
 	if (kernfs_type(kn) == KERNFS_DIR)
-		kn->parent->dir.subdirs--;
-	kernfs_inc_rev(kn->parent);
+		node_parent->dir.subdirs--;
+	kernfs_inc_rev(node_parent);
 	up_write(&kernfs_root(kn)->kernfs_iattr_rwsem);
 
-	rb_erase(&kn->rb, &kn->parent->dir.children);
+	rb_erase(&kn->rb, &node_parent->dir.children);
 	RB_CLEAR_NODE(&kn->rb);
 	return true;
 }
@@ -533,7 +540,8 @@ static void kernfs_free_rcu(struct rcu_head *rcu)
 {
 	struct kernfs_node *kn = container_of(rcu, struct kernfs_node, rcu);
 
-	kfree_const(kn->name);
+	/* If the whole node goes away, the name can't be used outside */
+	kfree_const(rcu_dereference_check(kn->name, true));
 
 	if (kn->iattr) {
 		simple_xattrs_free(&kn->iattr->xattrs, NULL);
@@ -556,17 +564,19 @@ void kernfs_put(struct kernfs_node *kn)
 
 	if (!kn || !atomic_dec_and_test(&kn->count))
 		return;
+
+	rcu_read_lock();
 	root = kernfs_root(kn);
  repeat:
 	/*
 	 * Moving/renaming is always done while holding reference.
 	 * kn->parent won't change beneath us.
 	 */
-	parent = kn->parent;
+	parent = rcu_dereference(kn->parent);
 
 	WARN_ONCE(atomic_read(&kn->active) != KN_DEACTIVATED_BIAS,
 		  "kernfs_put: %s/%s: released with incorrect active_ref %d\n",
-		  parent ? parent->name : "", kn->name, atomic_read(&kn->active));
+		  parent ? rcu_dereference(parent->name) : "", kn->name, atomic_read(&kn->active));
 
 	if (kernfs_type(kn) == KERNFS_LINK)
 		kernfs_put(kn->symlink.target_kn);
@@ -586,6 +596,7 @@ void kernfs_put(struct kernfs_node *kn)
 		idr_destroy(&root->ino_idr);
 		kfree_rcu(root, rcu);
 	}
+	rcu_read_unlock();
 }
 EXPORT_SYMBOL_GPL(kernfs_put);
 
@@ -643,7 +654,7 @@ static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
 	atomic_set(&kn->active, KN_DEACTIVATED_BIAS);
 	RB_CLEAR_NODE(&kn->rb);
 
-	kn->name = name;
+	rcu_assign_pointer(kn->name, name);
 	kn->mode = mode;
 	kn->flags = flags;
 
@@ -701,7 +712,7 @@ struct kernfs_node *kernfs_new_node(struct kernfs_node *parent,
 			       name, mode, uid, gid, flags);
 	if (kn) {
 		kernfs_get(parent);
-		kn->parent = parent;
+		rcu_assign_pointer(kn->parent, parent);
 	}
 	return kn;
 }
@@ -769,12 +780,14 @@ struct kernfs_node *kernfs_find_and_get_node_by_id(struct kernfs_root *root,
  */
 int kernfs_add_one(struct kernfs_node *kn)
 {
-	struct kernfs_node *parent = kn->parent;
-	struct kernfs_root *root = kernfs_root(parent);
+	struct kernfs_node *parent;
+	struct kernfs_root *root;
 	struct kernfs_iattrs *ps_iattr;
 	bool has_ns;
 	int ret;
 
+	parent = rcu_dereference_check(kn->parent, true);
+	root = kernfs_root(parent);
 	down_write(&root->kernfs_rwsem);
 
 	ret = -EINVAL;
@@ -790,7 +803,7 @@ int kernfs_add_one(struct kernfs_node *kn)
 	if (parent->flags & (KERNFS_REMOVING | KERNFS_EMPTY_DIR))
 		goto out_unlock;
 
-	kn->hash = kernfs_name_hash(kn->name, kn->ns);
+	kn->hash = kernfs_name_hash(kernfs_rcu_get_name(kn), kn->ns);
 
 	ret = kernfs_link_sibling(kn);
 	if (ret)
@@ -1111,6 +1124,7 @@ struct kernfs_node *kernfs_create_empty_dir(struct kernfs_node *parent,
 
 static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
 {
+	struct kernfs_node *parent;
 	struct kernfs_node *kn;
 	struct kernfs_root *root;
 
@@ -1119,8 +1133,6 @@ static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
 
 	/* Negative hashed dentry? */
 	if (d_really_is_negative(dentry)) {
-		struct kernfs_node *parent;
-
 		/* If the kernfs parent node has changed discard and
 		 * proceed to ->lookup.
 		 *
@@ -1162,16 +1174,17 @@ static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
 	if (!kernfs_active(kn))
 		goto out_bad;
 
+	parent = kernfs_rcu_get_parent(kn);
 	/* The kernfs node has been moved? */
-	if (kernfs_dentry_node(dentry->d_parent) != kn->parent)
+	if (kernfs_dentry_node(dentry->d_parent) != parent)
 		goto out_bad;
 
 	/* The kernfs node has been renamed */
-	if (strcmp(dentry->d_name.name, kn->name) != 0)
+	if (strcmp(dentry->d_name.name, kernfs_rcu_get_name(kn)) != 0)
 		goto out_bad;
 
 	/* The kernfs node has been moved to a different namespace */
-	if (kn->parent && kernfs_ns_enabled(kn->parent) &&
+	if (parent && kernfs_ns_enabled(parent) &&
 	    kernfs_info(dentry->d_sb)->ns != kn->ns)
 		goto out_bad;
 
@@ -1364,7 +1377,7 @@ static struct kernfs_node *kernfs_next_descendant_post(struct kernfs_node *pos,
 		return kernfs_leftmost_descendant(rb_to_kn(rbn));
 
 	/* no sibling left, visit parent */
-	return pos->parent;
+	return kernfs_rcu_get_parent(pos);
 }
 
 static void kernfs_activate_one(struct kernfs_node *kn)
@@ -1490,8 +1503,11 @@ static void __kernfs_remove(struct kernfs_node *kn)
 		 * to decide who's responsible for cleanups.
 		 */
 		if (!pos->parent || kernfs_unlink_sibling(pos)) {
-			struct kernfs_iattrs *ps_iattr =
-				pos->parent ? pos->parent->iattr : NULL;
+			struct kernfs_iattrs *ps_iattr;
+			struct kernfs_node *parent;
+
+			parent = kernfs_rcu_get_parent(pos);
+			ps_iattr = parent ? parent->iattr : NULL;
 
 			/* update timestamps on the parent */
 			down_write(&kernfs_root(kn)->kernfs_iattr_rwsem);
@@ -1733,8 +1749,10 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct kernfs_node *new_parent,
 		goto out;
 
 	error = 0;
-	if ((kn->parent == new_parent) && (kn->ns == new_ns) &&
-	    (strcmp(kn->name, new_name) == 0))
+	old_parent = kernfs_rcu_get_parent(kn);
+	old_name = kernfs_rcu_get_name(kn);
+	if ((old_parent == new_parent) && (kn->ns == new_ns) &&
+	    (strcmp(old_name, new_name) == 0))
 		goto out;	/* nothing to rename */
 
 	error = -EEXIST;
@@ -1742,7 +1760,7 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct kernfs_node *new_parent,
 		goto out;
 
 	/* rename kernfs_node */
-	if (strcmp(kn->name, new_name) != 0) {
+	if (strcmp(old_name, new_name) != 0) {
 		error = -ENOMEM;
 		new_name = kstrdup_const(new_name, GFP_KERNEL);
 		if (!new_name)
@@ -1757,25 +1775,18 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct kernfs_node *new_parent,
 	kernfs_unlink_sibling(kn);
 	kernfs_get(new_parent);
 
-	/* rename_lock protects ->parent and ->name accessors */
-	write_lock_irq(&kernfs_rename_lock);
-
-	old_parent = kn->parent;
-	kn->parent = new_parent;
+	rcu_assign_pointer(kn->parent, new_parent);
 
 	kn->ns = new_ns;
-	if (new_name) {
-		old_name = kn->name;
-		kn->name = new_name;
-	}
+	if (new_name)
+		rcu_assign_pointer(kn->name, new_name);
 
-	write_unlock_irq(&kernfs_rename_lock);
-
-	kn->hash = kernfs_name_hash(kn->name, kn->ns);
+	kn->hash = kernfs_name_hash(kernfs_rcu_get_name(kn), kn->ns);
 	kernfs_link_sibling(kn);
 
 	kernfs_put(old_parent);
-	kfree_const(old_name);
+	if (new_name && !is_kernel_rodata((unsigned long)old_name))
+		kfree_rcu_mightsleep(old_name);
 
 	error = 0;
  out:
@@ -1794,7 +1805,7 @@ static struct kernfs_node *kernfs_dir_pos(const void *ns,
 {
 	if (pos) {
 		int valid = kernfs_active(pos) &&
-			pos->parent == parent && hash == pos->hash;
+			kernfs_rcu_get_parent(pos) == parent && hash == pos->hash;
 		kernfs_put(pos);
 		if (!valid)
 			pos = NULL;
@@ -1859,7 +1870,7 @@ static int kernfs_fop_readdir(struct file *file, struct dir_context *ctx)
 	for (pos = kernfs_dir_pos(ns, parent, ctx->pos, pos);
 	     pos;
 	     pos = kernfs_dir_next_pos(ns, parent, ctx->pos, pos)) {
-		const char *name = pos->name;
+		const char *name = kernfs_rcu_get_name(pos);
 		unsigned int type = fs_umode_to_dtype(pos->mode);
 		int len = strlen(name);
 		ino_t ino = kernfs_ino(pos);
@@ -1868,10 +1879,10 @@ static int kernfs_fop_readdir(struct file *file, struct dir_context *ctx)
 		file->private_data = pos;
 		kernfs_get(pos);
 
-		up_read(&root->kernfs_rwsem);
-		if (!dir_emit(ctx, name, len, ino, type))
+		if (!dir_emit(ctx, name, len, ino, type)) {
+			up_read(&root->kernfs_rwsem);
 			return 0;
-		down_read(&root->kernfs_rwsem);
+		}
 	}
 	up_read(&root->kernfs_rwsem);
 	file->private_data = NULL;
diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 8502ef68459b9..8672264c166ca 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -911,9 +911,11 @@ static void kernfs_notify_workfn(struct work_struct *work)
 	/* kick fsnotify */
 
 	down_read(&root->kernfs_supers_rwsem);
+	down_read(&root->kernfs_rwsem);
 	list_for_each_entry(info, &kernfs_root(kn)->supers, node) {
 		struct kernfs_node *parent;
 		struct inode *p_inode = NULL;
+		const char *kn_name;
 		struct inode *inode;
 		struct qstr name;
 
@@ -927,7 +929,8 @@ static void kernfs_notify_workfn(struct work_struct *work)
 		if (!inode)
 			continue;
 
-		name = (struct qstr)QSTR_INIT(kn->name, strlen(kn->name));
+		kn_name = kernfs_rcu_get_name(kn);
+		name = (struct qstr)QSTR_INIT(kn_name, strlen(kn_name));
 		parent = kernfs_get_parent(kn);
 		if (parent) {
 			p_inode = ilookup(info->sb, kernfs_ino(parent));
@@ -947,6 +950,7 @@ static void kernfs_notify_workfn(struct work_struct *work)
 		iput(inode);
 	}
 
+	up_read(&root->kernfs_rwsem);
 	up_read(&root->kernfs_supers_rwsem);
 	kernfs_put(kn);
 	goto repeat;
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index b42ee6547cdc1..847e3cc7c903a 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -64,11 +64,13 @@ struct kernfs_root {
  *
  * Return: the kernfs_root @kn belongs to.
  */
-static inline struct kernfs_root *kernfs_root(struct kernfs_node *kn)
+static inline struct kernfs_root *kernfs_root(const struct kernfs_node *kn)
 {
+	struct kernfs_node *parent;
 	/* if parent exists, it's always a dir; otherwise, @sd is a dir */
-	if (kn->parent)
-		kn = kn->parent;
+	parent = rcu_dereference_check(kn->parent, true);
+	if (parent)
+		kn = parent;
 	return kn->dir.root;
 }
 
@@ -97,6 +99,21 @@ struct kernfs_super_info {
 };
 #define kernfs_info(SB) ((struct kernfs_super_info *)(SB->s_fs_info))
 
+static inline bool kernfs_root_is_locked(const struct kernfs_node *kn)
+{
+       return lockdep_is_held(&kernfs_root(kn)->kernfs_rwsem);
+}
+
+static inline struct kernfs_node *kernfs_rcu_get_parent(struct kernfs_node *kn)
+{
+       return rcu_dereference_check(kn->parent, kernfs_root_is_locked(kn));
+}
+
+static inline const char *kernfs_rcu_get_name(const struct kernfs_node *kn)
+{
+       return rcu_dereference_check(kn->name, kernfs_root_is_locked(kn));
+}
+
 static inline struct kernfs_node *kernfs_dentry_node(struct dentry *dentry)
 {
 	if (d_really_is_negative(dentry))
diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index 1358c21837f1a..de12915d20d68 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -146,7 +146,8 @@ static struct dentry *kernfs_get_parent_dentry(struct dentry *child)
 {
 	struct kernfs_node *kn = kernfs_dentry_node(child);
 
-	return d_obtain_alias(kernfs_get_inode(child->d_sb, kn->parent));
+	return d_obtain_alias(kernfs_get_inode(child->d_sb,
+					       rcu_dereference_check(kn->parent, true)));
 }
 
 static const struct export_operations kernfs_export_ops = {
@@ -181,15 +182,18 @@ struct kernfs_root *kernfs_root_from_sb(struct super_block *sb)
 static struct kernfs_node *find_next_ancestor(struct kernfs_node *child,
 					      struct kernfs_node *parent)
 {
+	struct kernfs_node *childs_parent;
+
 	if (child == parent) {
 		pr_crit_once("BUG in find_next_ancestor: called with parent == child");
 		return NULL;
 	}
 
-	while (child->parent != parent) {
-		if (!child->parent)
+	childs_parent = rcu_dereference_check(child->parent, true);
+	while (childs_parent != parent) {
+		if (!childs_parent)
 			return NULL;
-		child = child->parent;
+		childs_parent = rcu_dereference_check(child->parent, true);
 	}
 
 	return child;
@@ -225,6 +229,7 @@ struct dentry *kernfs_node_dentry(struct kernfs_node *kn,
 	do {
 		struct dentry *dtmp;
 		struct kernfs_node *kntmp;
+		const char *name;
 
 		if (kn == knparent)
 			return dentry;
@@ -233,8 +238,8 @@ struct dentry *kernfs_node_dentry(struct kernfs_node *kn,
 			dput(dentry);
 			return ERR_PTR(-EINVAL);
 		}
-		dtmp = lookup_positive_unlocked(kntmp->name, dentry,
-					       strlen(kntmp->name));
+		name = rcu_dereference_check(kntmp->name, true);
+		dtmp = lookup_positive_unlocked(name, dentry, strlen(name));
 		dput(dentry);
 		if (IS_ERR(dtmp))
 			return dtmp;
diff --git a/fs/kernfs/symlink.c b/fs/kernfs/symlink.c
index 45371a70caa71..f98725853c4eb 100644
--- a/fs/kernfs/symlink.c
+++ b/fs/kernfs/symlink.c
@@ -62,10 +62,10 @@ static int kernfs_get_target_path(struct kernfs_node *parent,
 
 	/* go up to the root, stop at the base */
 	base = parent;
-	while (base->parent) {
-		kn = target->parent;
-		while (kn->parent && base != kn)
-			kn = kn->parent;
+	while (kernfs_rcu_get_parent(base)) {
+		kn = kernfs_rcu_get_parent(target);
+		while (kernfs_rcu_get_parent(kn) && base != kn)
+			kn = kernfs_rcu_get_parent(kn);
 
 		if (base == kn)
 			break;
@@ -75,14 +75,14 @@ static int kernfs_get_target_path(struct kernfs_node *parent,
 
 		strcpy(s, "../");
 		s += 3;
-		base = base->parent;
+		base = kernfs_rcu_get_parent(base);
 	}
 
 	/* determine end of target string for reverse fillup */
 	kn = target;
-	while (kn->parent && kn != base) {
-		len += strlen(kn->name) + 1;
-		kn = kn->parent;
+	while (kernfs_rcu_get_parent(kn) && kn != base) {
+		len += strlen(kernfs_rcu_get_name(kn)) + 1;
+		kn = kernfs_rcu_get_parent(kn);
 	}
 
 	/* check limits */
@@ -94,15 +94,16 @@ static int kernfs_get_target_path(struct kernfs_node *parent,
 
 	/* reverse fillup of target string from target to base */
 	kn = target;
-	while (kn->parent && kn != base) {
-		int slen = strlen(kn->name);
+	while (kernfs_rcu_get_parent(kn) && kn != base) {
+		const char *name = kernfs_rcu_get_name(kn);
+		int slen = strlen(name);
 
 		len -= slen;
-		memcpy(s + len, kn->name, slen);
+		memcpy(s + len, name, slen);
 		if (len)
 			s[--len] = '/';
 
-		kn = kn->parent;
+		kn = kernfs_rcu_get_parent(kn);
 	}
 
 	return 0;
@@ -111,7 +112,7 @@ static int kernfs_get_target_path(struct kernfs_node *parent,
 static int kernfs_getlink(struct inode *inode, char *path)
 {
 	struct kernfs_node *kn = inode->i_private;
-	struct kernfs_node *parent = kn->parent;
+	struct kernfs_node *parent = rcu_dereference_check(kn->parent, true);
 	struct kernfs_node *target = kn->symlink.target_kn;
 	struct kernfs_root *root = kernfs_root(parent);
 	int error;
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 87c79d076d6d7..733d89de40542 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -199,8 +199,8 @@ struct kernfs_node {
 	 * never moved to a different parent, it is safe to access the
 	 * parent directly.
 	 */
-	struct kernfs_node	*parent;
-	const char		*name;
+	struct kernfs_node	__rcu *parent;
+	const char		__rcu *name;
 
 	struct rb_node		rb;
 
-- 
2.45.2


Sebastian

