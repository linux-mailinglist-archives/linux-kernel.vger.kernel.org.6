Return-Path: <linux-kernel+bounces-405359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FEB9C504A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 09:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E2D92821EC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 08:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192C520ADDE;
	Tue, 12 Nov 2024 08:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="Ikf7y/m9"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5181A08CB;
	Tue, 12 Nov 2024 08:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731398822; cv=none; b=Yf4K29NqrpYUUc5dt/CInIWdFgg2ULMxJQ9GoapWTsvYWSpy0twtU1lSX1Ds8+nsPu3OyZinfzKO0aiUr+W3EVYqTuCG6x01//CvLDVDxd5NObeq1lVnPv8Judc7XNg9L0ToxeVR+tF7mEH4ma2Jjk6gQZ3lQhDKXkBsN7YiT6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731398822; c=relaxed/simple;
	bh=HMpBG0EWkER/d5wAElJA7CpBW4T/KzQkjen8t8ghJ0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gfs45FMVFzyQVrBaOuG2j9IyuXzPbnBDs/yqnw2T9/WwrluPvSsEmYO/m8WqUnwmx5lCBDXE7bepZLflFMQvqStHrOlC1NKiIu720lNXvBvkgji1CJQ/VZ6ZcjNAcwPxBK/YC4OjsNLWS2T3Ys00Jf6zKKaNSjMj4EzgNemHRMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=Ikf7y/m9; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 62FB51F938;
	Tue, 12 Nov 2024 09:00:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1731398403;
	bh=t5k/krFv3SJskBWxwcoai7yAAgARXgJ1EMbSOEQ6Gtw=; h=From:To:Subject;
	b=Ikf7y/m91kOTnf4LmPXRRgzvIDRlybe/D1cXKnQO6tnTLD5NR7XsIuJpcAGId4Q+m
	 dnOCdUbg9YtL1ScBIE+CjMrtfh4dN67NoNwxHmaFwHF8XlY+259s6wkKyV0K20yfAb
	 L+dQoNGP2a+vToO+BDBXYnpDsLq11fKc6RgtiAvEBNxY9GtJK5s7vjxvogUmgyhJMh
	 4Bk8c89SYaG/2QKAvJKfRa/nT5GOU6pQpooVVvMF6eh+31iJUgNj06CilEY1et26Ac
	 38c5SQlemJ9gRLcNH9ck0HbGp97TdheEpEhw4X4E1VZwlF10W1hSdfaFIPtlrM/l5h
	 bZxozBSzXZwRg==
Date: Tue, 12 Nov 2024 08:59:58 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Shengjiu Wang <shengjiu.wang@nxp.com>, abelvesa@kernel.org,
	peng.fan@nxp.com, mturquette@baylibre.com, sboyd@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, linux-imx@nxp.com, shengjiu.wang@gmail.com,
	linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: regressions@lists.linux.dev, Adam Ford <aford173@gmail.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Mark Brown <broonie@kernel.org>, ulf.hansson@linaro.org
Subject: Re: clk_imx8mp_audiomix_runtime_resume Kernel panic regression on
 v6.12
Message-ID: <20241112075958.GA8092@francesco-nb>
References: <20241007132555.GA53279@francesco-nb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007132555.GA53279@francesco-nb>

Hello,

On Mon, Oct 07, 2024 at 03:25:55PM +0200, Francesco Dolcini wrote:
> Hello,
> it seems that an old regression is back on v6.12, reproduced on -rc2
> (not sure about rc1).
> 
> The original report is from https://lore.kernel.org/all/20240424164725.GA18760@francesco-nb/
> and it was fixed with https://lore.kernel.org/all/1715396125-3724-1-git-send-email-shengjiu.wang@nxp.com/.
> 
> Is it now back?

I was able to reproduce this issue once more, this time with 6.11.7.
As I wrote in another email the issue is not systematic as it used to
be.

Any idea?

