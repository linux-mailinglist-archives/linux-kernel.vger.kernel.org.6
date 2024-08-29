Return-Path: <linux-kernel+bounces-307174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 267F2964974
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 17:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59B061C228D1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 15:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4631AED4D;
	Thu, 29 Aug 2024 15:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="rNSXO3PX"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8651B0102
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 15:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724944058; cv=none; b=od1AxQMVFZbJn5tR4S+ejmyXayKrLetnoaBUyjVpPjmSFPY7cVdsWOwN7reU5XnzAbUjOQTmLzGzo/kd7e5naZFGvzISebhSkmjP1ZOC+JlA1NZHtxtY1tLKPtx4wzKPAMTPBz/VkEg1OrfMHkDF8AUMZZA+Gd8vgGhI5meIVrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724944058; c=relaxed/simple;
	bh=iBHkBfpTeLttKlC+5xkI9avDnQmycAW3GESvcHahMvE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CtKHjYmkJM3LOtv0f+5edpLS6Zo1woHMMC3nHDFSXAnq4nEEAW9rP7QqAdHvDW+6oPnJ7sSOGJxE88FqssAF5leax0eJVtt58Bn9QE75cDbs4RSEVutnsxfcYqffxqSOmaK4f0rKtOrO37Qcc7etVG7IfHx7wZmOoMUGTdo/zFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=rNSXO3PX; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1724944040;
 bh=ZwTRTuALx98evFLAh9ctTY+ppbSyT4A4mm+kS90lF4g=;
 b=rNSXO3PX1AAU63Yt0mZIrCohDhkC5C9Iz6j1oj2/jJWn2HwgKArI3xrUUxiUNixQLQl1Hc0xU
 XNzEby/5hzWAu/KV0tj/jNadMMJpdq7aH71mDbX/QLWKkpjNhVZpdlNFzOLHklwJFr8RjSrc+9P
 DuQQOsTlyTv3WW8dpT12IdOWXBYDPbCjlkLiVT70dsiP25ou9+T2WnU/zfLoyXV7dACf9IthBTn
 U37qGVGBaMw4AVcT8QiSn6OJPKEUK4Aug9QA7ujZITYVQu0wM27f6bOhGPA3KnI+HhbbNS2EyKD
 7mtX5iyMFcMOT8z7gUSY2RCu+NlGhtlh5Vvhb+jpFXvA==
Message-ID: <2d9da451-a553-4eb6-a0e3-067219de5302@kwiboo.se>
Date: Thu, 29 Aug 2024 17:07:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] arm64: dts: rockchip: Add Hardkernel ODROID-M1S
To: jonesthefox@icloud.com
Cc: linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <44115846-F7A9-47F5-899B-A8146E20BC31@icloud.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <44115846-F7A9-47F5-899B-A8146E20BC31@icloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66d08ea542a3f102c40026f2

Hi Patrick,

