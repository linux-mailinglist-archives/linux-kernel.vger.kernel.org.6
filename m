Return-Path: <linux-kernel+bounces-266027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F3093F976
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 17:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 213251C222A8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 15:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33527158853;
	Mon, 29 Jul 2024 15:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r3FNmVmx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC7014F9FD;
	Mon, 29 Jul 2024 15:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722267011; cv=none; b=HNfTuxo3IbYMByoCo3+57a7DqeWdOXV2Zxu3Z1nfcx8n1Nj4+h0zuqQJHxdkYMBQWz2dqVfCVGk7hCbR+1vbfn82RjaHelhNp0rNZ1rMgScPIjQCpPp0aDlJHM+nShcZV1FExNFlOk3GDHjfXTRrkGsGkkVjVnIiGh+hXmvqORM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722267011; c=relaxed/simple;
	bh=ndzDCEmWVqlMpqggu+GgSzXYK/Y1s948Sog4W6pkXyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D+tAmD4ZgVqkm0pqERl7v8dFsAmprsT+YKzBxCckJAk9dvI0C73hh2MxqIAFzKk0xoYiWr5D6SUOt2ey50GB97sweh2d5smQznHhF8SReXHbAIXMBEHZzJw4Vt0bsjQFkJad9Ye5/lPqK3WC6G2HLjkz4bkMQlK9UOEOz6B4qXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r3FNmVmx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9557CC32786;
	Mon, 29 Jul 2024 15:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722267011;
	bh=ndzDCEmWVqlMpqggu+GgSzXYK/Y1s948Sog4W6pkXyw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r3FNmVmxJSENQY/tBVzlojnsnOO/XLYOme3j10H4ISrIgxicyoteQ69TS9QDNELTQ
	 BVx24grjry2+duu1MS1L5TYMKK5T83OyyuLQjhpIPrmDD1C8XfPD90Ajfj10+xEGe3
	 9SBlBzaW6Ufie66kKdAHGqPf7gvzM7CgycphWWQSszX0j0PVdyfj4quoHFyMiW2xDd
	 Ht9fuSubV6AvdmFh5XWm+Z9aR0UBM5LXjrEZ82g6s+A9GC+omYcNkx3qFutThl7jsa
	 86ATPOv6cIbtI0eV5/O3uNqcTBWVFuRzuTzKRT2Ipz2p2rkhVkvOn8r8xlQZ3sCvqO
	 G4YQXLxYWK4Tg==
Date: Mon, 29 Jul 2024 08:30:08 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: Re: [tip:x86/microcode 1/1]
 arch/x86/kernel/cpu/microcode/amd.c:714:6: warning: variable 'equiv_id' is
 used uninitialized whenever 'if' condition is false
Message-ID: <20240729153008.GA685493@thelio-3990X>
References: <202407291815.gJBST0P3-lkp@intel.com>
 <20240729112614.GBZqd8Vu27mFVSHynA@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729112614.GBZqd8Vu27mFVSHynA@fat_crate.local>

Hi Boris,

