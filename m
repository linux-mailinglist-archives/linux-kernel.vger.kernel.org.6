Return-Path: <linux-kernel+bounces-193255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 068688D294A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 02:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 314DE1C22A97
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 00:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F2B1391;
	Wed, 29 May 2024 00:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="oviVzV2C"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7435632;
	Wed, 29 May 2024 00:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716941444; cv=none; b=uwPfUhcsIxBva7jn36WFP4QXn5IeK6f4Nvow4w/Hph8hCueZGwmu/Fi6k9kWsqWmKJdySBCArIQaC+WAyfvVocwvF0F3gVNJBkoSxrpcctiZ83AgW0OdOH808tS8em1zgieIW6CaCXqA915Qh2QLtGc9jVPqz6H2kQ0ZT0z3fE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716941444; c=relaxed/simple;
	bh=pwU/PeIG1ERrPdm7AqbTYA5jbg2LzYX5QkR3IuRAwyE=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=kOvsjOENIzy8424V5GqOGuF9OJUJll1f3BoCUX2wg4ENxu8q5ItjH+xWm6VX2lgu72UE+aDXY3zj/uyMMcZ4I2q4NIUE+j5KAxE5SRLXIkiR98ubvyL0Sicn+eJQrMvR/3leemb0AzPSgD8ruRciai7CcJnmYAyffBhW/+tamoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=oviVzV2C; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1716941440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7z6F1Ao1L/n/qQAEst7AHuaT7MITPT2BokqzLZjAtkw=;
	b=oviVzV2CR0rzR2GZkxMTnKGG3dxWHNwxm0rcUxfymyh2sXXP+ybudxEfHhyAPcSU8fheO/
	/gpNHludd2JY83m/g3BWiVhGsreWWUhgGC28vJiyQ/ntFDx6N/pkJDTF3vYLsZht87gmLz
	W+oWD1aJuE45p2MJL1GgT5klAmcsdkdAVD3b6rSECtBRvxf5MQahneEFmkdFLysX8YSBf4
	0MrVLwy7bI6fQ7tic+/sROdvcdqlFlR7fCwG+HvX+jOEZc7DDYbInXr2NcyOrio9+AePsu
	xgLu0l4h5FTxgkZ7lYfkYaKRBdnGhDlveSJ3jkwRysOuFafFn6b/S23TJ+Igdw==
Date: Wed, 29 May 2024 02:10:38 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Sebastian Kropatsch <seb-dev@web.de>
Cc: Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner <heiko@sntech.de>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Sebastian Reichel
 <sebastian.reichel@collabora.com>, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: Add CM3588 NAS board
In-Reply-To: <29e5cf31-3d9a-469a-befa-41a5aa2fe8b3@web.de>
References: <20240526214340.8459-1-seb-dev@web.de>
 <20240526214820.9381-1-seb-dev@web.de>
 <9f40c748-691b-4a03-bbd6-54870f46bf05@kwiboo.se>
 <29e5cf31-3d9a-469a-befa-41a5aa2fe8b3@web.de>
Message-ID: <bccd8879a19ceacfd92a41e7533b324c@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Sebastian,

On 2024-05-28 19:22, Sebastian Kropatsch wrote:
> Am 27.05.2024 um 21:02 schrieb Jonas Karlman:
>> On 2024-05-26 23:48, Sebastian Kropatsch wrote:
>>> The CM3588 NAS by FriendlyElec pairs the CM3588 compute module, based 
>>> on
>>> the Rockchip RK3588 SoC, with the CM3588 NAS Kit carrier board.
>>> 
>>> [...]
>>> 
>>> PCIe bifurcation is used to handle all four M.2 sockets at PCIe 3.0 
>>> x1
>>> speed. Data lane mapping in the DT is done like described in commit
>>> f8020dfb311d ("phy: rockchip-snps-pcie3: fix bifurcation on rk3588").
>>> 
>>> This device tree includes support for eMMC, SD card, ethernet, all 
>>> USB2
>>> and USB3 ports, all four M.2 slots, GPU, RTC, buzzer, UART debugging 
>>> as
>>> well as the buttons and LEDs.
>>> The GPIOs are labeled according to the schematics.
>>> 
>>> Signed-off-by: Sebastian Kropatsch <seb-dev@web.de>
>>> ---
>>>   arch/arm64/boot/dts/rockchip/Makefile         |    1 +
>>>   .../boot/dts/rockchip/rk3588-cm3588-nas.dts   | 1269 
>>> +++++++++++++++++
>>>   2 files changed, 1270 insertions(+)
>>>   create mode 100644 
>>> arch/arm64/boot/dts/rockchip/rk3588-cm3588-nas.dts
>> 
>> Because the CM3588 is a SoM and the NAS is a carrier board this should
>> probably be split in two, cm3588.dtsi and cm3588-nas.dts.
> 
> I thought about this before submitting. My reason for not splitting 
> this
> into two files for now was that as far as I know this board is the only
> combination for the CM, maybe no other daughter board will ever get
> released. If another carrier board compatible with the CM3588 is
> released, the splitting could be done at that point in time.
> 
> But since both you and Heiko prefer to have it split, I will figure out
> a way how and which parts will have to split up to the CM so we can
> have two files in the end. I guess most things will go into the NAS dts
> anyway.
> 
> I'll have a look how other Rockchip compute modules with split device
> trees were done in the past and orient myself by that.

I also support the DT split between the SoM and the carrier board,
even if there are currently no more carrier boards available for
the particular SoM.  That may seem redundant, but it reflects the
nature of the hardware setup, in which the SoM plugs into the carrier
board.  This follows the principle of the DT describing hardware.

