Return-Path: <linux-kernel+bounces-186255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9228CC1C5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 15:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ED151F217A9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 13:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65F313DDA7;
	Wed, 22 May 2024 13:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="wziilpdP"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26918757FD;
	Wed, 22 May 2024 13:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716383264; cv=none; b=bVodY4ZSy9iX1I6OKB+enpXgbgCDah8njXIPg86YvEeHZyg+9c61YQyylnL0xcoFO/VTI7GC+/ncb6IhT7q31TVQkKFKw+ggFONGMmrYw8tNMqZXSohd7Skc2380kxzn/KQApBsLv7xCbIIm5hVpfLaisWZtb3DbT3Y5L2m0Fao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716383264; c=relaxed/simple;
	bh=DR7CbPhtoXxljRXwMNH+G47S0+2kRKotroU41iH/CqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X0z8gQQYprgqTtLz73XIsq7gi6XgA26Jb71qrb9nfq1Qn/8RMOJEot6kK7pxxFLS7q85nhMP5dxI2KAncYVB+GAPAREHaWGJZT40SZspqT05lnkPN68FBmcOOhH8JJxk6qBleiNUieNZAoqx6IOWKeAQ02ALza1NcexbO+oAi6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=wziilpdP; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 816731F92B;
	Wed, 22 May 2024 15:07:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1716383251;
	bh=DVpLbXbSXLDR2E52fL0MUlD1s9DgA0AHMZxzZOEhZJI=; h=From:To:Subject;
	b=wziilpdPKArGBsfWTEBbbmnsuxxPES2PnWUvbENF/Y3GZDBtkC/EYoBB68r+8GgSN
	 eHXg9oZR8cQxoZG7dp4vFE1TkXXfcJxB/Su8c5wesQFMR/SaselD48MgWCUeipjLZw
	 rO/Aq8feLg/J0JdUKLCShK55vs0TWEESH0Ua09Tv6mTQQ73kP2aVlCk79CXzKqv8I1
	 xF4RgDGhBC6NYUCgEh+VF0Lz8rlYY/bhFMOO06g9vHVtFtqfeRrh6N3RALZBVsrGxZ
	 0uRnM9mp0TRw0dvmw/nauuJs9CODeWPetdetsqiKjtCKMRbYEvyd8fZdgCcZ5S2HLH
	 0w/oAHz0gN0WA==
Date: Wed, 22 May 2024 15:07:27 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Andrejs Cainikovs <andrejs.cainikovs@gmail.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
Subject: Re: [PATCH v1 2/2] ASoC: nau8822: add MCLK support
Message-ID: <20240522130727.GA30641@francesco-nb>
References: <20240409121719.337709-1-andrejs.cainikovs@gmail.com>
 <20240409121719.337709-3-andrejs.cainikovs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409121719.337709-3-andrejs.cainikovs@gmail.com>

Hello,

On Tue, Apr 09, 2024 at 02:17:19PM +0200, Andrejs Cainikovs wrote:
> From: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
> 
> This change adds MCLK clock handling directly within driver.
> When used in combination with simple-audio-card, and mclk-fs is set,
> simple-audio-card will change MCLK frequency before configuring PLL.
> In some cases, however, MCLK reference clock should be static (see [1]),
> which means it needs to be moved away from simple-audio-card.
> 
> [1]: https://lore.kernel.org/all/ZfBdxrzX3EnPuGOn@ediswmail9.ad.cirrus.com/


This seems buggy, it introduces the following error:

