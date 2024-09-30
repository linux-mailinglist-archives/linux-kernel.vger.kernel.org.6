Return-Path: <linux-kernel+bounces-344431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 861BD98A97C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 18:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDAA61F2499C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 16:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4522190482;
	Mon, 30 Sep 2024 16:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R31BemSg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F10635894;
	Mon, 30 Sep 2024 16:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727712628; cv=none; b=XvKmUk8oSl70UlOqNMJnudjm/SbwsteCqrsNRcLgkxytLEvY3cTdBvk3PQ+R3XEZTPUsNB6L7h1ubdgoaIV+5qmwknjzU9TsasV5Dof4OGLyt2HvwIeTTlYf87bR3WXJ6uShyn/rrT5VCMfmq3fff32H/ymEOc8jqZbjpPS+KAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727712628; c=relaxed/simple;
	bh=kGXqmstFcbWcGVvFNWj4UL7lFlWvJeeSSReWGtHrnuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iEyeWZyg5p2+mkpOZ2Xmqrnvf4i/Gx+unCUlKJCsbL2yy2mR5r/Fxd1lwugDwo7ZI29FdEQs2v0DiyR3k6SPZaZi06w/7y5szEZ2M7ZPp1dd8JP7LS5pLId1c6bpF4vkKWpR7/kEMuGXW3qa3W6rvXZBJuzQuW9fVKleLslh/UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R31BemSg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD5DAC4CEC7;
	Mon, 30 Sep 2024 16:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727712627;
	bh=kGXqmstFcbWcGVvFNWj4UL7lFlWvJeeSSReWGtHrnuM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=R31BemSgmkqLWZEZ5R2bNtTOeMT9rwWxAopCLrF7SZ/3vbe4evpxc6mlOGGFfoL9Y
	 kEGhZruhQyR/GzcMmwgVry0iTgMCN5I+UZ3TinoIqZLZ9+GiqqR4uj6bUDA3m50wE7
	 tsegxFUAmXkFQlqOvBJ2XWINdCJo8CcceHiWBDqWFb7QyuUAZ3HJ9f6ar9nEKASncG
	 fPg3LkvMVNCbYWfNWp7rMNNW9Xc+bYd1V0nYOO6zUtDS3HCMiN5n7CNCGMZ1JpN2Ja
	 OTIas2LOGo2c6IoSdhRcM/5sjlmO4BWGLRsdLOGJ1GvwxzZayBqtzK2eeUuJ1jRcJh
	 dx6ZQ20LWsT6g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 6D8FDCE0E19; Mon, 30 Sep 2024 09:10:27 -0700 (PDT)
Date: Mon, 30 Sep 2024 09:10:27 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-snps-arc@lists.infradead.org
Subject: Re: arch/arc/kernel/smp.c:267:18: sparse: sparse: cast removes
 address space '__percpu' of expression
Message-ID: <e8f6137d-ad2c-4b06-8eb2-cd200fbb1af2@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <202409251336.ToC0TvWB-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202409251336.ToC0TvWB-lkp@intel.com>

