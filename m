Return-Path: <linux-kernel+bounces-525352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 880C7A3EEE4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 09:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBE9819C321D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 08:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC29A20102A;
	Fri, 21 Feb 2025 08:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kfGKmFqr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="srR+I1cW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31671B0406
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 08:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740127357; cv=none; b=DSXzdOMQ/phCZdiyMEwpSTQVSYGtXPkDQ21rUcgFVWvLpTEBWR/9vuzE2Lh2UufWhpLk+pa1Epx7prapGD67rvi9ZA7KFaZtq3YBHmDZjrX5tImA39MSKbj7oL2TRYAwjNbkOhttkGi2nPLoCDTI7CtuAlJpRQYbdRu+RR69y/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740127357; c=relaxed/simple;
	bh=aQugDc1TgMoiAluzr/ZwOKQLVI9JjCwit02YYaVSkkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NqBYbxdjna6ImXKI/BTE5LDL///z1neJVcCuqIgP8qw9SRzKPSCvHAJdliRno8o+0CRu+zxut7IKihMD/z+jyrfcAvx4/7RmwLwzjtylXLMw03k9JawVOxrir1Y1M/+pwXxN4kLIibLT0SrqecodXouRZcGxRX5J+1jRThgu7YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kfGKmFqr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=srR+I1cW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 21 Feb 2025 09:42:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740127354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kfWyW3Ru7mRAcB4wq3FWMDy1z1YI9IDwUbQQozwZ2fs=;
	b=kfGKmFqrsUsC5Btlox5K/xTLxBkL5kMb4J/6BBU6q4SsReXp8/SESVsTCKZ/1rBfbTfgHr
	uie01s8+0U3EgF5lUgI3VvuJ6xvCzoK1wER+xvdhrcmvQvbocLplcxWuhgcTRsX8TT6gh+
	4mBtMd40bPje8WbgcDvXa4XhCb6jV4muOrKM5BzgCjMoSOSYIMHmwyDCj91rn/kAuIkFQ4
	vtCv+z46oF/wccsYi4W7RVXyRXgRYWURsFYWwsJEXvdtiVh9xmnFCoKhvUh+fJ73yqCcqv
	9KJsq1tQ5MqLgps6Ex0mcNlIOHhY24arZSGXxMwsc4c6iyTIByr3s9WZnP51ww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740127354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kfWyW3Ru7mRAcB4wq3FWMDy1z1YI9IDwUbQQozwZ2fs=;
	b=srR+I1cWWWSLd48L5cbU+8tnEAw4D199lz2dx4HcvuF9hUvesAbuPN6YVVAuC0SUeyTVRE
	qBPQtRLrfuYeKRCA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: syzbot <syzbot+ecccecbc636b455f9084@syzkaller.appspotmail.com>,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, tj@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] kernfs: Move dput() outside of the RCU section.
Message-ID: <20250221084232.xksA_IQ4@linutronix.de>
References: <67b45276.050a0220.173698.004f.GAE@google.com>
 <20250218163938.xmvjlJ0K@linutronix.de>
 <20250220203924.GL1977892@ZenIV>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250220203924.GL1977892@ZenIV>

Al Viro pointed out that dput() might sleep and must not be invoked
within an RCU section.

Keep only find_next_ancestor() winthin the RCU section.
Correct the wording in the comment.

Fixes: 6ef5b6fae3040 ("kernfs: Drop kernfs_rwsem while invoking lookup_positive_unlocked().")
Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 fs/kernfs/mount.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index f1cea282aae32..5124e196c2bfd 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -222,17 +222,17 @@ struct dentry *kernfs_node_dentry(struct kernfs_node *kn,
 	root = kernfs_root(kn);
 	/*
 	 * As long as kn is valid, its parent can not vanish. This is cgroup's
-	 * kn so it not have its parent replaced. Therefore it is safe to use
+	 * kn so it can't have its parent replaced. Therefore it is safe to use
 	 * the ancestor node outside of the RCU or locked section.
 	 */
 	if (WARN_ON_ONCE(!(root->flags & KERNFS_ROOT_INVARIANT_PARENT)))
 		return ERR_PTR(-EINVAL);
 	scoped_guard(rcu) {
 		knparent = find_next_ancestor(kn, NULL);
-		if (WARN_ON(!knparent)) {
-			dput(dentry);
-			return ERR_PTR(-EINVAL);
-		}
+	}
+	if (WARN_ON(!knparent)) {
+		dput(dentry);
+		return ERR_PTR(-EINVAL);
 	}
 
 	do {
-- 
2.47.2