[    4.287586] SError Interrupt on CPU1, code 0x00000000bf000002 -- SError
[    4.287594] CPU: 1 UID: 0 PID: 195 Comm: (udev-worker) Not tainted 6.11.7-7.1.0-devel-00010-g5374bda92db5 #1
[    4.287601] Hardware name: Toradex Verdin iMX8M Plus WB on Dahlia Board (DT)
[    4.287604] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    4.287609] pc : clk_imx8mp_audiomix_runtime_resume+0x18/0x40
[    4.287623] lr : pm_generic_runtime_resume+0x2c/0x44
[    4.287631] sp : ffff80008216b740
[    4.287633] x29: ffff80008216b740 x28: ffff800080e85010 x27: ffff8000794758d8
[    4.287642] x26: ffff0000c0a664f4 x25: 0000000000000000 x24: 0000000000000000
[    4.287649] x23: 0000000000000000 x22: ffff0000c0d01120 x21: 0000000000000000
[    4.287655] x20: ffff0000c1308800 x19: ffff0000c0a68c10 x18: 0000000000047820
[    4.287662] x17: 0000000000000000 x16: ffff0000faf87820 x15: 0000000000000002
[    4.287668] x14: 0000000000001400 x13: 00000000000003a0 x12: 0000000054a32c00
[    4.287675] x11: 0000000000000000 x10: ffff8000817b9d36 x9 : 0000000000000008
[    4.287682] x8 : 0000000000000008 x7 : 0000000000000000 x6 : 0000000000000000
[    4.287688] x5 : ffff800081ec0000 x4 : ffff0000c1a0b488 x3 : ffff800080bd23f0
[    4.287694] x2 : 0000000000000000 x1 : 0000000000000004 x0 : ffff800081ec0300
[    4.287703] Kernel panic - not syncing: Asynchronous SError Interrupt
[    4.287705] CPU: 1 UID: 0 PID: 195 Comm: (udev-worker) Not tainted 6.11.7-7.1.0-devel-00010-g5374bda92db5 #1
[    4.287711] Hardware name: Toradex Verdin iMX8M Plus WB on Dahlia Board (DT)
[    4.287714] Call trace:
[    4.287716]  dump_backtrace+0x94/0x114
[    4.287725]  show_stack+0x18/0x24
[    4.287732]  dump_stack_lvl+0x34/0x8c
[    4.287740]  dump_stack+0x18/0x24
[    4.287747]  panic+0x390/0x3a4
[    4.287751]  nmi_panic+0x40/0x8c
[    4.287755]  arm64_serror_panic+0x64/0x70
[    4.287759]  do_serror+0x3c/0x70
[    4.287763]  el1h_64_error_handler+0x30/0x48
[    4.287771]  el1h_64_error+0x64/0x68
[    4.287776]  clk_imx8mp_audiomix_runtime_resume+0x18/0x40
[    4.287784]  __genpd_runtime_resume+0x30/0x80
[    4.287791]  genpd_runtime_resume+0x114/0x29c
[    4.287799]  __rpm_callback+0x48/0x1d8
[    4.287806]  rpm_callback+0x68/0x74
[    4.287813]  rpm_resume+0x46c/0x6bc
[    4.287819]  __pm_runtime_resume+0x50/0x94
[    4.287825]  pm_runtime_get_suppliers+0x60/0x8c
[    4.287831]  __driver_probe_device+0x4c/0x15c
[    4.287838]  driver_probe_device+0x3c/0x110
[    4.287844]  __driver_attach+0xf0/0x1f8
[    4.287850]  bus_for_each_dev+0x7c/0xdc
[    4.287856]  driver_attach+0x24/0x30
[    4.287862]  bus_add_driver+0x110/0x234
[    4.287868]  driver_register+0x5c/0x124
[    4.287874]  __platform_driver_register+0x28/0x34
[    4.287882]  sdma_driver_init+0x20/0x1000 [imx_sdma]
[    4.287895]  do_one_initcall+0x80/0x1c8
[    4.287900]  do_init_module+0x60/0x218
[    4.287907]  load_module+0x1fcc/0x2040
[    4.287912]  init_module_from_file+0x88/0xcc
[    4.287918]  __arm64_sys_finit_module+0x254/0x34c
[    4.287924]  invoke_syscall.constprop.0+0x50/0xe4
[    4.287932]  do_el0_svc+0xa8/0xc8
[    4.287938]  el0_svc+0x3c/0x13c
[    4.287945]  el0t_64_sync_handler+0x120/0x12c
[    4.287952]  el0t_64_sync+0x190/0x194
[    4.287958] SMP: stopping secondary CPUs
[    4.287965] Kernel Offset: disabled
[    4.287966] CPU features: 0x00,00000000,00100000,4200420b
[    4.287970] Memory Limit: none
[    4.590829] ---[ end Kernel panic - not syncing: Asynchronous SError Interrupt ]---

Francesco


