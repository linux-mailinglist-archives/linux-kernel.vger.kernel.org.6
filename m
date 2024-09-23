Return-Path: <linux-kernel+bounces-336220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5AC97F0C4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 20:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04F501F238C3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 18:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0681A0705;
	Mon, 23 Sep 2024 18:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CLUj8CiJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941C9199944;
	Mon, 23 Sep 2024 18:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727116756; cv=none; b=ocSJpit2z5nRjDVV+Iy95VuYWLLVpZa62aDA0UXQpHP62i9GPxKcV8ooDxdUWMfl/JWnNex/TM3iDnIOgzdzHLaxjDpfzqzeNvo4S0OxqLX+vOna/sEMObfeeearA9uYGI9VXnUgQpKZ86sT2AjDQMD5/BumIrCcmuX5NtMXPwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727116756; c=relaxed/simple;
	bh=3xkrC7nH3yEPb6TWxqSBuuvlsepHC+lBMPVLDMwwOzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NPcZqdNK/0eLkJWP8WyqdpnlKFcXbDb+pSshJPDESL9Snq6J2SRNgTmcBptzElJD4GmOrXZXvFFqMR4KpIYgais1kasFXczcBjoz1Fb28WpG08AOAADg1RAXbYTeTtQd7iIQqmmGNXKbhA4RplTg2zuYbCSgYup/hyPGGTIRE+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CLUj8CiJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8BA7C4CEC4;
	Mon, 23 Sep 2024 18:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727116756;
	bh=3xkrC7nH3yEPb6TWxqSBuuvlsepHC+lBMPVLDMwwOzE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CLUj8CiJkL9bz0/ikwF4bf0wVI6siqWtxS5wxvnVCM3f8Sq2b7n2Gjaqh9M9MnOv6
	 AkKzn8LldUwioKqsP4hTPcGJ9FjV/Z/QMrwOOrAQOrHEZMefT6VQwwn1EhokcnwwOQ
	 CGS6nC/uJy40R21aQvtC/Og8SQ8vkN2i9GTKUlPE/xxDIfr+2r1+nWfZQ0rFJdR1LW
	 cof8uAmkkiuYQdw+s26LYQ3++fuR6yhzkGrvBpjvRQ8sOWUl+MqPSa0AojmiwLX7rw
	 iAIolaoqhy8uW935dBsxUCEVPuUd7dz8GNJE1MkJ/g1GkZmEmR1jPn0Ru+ox8Ude12
	 d0JDftb0CBCww==
Date: Mon, 23 Sep 2024 11:39:14 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: arch/powerpc/include/asm/switch_to.h:53:2: error: call to
 '__compiletime_assert_256' declared with 'error' attribute: BUILD_BUG failed
Message-ID: <20240923183914.GA671157@thelio-3990X>
References: <202409230705.hFpB3jMt-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202409230705.hFpB3jMt-lkp@intel.com>

On Mon, Sep 23, 2024 at 07:34:48AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   de5cb0dcb74c294ec527eddfe5094acfdb21ff21
> commit: c2e5d70cf05b48bfbd5b6625bbd0ec3052cecd5d powerpc/83xx: Fix build failure with FPU=n
> date:   7 months ago
> config: powerpc-randconfig-001-20240923 (https://download.01.org/0day-ci/archive/20240923/202409230705.hFpB3jMt-lkp@intel.com/config)
> compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 8663a75fa2f31299ab8d1d90288d9df92aadee88)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240923/202409230705.hFpB3jMt-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202409230705.hFpB3jMt-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
...
>    In file included from drivers/cpufreq/pmac32-cpufreq.c:38:
> >> arch/powerpc/include/asm/switch_to.h:53:2: error: call to '__compiletime_assert_256' declared with 'error' attribute: BUILD_BUG failed
>       53 |         BUILD_BUG();
>          |         ^
>    include/linux/build_bug.h:59:21: note: expanded from macro 'BUILD_BUG'
>       59 | #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
>          |                     ^
>    include/linux/build_bug.h:39:37: note: expanded from macro 'BUILD_BUG_ON_MSG'
>       39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>          |                                     ^
>    include/linux/compiler_types.h:435:2: note: expanded from macro 'compiletime_assert'
>      435 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>          |         ^
>    include/linux/compiler_types.h:423:2: note: expanded from macro '_compiletime_assert'
>      423 |         __compiletime_assert(condition, msg, prefix, suffix)
>          |         ^
>    include/linux/compiler_types.h:416:4: note: expanded from macro '__compiletime_assert'
>      416 |                         prefix ## suffix();                             \
>          |                         ^
>    <scratch space>:106:1: note: expanded from here
>      106 | __compiletime_assert_256
>          | ^
>    1 warning and 1 error generated.

Does not appear to be clang related but it seems like
drivers/cpufreq/pmac32-cpufreq.c needs the same fixup?

Cheers,
Nathan

diff --git a/drivers/cpufreq/pmac32-cpufreq.c b/drivers/cpufreq/pmac32-cpufreq.c
index 6c9f0888a2a7..25e84b7d3728 100644
--- a/drivers/cpufreq/pmac32-cpufreq.c
+++ b/drivers/cpufreq/pmac32-cpufreq.c
@@ -260,7 +260,8 @@ static int pmu_set_cpu_speed(int low_speed)
 	local_irq_save(flags);
 
 	/* Giveup the FPU & vec */
-	enable_kernel_fp();
+	if (IS_ENABLED(CONFIG_PPC_FPU))
+		enable_kernel_fp();
 
 #ifdef CONFIG_ALTIVEC
 	if (cpu_has_feature(CPU_FTR_ALTIVEC))

