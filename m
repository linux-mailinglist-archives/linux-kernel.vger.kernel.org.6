Return-Path: <linux-kernel+bounces-244235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ACB992A14F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 13:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E4B21F21FE6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 11:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E049F7E767;
	Mon,  8 Jul 2024 11:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LsrnwnoV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3464C101E2
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 11:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720438857; cv=none; b=eZMvswrQj3+hOT9cF9CFB+QWvUygRzr3XJvklU+sJVqZMwxgeOmXTVzxu755niV/xpcjjN8VN73O9cjS84mw3eEgKTEZBoNnaVphoqZJ6InN59P9Tqo4i+YSsFhApxjwLleD15PR0MSaWNpJY5RKr+BihLvhSPR+HW0jhCpA5uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720438857; c=relaxed/simple;
	bh=ggdsiSvYIt3dO3QAER9JNCQH3Vfx9KGbwlDnZxd431k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KWxD7H1YeClt/5RV3IWf8z+GhpkjAIJp7Bl2/ERTImEwpuUqBOdGEt62ZiMUfPZmhT4936qBuipeLnqiJ1kxVCnSTYzYZR4xm4glRybb82aZpDctR619L5WC8bAmWATMvVjcsb1nUgnt4Z4tSK5PeLvLfTwEZ8V4STBBW6O/3ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LsrnwnoV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4ABAC116B1;
	Mon,  8 Jul 2024 11:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720438856;
	bh=ggdsiSvYIt3dO3QAER9JNCQH3Vfx9KGbwlDnZxd431k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LsrnwnoVctpTMcIY7idaSAVCnh0RRgWjZgFkRd0ljN8qqc+nP+bfdD738bYDh2SZV
	 4RM4lgElz1IbThXf+cfAryxDJHT5mN5vyFNapcYQbIyFMOVGMbTnbfU442LzybJth9
	 bJBqer8uTFRwtPXqJ55nyr7jKsw4Yvm71B6/i4ZfN2ZdfFLYcSzkLK3lAYCbJ723jv
	 s8VqjDxpo3hM5i7743U6OJrpOafLwp/CMWdAXBOVRg/rMFqXTPFkdTUMQK81GtlYuK
	 89KKKaC/dF/CcD1Jan8txNKmNwcEJ7N7kA6r4M45obUwGHPFEQGXBwWiP6bVXlcVPM
	 hLKZWJ0vsFsPg==
Date: Mon, 8 Jul 2024 19:26:45 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: select ARCH_USE_SYM_ANNOTATIONS
Message-ID: <ZovM9YYql8ui9Tp_@xhacker>
References: <20240705132308.1469-1-jszhang@kernel.org>
 <beb8a766-8143-40ad-912b-b04f7937d4a4@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <beb8a766-8143-40ad-912b-b04f7937d4a4@rivosinc.com>

On Mon, Jul 08, 2024 at 11:20:56AM +0200, Clément Léger wrote:
> 
> 
> On 05/07/2024 15:23, Jisheng Zhang wrote:
> > After commit 76329c693924 ("riscv: Use SYM_*() assembly macros instead
> > of deprecated ones"), riscv has been to the new style SYM_ assembler
> > annotations. So select ARCH_USE_SYM_ANNOTATIONS to ensure the
> > deprecated macros such as ENTRY(), END(), WEAK() and so on are not
> > available and we don't regress.
> 
> Hi Jisheng,

Hi Clément,

> 
> On which branch/series is it based ? I tried it and it fails on
> errata_cip-435.s which still contains some uses of ENTRY():
> 
> ENTRY(sifive_cip_453_page_fault_trp)

aha, I see what happened. I did some asm -> c convesion [1]
two weeks ago. I also converted the sifive_cip_453_page_fault_trp etc.
to c as well, but I decided to not bring too many changes
in the last minute, so the last patch wasn't sent out, but
it's in my repo ;)

I will send out v2 soon. Thank you so much!

Link: https://lore.kernel.org/linux-riscv/20240616170553.2832-1-jszhang@kernel.org/ [1]

> 
> Thanks,
> 
> Clément
> 
> > 
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > ---
> >  arch/riscv/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index 0525ee2d63c7..c51b32a8ddff 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -62,6 +62,7 @@ config RISCV
> >  	select ARCH_USE_CMPXCHG_LOCKREF if 64BIT
> >  	select ARCH_USE_MEMTEST
> >  	select ARCH_USE_QUEUED_RWLOCKS
> > +	select ARCH_USE_SYM_ANNOTATIONS
> >  	select ARCH_USES_CFI_TRAPS if CFI_CLANG
> >  	select ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH if MMU
> >  	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU

