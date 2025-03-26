Return-Path: <linux-kernel+bounces-576623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E54EFA71201
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 09:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD0CC3B487B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 08:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711DB1A0B08;
	Wed, 26 Mar 2025 08:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3dXHjuSt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oITUO7BZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BE319FA8D
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 08:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742976198; cv=none; b=nkvBxx/SkiAgO6AmQ/gEBBP6I52PhDtFmpMMNKxzW8/xDQIY12YAapL+9ssUiBd3UBqh1rwL8NwFgLx8IU1053EsVctzX89au3HdUREDgPPfkG/wRd1viBXS/wWGWyUA04klBVj//P0J3SEiCaQBpBc+koIEh+B2yaw+dS4FziE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742976198; c=relaxed/simple;
	bh=vfq0O83JvaQGy5XnD1xc/ym1QQ+f4WEk1SQ125+DRCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LY5BWvtnCd25ZgybgmwdWGfUvRHnSJ3gPzPQyfeCQy7AeXV5RvLPZotz4nw5Qnnn8qdK08rJHuBpXKuI5pS6PJDnTWIvcTZWq2iHwAAhsN5ME4LGtX3oWxQthS10O6DO57jiuk4dHBYJJ0ci2wI/KqwDlSIDzV+3Vgmhox1OiSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3dXHjuSt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oITUO7BZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 26 Mar 2025 09:03:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742976193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=50MrsxYK3oYM3Wv16OwfeBCnz0qZd3DDseek+Q5I5Nc=;
	b=3dXHjuStrAtSqPURcmb66RC5Yv8F5u0il+NOYgJki8EhE0UEd/8N86qxnMEPU080SFQJQu
	iFD+XXJTnIYiVSHw+ne7RBICQfvh20Ygdyfn1nzHCfHRP6u+jeO2VOqQlc7wotcv314hUW
	ee8Lrp7OpmfzFJQ2wvrArS1OE0CkApHpm2ZrmtMLWlSpfv3RdFmLG4ZvnRXrZMQVPFdCow
	Q3nKLC6zsrlI3wXMMKP/7Q69ZyHyPVn2ACQNLXp1JSOVfflH+8IMIkhdeAtACmWDOfg0Wy
	iuegfIliqqCo/hHGhyWIsUfQ6VEh0wbUtlXltzBBsg+UwbsbEfX7jqktKkK9QA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742976193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=50MrsxYK3oYM3Wv16OwfeBCnz0qZd3DDseek+Q5I5Nc=;
	b=oITUO7BZR4HP0OrU58pH8607c04/ILVgTYE3po0FAru7lxWtZ7ZOrtDGnuEUpfpze2htQd
	S9kO2iF+7jqWB3CA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	=?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 20/21] futex: Implement FUTEX2_NUMA
Message-ID: <20250326080312._TLvBFLx@linutronix.de>
References: <20250312151634.2183278-1-bigeasy@linutronix.de>
 <20250312151634.2183278-21-bigeasy@linutronix.de>
 <fc3a6902-a845-4b11-ace8-514f10194288@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fc3a6902-a845-4b11-ace8-514f10194288@linux.ibm.com>

On 2025-03-26 01:22:19 [+0530], Shrikanth Hegde wrote:
> > diff --git a/kernel/futex/core.c b/kernel/futex/core.c
> > index bc7451287b2ce..b9da7dc6a900a 100644
> > --- a/kernel/futex/core.c
> > +++ b/kernel/futex/core.c
> > @@ -1597,24 +1646,41 @@ int futex_hash_prctl(unsigned long arg2, unsigned long arg3)
> >   static int __init futex_init(void)
> >   {
> >   	unsigned long hashsize, i;
> > -	unsigned int futex_shift;
> > +	unsigned int order, n;
> > +	unsigned long size;
> >   #ifdef CONFIG_BASE_SMALL
> >   	hashsize = 16;
> >   #else
> > -	hashsize = roundup_pow_of_two(256 * num_possible_cpus());
> > +	hashsize = 256 * num_possible_cpus();
> > +	hashsize /= num_possible_nodes();
> 
> Wouldn't it be better to use num_online_nodes? each node may get a bigger
> hash bucket which means less collision no?

Ideally at this point you should have online_nodes == possible_nodes.
Due to hotplug you could have more possible than online nodes. However
in this case you would have more smaller buckets which are used even if
the node is offline. Assuming the hash function is perfect, you should
utilize just the same amount of buckets.

Sebastian