On Mon, Jul 29, 2024 at 01:26:14PM +0200, Borislav Petkov wrote:
> + Nathan.
> 
> On Mon, Jul 29, 2024 at 07:04:51PM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/microcode
> > head:   94838d230a6c835ced1bad06b8759e0a5f19c1d3
> > commit: 94838d230a6c835ced1bad06b8759e0a5f19c1d3 [1/1] x86/microcode/AMD: Use the family,model,stepping encoded in the patch ID
> > config: i386-buildonly-randconfig-001-20240729 (https://download.01.org/0day-ci/archive/20240729/202407291815.gJBST0P3-lkp@intel.com/config)
> > compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240729/202407291815.gJBST0P3-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202407291815.gJBST0P3-lkp@intel.com/
> > 
> > All warnings (new ones prefixed by >>):
> > 
> > >> arch/x86/kernel/cpu/microcode/amd.c:714:6: warning: variable 'equiv_id' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
> >      714 |         if (x86_family(bsp_cpuid_1_eax) < 0x17) {
> >          |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >    arch/x86/kernel/cpu/microcode/amd.c:720:31: note: uninitialized use occurs here
> >      720 |         return cache_find_patch(uci, equiv_id);
> >          |                                      ^~~~~~~~
> >    arch/x86/kernel/cpu/microcode/amd.c:714:2: note: remove the 'if' if its condition is always true
> >      714 |         if (x86_family(bsp_cpuid_1_eax) < 0x17) {
> >          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >    arch/x86/kernel/cpu/microcode/amd.c:706:14: note: initialize the variable 'equiv_id' to silence this warning
> >      706 |         u16 equiv_id;
> >          |                     ^
> >          |                      = 0
> >    1 warning generated.
> > 
> > 
> > vim +714 arch/x86/kernel/cpu/microcode/amd.c
> > 
> >    701	
> >    702	static struct ucode_patch *find_patch(unsigned int cpu)
> >    703	{
> >    704		struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
> >    705		u32 rev, dummy __always_unused;
> >    706		u16 equiv_id;
> >    707	
> >    708		/* fetch rev if not populated yet: */
> >    709		if (!uci->cpu_sig.rev) {
> >    710			rdmsr(MSR_AMD64_PATCH_LEVEL, rev, dummy);
> >    711			uci->cpu_sig.rev = rev;
> >    712		}
> >    713	
> >  > 714		if (x86_family(bsp_cpuid_1_eax) < 0x17) {
> >    715			equiv_id = find_equiv_id(&equiv_table, uci->cpu_sig.sig);
> >    716			if (!equiv_id)
> >    717				return NULL;
> >    718		}
> >    719	
> >    720		return cache_find_patch(uci, equiv_id);
> >    721	}
> >    722	
> 
> That's a false positive, I think.
> 
> clang can't see that equiv_id is used in cache_find_patch() ->
> patch_cpus_equivalent() *only* in the
> 
> 	if (x86_family(bsp_cpuid_1_eax) < 0x17)
> 
> case.

Right, as clang does not perform interprocedural analysis for the sake
of warnings. That's partly why GCC's version of this warning was
disabled in commit 78a5255ffb6a ("Stop the ad-hoc games with
-Wno-maybe-initialized").

> And that case is handled properly in this function.

While it may be properly handled now, I think this pattern of
conditionally avoiding using a variable uninitialized is dubious.

> So, unless I'm missing something else, it's a good thing this warning is
> behind a W=1. Keep it there.

It's not behind W=1, this happens in a normal build:

  $ make -skj"$(nproc)" ARCH=x86_64 LLVM=1 mrproper defconfig arch/x86/kernel/cpu/microcode/amd.o
  arch/x86/kernel/cpu/microcode/amd.c:714:6: error: variable 'equiv_id' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
    714 |         if (x86_family(bsp_cpuid_1_eax) < 0x17) {
        |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  arch/x86/kernel/cpu/microcode/amd.c:720:31: note: uninitialized use occurs here
    720 |         return cache_find_patch(uci, equiv_id);
        |                                      ^~~~~~~~
  arch/x86/kernel/cpu/microcode/amd.c:714:2: note: remove the 'if' if its condition is always true
    714 |         if (x86_family(bsp_cpuid_1_eax) < 0x17) {
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  arch/x86/kernel/cpu/microcode/amd.c:706:14: note: initialize the variable 'equiv_id' to silence this warning
    706 |         u16 equiv_id;
        |                     ^
        |                      = 0
  1 error generated.

Even GCC would warn about this code if not for the commit I mentioned
above:

  $ make -skj"$(nproc)" ARCH=x86_64 CROSS_COMPILE=x86_64-linux- KCFLAGS=-Wmaybe-uninitialized mrproper defconfig arch/x86/kernel/cpu/microcode/amd.o
  In function 'cache_find_patch',
      inlined from 'find_patch' at arch/x86/kernel/cpu/microcode/amd.c:720:9:
  arch/x86/kernel/cpu/microcode/amd.c:647:20: error: 'equiv_id' may be used uninitialized [-Werror=maybe-uninitialized]
    647 |                 if (patch_cpus_equivalent(p, &n))
        |                    ^
  arch/x86/kernel/cpu/microcode/amd.c: In function 'find_patch':
  arch/x86/kernel/cpu/microcode/amd.c:706:13: note: 'equiv_id' was declared here
    706 |         u16 equiv_id;
        |             ^~~~~~~~
  cc1: all warnings being treated as errors

So I guess you can just ignore this if you want but others (maybe even
Linus) will likely notice this and report it as well.

Cheers,
Nathan

