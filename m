Return-Path: <linux-kernel+bounces-542557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B21A4CB14
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 19:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E4E43A1639
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EFA5214A60;
	Mon,  3 Mar 2025 18:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CkvFLEnA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7551D89E3
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 18:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741027063; cv=none; b=EMreJWAoiUrCTAQCJd+PdEvcJ1wZCmkdSM1J9cH+5d4KRa2mG4enN5s48H1cZEMVvWsq/g9nMBzBlCkY+ADqsFEmG2RHw3dFwRAwFeVoJuFp4KpGCGtJByCr7uNUyCh4TyNMjQ/oAI4WoUINwmA8iwRPKfXYTlAWMfE8t+0wmoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741027063; c=relaxed/simple;
	bh=4wJnUn6bLZwdXITOKhU51m+BdwQm4p7YtPDTnXGun5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O0h8otQaJhiJQtOFqhYwg0aUyXuo8SZTPH+GxcLbMFJ+KJsE4oCQQKteuFWj5FEfwqKsBQ+74ckYtuXC1VvaF9hfRgu9RTuBIwZuDfOvGlc5ZQsDygy4y9INQCIzzQ1SadaaMrW/fUU355XwY5FXfs9kV9y57fdwH/z2Z5CbmQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CkvFLEnA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 304E0C4CED6;
	Mon,  3 Mar 2025 18:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741027062;
	bh=4wJnUn6bLZwdXITOKhU51m+BdwQm4p7YtPDTnXGun5k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CkvFLEnAl7lRgKKUK0kS0vdIg+01ByGjOLqfaJUGUnsc/7FyVFWGybB9CGzN1bYeB
	 n4vgYPzia1PXh20+M0Fy2SGDDS5XGrAVBSMHJcwXUwWcRTGuZ5PWHrUY9raqYUERn8
	 mDhjXJZZ5mK0DVWhftg2Ai+ok+Jb2QmtbNkMCKe41smz5Pgi9IKtoEVFXM66MoHie/
	 94ETebv26NMp8LLiV3X4x/6/AemS3hrOceM3HVett5G9T69MnJg+Y1zVcWSn+Dh0PC
	 GKZAwJ94IAANn/CWturujOG0QfSvQSpOqBv0U6Bbzd19HvUix/AI2YaigW3OgVsHSG
	 cHu7sGomQ7oZQ==
Date: Mon, 3 Mar 2025 10:37:39 -0800
From: Kees Cook <kees@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: lkdtm: Annotate do_nothing()
Message-ID: <202503031036.079F90AD8@keescook>
References: <20250303093817.GJ5880@noisy.programming.kicks-ass.net>
 <202503030921.2CD851B31D@keescook>
 <20250303183525.GA15322@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303183525.GA15322@noisy.programming.kicks-ass.net>

On Mon, Mar 03, 2025 at 07:35:25PM +0100, Peter Zijlstra wrote:
> On Mon, Mar 03, 2025 at 09:26:57AM -0800, Kees Cook wrote:
> > On Mon, Mar 03, 2025 at 10:38:17AM +0100, Peter Zijlstra wrote:
> > > Hi Kees,
> > > 
> > > During my FineIBT testing the other week I stumbled upon the following
> > > complaint:
> > > 
> > >   vmlinux.o: warning: objtool: execute_location+0x4f: relocation to !ENDBR: .text+0x1032008
> > > 
> > > I finally got around to looking at it and realized we have means of
> > > annotating that since 93f16a1ab78c ("x86/boot: Mark start_secondary() with __noendbr")
> > > (which might still be in tip only).
> > 
> > Er, doesn't that mean do_nothing() will lack an ENDBR? Wait, no, that's
> > __noendbr. What does this annotation mean if the function _does_ have
> > ENDBR?
> > 
> > Note that these tests are explicitly using __nocfi (via the
> > execute_location() function) since they're testing the Execute bit in
> > different memory regions. But I would expect BTI to still work (and not
> > block execution).
> > 
> 
> Argh, I had a definite wake-up juice deficit this morning, and the BTF
> noise made me miss that the warning wasn't fixed.
> 
> For some reason I thought do_nothing() didn't have ENDBR. Looking at the
> build now, I see it does have, and the actual location pointed to is
> do_nothing+0x18, which is weird.
> 
> Ooh, I see, the thing looks to have unrolled and inlined that memcpy()
> like:
> 
>    156a3:       48 8b 05 00 00 00 00    mov    0x0(%rip),%rax        # 156aa <execute_location+0x2a>    156a6: R_X86_64_PC32    .text+0x1032024
>    156aa:       48 89 43 38             mov    %rax,0x38(%rbx)
>    156ae:       48 8b 05 00 00 00 00    mov    0x0(%rip),%rax        # 156b5 <execute_location+0x35>    156b1: R_X86_64_PC32    .text+0x103201c
>    156b5:       48 89 43 30             mov    %rax,0x30(%rbx)
>    156b9:       48 8b 05 00 00 00 00    mov    0x0(%rip),%rax        # 156c0 <execute_location+0x40>    156bc: R_X86_64_PC32    .text+0x1032014
>    156c0:       48 89 43 28             mov    %rax,0x28(%rbx)
>    156c4:       48 8b 05 00 00 00 00    mov    0x0(%rip),%rax        # 156cb <execute_location+0x4b>    156c7: R_X86_64_PC32    .text+0x103200c
>    156cb:       48 89 43 20             mov    %rax,0x20(%rbx)
>    156cf:       48 8b 05 00 00 00 00    mov    0x0(%rip),%rax        # 156d6 <execute_location+0x56>    156d2: R_X86_64_PC32    .text+0x1032004
>    156d6:       48 89 43 18             mov    %rax,0x18(%rbx)
>    156da:       48 8b 05 00 00 00 00    mov    0x0(%rip),%rax        # 156e1 <execute_location+0x61>    156dd: R_X86_64_PC32    .text+0x1031ffc
>    156e1:       48 89 43 10             mov    %rax,0x10(%rbx)
>    156e5:       48 8b 05 00 00 00 00    mov    0x0(%rip),%rax        # 156ec <execute_location+0x6c>    156e8: R_X86_64_PC32    .text+0x1031ff4
>    156ec:       48 89 43 08             mov    %rax,0x8(%rbx)
>    156f0:       48 8b 05 00 00 00 00    mov    0x0(%rip),%rax        # 156f7 <execute_location+0x77>    156f3: R_X86_64_PC32    .text+0x1031fec
>    156f7:       48 89 03                mov    %rax,(%rbx)
> 
> And objtool figures those .text references are an address-taken-of like
> thing and expects ENDBR at them.

Ah! It's (quite reasonably) not expecting text reference in memcpy. ;)

> Lovely stuff...
> 
> Anyway, ignore this patch.

Okay! :)

-- 
Kees Cook