On 2024-08-29 14:52, jonesthefox@icloud.com wrote:
> Hi Jonas,
> 
> I applied your four patches for the Odroid M1S to the mainline kernel [1], 
> compiled it using the kernel configuration from the Hardkernel Ubuntu 
> Server Image [2], and then attempted to boot into the official Generic 
> AArch64 image on mmcblk0 using a dtb file and an Arch Linux initrd by 
> manually copying the kernel and dtb file to the boot partition and 
> booting manually with the vendor's U-Boot [3]. 
> 
> The booting process was successful!
> 
> However, the network interface is not working. Here is the relevant 
> dmesg output:
> 
> ----
> [ 6.694455] rk_gmac-dwmac fe010000.ethernet: IRQ eth_lpi not found
> [ 6.695030] rk_gmac-dwmac fe010000.ethernet: IRQ sfty not found
> [ 6.702424] rk_gmac-dwmac fe010000.ethernet: clock input or output? (input).
> [ 6.703064] rk_gmac-dwmac fe010000.ethernet: Can not read property: tx_delay.
> [ 6.704461] rk_gmac-dwmac fe010000.ethernet: set tx_delay to 0x30
> [ 6.705002] rk_gmac-dwmac fe010000.ethernet: Can not read property: rx_delay.
> [ 6.709919] rk_gmac-dwmac fe010000.ethernet: set rx_delay to 0x10
> [ 6.710579] rk_gmac-dwmac fe010000.ethernet: integrated PHY? (no).
> [ 6.711180] rk_gmac-dwmac fe010000.ethernet: clock input from PHY
> [ 6.716749] rk_gmac-dwmac fe010000.ethernet: init for RGMII_ID
> [ 6.718117] rk_gmac-dwmac fe010000.ethernet: User ID: 0x30, Synopsys ID: 0x51
> [ 6.719022] rk_gmac-dwmac fe010000.ethernet: DWMAC4/5
> [ 6.719540] rk_gmac-dwmac fe010000.ethernet: DMA HW capability register supported
> [ 6.720204] rk_gmac-dwmac fe010000.ethernet: RX Checksum Offload Engine supported
> [ 6.720864] rk_gmac-dwmac fe010000.ethernet: TX Checksum insertion supported
> [ 6.721484] rk_gmac-dwmac fe010000.ethernet: Wake-Up On Lan supported
> [ 6.722155] rk_gmac-dwmac fe010000.ethernet: TSO supported
> [ 6.723019] rk_gmac-dwmac fe010000.ethernet: Enable RX Mitigation via HW Watchdog Timer
> [ 6.723761] rk_gmac-dwmac fe010000.ethernet: device MAC address 0e:c7:69:a9:f2:61
> [ 6.724436] rk_gmac-dwmac fe010000.ethernet: Enabled RFS Flow TC (entries=10)
> [ 6.725073] rk_gmac-dwmac fe010000.ethernet: TSO feature enabled
> [ 6.725609] rk_gmac-dwmac fe010000.ethernet: Using 32/32 bits DMA host/device width
> [ 6.998073] rk_gmac-dwmac fe010000.ethernet end0: renamed from eth0
> [ 7.096335] rk_gmac-dwmac fe010000.ethernet end0: Register MEM_TYPE_PAGE_POOL RxQ-0
> [ 7.097618] rk_gmac-dwmac fe010000.ethernet end0: __stmmac_open: Cannot attach to PHY (error: -19)
> ----
> 
> Does anyone have any idea what could be causing this issue, or if there 
> is anything I could try to get the network interface up and running?

This is more than likely an issue with the RTL8211F not being identified
because it needs to be reset before its phy-id can be read. See [4] for
an old topic on similar issue with RTL8211F on other boards.

Mainline U-Boot will reset the Ethernet PHY during boot and this will
help Linux identify it correctly. See [5] for mainline U-Boot for this
board. Will submit U-Boot patches once the DT has reached a tag in the
devicetree-rebasing repo.

Another possible solution (untested) would be to change the Ethernet PHY
compatible to "ethernet-phy-id001c.c916". That may help bootstrap Linux
into being able to reset and identify the PHY.

[4] https://lore.kernel.org/r/47d55aca-bee6-810f-379f-9431649fefa6@kwiboo.se/

[5] https://github.com/Kwiboo/u-boot-rockchip/commit/210dc397c1758c7666fa686a2da59e34010650ba
Branch: rk3xxx-2024.10, target: odroid-m1s-rk3566_defconfig

Regards,
Jonas

> 
> Thanks for your help!
> 
> Best regards,
> Patrick
> 
> [1] Linux Kernel Repository: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> Version: v6.11-rc5-50-g3ec3f5fc4a91
> 
> [2] Semi-official Hardkernel Ubuntu Server Preview Image for Odroid M1S: 
> https://forum.odroid.com/viewtopic.php?t=48230
> 
> [3] U-Boot Version: U-Boot 2017.09-g97ab962d1ed-230719 #tobetter (Oct 27 2023 - 14:54:41 +0900)