[ 8490.005519] ------------[ cut here ]------------
[ 8490.005527] audio_refclk:clk:157:10 already disabled
[ 8490.005585] WARNING: CPU: 0 PID: 858 at drivers/clk/clk.c:1038 clk_core_disable+0xb0/0xb8
[ 8490.005623] Modules linked in: 8021q garp stp mrp llc rfcomm af_alg usb_f_ncm u_ether ti_k3_r5_remoteproc virtio_rpmsg_bus btnxpuart rpmsg_ns rtc_ti_k3 ti_k3_m4_remoteproc ti_k3_common mwifiex_sdio mwifiex cfg80211 bluetooth ecdh_generic ecc tidss snd_soc_davinci_mcasp rfkill snd_soc_ti_udma snd_soc_ti_edma sa2ul drm_dma_helper snd_soc_ti_sdma mcrc ina2xx lontium_lt8916
[ 8490.005857] CPU: 0 PID: 858 Comm: rtcwake Tainted: G        W          6.1.80-15754-g2d31b2cc742b-dirty #38
[ 8490.005868] Hardware name: Toradex Verdin AM62 WB on Verdin Development Board (DT)
[ 8490.005876] pstate: 400000c5 (nZcv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[ 8490.005886] pc : clk_core_disable+0xb0/0xb8
[ 8490.005897] lr : clk_core_disable+0xb0/0xb8
[ 8490.005907] sp : ffff80000a5a3960
[ 8490.005911] x29: ffff80000a5a3960 x28: ffff800009246000 x27: ffff800008df4690
[ 8490.005926] x26: ffff8000091dbcc0 x25: ffff800008df4000 x24: ffff8000091dbc18
[ 8490.005941] x23: ffff000002de5080 x22: 0000000000000000 x21: ffff000002f5fc80
[ 8490.005955] x20: ffff00000118df00 x19: ffff00000118df00 x18: ffff800000d15000
[ 8490.005970] x17: 0000000000000000 x16: 0000000000000000 x15: ffff00000605aac0
[ 8490.005984] x14: fffffffffffca828 x13: 0a64656c62617369 x12: 642079646165726c
[ 8490.005997] x11: 656820747563205b x10: 2d2d2d2d2d2d2d2d x9 : 00000000fffffffe
[ 8490.006012] x8 : ffff8000090c1260 x7 : ffff80000a5a3760 x6 : 00000000fffff267
[ 8490.006026] x5 : ffff00001da1ab60 x4 : 0000000000000000 x3 : 0000000000000027
[ 8490.006039] x2 : ffff00001da1ab68 x1 : ae3ede0e49d60900 x0 : 0000000000000000
[ 8490.006055] Call trace:
[ 8490.006060]  clk_core_disable+0xb0/0xb8
[ 8490.006072]  clk_core_disable_lock+0x24/0x40
[ 8490.006082]  clk_disable+0x20/0x30
[ 8490.006093]  nau8822_set_bias_level+0x68/0x1a0 [snd_soc_nau8822]
[ 8490.006123]  snd_soc_component_set_bias_level+0x28/0x78
[ 8490.006136]  snd_soc_dapm_force_bias_level+0x24/0x40
[ 8490.006149]  nau8822_suspend+0x28/0x48 [snd_soc_nau8822]
[ 8490.006167]  snd_soc_component_suspend+0x24/0x40
[ 8490.006176]  snd_soc_suspend+0x1bc/0x218
[ 8490.006185]  platform_pm_suspend+0x2c/0x78
[ 8490.006198]  dpm_run_callback+0x3c/0x88
[ 8490.006209]  __device_suspend+0x110/0x3b0
[ 8490.006219]  dpm_suspend+0x100/0x200
[ 8490.006228]  dpm_suspend_start+0x80/0xa0
[ 8490.006238]  suspend_devices_and_enter+0xc8/0x4e8
[ 8490.006252]  pm_suspend+0x1f8/0x268
[ 8490.006261]  state_store+0x8c/0x118
[ 8490.006270]  kobj_attr_store+0x18/0x30
[ 8490.006287]  sysfs_kf_write+0x44/0x58
[ 8490.006297]  kernfs_fop_write_iter+0x118/0x1a8
[ 8490.006310]  vfs_write+0x33c/0x438
[ 8490.006320]  ksys_write+0x6c/0xf8
[ 8490.006327]  __arm64_sys_write+0x1c/0x28
[ 8490.006335]  invoke_syscall+0x44/0x108
[ 8490.006348]  el0_svc_common.constprop.0+0xcc/0xf0
[ 8490.006358]  do_el0_svc+0x1c/0x28
[ 8490.006367]  el0_svc+0x28/0x98
[ 8490.006377]  el0t_64_sync_handler+0xb8/0xc0
[ 8490.006386]  el0t_64_sync+0x18c/0x190
[ 8490.006397] ---[ end trace 0000000000000000 ]---
[ 8490.006407] ------------[ cut here ]------------
[ 8490.006410] audio_refclk:clk:157:10 already unprepared
[ 8490.006447] WARNING: CPU: 0 PID: 858 at drivers/clk/clk.c:897 clk_core_unprepare+0xf0/0x110
[ 8490.006463] Modules linked in: 8021q garp stp mrp llc rfcomm af_alg usb_f_ncm u_ether ti_k3_r5_remoteproc virtio_rpmsg_bus btnxpuart rpmsg_ns rtc_ti_k3 ti_k3_m4_remoteproc ti_k3_common mwifiex_sdio mwifiex cfg80211 bluetooth ecdh_generic ecc tidss snd_soc_davinci_mcasp rfkill snd_soc_ti_udma snd_soc_ti_edma sa2ul drm_dma_helper snd_soc_ti_sdma mcrc ina2xx lontium_lt8916
[ 8490.006644] CPU: 0 PID: 858 Comm: rtcwake Tainted: G        W          6.1.80-15754-g2d31b2cc742b-dirty #38
[ 8490.006653] Hardware name: Toradex Verdin AM62 WB on Verdin Development Board (DT)
[ 8490.006658] pstate: 40000005 (nZcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[ 8490.006667] pc : clk_core_unprepare+0xf0/0x110
[ 8490.006678] lr : clk_core_unprepare+0xf0/0x110
[ 8490.006688] sp : ffff80000a5a3970
[ 8490.006691] x29: ffff80000a5a3970 x28: ffff800009246000 x27: ffff800008df4690
[ 8490.006706] x26: ffff8000091dbcc0 x25: ffff800008df4000 x24: ffff8000091dbc18
[ 8490.006720] x23: ffff000002de5080 x22: 0000000000000000 x21: ffff000002f5fc80
[ 8490.006735] x20: 0000000000000000 x19: ffff00000118df00 x18: ffff800000d15000
[ 8490.006749] x17: 0000000000000000 x16: 0000000000000000 x15: ffff00000605aac0
[ 8490.006763] x14: fffffffffffcb568 x13: 0a64657261706572 x12: 706e752079646165
[ 8490.006777] x11: 656820747563205b x10: 2d2d2d2d2d2d2d2d x9 : 00000000fffffffe
[ 8490.006791] x8 : ffff8000090c1260 x7 : ffff80000a5a3770 x6 : 00000000fffff29a
[ 8490.006805] x5 : ffff00001da1ab60 x4 : 0000000000000000 x3 : 0000000000000027
[ 8490.006819] x2 : ffff00001da1ab68 x1 : ae3ede0e49d60900 x0 : 0000000000000000
[ 8490.006833] Call trace:
[ 8490.006836]  clk_core_unprepare+0xf0/0x110
[ 8490.006847]  clk_unprepare+0x2c/0x48
[ 8490.006855]  nau8822_set_bias_level+0x70/0x1a0 [snd_soc_nau8822]
[ 8490.006874]  snd_soc_component_set_bias_level+0x28/0x78
[ 8490.006883]  snd_soc_dapm_force_bias_level+0x24/0x40
[ 8490.006893]  nau8822_suspend+0x28/0x48 [snd_soc_nau8822]
[ 8490.006913]  snd_soc_component_suspend+0x24/0x40
[ 8490.006921]  snd_soc_suspend+0x1bc/0x218
[ 8490.006929]  platform_pm_suspend+0x2c/0x78
[ 8490.006939]  dpm_run_callback+0x3c/0x88
[ 8490.006948]  __device_suspend+0x110/0x3b0
[ 8490.006957]  dpm_suspend+0x100/0x200
[ 8490.006967]  dpm_suspend_start+0x80/0xa0
[ 8490.006976]  suspend_devices_and_enter+0xc8/0x4e8
[ 8490.006986]  pm_suspend+0x1f8/0x268
[ 8490.006994]  state_store+0x8c/0x118
[ 8490.007003]  kobj_attr_store+0x18/0x30
[ 8490.007014]  sysfs_kf_write+0x44/0x58
[ 8490.007022]  kernfs_fop_write_iter+0x118/0x1a8
[ 8490.007033]  vfs_write+0x33c/0x438
[ 8490.007041]  ksys_write+0x6c/0xf8
[ 8490.007047]  __arm64_sys_write+0x1c/0x28
[ 8490.007055]  invoke_syscall+0x44/0x108
[ 8490.007064]  el0_svc_common.constprop.0+0xcc/0xf0
[ 8490.007074]  do_el0_svc+0x1c/0x28
[ 8490.007083]  el0_svc+0x28/0x98
[ 8490.007091]  el0t_64_sync_handler+0xb8/0xc0
[ 8490.007100]  el0t_64_sync+0x18c/0x190
[ 8490.007108] ---[ end trace 0000000000000000 ]---


Francesco


