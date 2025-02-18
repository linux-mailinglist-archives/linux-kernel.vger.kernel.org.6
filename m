Return-Path: <linux-kernel+bounces-519669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9779FA3A082
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 15:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 458EB16782E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 14:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F2426A0D2;
	Tue, 18 Feb 2025 14:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ghV3OEoC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MmFO/Pi6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBAE269AF9
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 14:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739890163; cv=none; b=BJeXaxzyzPhMC6Y8NW9fQ67d9GEV0pSMXgTVb3jXUmZrnfimK9H+gBjxa0zHTTK9QloeH0wNT1HdCayuBbXA7pTh57Wtw9kF+S7pW+QIqwBclqsCjAHU8WxZS1h0ZtwG6JGpi078xtl8lHlEW9Kyzje+c84fumXWbib3wAKiEU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739890163; c=relaxed/simple;
	bh=EoFCNMATQP3Q9pMrw/bMv7YovslbUB9wfmbqPQ09s10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LBofn+8SLO7CZzom4pJ3P3payyad51TF6SE/w1e3kDKF5ngFhnbiuER0D5lYRIpHlgFicvoQShGBHB7C5+93+w9iPJwNz47JGdQoL2J7cZ3nZ+XRw7B+dLqCYA/nxQoayLI73faHGMepvwCBHMRgP91K3OUlSNDP49hLdpwXOz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ghV3OEoC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MmFO/Pi6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 15:49:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739890159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BfQaGrORdum9vGG5fQzt3Nbocsm7WjhndHQi5585VyI=;
	b=ghV3OEoCYxMjCHDtgSFEhjxZv1ibhMuYkRHOxDJq2VplgZAtywfWj8WmCnSa3yDGpB0T0g
	VNhhNu9b3kg7vuio7krvuQc+f7QR/MMXKHFkc4m8tnD/z9n7XPl+ZRr/lP460r1tXT08D9
	GdiIYiZ+qr4pSkvQgefhQt0cCJVdEXROSICZP7Q0/RyF8+dqLg5erIxVZ5Zu1Zm2N65k+C
	HTEjGpnI6eOLIbbzpbk3VHHFuOSoLcg8RCg/ayhui5AGJMSZobtQKI0YRa2MjV7XlXVS6V
	b38yrd7jl00YfpljHwFtjvTvDqf0IF8YUKBkO5DtvBfcRKxU4LC62oWWN40hfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739890159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BfQaGrORdum9vGG5fQzt3Nbocsm7WjhndHQi5585VyI=;
	b=MmFO/Pi6ESc16H/nlsONL22mJ4HvnJjwo72oTws3KYtfdvo8NHcHtxfXYo6KD0aSzGCCXB
	r5iogN97eZXPWFBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, Petr Pavlu <petr.pavlu@suse.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [linux-next:master] [x86]  66fbf67705:
 kernel-selftests.kvm.hardware_disable_test.fail
Message-ID: <20250218144918.Rl33HhXh@linutronix.de>
References: <202502140800.ebac2328-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202502140800.ebac2328-lkp@intel.com>

On 2025-02-14 10:03:18 [+0800], kernel test robot wrote:
> kernel test robot noticed "kernel-selftests.kvm.hardware_disable_test.fail" on:
> 
> commit: 66fbf677051818b9b5339fa8bfeac1b2e288efa5 ("x86: Use RCU in all users of __module_address().")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> [test failed on linux-next/master df5d6180169ae06a2eac57e33b077ad6f6252440]
> 
> # timeout set to 120
> # selftests: kvm: hardware_disable_test
> # Random seed: 0x6b8b4567
> #
> not ok 73 selftests: kvm: hardware_disable_test # TIMEOUT 120 seconds

I've been playing with that. It completed after ~45secs. The linked
dmesg had also mmu_stress_test timed out but it completed here, too.
I had a timeout in access_tracking_perf_test and memslot_perf_test.

The box is very sluggish. LOCKDEP, KASAN and maybe UBSAN cause that. I
would say the commit in question is innocent.

Sebastian

