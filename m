Return-Path: <linux-kernel+bounces-551200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E95CA56959
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 14:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 338CE1783D4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 13:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FB621ADCC;
	Fri,  7 Mar 2025 13:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z0++ta11";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tc1LYX4G"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D21F21ABD7
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 13:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741355289; cv=none; b=O6oxHb/uf5lsBuzP3rrky8Myd53Yb/9ERq0DxKnvIbK8rD1t+cixkanZbmbV/OHvvCJapofyThnQffgGRKrB0KM6q+zq8yk6ddcyPrE4vlqY0A/KKmBsrIzZ19vjqhuGE7S3qnv6Q3xSeyyizVfimxnGkKyDGnXfJiMVF+33ncE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741355289; c=relaxed/simple;
	bh=XcqIEEJGSi8aUmJHCEIcXsVJ/HfjYYX9FY26+bSCQMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iQeAjgp/tgaFhmI5y/ioTvFUB9qxTVRUo/bPLau3nUFoPCFdAKEwB5Rl+DMvEAbN1y4TIJTNfLCQqboWyJ3bT4aZnifReyfpaalUaMOC97KPUR3C9U++3K3ib5Lo0V4uHix9y+S1/K7IGMXmwtADZhZFmI4t8OySaC+vtsmOx/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z0++ta11; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tc1LYX4G; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 7 Mar 2025 14:48:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741355285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C+ps/GbNo7Lb+DsAaK0x7WRuor9Nl46Th5feabU2ueI=;
	b=z0++ta114LNxIj8y+Nr0co7/X/d1U5JZ07d0TIMKvta4eGiHPtDrN9T7hpt5kVLvpaQce2
	hyErXMBmIuP+ucOpDBir+uxTsgYur79sanDS/a25ldd8/d/ssHc6O1cW3WS+qixg821HbS
	NDg0efLA/Qd5g7CUZTPq4bYsToNWwcayGX+gfsulB3b1qMFj3Lp4dDuQWG9J1IqAjIbWhe
	8Bm83qYUmg5ZitI6fw6Bo0jdh8qQ4llRZmdTCCFvGJZwMtGaau5GeLLuyyKDiGLZET5T16
	HtLzfgvEFwBDnUc99dsFvTCN+/iLQtoziSrQUe+OA6lgQEQj9RD0yCsNiuHjcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741355285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C+ps/GbNo7Lb+DsAaK0x7WRuor9Nl46Th5feabU2ueI=;
	b=tc1LYX4GDRhM58yU73WCurUCAWkIaIA7iQw1OjgiGXpuxk6DQPUveLUstXak3ytrbdfPNh
	Lkl8GwbUp1Cg4pAg==
From: "Ahmed S. Darwish" <darwi@linutronix.de>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	John Ogness <john.ogness@linutronix.de>, x86-cpuid@lists.linux.dev,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 07/12] tools/x86/kcpuid: Add rudimentary CPU vendor
 detection
Message-ID: <Z8r5E3wfFyv-n8XK@lx-t490>
References: <20250306205000.227399-1-darwi@linutronix.de>
 <20250306205000.227399-8-darwi@linutronix.de>
 <0ada12f8-4fdb-4dad-90f7-b044993e829c@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ada12f8-4fdb-4dad-90f7-b044993e829c@intel.com>

On Thu, 06 Mar 2025, Dave Hansen wrote:
>
> So, this is cute and all. But isn't it a _wee_ bit too clever for its
> own good?
>

That was funny, thanks for the laugh :)

> Why not just have a dumb array:
>
> 	{ INTEL, "GenuineIntel" },
> 	{ AMD,   "AuthenticAMD" ],
> 	...
>
> Are we really looking to save a few dozen CPU cycles in this thing? It
> took me at least a minute or two of staring at this thing to figure out
> what the heck it was doing.
>

Indeed.

For some reason I forgot that this is all little-endian and a simple
strcmp() like what the kernel does at get_cpu_vendor() would suffice.

I'll fix it in v2.

Thanks!
Ahmed

