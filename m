Return-Path: <linux-kernel+bounces-192503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C04518D1E3C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 16:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEC431C22FEE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 14:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68AE916F838;
	Tue, 28 May 2024 14:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wFSLxzoB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QP/pyYu1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163A716FF33
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 14:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716905626; cv=none; b=Pk25nPc7kQm0M//atc8+2BDkZAX7qR/Bx8cPStbbkatWs8eiqe8d8nGBAoqTQvWaxmTCpbbQvpTHZQ4+9j+O4KPi/nDtzxH3iHWkPSVqnw8JePMyfuhUoLmwH0094Anlv0lgj53VZOwuNv/gkRBRlstBrg24B5C2TQ3ri4OcPr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716905626; c=relaxed/simple;
	bh=yGczwoowHgTBSzvC13wg6toyMlplKlmFcpHOKWv7Wrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NejbjtZjEIDZkSc5A/e7ceH5f+ufhTE/3ss4ySwhgYg5JRW7zpKH9TCxF18q05+Qrq539NTQlqjaM19HM3ZczVKNxYSuiSqezmKNnv8E0EkBeJfiqpcOGXAofGLsM+2ynTTxK+lAcMiG5q8QNhUuxSPkAJjr0b6xOUyauikICtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wFSLxzoB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QP/pyYu1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 28 May 2024 16:13:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716905623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vTOgAjTKulp1YcH/LU4x95O4AvhUBSt+M3+DMT8WODI=;
	b=wFSLxzoBVfwAtCCftNneGnf1GCgI3etrzLApZhe+KVi6LYCS0Bh+V0msc0WPKEkanbNa+W
	WY8YiyKsCYMHgB9o8sSwPjki7Yc83Vd+kt0HwL6xw7BvzlDBru09I6gRkXwfEB8IumYjy/
	4hYOlMRkS4Q/f6P6xZTboAWt1bNKZ+hES9s+VkuKNi1blqLJoNnIuh8KLOOKzqlXpNwnV0
	rGVxkaoNcXIHFo8J+/WvBAgx2FlzcoL7I/Cejd6Sm6hISTvFGcrFFFYkesIVKF6cLTyncq
	HEF1e1ecx3U9UgqxfogtdrjiGM9PAXRy1g7pHXiCEF/JhXXN1+LZAA2Yssacyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716905623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vTOgAjTKulp1YcH/LU4x95O4AvhUBSt+M3+DMT8WODI=;
	b=QP/pyYu1WTVN5VEjvoSr5awhkcFfSSc5ke5CgQ2wgvJ0vcdgW3vJKZQHLQPBKMm/rqjHlL
	PRb86YH1xWGdHRAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2] memcg: Remove the lockdep assert from
 __mod_objcg_mlstate().
Message-ID: <20240528141341.rz_rytN_@linutronix.de>
References: <20240528121928.i-Gu7Jvg@linutronix.de>
 <09e085bb-f09e-4901-a2dd-a0b789bb8a4d@kernel.org>
 <20240528134027.OxDASsS3@linutronix.de>
 <c84d6962-34fa-42e5-899c-925579cbfb26@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c84d6962-34fa-42e5-899c-925579cbfb26@kernel.org>

The assert was introduced in the commit cited below as an insurance that
the semantic is the same after the local_irq_save() has been removed and
the function has been made static.

The original requirement to disable interrupt was due the modification
of per-CPU counters which require interrupts to be disabled because the
counter update operation is not atomic and some of the counters are
updated from interrupt context.

All callers of __mod_objcg_mlstate() acquire a lock
(memcg_stock.stock_lock) which disables interrupts on !PREEMPT_RT and
the lockdep assert is satisfied. On PREEMPT_RT the interrupts are not
disabled and the assert triggers.

The safety of the counter update is already ensured by
VM_WARN_ON_IRQS_ENABLED() which is part of __mod_memcg_lruvec_state() and
does not require yet another check.

Remove the lockdep assert from __mod_objcg_mlstate().

Fixes: 91882c1617c15 ("memcg: simple cleanup of stats update functions")
Link: https://lore.kernel.org/r/20240528121928.i-Gu7Jvg@linutronix.de
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
On 2024-05-28 15:44:51 [+0200], Vlastimil Babka (SUSE) wrote:
> I think just s/memcg_stats_lock()/__mod_memcg_lruvec_state()/ in your
> phrasing, since we are removing the lockdep assert from path that calls
> __mod_memcg_lruvec_state() and not memcg_stats_lock()?
> Or am I missing something?

Yeah, makes sense.

 mm/memcontrol.c |    2 --
 1 file changed, 2 deletions(-)

--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3147,8 +3147,6 @@ static inline void __mod_objcg_mlstate(s
 	struct mem_cgroup *memcg;
 	struct lruvec *lruvec;
 
-	lockdep_assert_irqs_disabled();
-
 	rcu_read_lock();
 	memcg = obj_cgroup_memcg(objcg);
 	lruvec = mem_cgroup_lruvec(memcg, pgdat);

