Return-Path: <linux-kernel+bounces-567474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6536A6867D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 115451787D1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 08:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA7D24EA84;
	Wed, 19 Mar 2025 08:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C5F2QAPm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5DcDYoHB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4069A1EB5CC
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 08:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742372186; cv=none; b=aHw2MMZKTe0RHWrzPK5FZFz+OA4EZIDrUZNumbaIDsBstHozWtCRx+ZS0kqVVBHXoRR8EdIRHrfDGsppvA9HwTy9Y9HI7KrBa2dQ72hn8arJkD1I54tivSWMcjE3v8O3qrIH79EMuQGLXsybynFMt+KFjiginr5LjJ+4yAzLM64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742372186; c=relaxed/simple;
	bh=Pbb9BiHnxDGEIgYBADMDYqNBuyKNR/9/tEk3ALFWiKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DcRNZlMmbaoD7CT/3VpLL/DwznaXiEPLOwTUpXCxSlgmKu3GrQrKJ/AMmGiPtKW7Zvvqhiv+o5rS/3XSpVQ9BWoNAP4cdvJwzrwwEfq+ybTwugFAq8f+ousF25rL7jZCzPVyN8Ur2ude3oszLgVNEjWMxtc3CgrUlv1RW9HyfSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C5F2QAPm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5DcDYoHB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 19 Mar 2025 09:16:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742372183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WO9m2LGJJUZOdGnuX3+SlQrVPHHc7n0EMu6Pdu4vqmo=;
	b=C5F2QAPm8kSdNwrIdGak7FuM/LxBNYj0if1a3nDSZCWxOnQomWHVtE17Mfjwj58mzU4IxU
	79j/hlUByTnovUxBA/GvmFzNypL1WWvhRZIFxCnlMShREpjqsFeAgBaY2vGo2D+a/UbiGR
	U1mVICaF2wNHQfaYQ6IYvsmCca277WOJQaMg0I/o/I0puxk9rjOnhU4FiIMn0N0eZvLbVq
	xkLLjxSbqi7sVSfW2aD/YCXBkjYii2x7zIbS/SD9KG6QsozfzBPheKCqFLdjzTo6NICGvY
	7w/ZWIJLYu9fP/KUbsfQy8+Qv54R6mTUho5Y74GvrVyBf2ze3qD+vHbg9iyEbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742372183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WO9m2LGJJUZOdGnuX3+SlQrVPHHc7n0EMu6Pdu4vqmo=;
	b=5DcDYoHB/mLasE11ZGWadfLimLhg7nyYQtTrbLJbkASW7Elf/H79MGYg3nsX3Y2EuWjKjG
	qOoUQLU+dW0J4iCw==
From: "Ahmed S. Darwish" <darwi@linutronix.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, mingo@kernel.org,
	linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 4/5] x86/cpuid: Standardize on u32 in <asm/cpuid/api.h>
Message-ID: <Z9p9VcQ3CO7Mrubl@lx-t490>
References: <20250317223039.3741082-1-mingo@kernel.org>
 <20250317223039.3741082-5-mingo@kernel.org>
 <5D7935C3-8CAE-4821-8E31-A43169B8CB83@zytor.com>
 <bb1d6eb7-7dc8-49be-a4b5-aa461e85ac0b@citrix.com>
 <57505261-45EA-48B6-824E-49AF2203C094@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57505261-45EA-48B6-824E-49AF2203C094@zytor.com>

On Tue, 18 Mar 2025, H. Peter Anvin wrote:
>
> tglx has suggested that we should cache or even preload the cpuid data
> (the latter would have the potential advantage of making the memory
> data structures a little easier to manage, given the very large
>  potential space.)
>

This is indeed in the patch queue that I plan to send after this leaf
cleanups one gets merged.  We have a data model and CPUIDs are cached on
early boot.  The cache is also refreshed during machine state changes
where the CPUIDs can change; e.g. a microcode update, PSN disable, etc.

Call sites then just do:

    a = cpudata_cpuid(c, 0x0)->max_std_leaf;
    b = cpudata_cpuid(c, 0x80000000)->max_ext_leaf;

    struct leaf_0x1_0 *l1 = cpudata_cpuid(c, 0x1);
    x = l0->cpu_vendorid_0;
    y = l0->cpu_vendorid_1;
    z = l0->cpu_vendorid_2;

and all the data is retrieved auto-magically from the cached tables.

The struct leaf_0xM_N C99 bitfield listings are auto generated by
x86-cpuid-db of course, just like in tools/arch/x86/kcpuid/cpuid.csv.

Thanks,

--
Ahmed S. Darwish
Linutronix GmbH