On Wed, Sep 25, 2024 at 01:40:45PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   684a64bf32b6e488004e0ad7f0d7e922798f65b6
> commit: f2519d4d4fc4d36f2b58c5614357de9f5b4032fc ARC: Emulate one-byte cmpxchg
> date:   12 days ago
> config: arc-randconfig-r123-20240925 (https://download.01.org/0day-ci/archive/20240925/202409251336.ToC0TvWB-lkp@intel.com/config)
> compiler: arc-elf-gcc (GCC) 13.2.0
> reproduce: (https://download.01.org/0day-ci/archive/20240925/202409251336.ToC0TvWB-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202409251336.ToC0TvWB-lkp@intel.com/
> 
> sparse warnings: (new ones prefixed by >>)
>    arch/arc/kernel/smp.c:252:48: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long [noderef] __percpu *ipi_data_ptr @@     got unsigned long * @@
>    arch/arc/kernel/smp.c:252:48: sparse:     expected unsigned long [noderef] __percpu *ipi_data_ptr
>    arch/arc/kernel/smp.c:252:48: sparse:     got unsigned long *
>    arch/arc/kernel/smp.c:267:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile *v @@     got unsigned long [noderef] __percpu *__ai_ptr @@
>    arch/arc/kernel/smp.c:267:18: sparse:     expected void const volatile *v
>    arch/arc/kernel/smp.c:267:18: sparse:     got unsigned long [noderef] __percpu *__ai_ptr
> >> arch/arc/kernel/smp.c:267:18: sparse: sparse: cast removes address space '__percpu' of expression
> >> arch/arc/kernel/smp.c:267:18: sparse: sparse: cast removes address space '__percpu' of expression

I could "fix" this using __force.  Is that a reasonable approach?

If I don't hear otherwise, I will take that approach.

							Thanx, Paul

>    arch/arc/kernel/smp.c:401:72: sparse: sparse: incorrect type in argument 4 (different address spaces) @@     expected void [noderef] __percpu *percpu_dev_id @@     got int *dev @@
>    arch/arc/kernel/smp.c:401:72: sparse:     expected void [noderef] __percpu *percpu_dev_id
>    arch/arc/kernel/smp.c:401:72: sparse:     got int *dev
>    arch/arc/kernel/smp.c:265:30: sparse: sparse: dereference of noderef expression
> 
> vim +/__percpu +267 arch/arc/kernel/smp.c
> 
> 41195d236e8445 Vineet Gupta    2013-01-18  249  
> ddf84433f411b6 Vineet Gupta    2013-11-25  250  static void ipi_send_msg_one(int cpu, enum ipi_msg_type msg)
> 41195d236e8445 Vineet Gupta    2013-01-18  251  {
> f2a4aa5646687f Vineet Gupta    2013-11-26  252  	unsigned long __percpu *ipi_data_ptr = per_cpu_ptr(&ipi_data, cpu);
> d8e8c7dda11f5d Vineet Gupta    2013-11-28  253  	unsigned long old, new;
> 41195d236e8445 Vineet Gupta    2013-01-18  254  	unsigned long flags;
> 41195d236e8445 Vineet Gupta    2013-01-18  255  
> f2a4aa5646687f Vineet Gupta    2013-11-26  256  	pr_debug("%d Sending msg [%d] to %d\n", smp_processor_id(), msg, cpu);
> f2a4aa5646687f Vineet Gupta    2013-11-26  257  
> 41195d236e8445 Vineet Gupta    2013-01-18  258  	local_irq_save(flags);
> 41195d236e8445 Vineet Gupta    2013-01-18  259  
> d8e8c7dda11f5d Vineet Gupta    2013-11-28  260  	/*
> d8e8c7dda11f5d Vineet Gupta    2013-11-28  261  	 * Atomically write new msg bit (in case others are writing too),
> d8e8c7dda11f5d Vineet Gupta    2013-11-28  262  	 * and read back old value
> d8e8c7dda11f5d Vineet Gupta    2013-11-28  263  	 */
> d8e8c7dda11f5d Vineet Gupta    2013-11-28  264  	do {
> c6ed4d84a2c49d Bang Li         2022-03-19  265  		new = old = *ipi_data_ptr;
> d8e8c7dda11f5d Vineet Gupta    2013-11-28  266  		new |= 1U << msg;
> d8e8c7dda11f5d Vineet Gupta    2013-11-28 @267  	} while (cmpxchg(ipi_data_ptr, old, new) != old);
> 41195d236e8445 Vineet Gupta    2013-01-18  268  
> d8e8c7dda11f5d Vineet Gupta    2013-11-28  269  	/*
> d8e8c7dda11f5d Vineet Gupta    2013-11-28  270  	 * Call the platform specific IPI kick function, but avoid if possible:
> d8e8c7dda11f5d Vineet Gupta    2013-11-28  271  	 * Only do so if there's no pending msg from other concurrent sender(s).
> 82a423053eb3cf Changcheng Deng 2021-08-14  272  	 * Otherwise, receiver will see this msg as well when it takes the
> d8e8c7dda11f5d Vineet Gupta    2013-11-28  273  	 * IPI corresponding to that msg. This is true, even if it is already in
> d8e8c7dda11f5d Vineet Gupta    2013-11-28  274  	 * IPI handler, because !@old means it has not yet dequeued the msg(s)
> d8e8c7dda11f5d Vineet Gupta    2013-11-28  275  	 * so @new msg can be a free-loader
> d8e8c7dda11f5d Vineet Gupta    2013-11-28  276  	 */
> d8e8c7dda11f5d Vineet Gupta    2013-11-28  277  	if (plat_smp_ops.ipi_send && !old)
> ddf84433f411b6 Vineet Gupta    2013-11-25  278  		plat_smp_ops.ipi_send(cpu);
> 41195d236e8445 Vineet Gupta    2013-01-18  279  
> 41195d236e8445 Vineet Gupta    2013-01-18  280  	local_irq_restore(flags);
> 41195d236e8445 Vineet Gupta    2013-01-18  281  }
> 41195d236e8445 Vineet Gupta    2013-01-18  282  
> 
> :::::: The code at line 267 was first introduced by commit
> :::::: d8e8c7dda11f5d5cf90495f2e89d917a83509bc0 ARC: [SMP] optimize IPI send and receive
> 
> :::::: TO: Vineet Gupta <vgupta@synopsys.com>
> :::::: CC: Vineet Gupta <vgupta@synopsys.com>
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

