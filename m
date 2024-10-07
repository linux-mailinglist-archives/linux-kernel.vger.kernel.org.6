Return-Path: <linux-kernel+bounces-353869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD03E9933DE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 18:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 881171F23B35
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E818D1DC050;
	Mon,  7 Oct 2024 16:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yESCWZmQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oqo/naGF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73C91DBB3F
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 16:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728319795; cv=none; b=T5QLfn1HoN3Y6GloRj3FkzMhX+fKBf4HIj4uDP0YPJfDyq/2IIzyB6NcEa/mD22sP16ymvKGs0VKWHe4Y5nF+nNJmNQ0/SpPfbPopXaCYVb7wNSt8t5XTKZjqy3IJxIzsjqSxBu2tTVhXaESGPDc93FmrbwZVKLp5h7HTreGeRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728319795; c=relaxed/simple;
	bh=KjSTc1PGThG2YEWOAP17hEBzFz4VBeXuBHb6mHzo6As=;
	h=Message-ID:From:To:Cc:Subject:Date; b=cmvetrCdZr5Hw4fQzIUu4PK4kX3DeOEoLiBHe2T0zGt1DjcguSZJuN9Vp8eOtquULL+Cf+58W78nzt3C4hbhIkTmXI/ExowgR3XEQHqL2EbSwqeu6Ch24U7a8Y9WmnBXBLcy9HxFxYj4oTVFuu2xxcxWNZ256UsuJhX+kLZZ3Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yESCWZmQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oqo/naGF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20241007163507.647617031@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728319791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=CRxeZtJ8expviigBshObykNaMWb8vu8yehSsOIjnIy8=;
	b=yESCWZmQdQapfp10/VMdGMWZmNuSgQYU2hHgfxJAc4DnpXoUKJYpLw3UdaPqUQOrYtMrjJ
	2ohWVR/dVChI3KsFy34rHSA2VW0s6EJ8SsWTD9n87pmcNFf5tN+G9Ybl6eS2Luw0NnQrgl
	O16+StJXCuMf16LVrwosU1K1xyTXRX2viLd9VPzMk9o6We5cgpmFv2AueEWqf+xWznDqVh
	VVidJsdp/dNpK/nJuvqy+b7vEONZ9ktIY/EcUHKyc5ILeObnaoN5/JPdBLasvLGINfoJtp
	4pRnG5f41I0Xn0owoydR0vRJNYSE/nmgPDRUIC94/f46KUpOSimdz1xzY6ZZZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728319791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=CRxeZtJ8expviigBshObykNaMWb8vu8yehSsOIjnIy8=;
	b=oqo/naGFOHaI2fxLhpB8UGm29UwFffJlw4iJ2/VhdMMxdm/HSnZtW4uIQu/mmVOj4xuI6K
	e8YqyOMgq/pcnXCw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Zhen Lei <thunder.leizhen@huawei.com>,
 Waiman Long <longman@redhat.com>
Subject: [patch 00/25] debugobjects: Rework object handling
Date: Mon,  7 Oct 2024 18:49:51 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Zhen reported that the global lock in debug objects is problematic. There
are several issues:

    1) Parallel pool refill attempts result in long wait times

    2) The operations under the lock move batches of objects by moving
       them one by one from one list to another

       This takes quite some time and is also a cache line dirtying
       festival.

For further context see:

  https://lore.kernel.org/all/20240904133944.2124-1-thunder.leizhen@huawei.com
  https://lore.kernel.org/all/20240904134152.2141-1-thunder.leizhen@huawei.com

Address this with the following changes:

    1) Avoid parallel pool refills unless the fill level is critical

    2) Release and reacquire the pool look between batches in the worker
       thread.

    3) Convert the pool handling to a stack of batches which can be moved
       with trivial hlist operations which are fast and do not touch a
       gazillion of cache lines

While working on this, I noticed that the kmem_cache allocation/free rate
is rather high. This is addressed by:

    1) Doubling the per CPU pool size

    2) Agressively refilling the per CPU pool from the free list

    3) Throttling the kmem_cache_free() operations by monitoring the object
       usage with a exponentially wheighed moving average

The resulting reduction for a full kernel compile:

      kmem_cache_alloc()	kmem_cache_free()
Base: 380k			330k
#1:   295k			245k      
#2:   225k			245k
#3:   170k			117k

Especially the reduction of allocations makes a difference as that happens
in the hot path.

There are further possibilities to enhance this:

    1) Move the lock into the new global pool data structure
    2) Provide a per-node "global" pool which is brought up
       before the first CPU of a node is brought up

That's left as an exercise for the reader. :)

The series has incorporated the latest changes from Zhen:

  https://lore.kernel.org/all/20240911083521.2257-1-thunder.leizhen@huawei.com

to avoid conflicts.

It is based on v6.12-rc1 and also available from git:

   git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git core/debugobjects

Thanks,

	tglx
---
 include/linux/debugobjects.h |   12 
 lib/debugobjects.c           |  866 ++++++++++++++++++++++++-------------------
 2 files changed, 503 insertions(+), 375 deletions(-)

