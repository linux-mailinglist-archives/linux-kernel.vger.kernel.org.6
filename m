Return-Path: <linux-kernel+bounces-551236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1D0A569EE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 15:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC6183B04BD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 14:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B5321ADA4;
	Fri,  7 Mar 2025 14:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lJaj/OxB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G1r6x2oo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E713421ABD7
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 14:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741356386; cv=none; b=ghW87gsonQh9NxhA495ZnZJf1Ppd2XIqsHlUTBZxIQEwzQMo/7hzd2L6gXgLUGXZtJSxVg42AUMS2s1UdQunYj/UeT2I2jq+3j70WkMRic/pJgM6IezuHA8mZaitkSDbwb/x1Bsr4wVFI6Phkw/bG4esEqzRIOprA9yBhdYFCmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741356386; c=relaxed/simple;
	bh=wqhy5TPYm5RJ0L6opguVJAW3lnezYmtMO0kEqr5M6b0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KItsrqhN98XkduXVpqdja15PzS4Zy06mBxOFsalSK1km6lhl7aFO39erxGbur7+3vdpEeYevrYtESNvVV/bzHUV7uiC8tEXeFxyfcIl4WfFnwFmtwS+OkFJuWLxfAE7eIJUjPZk8e02fnRRhMRRm0DLh4nqqdQGyQcvLbmq1DyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lJaj/OxB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G1r6x2oo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 7 Mar 2025 15:06:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741356382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wqhy5TPYm5RJ0L6opguVJAW3lnezYmtMO0kEqr5M6b0=;
	b=lJaj/OxB/OCDp40EPPN5/PONPbRUU5n0NWOPOXjqVqkyy6UQGVsNoslUOsErDVLdvcgyh1
	k/nzSSu4aeYqS83I2F+Vjx6bPJzeYDgVI509A+rCLAfK2gxVEgWM3PF7gn7tpfzRyDypsN
	y/Eu+6tQ48xCCmRQUtro5P3OwAGTTLNtOHQFspcWwz0j6NV58EkHNUFjx8P2PU9HgPx6PR
	uVxqDFG2T/VSRte8wIyflqpa8J5Cfdmh364u0FBGusk1ztMvgD1HiWrXHjKv91aO1btDRV
	rQPwVgQUwit38OTObdAGBS/IgkrywPkTXfwh0VS7ClYhRTGECI7VGdyLwJzB/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741356382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wqhy5TPYm5RJ0L6opguVJAW3lnezYmtMO0kEqr5M6b0=;
	b=G1r6x2oolXoGZBGc0KHhALnd3QiFSQa1xWbhTYaNtLGUvqSaqUUZC5q7ZPsL1pgebUN8Uo
	jo1PYgMzxIWMgPAg==
From: "Ahmed S. Darwish" <darwi@linutronix.de>
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	John Ogness <john.ogness@linutronix.de>, x86-cpuid@lists.linux.dev,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 07/12] tools/x86/kcpuid: Add rudimentary CPU vendor
 detection
Message-ID: <Z8r9XN1wyYEDa_ji@lx-t490>
References: <20250306205000.227399-1-darwi@linutronix.de>
 <20250306205000.227399-8-darwi@linutronix.de>
 <01a2a955-98a5-47f6-aeb2-275ba840a9fa@citrix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01a2a955-98a5-47f6-aeb2-275ba840a9fa@citrix.com>

On Thu, 06 Mar 2025, Andrew Cooper wrote:
>
> Many CPUs have ways of overriding the vendor string, thanks to
> GenuineIntel being hardcoded in too many pieces of software.
>
> I suggest you check all registers, lest you find yourself on a CPU
> claiming EBX=0x68747541, ECX=0x6C65746E, EDX=0x6E65476E
>

Indeed; will do.

Thanks,
Ahmed

