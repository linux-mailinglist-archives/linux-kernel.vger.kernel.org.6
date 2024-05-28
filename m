Return-Path: <linux-kernel+bounces-192937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8A98D2493
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 21:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B38B228606C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 19:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B22417276E;
	Tue, 28 May 2024 19:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pR/sfznw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB8D171679;
	Tue, 28 May 2024 19:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716924409; cv=none; b=snyfUrxOAlJiIrqIzsQ5rmfX/DV14WOp0SadTYw9aVjAjM3Zmi+VIVjt8RgmmGec9Hi1R08HveowOxioYPljZckJg7EUIC7fnERMqDYAiZkSILOI/csIqr1B8jcZLtj070vGXy8UXKE7CYxwmEqHUo579kyownSHO1dKJSZSDdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716924409; c=relaxed/simple;
	bh=mWeHmicPyT/nFecLrD5KlpasVv692S7kVYOEr6pzmEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ObZeiKhpoNcBTaWe+hfPCWHDDsJgjAUEJ6SwVQLzeIjJ74yTBTgNKYQFbHiPUcSHu8OdM+G3ahSgkY75j+iuFDkziyW+zfEdr01+K5HK4LiV1bJ0HlvraHpptmLtl0ijiiR6ZKejPCrcUJa0TP9z653OiItlhZ1HxqV0G2WjWd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pR/sfznw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA5C7C3277B;
	Tue, 28 May 2024 19:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716924409;
	bh=mWeHmicPyT/nFecLrD5KlpasVv692S7kVYOEr6pzmEA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=pR/sfznwaK1jUa5P9QrGg2tsmgHS/jB6yWTbHka4JvnqD1DyI08Z8AQtrMyxJvf59
	 sm9IlDtkHuWu9m4fkRjEUBXe9ubkvK6JBur3hNRN/W0p2UQ0lBq2NzrqRlurUpd4av
	 PU+Etq3UnKpxiKG/BtlKSRmBGD14r60S+yeVl8usnfkY2OiMJoVmGI51J8aUH790kx
	 hibBkk2kMqRmsNmrqEcUcKcod2lWi+2BHEyUEyNkX1fj+sFyvaIv2G62AbUfOblqGM
	 Khgx29M73nC+3lc1jjcYB6qXTOlcdtoBwB9URhlGRdHdsE9rNOIeY1ieYstKugb2oQ
	 42sAb9TuokOHg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 88353CE0F8F; Tue, 28 May 2024 12:26:43 -0700 (PDT)
Date: Tue, 28 May 2024 12:26:43 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [paulmck-rcu:dev.2024.05.18a 44/51] update.c:undefined reference
 to `cmpxchg_emu_u8'
Message-ID: <df54d8ab-514d-409f-8522-b0790a12b953@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <202405271352.XYjxKyUi-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202405271352.XYjxKyUi-lkp@intel.com>

On Mon, May 27, 2024 at 01:25:58PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2024.05.18a
> head:   0e3eb8082184e066eb389f5e6f9c7b8c2d452d66
> commit: c48887df74a95090e633a29ffbcef00b71cdab66 [44/51] rcu-tasks: Remove open-coded one-byte cmpxchg() emulation
> config: um-allyesconfig (https://download.01.org/0day-ci/archive/20240527/202405271352.XYjxKyUi-lkp@intel.com/config)
> compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240527/202405271352.XYjxKyUi-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202405271352.XYjxKyUi-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    /usr/bin/ld: kernel/rcu/update.o: in function `rcu_trc_cmpxchg_need_qs':
> >> update.c:(.text+0x27d5): undefined reference to `cmpxchg_emu_u8'
>    /usr/bin/ld: kernel/rcu/update.o: in function `trc_read_check_handler':
>    update.c:(.text+0x2839): undefined reference to `cmpxchg_emu_u8'
> >> /usr/bin/ld: update.c:(.text+0x2882): undefined reference to `cmpxchg_emu_u8'
>    /usr/bin/ld: kernel/rcu/update.o: in function `trc_inspect_reader':
>    update.c:(.text+0x52ce): undefined reference to `cmpxchg_emu_u8'
>    /usr/bin/ld: update.c:(.text+0x5330): undefined reference to `cmpxchg_emu_u8'
>    /usr/bin/ld: kernel/rcu/update.o:update.c:(.text+0x5933): more undefined references to `cmpxchg_emu_u8' follow
> >> collect2: error: ld returned 1 exit status

Good catch!!!

Does the patch below clear this up?

							Thanx, Paul

------------------------------------------------------------------------

commit 47450c70303a11da1bd650403844ad9e688f05a4
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Tue May 28 12:15:06 2024 -0700

    um: Emulate one-byte cmpxchg
    
    Use the new cmpxchg_emu_u8() to emulate one-byte cmpxchg() on um.
    
    Reported-by: kernel test robot <lkp@intel.com>
    Closes: https://lore.kernel.org/all/202405271352.XYjxKyUi-lkp@intel.com/
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
    Cc: Richard Weinberger <richard@nod.at>
    Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
    Cc: Johannes Berg <johannes@sipsolutions.net>
    Cc: <linux-um@lists.infradead.org>

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 93a5a8999b07e..5fc55e1d71122 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -11,6 +11,7 @@ config UML
 	select ARCH_HAS_KCOV
 	select ARCH_HAS_STRNCPY_FROM_USER
 	select ARCH_HAS_STRNLEN_USER
+	select ARCH_NEED_CMPXCHG_1_EMU
 	select ARCH_NO_PREEMPT
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_KASAN if X86_64

