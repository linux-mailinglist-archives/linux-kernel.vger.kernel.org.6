Return-Path: <linux-kernel+bounces-400185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F2F9C0A16
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 16:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA10D281A26
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 15:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90130213133;
	Thu,  7 Nov 2024 15:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4gWnbb0J";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZxTtCI6C"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2EA1E7676
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 15:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730993261; cv=none; b=B8VMeFoAg/3E0ex39Hwsib4tVvpMerAiKkrbl6tDRUWVhhzqRxZ2dwXtiR/aCCXSgr374N9r2o3ut/LJHswxqee7UnPRB5/31w8/5L76TxgGSAVah/QiHpo+VceBan/e+X/sltZUHMQvtd3HhgM0boub6+vmt/ENHlnUfn6m9ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730993261; c=relaxed/simple;
	bh=ZZu2BXSdjUtMwxAWzNqbqFoawcRzg9hKYNF9EMvsMPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oFfX8uxFXGhqiPmq2MiZD0o0nzOvA0YRaIehivfMMRkQ9m+LO+4QbiKOTmeTdg7GTtfnNxYK05Q23avlo2pd2PPacHcuDII0b92ii8UxdatYMXboQf3K2FmkTPlVO5TPT6UKjIlQhrYSFi31yUWmpqhbRxyjjtZNmo3zpoeoULE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4gWnbb0J; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZxTtCI6C; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 7 Nov 2024 16:27:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730993257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D9GAkp6axrm31ZMYGbMxCuOZ4EkrG3h1hb4DuwNIX7w=;
	b=4gWnbb0JPA6louZB7MhLxMUhWSLppTnsLQbINltZYCdkRoFvDAOb8+j8uG1uTAQ31JdCBw
	8bq2UJJC8T03kvvs8d9RqMv7kYIY8H147SAnH7YP+jVL3eCAIFbzk2URYTOyr0nZc6cYKo
	AitVwZZe8xTdc9dIk7S/lbQnDuh1aDKS8uNBTInwEVbJ0r7mMDIznyADV1VSwmw1u/bVnY
	I2lprx7i6DVpgJ0dV+DcIs87c3MlalAbPOO/L3q1nD9qMM9CiTOj9ZvHyc0O1fbqKPjdVk
	uYLcT3kZz0zGuryquAThpQ3caFZsH2LksUvyBtOo7XUP5SLyCaaIiUPwTaGUhg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730993257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D9GAkp6axrm31ZMYGbMxCuOZ4EkrG3h1hb4DuwNIX7w=;
	b=ZxTtCI6CCJFS73eVuWExDYOllEmHp7Pxsrcs7aU7TeuBaqEJUgzfINiHhmE64uY9O5/NXf
	4Bbi4xp5gjVmDpDg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, Marco Elver <elver@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>, akpm@linux-foundation.org,
	cl@linux.com, iamjoonsoo.kim@lge.com, longman@redhat.com,
	penberg@kernel.org, rientjes@google.com, sfr@canb.auug.org.au
Subject: [PATCH v2 4/3] scftorture: Wait until scf_cleanup_handler()
 completes.
Message-ID: <20241107152736.BJPBLXGO@linutronix.de>
References: <20241107111821.3417762-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241107111821.3417762-1-bigeasy@linutronix.de>

The smp_call_function() needs to be invoked with the wait flag set to
wait until scf_cleanup_handler() is done. This ensures that all SMP
function calls, that have been queued earlier, complete at this point.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/scftorture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/scftorture.c b/kernel/scftorture.c
index 1268a91af5d88..ee8831096c091 100644
--- a/kernel/scftorture.c
+++ b/kernel/scftorture.c
@@ -552,7 +552,7 @@ static void scf_torture_cleanup(void)
 			torture_stop_kthread("scftorture_invoker", scf_stats_p[i].task);
 	else
 		goto end;
-	smp_call_function(scf_cleanup_handler, NULL, 0);
+	smp_call_function(scf_cleanup_handler, NULL, 1);
 	torture_stop_kthread(scf_torture_stats, scf_torture_stats_task);
 	scf_torture_stats_print();  // -After- the stats thread is stopped!
 	kfree(scf_stats_p);  // -After- the last stats print has completed!
-- 
2.45.2


