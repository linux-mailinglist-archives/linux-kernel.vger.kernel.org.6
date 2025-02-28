Return-Path: <linux-kernel+bounces-539036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFFDA4A009
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 471D17A0613
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 17:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD6B1F4C92;
	Fri, 28 Feb 2025 17:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="blOqq7ri"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2E71F4C87
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 17:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740762880; cv=none; b=PTmoVGoEdXcn07TctyjXF9KcyjOR10Pvxckg2q9uCm7YVO87BB0JCZluc1UzPfSNc2FpUK+Moqc5ANWOO/FOBFxLAf7NFDD2h17LmUW8Icu7TArxRU5FaGLtJDPsXKa35eas9GhD5fCGjlinj63JTiNUVQf+MdPblSeaywl18zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740762880; c=relaxed/simple;
	bh=NUeO+pACom+KYAvSBkCxTGgdvDOR9Jpk1E6DXGXn5d8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JKakhsZnzRMuxkupJh/4sjJN8zIiGYYnm1SIy6Wet9gWlMe7wdza9/HQzMUKwkALRSPFKsX5g2h21ore4eYInnmiMd02jIKee2pcRDxp7dRIGuQ96xaBUboSUke55uHpLG9aKI50o2oyZ+4asFF1CT8gzCUqR3vnU49wP3aTqqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=blOqq7ri; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26549C4CEE5;
	Fri, 28 Feb 2025 17:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740762879;
	bh=NUeO+pACom+KYAvSBkCxTGgdvDOR9Jpk1E6DXGXn5d8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=blOqq7riYw7R2bigdfXnOIr7FBqTYdzXTdZGHwRMGAX8zLhtdK1E+SlbmmjRxOjxW
	 4pcfCBzvvrkg8moo3H6dW1nRmeS7jZ1U2IfwO02whAEsP89tOkl+g6JJ1UVw1Cmech
	 +7g60/hSpSx1LcShpVYdqrZSElpf3w6pOIYp554pOJpnSOlmEe4O687MWQLigOyVfv
	 4WKGu+AMVDlUJ1GZhFuM3DuBwd3eyIq1VH9ofgDfLqZKCV0oFqPnr+JvMPPpVexa7x
	 oBMgNvy9wjZiETUS/+OyXEgvAcx/8xQ32rHdcJfeJMCQENI9N7pEKgIfUKCM8wu0LF
	 QKWg1oZ7M4dwQ==
Date: Fri, 28 Feb 2025 18:14:26 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, bp@alien8.de,
	dan.j.williams@intel.com, dave.hansen@linux.intel.com,
	david@redhat.com, jane.chu@oracle.com, osalvador@suse.de,
	tglx@linutronix.de
Subject: Re: [PATCH v2 2/2] x86/mm: Remove unnecessary include in set_memory.h
Message-ID: <Z8Hu8oDHRnLx_gxm@gmail.com>
References: <20241212080904.2089632-1-kevin.brodsky@arm.com>
 <20241212080904.2089632-3-kevin.brodsky@arm.com>
 <Z8BiUnkPnvrx06vp@gmail.com>
 <Z8BirVtqibWY6zaT@gmail.com>
 <ce29384e-b3fe-4196-a986-bb57a5d693d6@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ce29384e-b3fe-4196-a986-bb57a5d693d6@arm.com>

* Kevin Brodsky <kevin.brodsky@arm.com> wrote:

> On 27/02/2025 14:03, Ingo Molnar wrote:
> > * Ingo Molnar <mingo@kernel.org> wrote:
> >
> >> So I tried to pick up this patch belatedly, but there's more places 
> >> that mistakenly learned to rely on the stray <linux/mm.h> inclusion, 
> >> for example on x86 defconfig-ish kernels:
> >>
> >>
> >>   In file included from drivers/gpu/drm/i915/gt/intel_ggtt.c:6:
> >>   ./arch/x86/include/asm/set_memory.h:40:57: error: unknown type name ‘pgprot_t’
> >>   40 | int __set_memory_prot(unsigned long addr, int numpages, pgprot_t prot);
> >>   |                                                         ^~~~~~~~
> 
> This patch relies on patch 1 in this series, which removes 
> __set_memory_prot(). I seem to be able to build x86_64_defconfig 
> without issue with both patches applies on the latest mainline.

Oh, the 1/2 patch was missing from my mailbox (my mbox's fault, not yours),
and apparently the 'PATCH 2/2' tag wasn't a big enough of a clue for me
that there's a dependent patch. ;-)

Anyway, I re-tested it with both patches applied and it's all looking 
good now, and I have applied them to tip:x86/headers.

Thanks,

	Ingo

