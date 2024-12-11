Return-Path: <linux-kernel+bounces-441348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 674C99ECD22
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 14:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2EFA281207
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 13:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3AF22915E;
	Wed, 11 Dec 2024 13:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g3QuKsaQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oZyZKAzo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F6723FD06
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 13:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733923579; cv=none; b=aM6xcF5rGILnQf5p6e/7ZkviPugGF72LctmkTJgnUCyKrWoy9eSL3Gu90eR51ZWJ/cocXnwDxzPGpEIvvWQ/1x/By8tj0YgnxxlyJjBSAyCgrSmSbwbZBlLvdApdV9Wk5E+oRdP2Tnp8udqEpYykmQPTuBiCquTHdktKH1GBXBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733923579; c=relaxed/simple;
	bh=kc92lyMc64EmcoKkji8Mj4FJICIwmhsOCGb3QKzavws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uycTQyubvuyliWLSVl7bpYzZ6hqvbiTPGBwDPOm+t/JT8Bd+nzlsZccmlbZb1Qx7xGQKDTBdxYXn5umhQfIp7gXzS19eOgcV5BU/7CbYGgtydH09k+9R3d1uYE+erGH/F83JZQHqGQRZQQ8Kt1G5BYtviFJjBRuw7ngGsF3gnY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=g3QuKsaQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oZyZKAzo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 11 Dec 2024 14:26:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733923569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2cC0jtNFF2OB7EPEgIvbsGCXy7/YyEZDKndIQ+GkiRE=;
	b=g3QuKsaQef6e6PeMK+2oy3noWjaNhgRV6gXBjaotK0lO44SUXfa0MTZpNhHcq16gz+qlVh
	PN8w+U8BTzrMD0xY6Au9o2yGSnpKt9H2DtoVk4Dc+3Rf4bAtt2eWYbu5Xmjf/rJg6A+KKw
	DowFb+Ip/fqTB+MOql8BHL9HcrugxZeAXRzp4gnmPRaUtwONCu4O3MNVUzSmfFEPE6aOJ+
	bVSiv4nmWM4r9C6KV3w1RMoMq/hazNgGNMiNlZxCpGixcaXJrKgY0Pe6JZ7wYH5aYnYqTc
	4syQuoDYqxu9xGeFhtBThSDQgJA/mXzLVCjK7ybGuftIy28Wb7EmgjLiovNzSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733923569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2cC0jtNFF2OB7EPEgIvbsGCXy7/YyEZDKndIQ+GkiRE=;
	b=oZyZKAzopi3biPeXNdIzMu7nkbrftsiKhCO4QLn9NSke2ZXhslY9IaxLL2rMo1dfnCMIfX
	ScXi8cERdOFVpFBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>, linux-mm@kvack.org,
	linux-rt-devel@lists.linux.dev, Ard Biesheuvel <ardb@kernel.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Jason Baron <jbaron@akamai.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Matthew Wilcox <willy@infradead.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Russell King <linux@armlinux.org.uk>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/4] ARM: Disable jump-label on PREEMPT_RT
Message-ID: <20241211132607.z1zDTk89@linutronix.de>
References: <20241210160556.2341497-1-arnd@kernel.org>
 <20241210160556.2341497-2-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241210160556.2341497-2-arnd@kernel.org>

On 2024-12-10 17:05:53 [+0100], Arnd Bergmann wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> jump-labels are used to efficiently switch between two possible code
> paths. To achieve this, stop_machine() is used to keep the CPU in a
> known state while the opcode is modified. The usage of stop_machine()
> here leads to large latency spikes which can be observed on PREEMPT_RT.
> 
> Jump labels may change the target during runtime and are not restricted
> to debug or "configuration/ setup" part of a PREEMPT_RT system where
> high latencies could be defined as acceptable.
> 
> On 64-bit Arm, it is possible to use jump labels without the
> stop_machine() call, which architecturally provides a way to atomically
> change one 32-bit instruction word while keeping maintaining consistency,
> but this is not generally the case on 32-bit, in particular in thumb2
> mode.
> 
> Disable jump-label support on a PREEMPT_RT system when SMP is enabled.
> 
> [bigeasy: Patch description.]
> [arnd: add !SMP case, extend changelog]
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Link: https://lkml.kernel.org/r/20220613182447.112191-2-bigeasy@linutronix.de
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> I slightly changed the patch from the version currently in linux-rt.git
> to leave jump labels enabled on single-CPU kernels that are still
> fairly common on 32-bit arm.

So HOTPLUG_CPU depends on SMP and without SMP there no HOTPLUG_CPU so
the patch function will be invoked directly. So we patch and flush.
Well, okay.

> If there are no additional concerns about this version, I will
> forward it to Russell's patch system

I'm fine with it, thank you.

Sebastian

