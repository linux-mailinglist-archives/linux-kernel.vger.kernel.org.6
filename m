Return-Path: <linux-kernel+bounces-402435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D41E9C2776
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 23:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96BA01C22978
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 22:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DC51E1C3F;
	Fri,  8 Nov 2024 22:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DprS641O";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IZVFvJtD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0931AA1FD
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 22:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731104652; cv=none; b=OlYoM+w0rYYGN09DA1JnEWKM+oSdyU06UJBrtAzmK5a9ttmU81EBBvLBtSPWGk5Wvu12ikgEqGpMRjM6FFgGD6EfGDAUivTeVuA6JJdzp6zNUEH7FgPGvxW/ciQ7dTFaHqLlV3PANTlxITSTuxP1UHkR1XrTqUEcWgql0z/Sjzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731104652; c=relaxed/simple;
	bh=VJyBh1pziz9q9COH0bwBsfgAHg0vv93Snu6nzilWJMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YqYR7SPdXnMvgqSRJSkU03up01dO0YEjtWnjFG27AGZvoUGuFYAbPCpQRkr6SVumeQOcDwiTecKu1I14P9RrHB5cUA8Drjw3Xic/ZexuXTgtEcSRTSoduwhOF4XWLgv4p51KXhB1ps3CK/QTwTg2MMtoW/DyBxoojMw/GHJosd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DprS641O; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IZVFvJtD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 8 Nov 2024 23:24:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731104648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uJHtUp4GxYjs2WAU7BIbnuJGIp4iQvhZJBuiibH6nHg=;
	b=DprS641O+KnQQg3klljSY/luk1bujx/lV8GILdh3iG4OGYrsqyzjIPAJPJjVOycPFppU5l
	6aVxZVocArxESTN/t+x8mZ9wZYkocuOd61xqO0aNpYeCpGAc8cr1vVJfYZS4gLKd7Ypski
	OzU68cG7EJGPIklK6WuQwbXCZh+swBcTRnW8H6DmUC7WmzU2za+zumhwfpzOr7KafBQ0Yc
	TciNPPrSdVoRJwGoT6gR14yiYfO4+rduJUkjO/KeiFbkXuF9zc/3A814HkBKoeHPpygGCY
	TCWGaEeaan8H0V4QfNML8PuKqzCxXcVndCMKmaUPfyXmVs39EsvYOkpxDpLHWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731104648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uJHtUp4GxYjs2WAU7BIbnuJGIp4iQvhZJBuiibH6nHg=;
	b=IZVFvJtDn7wT6Vw+kUT5j/vJ1IukbXN9Oaeh8+2nW90lIfHUk1VJnrgHUuBR+6l3cy2SXD
	rp9VcW2TjfK1cdBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Tejun Heo <tj@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org, tglx@linutronix.de,
	syzbot <syzbot+6ea37e2e6ffccf41a7e6@syzkaller.appspotmail.com>
Subject: [PATCH] kernfs: Use RCU for kernfs_node::name lookup.
Message-ID: <20241108222406.n5azgO98@linutronix.de>
References: <41619255-cdc2-4573-a360-7794fc3614f7@paulmck-laptop>
 <e06d69c9-f067-45c6-b604-fd340c3bd612@suse.cz>
 <ZyK0YPgtWExT4deh@elver.google.com>
 <66a745bb-d381-471c-aeee-3800a504f87d@paulmck-laptop>
 <20241102001224.2789-1-hdanton@sina.com>
 <ZyV2DfuIPsISds-1@Boquns-Mac-mini.local>
 <ZykNhbMOrlgCXFYJ@slm.duckdns.org>
 <20241108100503.H-__545n@linutronix.de>
 <Zy5EIHUwoXjK1sAJ@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zy5EIHUwoXjK1sAJ@slm.duckdns.org>

Instead of using kernfs_rename_lock for lookups of ::name use RCU for
lookup. Rely on kn's kernfs_root::kernfs_rwsem for update
synchronisation.

The .*_locked() have been moved into the callers.
The lock in kernfs_get_parent() has been dropped, the parent node should
node vanish underneath us. The RCU read-lock and atomic_inc_not_zero()
is a safety net in case it does.
kernfs_fop_readdir() no longer drops kernfs_root::kernfs_rwsem to ensure
the name pointer does not vanish while the page fault is handled.
kernfs_notify_workfn() gained the lock for the same reason.

