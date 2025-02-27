Return-Path: <linux-kernel+bounces-536348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE5CA47E74
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6348E188AC09
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44D622CBF9;
	Thu, 27 Feb 2025 13:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BD8SODM4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545DD1662EF
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 13:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740661341; cv=none; b=kR44ETBsS0aFKi92wMn1NOi7AN6D/0NS2cPedxfKUoX5diR6ex2U3zSHLYe2K4SUKL5aB72tKBoS2q+3q1de42irbqvEgVr2vWbpLgzWkFjaJoq54FjjwBq+HWbW5GjSmaGVz4qLjpdxScRqael06VGp9SC+6Y2V/y7fsE7qB2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740661341; c=relaxed/simple;
	bh=BWhyXiuwSOv2ohv2ZadQVGsTB+PeqblJYGnKLSvBdTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P3JrclRKFHitwenDsmAenWpFrH1iS4pWWnLwBd/sY2KX65ZtSLCRvpWthCOenqdgI+eEbY03k03efoFl2zBxwSuK0LNRpBxgWD0Sb/HgbS0NDmAS16QU4Kujw51EQlIz5766dSfgRzWvBebqCIOG2PgfeoCtN7R8PnxyOTdyKCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BD8SODM4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86463C4CEDD;
	Thu, 27 Feb 2025 13:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740661340;
	bh=BWhyXiuwSOv2ohv2ZadQVGsTB+PeqblJYGnKLSvBdTo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BD8SODM4H92ii2XLIMdsB9tWXcaFDRqCVP/Y3qARsx6yFS1ZSOYBrCJd/DdFLTDJZ
	 li4OeTt6ifZlSvEvsp1Y2a121o+oOCk6QHrZe2dFo0jy76wH9QOq2P5kb1J+rqelJ4
	 ELY+n2vT5IXFWgQJT1ZjsZNbVvw0fsWBO48+L5QY/NjT7xAfW8dxAGEJeS38ig193K
	 qjZYoZToz3mXOdFQFSo5D6Q/A2VsK/8GS5GTZxA18J4N1SAuKfibQM4zBZHmR0N6MZ
	 vyDsRjtXBxVkFjRBddSEIuPlwTxBSFLGC1fSx3EuXqkB60Egnsuvafwv9aKqx7lOio
	 zo0XQPpgDPW/A==
Date: Thu, 27 Feb 2025 14:02:10 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, bp@alien8.de,
	dan.j.williams@intel.com, dave.hansen@linux.intel.com,
	david@redhat.com, jane.chu@oracle.com, osalvador@suse.de,
	tglx@linutronix.de
Subject: Re: [PATCH v2 2/2] x86/mm: Remove unnecessary include in set_memory.h
Message-ID: <Z8BiUnkPnvrx06vp@gmail.com>
References: <20241212080904.2089632-1-kevin.brodsky@arm.com>
 <20241212080904.2089632-3-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241212080904.2089632-3-kevin.brodsky@arm.com>


* Kevin Brodsky <kevin.brodsky@arm.com> wrote:

> Commit 03b122da74b2 ("x86/sgx: Hook arch_memory_failure() into
> mainline code") included <linux/mm.h> in asm/set_memory.h to provide
> some helper. However commit b3fdf9398a16 ("x86/mce: relocate
> set{clear}_mce_nospec() functions") moved the inline definitions
> someplace else, and now set_memory.h just declares a bunch of
> functions.
> 
> No need for the whole linux/mm.h for declaring functions; just
> remove that include. This helps avoid circular dependency headaches
> (e.g. if linux/mm.h ends up including <linux/set_memory.h>).
> 
> This change requires a couple of include fixups not to break the
> build:
> 
> * asm/smp.h: including <asm/thread_info.h> directly relies on
>   <linux/thread_info.h> having already been included, because the
>   former needs the BAD_STACK/NOT_STACK constants defined in the
>   latter. This is no longer the case when asm/smp.h is included from
>   some driver file - just include <linux/thread_info.h> to stay out
>   of trouble.
> 
> * sev-guest.c relies on <asm/set_memory.h> including <linux/mm.h>,
>   so we just need to make that include explicit.
> 
> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
> ---
>  arch/x86/include/asm/set_memory.h       | 1 -
>  arch/x86/include/asm/smp.h              | 2 +-
>  drivers/virt/coco/sev-guest/sev-guest.c | 1 +
>  3 files changed, 2 insertions(+), 2 deletions(-)

So I tried to pick up this patch belatedly, but there's more places 
that mistakenly learned to rely on the stray <linux/mm.h> inclusion, 
for example on x86 defconfig-ish kernels:


  In file included from drivers/gpu/drm/i915/gt/intel_ggtt.c:6:
  ./arch/x86/include/asm/set_memory.h:40:57: error: unknown type name ‘pgprot_t’
  40 | int __set_memory_prot(unsigned long addr, int numpages, pgprot_t prot);
  |                                                         ^~~~~~~~

Thanks,

	Ingo

