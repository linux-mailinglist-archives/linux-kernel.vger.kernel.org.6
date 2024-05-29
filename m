Return-Path: <linux-kernel+bounces-193639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6588D2EFB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 09:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB7E81C21E14
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 07:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7941167DBB;
	Wed, 29 May 2024 07:58:05 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7EF1C286;
	Wed, 29 May 2024 07:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716969485; cv=none; b=AlTp6452bFOf5hUA0x/rjQMfA4LwA7OFBmHBga2uRtFE2i1v0zvDwSL+EakxI7f7J+r1mQ+fYbB6Ggs1HgK05la6fM1x9P8xVvOsFE26MxZKQVcEugj8+fJXgUoRp2cx636dyOTZHQ3XU1nSad5cTiIIljAMBBaGMJhBDVhIqj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716969485; c=relaxed/simple;
	bh=RoabwHq66vizFMxPVCyGLA0hhXFCEADFoMq2+sxGbg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=itqD74iHoonQ9TKjzI+iOmrhL9Yv4Fqml8H5sUC6XR/5nyuzmhTK8agtf3Lad9ALFGufqlYhz3X+H+9VZ9M6MFWKMK6izuijtS5z/LsAWOP0TpSX+c9ao9S1ENbaTaOtutOKeAC3GPEK+Vp8RdkGcopk4iHqWHi7YryLkp+2qjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e86193d.versanet.de ([94.134.25.61] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sCEBr-0002F8-B5; Wed, 29 May 2024 09:57:43 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Jonas Karlman <jonas@kwiboo.se>, Sebastian Kropatsch <seb-dev@web.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: Add CM3588 NAS board
Date: Wed, 29 May 2024 09:57:42 +0200
Message-ID: <2693701.q0ZmV6gNhb@diego>
In-Reply-To: <ac376b42-a52f-4fef-8543-b961becd5f4d@web.de>
References:
 <20240526214340.8459-1-seb-dev@web.de> <3609340.LM0AJKV5NW@diego>
 <ac376b42-a52f-4fef-8543-b961becd5f4d@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hi Sebastian,

Am Dienstag, 28. Mai 2024, 17:55:55 CEST schrieb Sebastian Kropatsch:
> Am 27.05.2024 um 22:54 schrieb Heiko St=FCbner:
> > Am Montag, 27. Mai 2024, 21:02:02 CEST schrieb Jonas Karlman:
> >> On 2024-05-26 23:48, Sebastian Kropatsch wrote:
> >>> The CM3588 NAS by FriendlyElec pairs the CM3588 compute module, based=
 on
> >>> the Rockchip RK3588 SoC, with the CM3588 NAS Kit carrier board.
> >>>
> >>> Hardware features:
> >>>      - Rockchip RK3588 SoC
> >>>      - 4GB/8GB/16GB LPDDR4x RAM
> >>>      - 64GB eMMC
> >>>      - MicroSD card slot
> >>>      - 1x RTL8125B 2.5G Ethernet
> >>>      - 4x M.2 M-Key with PCIe 3.0 x1 (via bifurcation) for NVMe SSDs
> >>>      - 2x USB 3.0 (USB 3.1 Gen1) Type-A, 1x USB 2.0 Type-A
> >>>      - 1x USB 3.0 Type-C with DP AltMode support
> >>>      - 2x HDMI 2.1 out, 1x HDMI in
> >>>      - MIPI-CSI Connector, MIPI-DSI Connector
> >>>      - 40-pin GPIO header
> >>>      - 4 buttons: power, reset, recovery, MASK, user button
> >>>      - 3.5mm Headphone out, 2.0mm PH-2A Mic in
> >>>      - 5V Fan connector, PWM buzzer, IR receiver, RTC battery connect=
or
> >>>
> >>> PCIe bifurcation is used to handle all four M.2 sockets at PCIe 3.0 x1
> >>> speed. Data lane mapping in the DT is done like described in commit
> >>> f8020dfb311d ("phy: rockchip-snps-pcie3: fix bifurcation on rk3588").
> >>>
> >>> This device tree includes support for eMMC, SD card, ethernet, all US=
B2
> >>> and USB3 ports, all four M.2 slots, GPU, RTC, buzzer, UART debugging =
as
> >>> well as the buttons and LEDs.
> >>> The GPIOs are labeled according to the schematics.
> >>>
> >>> Signed-off-by: Sebastian Kropatsch <seb-dev@web.de>
> >>> ---
> >>>   arch/arm64/boot/dts/rockchip/Makefile         |    1 +
> >>>   .../boot/dts/rockchip/rk3588-cm3588-nas.dts   | 1269 ++++++++++++++=
+++
> >>>   2 files changed, 1270 insertions(+)
> >>>   create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-cm3588-nas.d=
ts
> >>
> >> Because the CM3588 is a SoM and the NAS is a carrier board this should
> >> probably be split in two, cm3588.dtsi and cm3588-nas.dts.
> >
> > also, because of that way too generic name "cm", please incorporate the
> > company name in the filename as well. For the same reason we named
> > the rk3568-wolfvision-pf5.dts that way ;-) [Wolfvision being the compan=
y]
> >
> > So maybe:
> > rk3588-friendlyelec-cm3588.dtsi and rk3588-friendlyelec-cm3588-nas.dts
> >
>=20
> Yes, I agree that the name is very generic. I struggled with this as
> well, but your suggestion sounds good!
>=20
> In this case, is it also preferred to change the commit message to
> include the company name event though the commit message subject exceeds
> 50 characters this way?
> ("arm64: dts: rockchip: Add FriendlyElec CM3588 NAS board")

Were does a 50 character limit even come from?
In other words, the subject should be meaningful and with the needed
prefixes adhering to a 50 chars maxlen would cause pretty unreadable
subject in a lot of cases.

So the proposed subject is absolutely fine :-) .


Heiko



