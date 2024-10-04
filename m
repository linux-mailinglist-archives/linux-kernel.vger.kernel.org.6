Return-Path: <linux-kernel+bounces-350666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CFDCB9908CA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 18:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38E0FB2A1C9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 15:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B321DD894;
	Fri,  4 Oct 2024 15:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OcIjcXhJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328391C304D;
	Fri,  4 Oct 2024 15:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728056487; cv=none; b=PNTYtuxxeI+4Gpr5QRnm4RzZgopgdwm3IgM6g0JpoMeE7au+3cvm++BJRSfV6FckuHHkVEG81qAtCOHrxn6bALyVI/gV8nwkZ1mA+xguplWH46M1MmotLBKIMr7J/LeR/dN5E4wG5RPWk7amUfFEbHeoi9dB1B0X7c2oz0s+vBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728056487; c=relaxed/simple;
	bh=wWIqaWFb9hczSFyfBOrlAdAaRIwnd6rA02tbEjm3/Hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NSRC5k3tgGp3IpN66FIngFsX86aE8unnp0rHbHR8iABegeTR7SzXTRAYViFqYGx+yEAB8aLrOQ96PCCgWYadzhYe59ABp312Pm/Z5DIR4+DNPnUucFZSXx2WVukvAqXnfhOTMnSjuSqlw37KIfYmglc9Tq4GSejdHorX5RBdAO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OcIjcXhJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8ADBC4CEC6;
	Fri,  4 Oct 2024 15:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728056486;
	bh=wWIqaWFb9hczSFyfBOrlAdAaRIwnd6rA02tbEjm3/Hw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=OcIjcXhJL6RvMjskKV2gco+Uaa/9U9nZ9azzuXuQkJepVHmz60SCWHFFNRmETlEaD
	 5pmOdUplQAuB0q1GhHLSOLJH7utcGfkPlKMbrUQHEfci0MDPOn7O8P6V9m2gJ4/UtA
	 a+lNf4lC1AsoR/qOucYlAmAE5G0yIElR6coz44xZPrl/k/X0tlUtSjNfEM0azDMMiS
	 gOwSJZUWDK90c1/7nUmRiS4HdanyuUxKTgvGRWjtGofbLs7XorYpsSHFwl9TyLek1P
	 /dnLIcQLTlEvrzpr0g0IZp6GXBLG/RHKwwiIpRdRvE4cpBTc4HXjObAKxS6OgpKoax
	 JZRh95qCYEntw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 44B5DCE0D71; Fri,  4 Oct 2024 08:41:26 -0700 (PDT)
Date: Fri, 4 Oct 2024 08:41:26 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-snps-arc@lists.infradead.org
Subject: Re: arch/arc/kernel/smp.c:267:18: sparse: sparse: cast removes
 address space '__percpu' of expression
Message-ID: <5ada7b12-f3c4-4ae8-b396-a3e474f4f852@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <202409251336.ToC0TvWB-lkp@intel.com>
 <e8f6137d-ad2c-4b06-8eb2-cd200fbb1af2@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8f6137d-ad2c-4b06-8eb2-cd200fbb1af2@paulmck-laptop>

On Mon, Sep 30, 2024 at 09:10:27AM -0700, Paul E. McKenney wrote:
> On Wed, Sep 25, 2024 at 01:40:45PM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   684a64bf32b6e488004e0ad7f0d7e922798f65b6
> > commit: f2519d4d4fc4d36f2b58c5614357de9f5b4032fc ARC: Emulate one-byte cmpxchg
> > date:   12 days ago
> > config: arc-randconfig-r123-20240925 (https://download.01.org/0day-ci/archive/20240925/202409251336.ToC0TvWB-lkp@intel.com/config)
> > compiler: arc-elf-gcc (GCC) 13.2.0
> > reproduce: (https://download.01.org/0day-ci/archive/20240925/202409251336.ToC0TvWB-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202409251336.ToC0TvWB-lkp@intel.com/
> > 
> > sparse warnings: (new ones prefixed by >>)
> >    arch/arc/kernel/smp.c:252:48: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long [noderef] __percpu *ipi_data_ptr @@     got unsigned long * @@
> >    arch/arc/kernel/smp.c:252:48: sparse:     expected unsigned long [noderef] __percpu *ipi_data_ptr
> >    arch/arc/kernel/smp.c:252:48: sparse:     got unsigned long *
> >    arch/arc/kernel/smp.c:267:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile *v @@     got unsigned long [noderef] __percpu *__ai_ptr @@
> >    arch/arc/kernel/smp.c:267:18: sparse:     expected void const volatile *v
> >    arch/arc/kernel/smp.c:267:18: sparse:     got unsigned long [noderef] __percpu *__ai_ptr
> > >> arch/arc/kernel/smp.c:267:18: sparse: sparse: cast removes address space '__percpu' of expression
> > >> arch/arc/kernel/smp.c:267:18: sparse: sparse: cast removes address space '__percpu' of expression
> 
> I could "fix" this using __force.  Is that a reasonable approach?
> 
> If I don't hear otherwise, I will take that approach.

Having not heard otherwise, does the following fix this issue for you?

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/arch/arc/include/asm/cmpxchg.h b/arch/arc/include/asm/cmpxchg.h
index 58045c8983404..76f43db0890fc 100644
--- a/arch/arc/include/asm/cmpxchg.h
+++ b/arch/arc/include/asm/cmpxchg.h
@@ -48,7 +48,7 @@
 									\
 	switch(sizeof((_p_))) {						\
 	case 1:								\
-		_prev_ = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *)_p_, (uintptr_t)_o_, (uintptr_t)_n_);	\
+		_prev_ = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *__force)_p_, (uintptr_t)_o_, (uintptr_t)_n_);	\
 		break;							\
 	case 4:								\
 		_prev_ = __cmpxchg(_p_, _o_, _n_);			\

