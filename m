Return-Path: <linux-kernel+bounces-420158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9969D75E6
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 17:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A979C165932
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 16:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65719189F45;
	Sun, 24 Nov 2024 16:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RLE+Gyas"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77E32500B1;
	Sun, 24 Nov 2024 16:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732465784; cv=none; b=TBJq1OxtcJBl5JSFPPjNCniVMV9l6vGNK98G6KrSRKG7wP7TLsDG9NNN8KtEUCk3Pht8FlnCip2oHmjYn6PbAvgZWDpDrXXAnHOV5clh2vB3SqjkhNd7oEBJbvf7fqLw472UdiACbbpxv2rvZHeILQi61WjM//gh/Nwkg1NjGls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732465784; c=relaxed/simple;
	bh=h3HMakiSc3Yi/We9ZVKmd1w16G+zsylyS7d42MMaPH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GBR7KzF9O+eBbIb22wcYciZ0ugi9jo7517X3Zh5Ard5HoVBP+brNzJB7pxuRCX83cTM/wrzBF80LhF4xV11rjTriVE0g15UFYFgDYYRdBUZGu62ta6t1QDZWy9qdZGhsKuahGWnybJQjO/qFHOJyfoD1PRWUZHYspYH050QpAyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RLE+Gyas; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08816C4CECC;
	Sun, 24 Nov 2024 16:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732465784;
	bh=h3HMakiSc3Yi/We9ZVKmd1w16G+zsylyS7d42MMaPH4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RLE+GyasF/xkcYooj+dwtWSgr6RX/CEWvjqc6Dt2qNIQg8VTrHdPBCqKyoJwNVf1p
	 NWVP3mQX1RzQXS04O7Gpf93d+gmdO21c8R0fHHMtUPqPMdDwydBYz7n/u9kYZf80na
	 x37+G9NMMKB9igcNtrn3dBKKb2/I24OcTKNN/BU6gzLwMRfibbtvhy74j4rke3UlRz
	 gJ0bbp7Z3J2NpQXuK2YB5Cx52slLIQ7QWIYAQBH+9DUp62yzKSF0wjrCbVQYaRx4Xb
	 JlcjdKSemQSxBo0Rm1p/Z1HeYfztE67IE1U9OoB3NEMkfA/5NU6QHH/2d8rYRTCI56
	 Kh+uasP1ilAPQ==
Date: Sun, 24 Nov 2024 11:29:42 -0500
From: Sasha Levin <sashal@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Saravana Kannan <saravanak@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [GIT PULL] Devicetree updates for v6.13
Message-ID: <Z0NUdoG17EwuCigT@sashalap>
References: <20241118210730.GA3331421-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241118210730.GA3331421-robh@kernel.org>

Hi Rob,

On Mon, Nov 18, 2024 at 03:07:30PM -0600, Rob Herring wrote:
>      of: WARN on deprecated #address-cells/#size-cells handling

With the commit above, I've started seeing boot warnings on a few
platforms that KernelCI is testing. One example is:

