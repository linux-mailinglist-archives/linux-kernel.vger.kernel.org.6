Return-Path: <linux-kernel+bounces-367046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E41199FE0F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 03:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23870288D36
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 01:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667507405A;
	Wed, 16 Oct 2024 01:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="gLW1l2Dh"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0A8433C0;
	Wed, 16 Oct 2024 01:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729040973; cv=none; b=LEW6rG9/rkOADNumVk+RFJyzWlIT78bHrtLUskfSUJbm2TnS+ErtRrW/FnB/gcuHyD2YWush1AXPpHXWDTd0MZerds6aikHdZAsZ0skpxAPGFAaD0p+oqUyYiBeAs5+k5G86+lJsvQ92OjzRD4RFDth5UkfxhuaetBLRO1xGnPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729040973; c=relaxed/simple;
	bh=QB8nv0mgmERydGi8qLYufLLFealMe6fq/N6zy54RpZA=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Hn+79LBm2gR91tIVMXGT06P6syVfchKiS9gDo1RCsBQXwiN/WxbFq/9XUL80kmiZ5+AO4Q4wqX52fjMOJXEIVfyIi8P6hmof6tqWE8cApEEN2fpFcgl5R9l2TQbPBbeLtztx6/E+hsMQumg2YTj66nestMlGbaKej2Fm470TgmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=gLW1l2Dh; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1729040962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q62TzgJVkucL37i2DOtU/nMFPRmh8xCYuwUlxEw9sIs=;
	b=gLW1l2DhyXVLupEjarCByz0tD8ShAZZzloSBhFAKSRaxZx+TVF3cxBP5F7h6wFQckjGSZt
	yFQ4xPp1HJBivkYsPUVWbaHtnN5HZ86UKo7H18t3/8zBBETrnjcPv8XZ0Pm5nqqZV95tTM
	y0HR1QhvZxfNnwjKZFOL6cdfKKI257FDheLAtbMHBGU32xw5DF+K8EgNNRdrQN30l0J9u9
	xUPgBgIf5xCxBy/4ZNtWrxhi8Fc3daJRRgjqlFIzXeQeKtLqyojElj2IJ8Q/o04usCp62x
	isdsq4tligJ6g9VPgYNdT/hyUyr4A+KdWQ/AF8FLLtcwz2dDpT9nuVP0lkZ8oA==
Date: Wed, 16 Oct 2024 03:09:20 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Cenk Uluisik <cenk.uluisik@googlemail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Chris
 Morgan <macromorgan@hotmail.com>, Jonas Karlman <jonas@kwiboo.se>, Andy Yan
 <andyshrk@163.com>, Tim Lunn <tim@feathertop.org>, Jagan Teki
 <jagan@edgeble.ai>, Michael Riesch <michael.riesch@wolfvision.net>, Jimmy
 Hon <honyuenkwun@gmail.com>, Jing Luo <jing@jing.rocks>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] arm64: dts: rockchip: Add rk3588-orangepi-5b
 device tree and refactor
In-Reply-To: <CAAWLpRtOcxc7=EAw6NPtkwqCNJ0LRE50StjZ4h4ra7wvhsyeaA@mail.gmail.com>
References: <20241015192905.28969-1-cenk.uluisik@googlemail.com>
 <20241015192905.28969-2-cenk.uluisik@googlemail.com>
 <CAAWLpRtOcxc7=EAw6NPtkwqCNJ0LRE50StjZ4h4ra7wvhsyeaA@mail.gmail.com>
Message-ID: <03103381f2a356b4a23ead545e456460@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Cenk,

On 2024-10-15 21:33, Cenk Uluisik wrote:
> I accidently didnt save the Patch Version on the first email, it's the
> same patch but with fixed versioning. It was an accident, sorry.

As I suggested already, it's always a good idea to send patches
to your own email address first, before sending them to the ML(s),
to check the patches one last time and make sure everything looks
good.  That's the way I do it, FWIW.

> Am Di., 15. Okt. 2024 um 21:29 Uhr schrieb Cenk Uluisik
> <cenk.uluisik@googlemail.com>:
> 
>> Implements a slightly modified rk3588s-orangepi-5b.dts from the
>> vendor.
>> Unfortunately the &wireless_bluetooth and &wireless_wlan are not
>> implemented yet.
>> 
>> Bigger parts of the rk3588s-orangepi-5.dts file were moved into a
>> new
>> rk3588s-orangepi-5.dtsi file, so that both device trees from the
>> orangepi-5 and 5b include from it and avoid including from the .dts.
>> 
>> This changes the Orange Pi 5's sdmmc alias to be mmc1, breaking
>> existing
>> users if they used the /dev/mmc0 device file, so it's consistent
>> with all
>> the other rk3588 DTS, which, is also the new default that rockchip
>> wants
>> to use.
>> https://github.com/orangepi-xunlong/linux-orangepi/commit/
>> bce92d16b230b8e93c2831fb7768839fd7bbab04
>> Therefore add the sdhc alias to be mmc0 on the
>> rk3588s-orangepi-5b.dts.
>> 
>> The "enable-active-low" warning is addressed here:
>> 
> https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git/
>> 
> commit/?h=v6.12-armsoc/dtsfixes&id=f4d29bebaa6118c1e51e8f1c21ce2b34f43e1479
>> The "leds-gpio" warning was already there because the DTS checking
>> script
>> might not like the ID, which is probably avoidable by renaming it,
>> but this
>> will be addressed in a seperate issue.
>> 
>> How does this board differ from the original Orange Pi 5?
>> - the Orange Pi 5 has a M.2 NVMe M-key PCI 2.0x1
>> slot (hooked to combphy0_ps) whereas the Orange Pi 5b uses
>> combphy0_ps
>> for the WiFi.
>> - The Orange Pi 5 with the M.2 socket has a regulator defined
>> hooked to
>> "GPIO0_C5" (i.e. PCIE_PWREN_H) whereas the Orange Pi 5B has
>> GPIO0_C5
>> hooked to BT_WAKE_HOST.
>> - builtin eMMC storage
>> - no SPI NOR flash (u-boot, preboot etc. initiates
>> from within the eMMC
>> storage)
>> - ap6275p Wifi module (like the Orange Pi 5 Plus)
>> - builtin BlueTooth module
>> 
>> Signed-off-by: Cenk Uluisik <cenk.uluisik@googlemail.com>

