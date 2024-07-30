Return-Path: <linux-kernel+bounces-268033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D908941F93
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 20:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE330B24070
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 18:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677F218A6C6;
	Tue, 30 Jul 2024 18:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iAZ2un2h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFF51A76BE;
	Tue, 30 Jul 2024 18:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722364354; cv=none; b=GWYHJ+amkVsZ8cPrg0n0ivP4scENA32XQLpECj0pQoGYr4D5FHZ58wjKTlHzx2aqxnOTKuwarpeB7+GZDcvwRWqxv068avjWRc7zvPnugTckQ6QAcBgb2fojvihhvzwtAzcRS2UZ50xZy8f7bsZlOOPWNUd5uyAohQpYeySJsWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722364354; c=relaxed/simple;
	bh=g+OGyy+vT85w380nT0+iGcOi+FcSygg/gUut0p0k0Fg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rsekSzPsF1QEUlPdxu5HV84vsyAHhEqUqmHdgYcv/E9mZFMKwQJcmrPCBc6G5/mrOHtnE7qHnnTJslhfejmwQyouIJa3+YbpV5r69W/M3xFtgNbAhUhndXOHrkG/DIUxb+NtNo6tUZgPmFdaS5q9ItKsPkpXSGLU6YCkFWFgs7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iAZ2un2h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D519EC4AF0A;
	Tue, 30 Jul 2024 18:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722364354;
	bh=g+OGyy+vT85w380nT0+iGcOi+FcSygg/gUut0p0k0Fg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iAZ2un2hLYorsB4Sjl+hLldJqIsVwwJ3R4Un+dzc3l/i1xHUw/S92H01WG1RXJ73U
	 8ex5pqe5YFWQIQTygJq6lgwNByv0Hu/BLNUgvirpTi4UTx9arZmfNKTbXNU30BcTTM
	 Qy0BXT7WCyKv6OaKWewsL/gDy2D/Q1/cjLfzMsNP+Xk2jpo9u4AJBbmOu1BzGRuGEG
	 FgPMZoyoYhWDqXyuXjJPNLDXnsqRLxyEeIB0DS+xq1/qo0H4+PCJD2i4cOmL+FJHKR
	 zClTy1Jgh3QIDxzCg4bRAQixcFSuOK5WqihiGDbDZlEjewmIa8HrNzrfKZF63+w00C
	 pUhU+inxh4pyw==
Date: Tue, 30 Jul 2024 11:32:32 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: Re: [tip:x86/microcode 1/1]
 arch/x86/kernel/cpu/microcode/amd.c:714:6: warning: variable 'equiv_id' is
 used uninitialized whenever 'if' condition is false
Message-ID: <20240730183232.GA2428521@thelio-3990X>
References: <202407291815.gJBST0P3-lkp@intel.com>
 <20240729112614.GBZqd8Vu27mFVSHynA@fat_crate.local>
 <20240729153008.GA685493@thelio-3990X>
 <20240730080326.GAZqieTl1Gz4RheSiI@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730080326.GAZqieTl1Gz4RheSiI@fat_crate.local>

On Tue, Jul 30, 2024 at 10:03:26AM +0200, Borislav Petkov wrote:
> On Mon, Jul 29, 2024 at 08:30:08AM -0700, Nathan Chancellor wrote:
> > Right, as clang does not perform interprocedural analysis for the sake
> > of warnings. That's partly why GCC's version of this warning was
> > disabled in commit 78a5255ffb6a ("Stop the ad-hoc games with
> > -Wno-maybe-initialized").
> 
> So why aren't we shutting up clang too?

Because it does not suffer from the same issues. There are many more
instances of local variables that are genuinely uninitialized when used
that get properly flagged than instances such as this where lack of
interprocedural analysis may cause emission of a false positive. Losing
Clang's version of the warning means that no compiler would warn on
instances of obviously uninitialized local variables, which still occurs
quite frequently.

> > While it may be properly handled now, I think this pattern of
> > conditionally avoiding using a variable uninitialized is dubious.
> 
> Well, in this particular case of the microcode loader, this is the best
> compromise I can think of - I have two different paths of handling a microcode
> patch - Zen and newer - and before - so I need those separate flows.
> 
> So sometimes it makes sense.

Sure, I just think it is a potential footgun waiting to happen but it's
obviously fine now.

> > So I guess you can just ignore this if you want but others (maybe even
> > Linus) will likely notice this and report it as well.
> 
> I think this warning should be behind W=1 if it can trigger false positives.

I disagree, any warning can trigger false positives, as they are
heuristics. Feel free to propose a patch if you feel strongly about it
though and we can bring the discussion to a wider audience.

> Anyway:
> 
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> Date: Tue, 30 Jul 2024 09:52:43 +0200
> Subject: [PATCH] x86/microcode/AMD: Fix a -Wsometimes-uninitialized clang
>  false positive
> 
> Initialize equiv_id in order to shut up:
> 
>   arch/x86/kernel/cpu/microcode/amd.c:714:6: warning: variable 'equiv_id' is \
>   used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
>         if (x86_family(bsp_cpuid_1_eax) < 0x17) {
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> because clang doesn't do interprocedural analysis for warnings to see
> that this variable won't be used uninitialized.
> 
> Fixes: 94838d230a6c ("x86/microcode/AMD: Use the family,model,stepping encoded in the patch ID")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202407291815.gJBST0P3-lkp@intel.com/
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  arch/x86/kernel/cpu/microcode/amd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
> index 1f5d36f92b8a..f63b051f25a0 100644
> --- a/arch/x86/kernel/cpu/microcode/amd.c
> +++ b/arch/x86/kernel/cpu/microcode/amd.c
> @@ -703,7 +703,7 @@ static struct ucode_patch *find_patch(unsigned int cpu)
>  {
>  	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
>  	u32 rev, dummy __always_unused;
> -	u16 equiv_id;
> +	u16 equiv_id = 0;
>  
>  	/* fetch rev if not populated yet: */
>  	if (!uci->cpu_sig.rev) {
> -- 
> 2.43.0
> 
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