[    0.047792] ------------[ cut here ]------------
[    0.047803] Missing '#address-cells' in /firmware
[    0.047873] WARNING: CPU: 0 PID: 1 at drivers/of/base.c:106 of_bus_n_addr_cells+0x90/0xf0
[    0.047900] Modules linked in:
[    0.047917] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.12.0 #1 933ab9971ff4d5dc58cb378a96f64c7f72e3454d
[    0.047935] Hardware name: Google juniper sku16 board (DT)
[    0.047947] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    0.047961] pc : of_bus_n_addr_cells+0x90/0xf0
[    0.047974] lr : of_bus_n_addr_cells+0x90/0xf0
[    0.047987] sp : ffff80008008ba50
[    0.047997] x29: ffff80008008ba50 x28: ffffcc9644c19060 x27: ffffcc9644b60118
[    0.048016] x26: 0000000000000000 x25: ffff119d7f5c3fe8 x24: ffff80008008bb80
[    0.048034] x23: ffff80008008bb7c x22: ffffcc96441dc0f0 x21: ffffcc9644522170
[    0.048053] x20: ffffcc96454964ed x19: ffff119d7f5c3e28 x18: 0000000000000006
[    0.048071] x17: 64656c62616e655f x16: 0000000000000100 x15: ffff80008008b4d0
[    0.048090] x14: 0000000000000000 x13: 657261776d726966 x12: ffffcc96452d14f0
[    0.048108] x11: 0000000000000001 x10: 0000000000000001 x9 : ffffcc9642742150
[    0.048126] x8 : c0000000ffffdfff x7 : ffffcc9645221450 x6 : 00000000000affa8
[    0.048145] x5 : ffffcc96452d1498 x4 : 0000000000000000 x3 : 0000000000000000
[    0.048163] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff119d40288000
[    0.048182] Call trace:
[    0.048192]  of_bus_n_addr_cells+0x90/0xf0 (P)
[    0.048207]  of_bus_n_addr_cells+0x90/0xf0 (L)
[    0.048222]  of_n_addr_cells+0x24/0x38
[    0.048235]  of_bus_default_count_cells+0x30/0x60
[    0.048251]  __of_get_address+0xb4/0x1c0
[    0.048264]  __of_address_to_resource+0x4c/0x198
[    0.048278]  of_address_to_resource+0x20/0x38
[    0.048292]  of_device_alloc+0x80/0x1a0
[    0.048306]  of_platform_device_create_pdata+0x5c/0x138
[    0.048321]  of_platform_bus_create+0x15c/0x398
[    0.048335]  of_platform_populate+0x58/0x110
[    0.048350]  of_platform_default_populate_init+0x98/0xf8
[    0.048366]  do_one_initcall+0x60/0x320
[    0.048382]  kernel_init_freeable+0x20c/0x420
[    0.048397]  kernel_init+0x28/0x1e8
[    0.048410]  ret_from_fork+0x10/0x20
[    0.048424] ---[ end trace 0000000000000000 ]---
[    0.048445] ------------[ cut here ]------------
[    0.048455] Missing '#size-cells' in /firmware
[    0.048495] WARNING: CPU: 0 PID: 1 at drivers/of/base.c:133 of_bus_n_size_cells+0x90/0xf0
[    0.048513] Modules linked in:
[    0.048526] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Tainted: G        W          6.12.0 #1 933ab9971ff4d5dc58cb378a96f64c7f72e3454d
[    0.048544] Tainted: [W]=WARN
[    0.048553] Hardware name: Google juniper sku16 board (DT)
[    0.048563] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    0.048576] pc : of_bus_n_size_cells+0x90/0xf0
[    0.048589] lr : of_bus_n_size_cells+0x90/0xf0
[    0.048602] sp : ffff80008008ba50
[    0.048611] x29: ffff80008008ba50 x28: ffffcc9644c19060 x27: ffffcc9644b60118
[    0.048630] x26: 0000000000000000 x25: ffff119d7f5c3fe8 x24: ffff80008008bb80
[    0.048649] x23: ffff80008008bb7c x22: ffffcc96441dc0f0 x21: ffffcc96445221a8
[    0.048667] x20: ffffcc96454964ed x19: ffff119d7f5c3e28 x18: 0000000000000006
[    0.048686] x17: 64656c62616e655f x16: 0000000000000100 x15: ffff80008008b4d0
[    0.048704] x14: 0000000000000000 x13: 657261776d726966 x12: ffffcc96452d14f0
[    0.048722] x11: 0000000000000001 x10: 0000000000000001 x9 : ffffcc9642742150
[    0.048740] x8 : c0000000ffffdfff x7 : ffffcc9645221450 x6 : 00000000000affa8
[    0.048758] x5 : ffffcc96452d1498 x4 : 0000000000000000 x3 : 0000000000000000
[    0.048776] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff119d40288000
[    0.048794] Call trace:
[    0.048803]  of_bus_n_size_cells+0x90/0xf0 (P)
[    0.048817]  of_bus_n_size_cells+0x90/0xf0 (L)
[    0.048831]  of_n_size_cells+0x24/0x38
[    0.048845]  of_bus_default_count_cells+0x40/0x60
[    0.048859]  __of_get_address+0xb4/0x1c0
[    0.048872]  __of_address_to_resource+0x4c/0x198
[    0.048885]  of_address_to_resource+0x20/0x38
[    0.048899]  of_device_alloc+0x80/0x1a0
[    0.048912]  of_platform_device_create_pdata+0x5c/0x138
[    0.048928]  of_platform_bus_create+0x15c/0x398
[    0.048942]  of_platform_populate+0x58/0x110
[    0.048956]  of_platform_default_populate_init+0x98/0xf8
[    0.048970]  do_one_initcall+0x60/0x320
[    0.048983]  kernel_init_freeable+0x20c/0x420
[    0.048997]  kernel_init+0x28/0x1e8
[    0.049009]  ret_from_fork+0x10/0x20
[    0.049021] ---[ end trace 0000000000000000 ]---


-- 
Thanks,
Sasha

