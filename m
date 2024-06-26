Return-Path: <linux-kernel+bounces-231267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26520918A00
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 19:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D519A282F4C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 17:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44C918FDBD;
	Wed, 26 Jun 2024 17:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cqMy4DMS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C979417FAAE;
	Wed, 26 Jun 2024 17:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719422516; cv=none; b=IECmcNVulxVpWPxlRh66tPWSR+AjQ8qY9cLuXUqO1jJz74FFEgVSC+dbdNucBsS8L3JDldQighv2/7YEJaCoT9i556oDdL32YuTOK3f7nyZG/qkQH+DtZIVFFGc4XElWlHmqEFEtyE2gt1LP4h8nvYckkXFc1aT/4UkRzZgD41I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719422516; c=relaxed/simple;
	bh=ad4rc6FZLnmWijmzWdVBxLkWOIBIb361HgitCWotO68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iJAfHjiW9gyugRexbm37afGfVSYVeRH52RoM1DykMQG4D1kQz4G8Bb3eaedfG0NDhVJu2b8eiSUTLFaMB0nZzqdeoq15B6gNRrTvGIDjnswZJEzBBxoOdS5qZHO3yzq8mfJHcn7N/b0xN7mw4mt3J98xm991KC+4Ir93fLvl7FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cqMy4DMS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF867C116B1;
	Wed, 26 Jun 2024 17:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719422516;
	bh=ad4rc6FZLnmWijmzWdVBxLkWOIBIb361HgitCWotO68=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cqMy4DMSOujgTrAZ2D5Y2EiS/C6sfPmo9Szifl+B3gVLiHbsUH2RnWYYJTQUsOXXi
	 4hS0osIb1DzbchtNbu3Y0PbMeW0ym9Uq9uV53mFiACj6LbCZ7Xa43IGfuUGEqoZWw6
	 GbI3oP7lwxK8NUIL7bwWvN9edKq3tpTQnRTL9TJtMOLiVTYZsiIbNvA4XvnZ+c0giD
	 /V1mBt+y5Zx5zxSUfEc9MPrx1iP1CO+gulNd3p8B/C1EeXb/3KLsxTnlJp94G+aVys
	 9qdV3I9D3xMZfkLUFLNeFDrSx9kD4WNts7iAJaomERQFFzwFeJwTlPnHo5EaqmvNa8
	 yNlR336vPFdzw==
Date: Wed, 26 Jun 2024 10:21:54 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Sami Tolvanen <samitolvanen@google.com>
Subject: Re: arch/arm/mm/proc.c:82:6: error: conflicting types for
 'cpu_arm920_reset'
Message-ID: <20240626172154.GA50752@fedora-macbook-air-m2>
References: <202406260432.6WGV2jCk-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202406260432.6WGV2jCk-lkp@intel.com>

On Wed, Jun 26, 2024 at 04:37:00AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   55027e689933ba2e64f3d245fb1ff185b3e7fc81
> commit: 1a4fec49efe5273eb2fcf575175a117745f76f97 ARM: 9392/2: Support CLANG CFI
> date:   8 weeks ago
> config: arm-randconfig-002-20240626 (https://download.01.org/0day-ci/archive/20240626/202406260432.6WGV2jCk-lkp@intel.com/config)
> compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project ad79a14c9e5ec4a369eed4adf567c22cc029863f)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240626/202406260432.6WGV2jCk-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202406260432.6WGV2jCk-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
> >> arch/arm/mm/proc.c:82:6: error: conflicting types for 'cpu_arm920_reset'
>       82 | void cpu_arm920_reset(void);
>          |      ^
>    arch/arm/include/asm/proc-fns.h:96:13: note: previous declaration is here
>       96 | extern void cpu_reset(unsigned long addr, bool hvc) __attribute__((noreturn));
>          |             ^
>    arch/arm/include/asm/glue-proc.h:251:21: note: expanded from macro 'cpu_reset'
>      251 | #define cpu_reset                       __glue(CPU_NAME,_reset)
>          |                                         ^
>    arch/arm/include/asm/glue.h:20:26: note: expanded from macro '__glue'
>       20 | #define __glue(name,fn)         ____glue(name,fn)
>          |                                 ^
>    arch/arm/include/asm/glue.h:16:27: note: expanded from macro '____glue'
>       16 | #define ____glue(name,fn)       name##fn
>          |                                 ^
>    <scratch space>:70:1: note: expanded from here
>       70 | cpu_arm920_reset
>          | ^
>    1 error generated.

Hmmm, it seems like the prototypes of the reset functions in
arch/arm/mm/proc.c are incorrect? This builds for me with the original
configuration and allmodconfig + CONFIG_CFI_CLANG=y.

diff --git a/arch/arm/mm/proc.c b/arch/arm/mm/proc.c
index bdbbf65d1b36..4e4b5733bd26 100644
--- a/arch/arm/mm/proc.c
+++ b/arch/arm/mm/proc.c
@@ -17,7 +17,7 @@ void cpu_arm7tdmi_proc_init(void);
 __ADDRESSABLE(cpu_arm7tdmi_proc_init);
 void cpu_arm7tdmi_proc_fin(void);
 __ADDRESSABLE(cpu_arm7tdmi_proc_fin);
