Return-Path: <linux-kernel+bounces-280971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A8B94D17F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 15:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAFE4281DC1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 13:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD15195803;
	Fri,  9 Aug 2024 13:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hrZIAq36"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDE9194C71;
	Fri,  9 Aug 2024 13:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723211081; cv=none; b=J2cZIOgKDHNtwZ+LLT+lr46VL6tsMA1zmxUmrPTF6OIrMlmOoMpALiBGVgPwE2XFB5wTrGv++Rth5Do36FWUia8tT4aI7i+dBCz44XsM2yIFriiCCxKJaZPPLwfRVtVcYIUQwsXcfsudSg+LcPjDrEzXbLZ/4tuAmwDVqPRGX6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723211081; c=relaxed/simple;
	bh=HX1cvtY261kXNzpQl26UX061L3ayljAk4uTgDBcyzG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KY36QfdkiJiy5JZsnMuPnE6E06N8fD8yjR4xDpmq4YSRvBDSXV7sGKFSpSeYK8eB2sfHBZLmBDgBGlQYUHQKdMum0t01qoSslOCOMm7fWbcNmCVhH9dUCaq4uQMMKp4MTqdyJgimy2gX71HmYYIe1nyBbfuQjoVoovLYv3J/qyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hrZIAq36; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 312B2C32782;
	Fri,  9 Aug 2024 13:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723211081;
	bh=HX1cvtY261kXNzpQl26UX061L3ayljAk4uTgDBcyzG8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=hrZIAq36R2OA9det/JxrrOMJyAUGztLpXLGx3xGXiZMUB2tAaFVeo7KwS9KDhp7MW
	 maPV3zgoSXSUy4iY1jg+kSfykgik6YEVxOr7QKpxruNpUrqxJ/ijlIzGuFCyhSt1Of
	 5B8rgpnrg/ijUS03DbW/fqVtTCCXZgNhf2mc9Tjxv9A6fSM9lU7A9en9fru+nOwZm7
	 xMvAu3hOkQFji1756OnZp6N8df7T8JC1QV4WhtFz4i9B4NuthNsBjfi/dIsfQHmpYo
	 bd/L2kZSfh/z13Dgf4UvjC2wjWWmbdqbfaUzGTkqdMT/9bwwFAkUYvr8xIrvBpyi8s
	 9RkEZSpfgEhsQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C9736CE0734; Fri,  9 Aug 2024 06:44:40 -0700 (PDT)
Date: Fri, 9 Aug 2024 06:44:40 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [paulmckrcu:dev.2024.08.05a] [rcuscale]  0b85a3ea0a:
 WARNING:at_lib/alloc_tag.c:#alloc_tag_module_unload
Message-ID: <045374c6-d969-48f6-acd7-320031961bb2@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <202408091019.8ed98238-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202408091019.8ed98238-lkp@intel.com>

On Fri, Aug 09, 2024 at 10:22:08AM +0800, kernel test robot wrote:
> 
> hi, Paul,
> 
> we noticed the issue for dev.2024.07.31a at first, but recently we cannot handle
> the report fast enough so didn't report that to you.
> 
> we also noticed similar commit in dev.2024.08.06a, but didn't finish test so
> far. in order to avoid further delay, just send out this FYI.
> 
> if it's a known issue and has already fixed in dev.2024.08.06a, please just
> ignore. thanks
> 
> 
> Hello,
> 
> kernel test robot noticed "WARNING:at_lib/alloc_tag.c:#alloc_tag_module_unload" on:
> 
> commit: 0b85a3ea0a8e4d8235e858a3aa1dadc3d0cec4e2 ("rcuscale: Dump stacks of stalled rcu_scale_writer() instances")
> https://github.com/paulmckrcu/linux dev.2024.08.05a
> 
> in testcase: rcuscale
> version: 
> with following parameters:
> 
> 	runtime: 300s
> 	scale_type: rcu
> 
> 
> 
> compiler: clang-18
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> +-----------------------------------------------------+------------+------------+
> |                                                     | 532e4ab154 | 0b85a3ea0a |
> +-----------------------------------------------------+------------+------------+
> | WARNING:at_lib/alloc_tag.c:#alloc_tag_module_unload | 0          | 12         |
> | RIP:alloc_tag_module_unload                         | 0          | 12         |
> +-----------------------------------------------------+------------+------------+
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202408091019.8ed98238-lkp@intel.com
> 
> 
> [  465.251143][ T1160] ------------[ cut here ]------------
> [  465.252395][ T1160] kernel/rcu/rcuscale.c:1037 module rcuscale func:rcu_scale_init has 32 allocated at module unload
> [ 465.252492][ T1160] WARNING: CPU: 0 PID: 1160 at lib/alloc_tag.c:170 alloc_tag_module_unload (lib/alloc_tag.c:168) 
> [  465.256072][ T1160] Modules linked in: rcuscale(-) torture ipmi_devintf ppdev crct10dif_pclmul crc32_pclmul parport_pc aesni_intel parport serio_raw loop fuse [last unloaded: rcuscale]

Good catch, thank you!

Does the diff shown below help?

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index b1c50df142eba..6d37596deb1f1 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -1052,6 +1052,8 @@ rcu_scale_cleanup(void)
 		writer_durations = NULL;
 		kfree(writer_n_durations);
 		writer_n_durations = NULL;
+		kfree(writer_done);
+		writer_done = NULL;
 		kfree(writer_freelists);
 		writer_freelists = NULL;
 	}

