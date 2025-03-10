Return-Path: <linux-kernel+bounces-554465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C57D7A5980C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5873F7A2EAE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 14:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F351AA1FE;
	Mon, 10 Mar 2025 14:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pVylE1H+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AMaTnbiZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F209F21E0BC
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 14:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741618040; cv=none; b=sbFIj/4gwlNjdP6OFblgGhhJ66MtosM1+IaB1FP86rwKN37iskFDlDZOiHTsQz4soCip20pPe9WV7xui/hZJKUKomqlfBst4PoNGIkgbjkIMGV8HuR8xo6qRS2+FUMAxAwblRdA1J3LnVM/vbD5nIrRfqsW0vwjH4S05SxB58GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741618040; c=relaxed/simple;
	bh=3J4HPQC5Alvo5h1pDOlzk5eK0aUBfXtIT3thTrKUoC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r0J9EbA+w+eEAjXR6HhPTYolDJj1IAeIB8MND8yPagZRPABlZ7ZuQT57gABX/ojwiazVAQiKiLRCJQLjcEb53syrodyuxkAzM48vaR0U7B1VPYO7iloFtJAD38GUkWUwzT9YFbSp2dvegF/dFOJpn+inIk3CbRZ62ECy5SROo4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pVylE1H+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AMaTnbiZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 10 Mar 2025 15:47:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741618037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7b2ov5GBMC3MQq4xudbWOIYog0WKb2nVO/fY6omPp+E=;
	b=pVylE1H+EnISaczOaMZ98Aqq/RoVZtyJecnpQdZsWnLvALtRuKEZSBb4HRKOOluz/QaynJ
	4qodBqOI9PzKRNypl8rsCnMGOZIUOZeMSUaGe1mEXNb0doyobf8mCEHaxOOF01+C2fBC5M
	J3uUrE6uQetvMw2lOXiOnXfnjwZcrqK+LUl4pxkYAzbqTz7AmZV8TKR89570E+A63Te2NR
	pdlUpgiXVu+LAqe8hWU0JMAkiwjzpi7A0YSlZbB42m0kpiqiMlqjLw17KEqdZh0fLzQVSY
	KkpDm9P6wfgo7igIzanTLHNh/sdJt8XCVCnm4K53+QIhiLIPT4a/j/VU6rZhHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741618037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7b2ov5GBMC3MQq4xudbWOIYog0WKb2nVO/fY6omPp+E=;
	b=AMaTnbiZQQual7HtaCqzHQXl14ih2f39xW1Nv+xX/ze2Mio85eexuchRc9T1cuByvLpMJf
	oiWsQMrUREvhMnCQ==
From: "Ahmed S. Darwish" <darwi@linutronix.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>, x86@kernel.org,
	John Ogness <john.ogness@linutronix.de>, x86-cpuid@lists.linux.dev,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 10/12] tools/x86/kcpuid: Update bitfields to
 x86-cpuid-db v2.0
Message-ID: <Z877c2pAEYQ8SjCW@lx-t490>
References: <20250306205000.227399-1-darwi@linutronix.de>
 <20250306205000.227399-11-darwi@linutronix.de>
 <C7684E03-36E0-4D58-B6F0-78F4DB82D737@zytor.com>
 <Z8sLmGf2L4mszUEp@lx-t490>
 <B5E71AD5-3AA3-4B2D-A832-D95F72454E0F@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <B5E71AD5-3AA3-4B2D-A832-D95F72454E0F@zytor.com>

Hi!

On Fri, 07 Mar 2025, H. Peter Anvin wrote:
>
> On Fri, 07 Mar 2025, Ahmed S. Darwish wrote
> >
> > Thanks, I missed that Pentium III can provide leaf 0x3 as well.
> >
> > It seems that leaf 0x3's format differs between Intel and Transmeta.
> > On Intel, PSN is at ECX:EDX, while on Transmeta, the PSN is at
> > EAX:EBX, and ECX:EDX on non-evaluation models provide the rest. [*]
> >
> > Unfortunately, so far, x86-cpuid-db does not support having a CPUID
> > bitfield with different interpretations across vendors.
> >
> > Given that Linux force disables PSN at early boot, I'll just remove
> > that leaf from the database — for now.  (Time wise, finishing the new
> > linux/arch/x86/ CPUID data model for mainline submission is a much
> > higher priority.)
> >
>
> You can simply output the 128 bits as is. Some vendors will have zeroes
> in some of the fields, but it doesn't matter.
>

The x86-cpuid-db schema works on a register-by-register basis.  For
example, here is db/xml/leaf_03.xml (with Intel added as a vendor):

|  <leaf id="0x3">
|    <desc>Processor Serial Number (PSN)</desc>
|    <text>
|      If PSN is disabled, the returned register values are zero.
|    </text>
|    <vendors>
|      <vendor>Intel</vendor>
|      <vendor>Transmeta</vendor>
|    </vendors>
|    <subleaf id="0">
|      <eax>...</eax>
|      <ebx>...</ebx>
|      <ecx>...</ecx>
|      <edx>...</edx>
|    </subleaf>
|  </leaf>

Adding support for a one-shot EAX-EBX-ECX-EDX 128-bit range is definitely
doable, but it will require changes to the project's XML schema.  And
given the output format change, the kcpuid CSV file generator and the C99
bitfields header file generator will also need to be changed.

It is doable of course: in no way I'd like to set the project "in stone."
But it's more work than what meets the eye, for a very low-priority leaf.

Thanks!

--
Ahmed S. Darwish
Linutronix GmbH

