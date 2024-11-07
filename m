Return-Path: <linux-kernel+bounces-400114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4871E9C0921
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 15:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 008B51F24115
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 14:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7238212EFF;
	Thu,  7 Nov 2024 14:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G83b4EPS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZKJS7su5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4710212EE5
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 14:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730990585; cv=none; b=HYq6E2Ttac8q5IQqTzaB/tdJlQh7VF37IZ8zpgLf350XhAtcae3MIkkr0PtJ8Kl83Gn97vZTT17487yxuTUeM5UE8/wvcj6bccp9srB5YatiOavKj81VdMguFgSnh5XOyLXQ9si4OzOiJOTIth9wYuJN0ONr5arIKki9i1J9cs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730990585; c=relaxed/simple;
	bh=1ToEirFqX9dSyAzp9HJHCP0ZYk6zc8VprT/nAiXv4Dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XHGzLVRsfULZmV/x29xAvOkozAe4v63RcAs7rTWr4mrbNQkKncHL5UEP7zNWpf+wXQDCHd7K+v341PB1/OW2iF+nP44XXlYHiAJHeAwrOkZSUwZ2Q0O85RdWiW7zR51Ud6zyNaJMHZlsvc9Qa0A7p2IoOoegg7RTcFQTFJrVm+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G83b4EPS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZKJS7su5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 7 Nov 2024 15:43:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730990581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+3nFScjAqsAlvVm2mxTWkS7nXe59tRsb+n/sCrz1BIo=;
	b=G83b4EPSGVF7QalnBfad8hYevHcPDwOLC146zjyFK2/bDXa7k94yu5AWXG7SgZ2iMywjUn
	ieJnJ969+KZg3JAvwNbdlkCDOezPlNeSw6AbXmyaxn0zi9utQex7APY8ZAp6mtvlIOClhx
	oI+Ain2UoX5PNtSaoOADXU+1KkBrkAtIZVDgqSuwafHMb0fI8OvlhkRS/IftHexxJBRxsx
	anse6l3ji6y87MzUkH3/Y2BFHj5lAHVx15n3utirdLN08ebaRFrIMWwxsnSiSSN4eciChf
	CDsvPWBmmAKuofC0/2jNmsYUaula5K5eXZ4WRX5v2J/1Dg8yXMdCJH/CpPjz7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730990581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+3nFScjAqsAlvVm2mxTWkS7nXe59tRsb+n/sCrz1BIo=;
	b=ZKJS7su5SDEBlnZwowdFcbYheXzwBdQqmCJm8wbHv2nTU7jPO+istpuA1drFgkNsM60sb1
	2V+Lv1qcNsOtC2Cw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Vlastimil Babka <vbabka@suse.cz>,
	Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com, linux-mm@kvack.org,
	sfr@canb.auug.org.au, longman@redhat.com, cl@linux.com,
	penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
	akpm@linux-foundation.org, Tomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/2] scftorture: Use a lock-less list to free memory.
Message-ID: <20241107144300.gbzCzBRf@linutronix.de>
References: <88694240-1eea-4f4c-bb7b-80de25f252e7@paulmck-laptop>
 <20241104105053.2182833-1-bigeasy@linutronix.de>
 <20241104105053.2182833-2-bigeasy@linutronix.de>
 <ZyluI0A-LSvvbBb9@boqun-archlinux>
 <20241107112107.3rO2RTzX@linutronix.de>
 <45725c86-d07f-4422-a6fd-c9f02744ac75@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <45725c86-d07f-4422-a6fd-c9f02744ac75@paulmck-laptop>

On 2024-11-07 06:08:35 [-0800], Paul E. McKenney wrote:
=E2=80=A6
> This statement in scf_torture_cleanup() is supposed to wait for all
> outstanding IPIs:
>=20
> 	smp_call_function(scf_cleanup_handler, NULL, 0);

This should be
	smp_call_function(scf_cleanup_handler, NULL, 1);

so it queues the function call and waits for its completion. Otherwise
it is queued and might be invoked _later_.

> And the scf_cleanup_handler() function is as follows:
>=20
> 	static void scf_cleanup_handler(void *unused)
> 	{
> 	}
>=20
> Does that work, or am I yet again being overly naive?

See above. I can send a patch later on if you have no other complains ;)

> 							Thanx, Paul

Sebastian

