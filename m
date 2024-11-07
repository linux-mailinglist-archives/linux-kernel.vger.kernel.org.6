Return-Path: <linux-kernel+bounces-399754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5500A9C03C5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 12:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1859D28295C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 11:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756011F4721;
	Thu,  7 Nov 2024 11:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W3C6oGXE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hz7cJ959"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829FF1F4FB4
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 11:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730978471; cv=none; b=Cy127/QxPQbPULP7UjXC21zB9BVQ4uHC1F+QxPZORwsg5y7sC0HYBmXlCKVy04cMPwTafwHnKVQgXQZiQgl+ryBSegiER6VJam0SsaG7mSlDXAS+l6wy7pu4DLu2CCDpVDkfV2oisZGkU6G4isOugBWoVQqbxpryopqPNoaA1sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730978471; c=relaxed/simple;
	bh=a/Di2nBt7ViZy5xULJgXlhWj9A0J15O4YDLs+0OPrYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GfWc/UpPCd7rDiEp6p+G6PwGMWya4kp+sXcIYk7wuamryGOxhFHmgvIV2cnAqpN57mecITyEotGnTNo8Ea2ZCemyW20OF7Iwfdqr8DegfOpsgrXD33v8tpCovJDDTLntJVMUoVeEJIqn/tkcLIRJi1E5WBsr0RjVsRK7pi2RuJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W3C6oGXE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hz7cJ959; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 7 Nov 2024 12:21:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730978468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tel7mhMevWRKEW+kc/Ko2O9+6EggljMRxxOElNb7ssE=;
	b=W3C6oGXEQXRwvNLsOP4zrorS7k8zE1HWJ1u6iYEc98GTmka08DKKdwQjrcec2DL4S9I9Y2
	ilSwg3/UByge5gaTUoz65dveGCMZ/GqUYp1daEuDgCj3HWTT3sPnKUGpLhAxN/YYLxUOzj
	jWT21SXsVLiuUfFDkNqUX6PPqB9/7s8BNtSFsibPNGb+Uu7kymiY2hxvDf2Sx93taZg0ZX
	G5IOc5CmYJm8Ef/oJRyTSqp8+rqmZaRUcs4qKYAoQPz8gzMGTdz4oYsvn6FTGfaBp7sfPG
	WHLxGYgMr4enHlrjMQYjPbshwcWdn9yyAzDVZQFA2DNtnqK3Hclkv1A9h4xKyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730978468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tel7mhMevWRKEW+kc/Ko2O9+6EggljMRxxOElNb7ssE=;
	b=hz7cJ959UdsIvZ6hEDfAs3E/k6PbOtB+HnDa2LgpYnPu2zvuzi9uiKbfvUXn8hdmXhRYM2
	XqqNldinZMnf+XCQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>, Marco Elver <elver@google.com>,
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
	linux-mm@kvack.org, sfr@canb.auug.org.au, longman@redhat.com,
	cl@linux.com, penberg@kernel.org, rientjes@google.com,
	iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
	Tomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/2] scftorture: Use a lock-less list to free memory.
Message-ID: <20241107112107.3rO2RTzX@linutronix.de>
References: <88694240-1eea-4f4c-bb7b-80de25f252e7@paulmck-laptop>
 <20241104105053.2182833-1-bigeasy@linutronix.de>
 <20241104105053.2182833-2-bigeasy@linutronix.de>
 <ZyluI0A-LSvvbBb9@boqun-archlinux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ZyluI0A-LSvvbBb9@boqun-archlinux>

On 2024-11-04 17:00:19 [-0800], Boqun Feng wrote:
> Hi Sebastian,
Hi Boqun,

=E2=80=A6
> I think this needs to be:
>=20
> 		scf_cleanup_free_list(cpu);
>=20
> or
>=20
> 		scf_cleanup_free_list(curcpu);
>=20
> because scfp->cpu is actually the thread number, and I got a NULL
> dereference:
>=20
> [   14.219225] BUG: unable to handle page fault for address: ffffffffb2ff=
7210

Right. Replaced with cpu.
=E2=80=A6
>=20
> Another thing is, how do we guarantee that we don't exit the loop
> eariler (i.e. while there are still callbacks on the list)? After the
> following scftorture_invoke_one(), there could an IPI pending somewhere,
> and we may exit this loop if torture_must_stop() is true. And that IPI
> might add its scf_check to the list but no scf_cleanup_free_list() is
> going to handle that, right?

Okay. Assuming that IPIs are done by the time scf_torture_cleanup is
invoked, I added scf_cleanup_free_list() for all CPUs there.

Reposted at
	https://lore.kernel.org/20241107111821.3417762-1-bigeasy@linutronix.de

> Regards,
> Boqun

Sebastian

