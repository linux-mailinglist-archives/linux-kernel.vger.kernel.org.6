Return-Path: <linux-kernel+bounces-402204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6579C2502
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 19:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 041FE1F22B7A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 18:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095A11A9B36;
	Fri,  8 Nov 2024 18:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zXftWIVt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LeDBfPQI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA41199385
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 18:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731091516; cv=none; b=HQSm+puK1k0bqc/4nsV7JJKdMolrmAA6FmsDDlYptU5/25TtBNvGq9ZZVWcq42kdRfMK6F4hk/tPEQacHol/LJG2k02/1YD3aYB5RyHrsL/RP8HpNRR9x6s1TjYLpVDQ5W1alUuatg2kakmlw27WxE75cR2clo0A8KksbcIiWB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731091516; c=relaxed/simple;
	bh=qEiklefkYlY8X0R8IH2gpRPFRBj7H4mRe1NAK1dYnqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TY5cukSwS2vFzA69MIv1ymgmzhwlejUn01BXnNrf3bQHN2/LjOYnfktJOsb4bTG8Bo3UoF7ep1fRYb6JGj0uNEdV/5hIkS6OsQ5eRAjVly5P9mWE3goZ7D2mWvzWEjnX+AOpRvjg2CUwLb8IGVeVnNOgHvVGjugXrm8lLn61kLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zXftWIVt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LeDBfPQI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 8 Nov 2024 19:45:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731091512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=smasxwc1HueSLuJ/s/xYGqRFsxf23PGmCoAvEW1t/yw=;
	b=zXftWIVtHzkqN6ywIXt3x2UIsgkA+vFNCtUKmMAabNTOiEBrIsUvqifQN7cylHSiTlenth
	YhP/PIALheIZKNe3SBpUKAJ5dgSPfrdYzws9sdQqnoRqvs5/95hVxjKSXDxKgO/928qlgT
	ZGX9G8USbZLHcg/eoMJsYPXRagGFhqlLD+RHACJNG2+7uCtsMDIt3dJ+7WVkSnmNL4A6dr
	QajWHZ/0hPHRcrBad1YPhkJlDG3MhboGzxlEAP066ebTJh7lvXSM7gEDViR53N7a+cMwlT
	LQtkfINPOe7r+ANiAZCF7AlqB8wKi1a8lA1ZbwmbekfmS9YLMprovsrIbiTvGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731091512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=smasxwc1HueSLuJ/s/xYGqRFsxf23PGmCoAvEW1t/yw=;
	b=LeDBfPQIY1MVm8UGldREjqwNkHhu8P3umZ1tnddLnzAxZnFBxKBkOj/piurBHbxPOiwhy4
	E3ZgNyXCh2Sm0xBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Marco Elver <elver@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>, akpm@linux-foundation.org,
	cl@linux.com, iamjoonsoo.kim@lge.com, longman@redhat.com,
	penberg@kernel.org, rientjes@google.com, sfr@canb.auug.org.au
Subject: Re: [PATCH v3 0/4] scftorture: Avoid kfree from IRQ context.
Message-ID: <20241108184510.O8w42_-e@linutronix.de>
References: <20241108104217.3759904-1-bigeasy@linutronix.de>
 <Zy5OX5Wy0LsFPdjO@Boquns-Mac-mini.local>
 <18b237cf-d510-49bf-b21b-78f9cebd1e3d@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <18b237cf-d510-49bf-b21b-78f9cebd1e3d@paulmck-laptop>

On 2024-11-08 10:33:29 [-0800], Paul E. McKenney wrote:
> Sebastian, I am guessing that the Kconfig change exposing the bugs fixed
> by your series is headed to mainline for the upcoming merge window?

Yes. It is in tip/locking/core.

> If so, I should of course push these in as well.

That would be nice ;)

> 							Thanx, Paul

Sebastian

