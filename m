Return-Path: <linux-kernel+bounces-353871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5789933E5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 18:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F499B2705F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720851DC1B1;
	Mon,  7 Oct 2024 16:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JNtOPjbB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+9ulgnTo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3901DBB20
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 16:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728319796; cv=none; b=CKKZ7IJN+9v7nFL/nejOZm8WNWTc9XQ5AF7Y/jU0CcWuZTBi+HU29C2TZH6NzFwYgU+mqUFwYLRQtRKL+w5UmPo0Ano1VmR9MN/R/S/DwckSWU11SiDJ4rHIUcfyvs2RIDa7Ro9qMQnCOsvG46JhlhVzxHjGclZ/j2LJNZW+Yrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728319796; c=relaxed/simple;
	bh=k0DnZZu43ruD+bdSb4T6LCSi2wCBz0Hja4zGcT8s0mw=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=TtUh138q++0d0HGnJjE3YKZKWL1Ie/H4stDdjtAqBZ4hmPcvBhqT9gcLJJt3bctelsEDMnmqTBGjIAlGDaCYrH1yOsQ++g/CaouYIADf9X3g0QFzXQG/7OJY5U72Jl31Aaze8oH9sLK+CDsMEsxJJETV20/OM8N4e8T4+8OZIdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JNtOPjbB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+9ulgnTo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20241007164913.009849239@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728319792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=R5gfZFizKr+dgdbeMxiwbggyU0Kkmipobr0FHuBYryc=;
	b=JNtOPjbB05KL37x7osBOUnibEtZ0i5bRN9nWMo/ujao+h5nBl6489z5mON7lNW+T7cpHeB
	GbVVDMibe/rsINJyReKEZ1fQXuMAzRatD5fsJvR7eZ3cM1eRjCHLTQLMWG2GQQuH7c6zfe
	3VHxUaI9vC2rHJ/htoVLa8ztxLWObbkPU4P/ub1KQ/8C88kGuQ19kXvcQoZdPhqQi+DGY3
	eHbFsLx+HMctKzr0gbJale1ctxmpvOXkBbeRzTSVbTUUnbwFlwKXcbgPesCrINRJdhdl3t
	oY99tnLnzCypKv1gYbi2+H1vR8V42KHt94O9Y/uAA1sQHwFN0ND7waK9zn3VrA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728319792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=R5gfZFizKr+dgdbeMxiwbggyU0Kkmipobr0FHuBYryc=;
	b=+9ulgnToVXOlDSURnoX/ZbH5raqwQq7Xd8GL06L+KTH74o9Vh89sco2soxc14pN6rnrt7f
	JiNjlAnzpO68p0DA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Zhen Lei <thunder.leizhen@huawei.com>,
 Waiman Long <longman@redhat.com>
Subject: [patch 01/25] debugobjects: Delete a piece of redundant code
References: <20241007163507.647617031@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon,  7 Oct 2024 18:49:52 +0200 (CEST)

From: Zhen Lei <thunder.leizhen@huawei.com>

The statically allocated objects are all located in obj_static_pool[],
the whole memory of obj_static_pool[] will be reclaimed later. Therefore,
there is no need to split the remaining statically nodes in list obj_pool
into isolated ones, no one will use them anymore. Just write
INIT_HLIST_HEAD(&obj_pool) is enough. Since hlist_move_list() directly
discards the old list, even this can be omitted.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240911083521.2257-2-thunder.leizhen@huawei.com

---
 lib/debugobjects.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -1325,10 +1325,10 @@ static int __init debug_objects_replace_
 	 * active object references.
 	 */
 
-	/* Remove the statically allocated objects from the pool */
-	hlist_for_each_entry_safe(obj, tmp, &obj_pool, node)
-		hlist_del(&obj->node);
-	/* Move the allocated objects to the pool */
+	/*
+	 * Replace the statically allocated objects list with the allocated
+	 * objects list.
+	 */
 	hlist_move_list(&objects, &obj_pool);
 
 	/* Replace the active object references */


