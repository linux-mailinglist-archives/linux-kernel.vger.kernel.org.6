Return-Path: <linux-kernel+bounces-355182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FF19949A8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 14:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A390228100D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 12:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4C11DF26A;
	Tue,  8 Oct 2024 12:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="QOoMRLiz"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E869D1DF263;
	Tue,  8 Oct 2024 12:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728390281; cv=none; b=KE9IRNktpWtw0WTb8P6fz0WmmUE5nQJg70/1ye1mVe3h4j4+1KCGXn1A7SNKcLt/jcpt873df8L3xVpwPQwsnn062gzVetil+gMUP3hi4VBS8tK7nxWyteGAO1JGlgxEV5Nb8jsAQRo5fqLTPmF7QOVJCCNZ8r2ulBX397AIFsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728390281; c=relaxed/simple;
	bh=0s+4gHJr9qsvPt6+u0tXhbgzW2NNJIE8kSyNOUIzW3A=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=oQ6kNT+sLVIw1iHGq9KXqUBQ82i3XtFjjquisGPKDyHRojz8icnk9yMltUDxhV4UjjGQR8PnIQSWecJLVHHgS2+7NT6txrc9lCoJOO3tNSQBV0eVXGWDfVG+fK4a6EVUfuJBbR3dsSbBmDWU3lPP0h8LZfBOYb8FUt3J7IMm9Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=QOoMRLiz; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from [127.0.0.1] (unknown [176.200.169.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 8F35E20151;
	Tue,  8 Oct 2024 14:24:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1728390269;
	bh=D8AB0p6sVH9uqIa4vDHSPPZOfrBdwOjdjHP353g3wjU=; h=From:To:Subject;
	b=QOoMRLizYBPw4sJrPYKC2gIq6ugUHH1BkI1sdixcS/CTVapi+JqAs12XMW/STzZy0
	 kvzSpYjm+uUArDMpX9TDsZbPz3g4Pxss49UtvuNP2C8KxuMKlaKbl7FHHlX3HjwkLy
	 lgzdIu65kQ2aotc6mgtsAPIZOdKknjmNqha8RQMC40PhvrYUPTs/kn2gR3rlZVhuRb
	 IfAx8OkF/kVbgqgi+w61CYJZRWauYTCRlth5QlEifgsRBil1UPmHts0qadYiwZZ2nk
	 KnRv1qenox4WIbwNEkEMmrqh0OITnVLhqYbrwXeMSzogV7u3Y5gIos0/uoZzczHQzD
	 +rdIzQx1SDHmA==
Date: Tue, 08 Oct 2024 14:24:27 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Adam Ford <aford173@gmail.com>, Peng Fan <peng.fan@nxp.com>
CC: "S.J. Wang" <shengjiu.wang@nxp.com>,
 "abelvesa@kernel.org" <abelvesa@kernel.org>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 "sboyd@kernel.org" <sboyd@kernel.org>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "festevam@gmail.com" <festevam@gmail.com>, dl-linux-imx <linux-imx@nxp.com>,
 "shengjiu.wang@gmail.com" <shengjiu.wang@gmail.com>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Mark Brown <broonie@kernel.org>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Subject: =?US-ASCII?Q?Re=3A_clk=5Fimx8mp=5Faudiomix=5Fruntime=5Fres?=
 =?US-ASCII?Q?ume_Kernel_panic_regression_on_v6=2E12?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAHCN7xLzYVBB=+EkD14xYqGJDR6BRUO7hxBZGOtvzCFLp_kXdg@mail.gmail.com>
References: <20241007132555.GA53279@francesco-nb> <PAXPR04MB84596824B2DFDF20E005F173887E2@PAXPR04MB8459.eurprd04.prod.outlook.com> <PAXPR04MB845980EE67F1B99C9AC9D0DF887E2@PAXPR04MB8459.eurprd04.prod.outlook.com> <CAHCN7xLzYVBB=+EkD14xYqGJDR6BRUO7hxBZGOtvzCFLp_kXdg@mail.gmail.com>
Message-ID: <84371A37-9C3D-44AF-8796-7427B39DC3D4@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Il 8 ottobre 2024 14:19:15 CEST, Adam Ford <aford173@gmail=2Ecom> ha scritt=
o:
>On Tue, Oct 8, 2024 at 3:51=E2=80=AFAM Peng Fan <peng=2Efan@nxp=2Ecom> wr=
ote:
>>
>> > Subject: RE: clk_imx8mp_audiomix_runtime_resume Kernel panic
>> > regression on v6=2E12
>> >
>> > > Subject: clk_imx8mp_audiomix_runtime_resume Kernel panic
>> > regression on
>> > > v6=2E12
>> > >
>> > >
>> > > Is it now back?
>> >
>> > With tag: next-20240930, I need see this issue on i=2EMX8MP-EVK board=
=2E
>>
>> Sorry, typo=2E I not see issue on my board=2E
>
>I tested RC1 on the Beacon board and didn't see any issues, but I can
>try testing linux-next when I have some time=2E
>

I forgot to mention that the issue is not systematic as it was in the orig=
inal report=2E

And it was reproduced on v6=2E12-rc2, not with -next=2E

Francesco=20


>adam
>>
>> Regards,
>> Peng=2E
>>
>> >
>> > Regards,
>> > Peng=2E
>> >
>> > >
>> > > [    4=2E012850] SError Interrupt on CPU2, code 0x00000000bf000002 =
-
>> > -
>> > > SError
>> > > [    4=2E012862] CPU: 2 UID: 0 PID: 186 Comm: (udev-worker) Not
>> > tainted
>> > > 6=2E12=2E0-rc2-0=2E0=2E0-devel-00004-g8b1b79e88956 #1
>> > > [    4=2E012869] Hardware name: Toradex Verdin iMX8M Plus WB on
>> > > Dahlia Board (DT)
>> > > [    4=2E012872] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -
>> > SSBS
>> > > BTYPE=3D--)
>> > > [    4=2E012877] pc :
>> > clk_imx8mp_audiomix_runtime_resume+0x38/0x48
>> > > [    4=2E012891] lr : pm_generic_runtime_resume+0x2c/0x44
>> > > [    4=2E012897] sp : ffff8000821cb740
>> > > [    4=2E012899] x29: ffff8000821cb740 x28: ffff8000793c48d8 x27:
>> > > ffff8000793c48c0
>> > > [    4=2E012908] x26: ffff0000c0ec90f4 x25: 0000000000000000 x24:
>> > > 0000000000000000
>> > > [    4=2E012916] x23: 0000000000000000 x22: ffff0000c1bef180 x21:
>> > > 0000000000000000
>> > > [    4=2E012923] x20: ffff0000c0a73000 x19: ffff0000c0ecbc10 x18:
>> > > ffffffffffffffff
>> > > [    4=2E012930] x17: 3030303064623033 x16: 2f7375622e303030 x15:
>> > > 756e285472656c6c
>> > > [    4=2E012937] x14: ffff800081267458 x13: 6d692c6c73664361 x12:
>> > > 0000000000000000
>> > > [    4=2E012944] x11: 00353333333d4d55 x10: ffff8000818020ae x9 :
>> > > 0000000000000008
>> > > [    4=2E012951] x8 : 0000000000000008 x7 : 0000000000000000 x6 :
>> > > ffff0000c5bf2080
>> > > [    4=2E012958] x5 : ffff800081f10000 x4 : ffff800080c182e8 x3 :
>> > > ffff0000c0ee7088
>> > > [    4=2E012965] x2 : 0000000000000000 x1 : 0000000000000004 x0 :
>> > > ffff800081f10300
>> > > [    4=2E012973] Kernel panic - not syncing: Asynchronous SError
>> > Interrupt
>> > > [    4=2E012976] CPU: 2 UID: 0 PID: 186 Comm: (udev-worker) Not
>> > tainted
>> > > 6=2E12=2E0-rc2-0=2E0=2E0-devel-00004-g8b1b79e88956 #1
>> > > [    4=2E012982] Hardware name: Toradex Verdin iMX8M Plus WB on
>> > > Dahlia Board (DT)
>> > > [    4=2E012985] Call trace:
>> > > [    4=2E012988]  dump_backtrace+0xd0/0x120
>> > > [    4=2E012998]  show_stack+0x18/0x24
>> > > [    4=2E013005]  dump_stack_lvl+0x60/0x80
>> > > [    4=2E013013]  dump_stack+0x18/0x24
>> > > [    4=2E013019]  panic+0x168/0x350
>> > > [    4=2E013025]  add_taint+0x0/0xbc
>> > > [    4=2E013029]  arm64_serror_panic+0x64/0x70
>> > > [    4=2E013034]  do_serror+0x3c/0x70
>> > > [    4=2E013039]  el1h_64_error_handler+0x30/0x54
>> > > [    4=2E013046]  el1h_64_error+0x64/0x68
>> > > [    4=2E013050]  clk_imx8mp_audiomix_runtime_resume+0x38/0x48
>> > > [    4=2E013059]  __genpd_runtime_resume+0x30/0x80
>> > > [    4=2E013066]  genpd_runtime_resume+0x114/0x29c
>> > > [    4=2E013073]  __rpm_callback+0x48/0x1e0
>> > > [    4=2E013079]  rpm_callback+0x68/0x80
>> > > [    4=2E013084]  rpm_resume+0x3bc/0x6a0
>> > > [    4=2E013089]  __pm_runtime_resume+0x50/0x9c
>> > > [    4=2E013095]  pm_runtime_get_suppliers+0x60/0x8c
>> > > [    4=2E013101]  __driver_probe_device+0x4c/0x14c
>> > > [    4=2E013108]  driver_probe_device+0x3c/0x120
>> > > [    4=2E013114]  __driver_attach+0xc4/0x200
>> > > [    4=2E013119]  bus_for_each_dev+0x7c/0xe0
>> > > [    4=2E013125]  driver_attach+0x24/0x30
>> > > [    4=2E013130]  bus_add_driver+0x110/0x240
>> > > [    4=2E013135]  driver_register+0x68/0x124
>> > > [    4=2E013142]  __platform_driver_register+0x24/0x30
>> > > [    4=2E013149]  sdma_driver_init+0x20/0x1000 [imx_sdma]
>> > > [    4=2E013163]  do_one_initcall+0x60/0x1e0
>> > > [    4=2E013168]  do_init_module+0x5c/0x21c
>> > > [    4=2E013175]  load_module+0x1a98/0x205c
>> > > [    4=2E013181]  init_module_from_file+0x88/0xd4
>> > > [    4=2E013187]  __arm64_sys_finit_module+0x258/0x350
>> > > [    4=2E013194]  invoke_syscall=2Econstprop=2E0+0x50/0xe0
>> > > [    4=2E013202]  do_el0_svc+0xa8/0xe0
>> > > [    4=2E013208]  el0_svc+0x3c/0x140
>> > > [    4=2E013215]  el0t_64_sync_handler+0x120/0x12c
>> > > [    4=2E013222]  el0t_64_sync+0x190/0x194
>> > > [    4=2E013228] SMP: stopping secondary CPUs
>> > > [    4=2E013237] Kernel Offset: disabled
>> > > [    4=2E013239] CPU features: 0x00,00000000,00200000,4200420b
>> > > [    4=2E013243] Memory Limit: none
>> > > [    4=2E316721] ---[ end Kernel panic - not syncing: Asynchronous =
SError
>> > > Interrupt ]---
>> > >
>> > >
>> > > Francesco
>>

Hello,

