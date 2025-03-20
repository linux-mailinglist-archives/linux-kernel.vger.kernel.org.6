Return-Path: <linux-kernel+bounces-570306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1381A6AE99
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 20:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B67F13BB14E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 19:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBB0227EAE;
	Thu, 20 Mar 2025 19:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dyE0zpdC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Jo57SlfX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12431E3DDB
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 19:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742499202; cv=none; b=mrJ1JX+TPTbcTp3b9w1duVSLJAga8lNkqmoBNxHOgeU1ke+QTm4/kuIgUlJYWEWQS7EmoRHYman2/LNWx1MjHWHw7pL08oH4r2KtyGMZOPAso1OKnS37nhEe+Frdjyo5qjipOSShLY3yikr8MA0TP0z0yXkgwKflINbEyXZ2vJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742499202; c=relaxed/simple;
	bh=n2WuDKUJehig2OqByicj1g7VjYrq/PTeP2s0UY6W1go=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=b3U4EZCr6sTuTD+3FD/SaRuHelgDp9aHqdsyeJ8eWvqOvWEjRKR6XVgINXp1aUwY8p4M0lZDOCpVdVHWnzO0qnV1csB0WpTQzI/QDAvTFMroj24O/fxMZHgRYetd8Y2vX2oSzMx/7qkq1G91TGGqGBCC4H3TWhDt8JzUS+XaHHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dyE0zpdC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Jo57SlfX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 20 Mar 2025 20:33:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742499198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=Dl7nJorMTIUh6c864KG5H8S26ZyKWP2DgtImU18sjfM=;
	b=dyE0zpdCHp5FK1SSzbFFEpGygaozMaQD7LQDWSLbb7S85V3Gh3LN0/B3+q/WduCVMxFit3
	8HDHvNG2IMdJXloapeANKKnecSkAH+zfcKnOVdxgjtJDzWBCQHh5kS1cEMXYVL8tQt1y7a
	sXEM07LWjsfdHMMAgD3nXkYDXVDSklT1RNtsWClx6sz7H5Tw6XSrQSGjEdvA+Wyb57iuF4
	SbNqmkzLuHMyuvrDQ5P6tIvNVtly2bY/X65JNELietnuREYsK9pxbhEdyQ9lrJb/XHmrYC
	y7qoUK2BD1gbrZfAjKx2Q8KJ2jLoGvsCVNFYhcFAgU2TKknwEHSnNz7NNO+RIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742499198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=Dl7nJorMTIUh6c864KG5H8S26ZyKWP2DgtImU18sjfM=;
	b=Jo57SlfXu6hChPbC2fmm2psLr3kMlPM9nbkL0S0q++GJoXugCTApih6jNdBY5lh5+lB7vc
	jmKO1twCqs1KxYAQ==
From: "Ahmed S. Darwish" <darwi@linutronix.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	John Ogness <john.ogness@linutronix.de>, x86@kernel.org,
	x86-cpuid@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
Subject: [x86/cpuid] Question regarding historic leaf 0x80000000 code
Message-ID: <Z9xtfC5pL-g4LYvK@lx-t490>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi hpa,

As you probably know by now, we're working on a centralized "CPUID table"
data model, on top of the cleanups at:

    https://lore.kernel.org/x86-cpuid/20250304085152.51092-1-darwi@linutronix.de
    https://lore.kernel.org/x86-cpuid/20250319122137.4004-1-darwi@linutronix.de
    https://lore.kernel.org/x86-cpuid/20250312143738.458507-1-darwi@linutronix.de

The idea is to remove all the direct CPUID queries from the x86 code, and
access a pre-filled table instead (with caveats outside the scope of this
question.)

While changing the CPUID queries one by one, I've stumbled with:

    => arch/x86/kernel/cpu/common.c
    void get_cpu_cap(struct cpuinfo_x86 *c)
    {
	...
	/* AMD-defined flags: level 0x80000001 */
	eax = cpuid_eax(0x80000000);
	c->extended_cpuid_level = eax;

	if ((eax & 0xffff0000) == 0x80000000) {
		if (eax >= 0x80000001) {
			cpuid(0x80000001, &eax, &ebx, &ecx, &edx);

			c->x86_capability[CPUID_8000_0001_ECX] = ecx;
			c->x86_capability[CPUID_8000_0001_EDX] = edx;
		}
	}
	...
    }

You've contributed that snippet here:

    https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git/commit/?h=2.4.0-test11pre5&id=67ad24e6d39c3

Do you remember what was the rationale for the "if (eax & 0xffff0000) ==
0x80000000" check?

You've also contriubted a similar check to head_32.S:

    https://lore.kernel.org/r/1258154897-6770-2-git-send-email-hpa@zytor.com

    /* Check if extended functions are implemented */
    movl $0x80000000, %eax
    cpuid
    /* Value must be in the range 0x80000001 to 0x8000ffff */
    subl $0x80000001, %eax
    cmpl $(0x8000ffff-0x80000001), %eax
    ja .Lenable_paging

So I would assume, it would be safe to have a similar check in our
centralized "system CPUID table" scanner.

In all cases, if you know more details, it would be great to know, so
that I add it in the centralized CPUID table patch queue changelog (in a
separate patch.)

Thanks a lot!

--
Ahmed S. Darwish
Linutronix GmbH

