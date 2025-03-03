Return-Path: <linux-kernel+bounces-542426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D40FA4C98E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 238DB189F8AE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FEB253352;
	Mon,  3 Mar 2025 17:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lSqw7faB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82DF253335;
	Mon,  3 Mar 2025 17:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741021918; cv=none; b=StPgmKIHMFTa44YbXBXryTwiEo7pLlBHRzOYylH1hhTMwQP9QsWZVHEZ6r4V0gdjd0Mckdm6u3xoTSxT7Xy9bs/pojZGVASJ8Nv3NI2quc2Z6w7pXqIAN25tGhygS15B+e56uEKu66B/zglDQ7yZwdFtwngjG5esLIRK9xmiEd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741021918; c=relaxed/simple;
	bh=OLWjZZWB4HXHmwUAJi1MwCJ/ZF5m6XWgpdEW5VZnb2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PckztqfqifuH2kEM15isATosnY9MUDDu0Fy3uvUvJvvO2X1aAWzrT38DT9ZiglLro7wfc0pr4JpBhCIVe05qcq/n3CfOcFCACPjFEN7Z+ShNavJYIurIvFSEYTb3s1J4gl9VOplEiBK0fTXSUdzXRV1O3MfhGhZx63TuRL9FcH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lSqw7faB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 566CBC4CED6;
	Mon,  3 Mar 2025 17:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741021917;
	bh=OLWjZZWB4HXHmwUAJi1MwCJ/ZF5m6XWgpdEW5VZnb2o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lSqw7faBJGHdNV2g/xhp0qxwaF8Qtw3yYTHtSPsC67F8VGkAuh/W8/Vd9qicZbqkl
	 aSxklh24ugiGnQNvJ/re21TMQfNnC/9NM1K1JvY+LYPSe7rZH6dEf/Zm+xJcAK3Ckj
	 OrhNHzrbUFgPxX4UcBm4u4m4JF4tdPCkYzfdPqjdck993/J2aqaLIGHlcmxvT2HMho
	 IMSffHFsDwcGjsXBq9R2AxMIG3tQD1VTdTHizpKM22miSv3goi5jp2HAIMf2qqEi0o
	 aaBNzMq/b9F5zopz5xQGY0DsdNDS9SokuUDcJqd2aw8QaG3DHepuhM/R141wkvqcDV
	 nz7+E10L+c55Q==
Date: Mon, 3 Mar 2025 09:11:54 -0800
From: Kees Cook <kees@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	x86@kernel.org, Ingo Molnar <mingo@kernel.org>
Subject: Re: [tip:x86/core 16/17] vmlinux.o: warning: objtool: do_jit+0x276:
 relocation to !ENDBR: .noinstr.text+0x6a60
Message-ID: <202503030910.55EBC9A76@keescook>
References: <202503030704.H9KFysNS-lkp@intel.com>
 <20250303092459.GI5880@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303092459.GI5880@noisy.programming.kicks-ass.net>

On Mon, Mar 03, 2025 at 10:24:59AM +0100, Peter Zijlstra wrote:
> On Mon, Mar 03, 2025 at 07:47:57AM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/core
> > head:   dfebe7362f6f461d771cdb9ac2c5172a4721f064
> > commit: 0c92385dc05ee9637c04372ea95a11bbf6e010ff [16/17] x86/ibt: Implement FineIBT-BHI mitigation
> > config: x86_64-randconfig-071-20250303 (https://download.01.org/0day-ci/archive/20250303/202503030704.H9KFysNS-lkp@intel.com/config)
> > compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250303/202503030704.H9KFysNS-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202503030704.H9KFysNS-lkp@intel.com/
> > 
> > All warnings (new ones prefixed by >>):
> > 
> > >> vmlinux.o: warning: objtool: do_jit+0x276: relocation to !ENDBR: .noinstr.text+0x6a60
> 
> Thanks, below seems to cure it for me.
> 
> ---
> Subject: x86/ibt: Make cfi_bhi a constant for FINEIBT_BHI=n
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Mon Mar 3 10:21:47 CET 2025
> 
> Robot yielded a .config that tripped:
> 
>   vmlinux.o: warning: objtool: do_jit+0x276: relocation to !ENDBR: .noinstr.text+0x6a60
> 
> This is the result of using __bhi_args[1] in unreachable code; make
> sure the compiler is able to determine this is unreachable and trigger
> DCE.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202503030704.H9KFysNS-lkp@intel.com/
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/include/asm/cfi.h    |    5 +++++
>  arch/x86/kernel/alternative.c |    3 +++
>  2 files changed, 8 insertions(+)
> 
> --- a/arch/x86/include/asm/cfi.h
> +++ b/arch/x86/include/asm/cfi.h
> @@ -100,7 +100,12 @@ enum cfi_mode {
>  };
>  
>  extern enum cfi_mode cfi_mode;
> +
> +#ifdef CONFIG_FINEIBT_BHI
>  extern bool cfi_bhi;
> +#else
> +#define cfi_bhi (0)
> +#endif

Just for my own curiosity, how did you track this down? (The
relationship between cfi_bhi and do_jit is not immediately obvious to
me. Or rather, what was needing DCE?)

-Kees

-- 
Kees Cook