Fixes: 2b5067a8143e3 ("mm: mmap_lock: add tracepoints around lock acquisition")
Reported-by: syzbot+6ea37e2e6ffccf41a7e6@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/lkml/67251dc6.050a0220.529b6.015e.GAE@google.com/
Reported-by: Hillf Danton <hdanton@sina.com>
Closes: https://lore.kernel.org/20241102001224.2789-1-hdanton@sina.com
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 fs/kernfs/dir.c             | 164 ++++++++++++++----------------------
 fs/kernfs/file.c            |   6 +-
 fs/kernfs/kernfs-internal.h |  12 ++-
 fs/kernfs/mount.c           |   6 +-
 fs/kernfs/symlink.c         |  10 ++-
 include/linux/kernfs.h      |   4 +-
 6 files changed, 93 insertions(+), 109 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 458519e416fe7..9f4f2fc48b0a1 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -17,7 +17,6 @@
 
 #include "kernfs-internal.h"
 
-static DEFINE_RWLOCK(kernfs_rename_lock);	/* kn->parent and ->name */
 /*
  * Don't use rename_lock to piggy back on pr_cont_buf. We don't want to
  * call pr_cont() while holding rename_lock. Because sometimes pr_cont()
@@ -51,14 +50,6 @@ static bool kernfs_lockdep(struct kernfs_node *kn)
 #endif
 }
 
-static int kernfs_name_locked(struct kernfs_node *kn, char *buf, size_t buflen)
-{
-	if (!kn)
-		return strscpy(buf, "(null)", buflen);
-
-	return strscpy(buf, kn->parent ? kn->name : "/", buflen);
-}
-
 /* kernfs_node_depth - compute depth from @from to @to */
 static size_t kernfs_depth(struct kernfs_node *from, struct kernfs_node *to)
 {
@@ -102,7 +93,35 @@ static struct kernfs_node *kernfs_common_ancestor(struct kernfs_node *a,
 }
 
 /**
- * kernfs_path_from_node_locked - find a pseudo-absolute path to @kn_to,
+ * kernfs_name - obtain the name of a given node
+ * @kn: kernfs_node of interest
+ * @buf: buffer to copy @kn's name into
+ * @buflen: size of @buf
+ *
+ * Copies the name of @kn into @buf of @buflen bytes.  The behavior is
+ * similar to strscpy().
+ *
+ * Fills buffer with "(null)" if @kn is %NULL.
+ *
+ * Return: the resulting length of @buf. If @buf isn't long enough,
+ * it's filled up to @buflen-1 and nul terminated, and returns -E2BIG.
+ *
+ * This function can be called from any context.
+ */
+int kernfs_name(struct kernfs_node *kn, char *buf, size_t buflen)
+{
+	const char *kn_name;
+
+	if (!kn)
+		return strscpy(buf, "(null)", buflen);
+
+	guard(rcu)();
+	kn_name = rcu_dereference(kn->name);
+	return strscpy(buf, kn->parent ? kn_name : "/", buflen);
+}
+
+/**
+ * kernfs_path_from_node - find a pseudo-absolute path to @kn_to,
  * where kn_from is treated as root of the path.
  * @kn_from: kernfs node which should be treated as root for the path
  * @kn_to: kernfs node to which path is needed
@@ -131,9 +150,8 @@ static struct kernfs_node *kernfs_common_ancestor(struct kernfs_node *a,
  * greater than @buflen, @buf contains the truncated path with the trailing
  * '\0'.  On error, -errno is returned.
  */
-static int kernfs_path_from_node_locked(struct kernfs_node *kn_to,
-					struct kernfs_node *kn_from,
-					char *buf, size_t buflen)
+int kernfs_path_from_node(struct kernfs_node *kn_to, struct kernfs_node *kn_from,
+			  char *buf, size_t buflen)
 {
 	struct kernfs_node *kn, *common;
 	const char parent_str[] = "/..";
@@ -166,71 +184,16 @@ static int kernfs_path_from_node_locked(struct kernfs_node *kn_to,
 		len += copied;
 	}
 
+	guard(rcu)();
 	/* Calculate how many bytes we need for the rest */
 	for (i = depth_to - 1; i >= 0; i--) {
 		for (kn = kn_to, j = 0; j < i; j++)
 			kn = kn->parent;
 
-		len += scnprintf(buf + len, buflen - len, "/%s", kn->name);
+		len += scnprintf(buf + len, buflen - len, "/%s", rcu_dereference(kn->name));
 	}
-
 	return len;
 }
-
-/**
- * kernfs_name - obtain the name of a given node
- * @kn: kernfs_node of interest
- * @buf: buffer to copy @kn's name into
- * @buflen: size of @buf
- *
- * Copies the name of @kn into @buf of @buflen bytes.  The behavior is
- * similar to strscpy().
- *
- * Fills buffer with "(null)" if @kn is %NULL.
- *
- * Return: the resulting length of @buf. If @buf isn't long enough,
- * it's filled up to @buflen-1 and nul terminated, and returns -E2BIG.
- *
- * This function can be called from any context.
- */
-int kernfs_name(struct kernfs_node *kn, char *buf, size_t buflen)
-{
-	unsigned long flags;
-	int ret;
-
-	read_lock_irqsave(&kernfs_rename_lock, flags);
-	ret = kernfs_name_locked(kn, buf, buflen);
-	read_unlock_irqrestore(&kernfs_rename_lock, flags);
-	return ret;
-}
-
-/**
- * kernfs_path_from_node - build path of node @to relative to @from.
- * @from: parent kernfs_node relative to which we need to build the path
- * @to: kernfs_node of interest
- * @buf: buffer to copy @to's path into
- * @buflen: size of @buf
- *
- * Builds @to's path relative to @from in @buf. @from and @to must
- * be on the same kernfs-root. If @from is not parent of @to, then a relative
- * path (which includes '..'s) as needed to reach from @from to @to is
- * returned.
- *
- * Return: the length of the constructed path.  If the path would have been
- * greater than @buflen, @buf contains the truncated path with the trailing
- * '\0'.  On error, -errno is returned.
- */
-int kernfs_path_from_node(struct kernfs_node *to, struct kernfs_node *from,
-			  char *buf, size_t buflen)
-{
-	unsigned long flags;
-	int ret;
-
-	read_lock_irqsave(&kernfs_rename_lock, flags);
-	ret = kernfs_path_from_node_locked(to, from, buf, buflen);
-	read_unlock_irqrestore(&kernfs_rename_lock, flags);
-	return ret;
-}
 EXPORT_SYMBOL_GPL(kernfs_path_from_node);
 
 /**
@@ -292,13 +255,15 @@ void pr_cont_kernfs_path(struct kernfs_node *kn)
 struct kernfs_node *kernfs_get_parent(struct kernfs_node *kn)
 {
 	struct kernfs_node *parent;
-	unsigned long flags;
 
-	read_lock_irqsave(&kernfs_rename_lock, flags);
+	guard(rcu)();
 	parent = kn->parent;
-	kernfs_get(parent);
-	read_unlock_irqrestore(&kernfs_rename_lock, flags);
+	if (!parent)
+		return parent;
 
+	if (WARN_ON_ONCE(!__kernfs_active(parent) ||
+			 !atomic_inc_not_zero(&parent->count)))
+		return NULL;
 	return parent;
 }
 
@@ -336,13 +301,13 @@ static int kernfs_name_compare(unsigned int hash, const char *name,
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
@@ -533,7 +498,8 @@ static void kernfs_free_rcu(struct rcu_head *rcu)
 {
 	struct kernfs_node *kn = container_of(rcu, struct kernfs_node, rcu);
 
-	kfree_const(kn->name);
+	/* If the whole node goes away, the name can't be used outside */
+	kfree_const(rcu_dereference_check(kn->name, true));
 
 	if (kn->iattr) {
 		simple_xattrs_free(&kn->iattr->xattrs, NULL);
@@ -556,7 +522,9 @@ void kernfs_put(struct kernfs_node *kn)
 
 	if (!kn || !atomic_dec_and_test(&kn->count))
 		return;
+
 	root = kernfs_root(kn);
+	guard(rcu)();
  repeat:
 	/*
 	 * Moving/renaming is always done while holding reference.
@@ -566,7 +534,8 @@ void kernfs_put(struct kernfs_node *kn)
 
 	WARN_ONCE(atomic_read(&kn->active) != KN_DEACTIVATED_BIAS,
 		  "kernfs_put: %s/%s: released with incorrect active_ref %d\n",
-		  parent ? parent->name : "", kn->name, atomic_read(&kn->active));
+		  parent ? rcu_dereference(parent->name) : "",
+		  rcu_dereference(kn->name), atomic_read(&kn->active));
 
 	if (kernfs_type(kn) == KERNFS_LINK)
 		kernfs_put(kn->symlink.target_kn);
@@ -643,7 +612,7 @@ static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
 	atomic_set(&kn->active, KN_DEACTIVATED_BIAS);
 	RB_CLEAR_NODE(&kn->rb);
 
-	kn->name = name;
+	rcu_assign_pointer(kn->name, name);
 	kn->mode = mode;
 	kn->flags = flags;
 
@@ -790,7 +759,7 @@ int kernfs_add_one(struct kernfs_node *kn)
 	if (parent->flags & (KERNFS_REMOVING | KERNFS_EMPTY_DIR))
 		goto out_unlock;
 
-	kn->hash = kernfs_name_hash(kn->name, kn->ns);
+	kn->hash = kernfs_name_hash(kernfs_rcu_get_name(kn), kn->ns);
 
 	ret = kernfs_link_sibling(kn);
 	if (ret)
@@ -1167,7 +1136,7 @@ static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
 		goto out_bad;
 
 	/* The kernfs node has been renamed */
-	if (strcmp(dentry->d_name.name, kn->name) != 0)
+	if (strcmp(dentry->d_name.name, kernfs_rcu_get_name(kn)) != 0)
 		goto out_bad;
 
 	/* The kernfs node has been moved to a different namespace */
@@ -1733,8 +1702,10 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct kernfs_node *new_parent,
 		goto out;
 
 	error = 0;
-	if ((kn->parent == new_parent) && (kn->ns == new_ns) &&
-	    (strcmp(kn->name, new_name) == 0))
+	old_parent = kn->parent;
+	old_name = kernfs_rcu_get_name(kn);
+	if ((old_parent == new_parent) && (kn->ns == new_ns) &&
+	    (strcmp(old_name, new_name) == 0))
 		goto out;	/* nothing to rename */
 
 	error = -EEXIST;
@@ -1742,7 +1713,7 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct kernfs_node *new_parent,
 		goto out;
 
 	/* rename kernfs_node */
-	if (strcmp(kn->name, new_name) != 0) {
+	if (strcmp(old_name, new_name) != 0) {
 		error = -ENOMEM;
 		new_name = kstrdup_const(new_name, GFP_KERNEL);
 		if (!new_name)
@@ -1757,25 +1728,18 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct kernfs_node *new_parent,
 	kernfs_unlink_sibling(kn);
 	kernfs_get(new_parent);
 
-	/* rename_lock protects ->parent and ->name accessors */
-	write_lock_irq(&kernfs_rename_lock);
-
-	old_parent = kn->parent;
 	kn->parent = new_parent;
 
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
@@ -1859,7 +1823,7 @@ static int kernfs_fop_readdir(struct file *file, struct dir_context *ctx)
 	for (pos = kernfs_dir_pos(ns, parent, ctx->pos, pos);
 	     pos;
 	     pos = kernfs_dir_next_pos(ns, parent, ctx->pos, pos)) {
-		const char *name = pos->name;
+		const char *name = kernfs_rcu_get_name(pos);
 		unsigned int type = fs_umode_to_dtype(pos->mode);
 		int len = strlen(name);
 		ino_t ino = kernfs_ino(pos);
@@ -1868,10 +1832,10 @@ static int kernfs_fop_readdir(struct file *file, struct dir_context *ctx)
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
index b42ee6547cdc1..335826a1f42d5 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -64,7 +64,7 @@ struct kernfs_root {
  *
  * Return: the kernfs_root @kn belongs to.
  */
-static inline struct kernfs_root *kernfs_root(struct kernfs_node *kn)
+static inline struct kernfs_root *kernfs_root(const struct kernfs_node *kn)
 {
 	/* if parent exists, it's always a dir; otherwise, @sd is a dir */
 	if (kn->parent)
@@ -97,6 +97,16 @@ struct kernfs_super_info {
 };
 #define kernfs_info(SB) ((struct kernfs_super_info *)(SB->s_fs_info))
 
+static inline bool kernfs_root_is_locked(const struct kernfs_node *kn)
+{
+	return lockdep_is_held(&kernfs_root(kn)->kernfs_rwsem);
+}
+
+static inline const char *kernfs_rcu_get_name(const struct kernfs_node *kn)
+{
+	return rcu_dereference_check(kn->name, kernfs_root_is_locked(kn));
+}
+
 static inline struct kernfs_node *kernfs_dentry_node(struct dentry *dentry)
 {
 	if (d_really_is_negative(dentry))
diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index 1358c21837f1a..7dedcfae022c4 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -222,9 +222,11 @@ struct dentry *kernfs_node_dentry(struct kernfs_node *kn,
 		return ERR_PTR(-EINVAL);
 	}
 
+	guard(rcu)();
 	do {
 		struct dentry *dtmp;
 		struct kernfs_node *kntmp;
+		const char *name;
 
 		if (kn == knparent)
 			return dentry;
@@ -233,8 +235,8 @@ struct dentry *kernfs_node_dentry(struct kernfs_node *kn,
 			dput(dentry);
 			return ERR_PTR(-EINVAL);
 		}
-		dtmp = lookup_positive_unlocked(kntmp->name, dentry,
-					       strlen(kntmp->name));
+		name = rcu_dereference(kntmp->name);
+		dtmp = lookup_positive_unlocked(name, dentry, strlen(name));
 		dput(dentry);
 		if (IS_ERR(dtmp))
 			return dtmp;
diff --git a/fs/kernfs/symlink.c b/fs/kernfs/symlink.c
index 45371a70caa71..bdb4f45254b91 100644
--- a/fs/kernfs/symlink.c
+++ b/fs/kernfs/symlink.c
@@ -57,8 +57,10 @@ static int kernfs_get_target_path(struct kernfs_node *parent,
 				  struct kernfs_node *target, char *path)
 {
 	struct kernfs_node *base, *kn;
+	const char *name;
 	char *s = path;
 	int len = 0;
+	int slen;
 
 	/* go up to the root, stop at the base */
 	base = parent;
@@ -81,7 +83,8 @@ static int kernfs_get_target_path(struct kernfs_node *parent,
 	/* determine end of target string for reverse fillup */
 	kn = target;
 	while (kn->parent && kn != base) {
-		len += strlen(kn->name) + 1;
+		name = kernfs_rcu_get_name(kn);
+		len += strlen(name) + 1;
 		kn = kn->parent;
 	}
 
@@ -95,10 +98,11 @@ static int kernfs_get_target_path(struct kernfs_node *parent,
 	/* reverse fillup of target string from target to base */
 	kn = target;
 	while (kn->parent && kn != base) {
-		int slen = strlen(kn->name);
+		name = kernfs_rcu_get_name(kn);
+		slen = strlen(name);
 
 		len -= slen;
-		memcpy(s + len, kn->name, slen);
+		memcpy(s + len, name, slen);
 		if (len)
 			s[--len] = '/';
 
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 87c79d076d6d7..bbeeee3ae7dbc 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -200,7 +200,7 @@ struct kernfs_node {
 	 * parent directly.
 	 */
 	struct kernfs_node	*parent;
-	const char		*name;
+	const char		__rcu *name;
 
 	struct rb_node		rb;
 
@@ -395,7 +395,7 @@ static inline bool kernfs_ns_enabled(struct kernfs_node *kn)
 }
 
 int kernfs_name(struct kernfs_node *kn, char *buf, size_t buflen);
-int kernfs_path_from_node(struct kernfs_node *root_kn, struct kernfs_node *kn,
+int kernfs_path_from_node(struct kernfs_node *kn_to, struct kernfs_node *kn_from,
 			  char *buf, size_t buflen);
 void pr_cont_kernfs_name(struct kernfs_node *kn);
 void pr_cont_kernfs_path(struct kernfs_node *kn);
-- 
2.45.2


