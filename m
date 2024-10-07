Return-Path: <linux-kernel+bounces-353896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 519D299340A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 18:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0911D1F20C17
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317631DE8A9;
	Mon,  7 Oct 2024 16:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Nw02v3u4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uMQ9fmZT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340D61DE4F6
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 16:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728319823; cv=none; b=Sn9AeIPOvXkXxrT4TxP8uVdA9v2zqMcoTypWUii/Jp2WooRTg/qG540bcx+FljrWYldLqlG7Cbbr1mgBF2v4kkLdY2+GbWunBHvqm6nBy6r+6mwtXZ1g7HBq4imH3q2Wqz1r+nDd9sq9vGiaDm74hYIshYOgAbFkDz6gDov1Ei4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728319823; c=relaxed/simple;
	bh=A9HbtYbk1zUjHwIbER7JB9z1psrSbF3hl4GInqdSUAs=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=owfMmPicY4SAKbSMNjbgkvlSYeMr3bK3YfjETTBzGRTxw7YADGLJ7ju22ik0NdKhslJupacjKJDvOlF/qLHs2ym/73RzuUVNGjXPnj671OYI/c095QeA+v5YVDYCM59pgEGvrYGIJDwpBOroHQnovUkbdvgkxnKQZWGS/0SVYw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Nw02v3u4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uMQ9fmZT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20241007164914.439053085@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728319820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=8EaFnUcTOTl6eBkUKro450FuKCraH5nZVOpj/jHvlNA=;
	b=Nw02v3u4NVdtFf4nltBHBprJcmq+KduMrejVKG9dzhWT44bDVu+KXGeLHdqx/GIErauzOd
	CMMxArpXKCWQMwu1RkQ8W+x7cIyEOSot7wzpnu1vu199VZK2D/2nToPw2RfHui4JP1kWog
	C+K7Rpg2ZqVUBJVtnskI8GA5u9wPgnqqddAG+amN6YVIVrpFqPhe+iRFLTtmDRO2bOl8Yr
	XBkD1MHuhXckU6BPbjZgMkZLJFKtbrVVOn9JqoVuy1ITudUSe2YCpndRss2OIiJE20ktA0
	QtCq50VPUZtL+Ya6A3EudhJUjPhj8KYCcEWl77umzdIYBE81f8bk2JqIwh7EGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728319820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=8EaFnUcTOTl6eBkUKro450FuKCraH5nZVOpj/jHvlNA=;
	b=uMQ9fmZTwuy1rsSiNCf/PXGDMTCbVvUfgRFc3eQNRTjR8/5BRrN4lGwDzlDm+OonB/MebC
	lF/ulf07ifKhvwCg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Zhen Lei <thunder.leizhen@huawei.com>,
 Waiman Long <longman@redhat.com>
Subject: [patch 24/25] debugobjects: Refill per CPU pool more agressively
References: <20241007163507.647617031@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon,  7 Oct 2024 18:50:20 +0200 (CEST)

Right now the per CPU pools are only refilled when they become
empty. That's suboptimal especially when there are still non-freed objects
in the to free list.

Check whether an allocation from the per CPU pool emptied a batch and try
to allocate from the free pool if that still has objects available.

   	    kmem_cache_alloc()	kmem_cache_free()
Baseline:   295k		245k
Refill:	    225k		173k

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 lib/debugobjects.c |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -255,6 +255,24 @@ static struct debug_obj *pcpu_alloc(void
 
 		if (likely(obj)) {
 			pcp->cnt--;
+			/*
+			 * If this emptied a batch try to refill from the
+			 * free pool. Don't do that if this was the top-most
+			 * batch as pcpu_free() expects the per CPU pool
+			 * to be less than ODEBUG_POOL_PERCPU_SIZE.
+			 */
+			if (unlikely(pcp->cnt < (ODEBUG_POOL_PERCPU_SIZE - ODEBUG_BATCH_SIZE) &&
+				     !(pcp->cnt % ODEBUG_BATCH_SIZE))) {
+				/*
+				 * Don't try to allocate from the regular pool here
+				 * to not exhaust it prematurely.
+				 */
+				if (pool_count(&pool_to_free)) {
+					guard(raw_spinlock)(&pool_lock);
+					pool_move_batch(pcp, &pool_to_free);
+					pcpu_refill_stats();
+				}
+			}
 			return obj;
 		}
 