-void cpu_arm7tdmi_reset(void);
+void cpu_arm7tdmi_reset(unsigned long addr, bool hvc) __attribute__((noreturn));
 __ADDRESSABLE(cpu_arm7tdmi_reset);
 int cpu_arm7tdmi_do_idle(void);
 __ADDRESSABLE(cpu_arm7tdmi_do_idle);
@@ -32,7 +32,7 @@ void cpu_arm720_proc_init(void);
 __ADDRESSABLE(cpu_arm720_proc_init);
 void cpu_arm720_proc_fin(void);
 __ADDRESSABLE(cpu_arm720_proc_fin);
-void cpu_arm720_reset(void);
+void cpu_arm720_reset(unsigned long addr, bool hvc) __attribute__((noreturn));
 __ADDRESSABLE(cpu_arm720_reset);
 int cpu_arm720_do_idle(void);
 __ADDRESSABLE(cpu_arm720_do_idle);
@@ -49,7 +49,7 @@ void cpu_arm740_proc_init(void);
 __ADDRESSABLE(cpu_arm740_proc_init);
 void cpu_arm740_proc_fin(void);
 __ADDRESSABLE(cpu_arm740_proc_fin);
-void cpu_arm740_reset(void);
+void cpu_arm740_reset(unsigned long addr, bool hvc) __attribute__((noreturn));
 __ADDRESSABLE(cpu_arm740_reset);
 int cpu_arm740_do_idle(void);
 __ADDRESSABLE(cpu_arm740_do_idle);
@@ -64,7 +64,7 @@ void cpu_arm9tdmi_proc_init(void);
 __ADDRESSABLE(cpu_arm9tdmi_proc_init);
 void cpu_arm9tdmi_proc_fin(void);
 __ADDRESSABLE(cpu_arm9tdmi_proc_fin);
-void cpu_arm9tdmi_reset(void);
+void cpu_arm9tdmi_reset(unsigned long addr, bool hvc) __attribute__((noreturn));
 __ADDRESSABLE(cpu_arm9tdmi_reset);
 int cpu_arm9tdmi_do_idle(void);
 __ADDRESSABLE(cpu_arm9tdmi_do_idle);
@@ -79,7 +79,7 @@ void cpu_arm920_proc_init(void);
 __ADDRESSABLE(cpu_arm920_proc_init);
 void cpu_arm920_proc_fin(void);
 __ADDRESSABLE(cpu_arm920_proc_fin);
-void cpu_arm920_reset(void);
+void cpu_arm920_reset(unsigned long addr, bool hvc) __attribute__((noreturn));
 __ADDRESSABLE(cpu_arm920_reset);
 int cpu_arm920_do_idle(void);
 __ADDRESSABLE(cpu_arm920_do_idle);
@@ -102,7 +102,7 @@ void cpu_arm922_proc_init(void);
 __ADDRESSABLE(cpu_arm922_proc_init);
 void cpu_arm922_proc_fin(void);
 __ADDRESSABLE(cpu_arm922_proc_fin);
-void cpu_arm922_reset(void);
+void cpu_arm922_reset(unsigned long addr, bool hvc) __attribute__((noreturn));
 __ADDRESSABLE(cpu_arm922_reset);
 int cpu_arm922_do_idle(void);
 __ADDRESSABLE(cpu_arm922_do_idle);
@@ -119,7 +119,7 @@ void cpu_arm925_proc_init(void);
 __ADDRESSABLE(cpu_arm925_proc_init);
 void cpu_arm925_proc_fin(void);
 __ADDRESSABLE(cpu_arm925_proc_fin);
-void cpu_arm925_reset(void);
+void cpu_arm925_reset(unsigned long addr, bool hvc) __attribute__((noreturn));
 __ADDRESSABLE(cpu_arm925_reset);
 int cpu_arm925_do_idle(void);
 __ADDRESSABLE(cpu_arm925_do_idle);
@@ -159,7 +159,7 @@ void cpu_arm940_proc_init(void);
 __ADDRESSABLE(cpu_arm940_proc_init);
 void cpu_arm940_proc_fin(void);
 __ADDRESSABLE(cpu_arm940_proc_fin);
-void cpu_arm940_reset(void);
+void cpu_arm940_reset(unsigned long addr, bool hvc) __attribute__((noreturn));
 __ADDRESSABLE(cpu_arm940_reset);
 int cpu_arm940_do_idle(void);
 __ADDRESSABLE(cpu_arm940_do_idle);
@@ -174,7 +174,7 @@ void cpu_arm946_proc_init(void);
 __ADDRESSABLE(cpu_arm946_proc_init);
 void cpu_arm946_proc_fin(void);
 __ADDRESSABLE(cpu_arm946_proc_fin);
-void cpu_arm946_reset(void);
+void cpu_arm946_reset(unsigned long addr, bool hvc) __attribute__((noreturn));
 __ADDRESSABLE(cpu_arm946_reset);
 int cpu_arm946_do_idle(void);
 __ADDRESSABLE(cpu_arm946_do_idle);
@@ -429,7 +429,7 @@ void cpu_v7_proc_init(void);
 __ADDRESSABLE(cpu_v7_proc_init);
 void cpu_v7_proc_fin(void);
 __ADDRESSABLE(cpu_v7_proc_fin);
-void cpu_v7_reset(void);
+void cpu_v7_reset(unsigned long addr, bool hvc) __attribute__((noreturn));
 __ADDRESSABLE(cpu_v7_reset);
 int cpu_v7_do_idle(void);
 __ADDRESSABLE(cpu_v7_do_idle);

