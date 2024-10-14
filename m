Return-Path: <linux-kernel+bounces-364704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD27D99D82C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 22:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE4B01C22693
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 20:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85DC1D0E08;
	Mon, 14 Oct 2024 20:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="HKsn0S9T"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30771D0942;
	Mon, 14 Oct 2024 20:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728937760; cv=none; b=Vc0BIYnaCiCZceq/7VoAIIrPVy4vpfr6OIvrqfC0fBdGOwe2Jn/y6JQEDrLqvqBUbYtO7WYmyEt1MIU4sF4QnOacx276UEHaoWw0a4tbitPwdSeBfsI7W1V3Pc635RfBlEEF5kS2k4nR2Tyyik6mvCG5mUf40P8krN/EdlHJmvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728937760; c=relaxed/simple;
	bh=9aR9lv25iuYJM3n3+1PvxoqvrjezR4dJ7SJeHh1oAK4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=m4u1AYUc7HSCKHrQtEiTa06muVSOFV3hY7EKiIJH0ZMKSU1Xk9D/KubsQOOntjDdaKkg9COVxO5ybseUnC0fghCpxwK4d0GDUL7aKXXqZpBFuqqPiLwaw3muk4+gnOiwejaaMqPn6xAfjOOuZ3vK48qvaLiDeyWSU2aVaTvhaOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=HKsn0S9T; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1728937755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DU60WL7DeLOtDOK8bJ4w2KZeuNGEq/82GYZDHFw14lE=;
	b=HKsn0S9TKKzWyslK26UMDckc592r3RWQhpWtdnl9rSbPcZIsLoOhVQBdBy61CVL+xdG4hp
	fG6YS6rPr+HomDcbdN01FRt03BsoHwVFmx+3+qw2LY8T0YPJgCrDLgPL1B/DVRy94VZFX3
	itt8Wzv39tScYpodsp8SoHSaVerj4Fc2/lLCwn9+Ei3W4bsZZFmwlLy8XCZpqqnn60Y8Yc
	19cwgv7qlaglbcGfM1XYYhtNqiv6G+vbTlQNUyxZtyBdElTwopm+381mWgrg9OBn/egGBR
	oQdTeX6YETf0v9cGyzJ5BdnNgzkJ4qILrbfqfAhI4boxSbbfiVgMKrujsWNBnQ==
Date: Mon, 14 Oct 2024 22:29:14 +0200
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
Subject: Re: [PATCH v5 2/2] arm64: dts: rockchip: Add rk3588-orangepi-5b
 device tree and refactor
In-Reply-To: <20241014180324.536702-2-cenk.uluisik@googlemail.com>
References: <20241014180324.536702-1-cenk.uluisik@googlemail.com>
 <20241014180324.536702-2-cenk.uluisik@googlemail.com>
Message-ID: <c773f975333718d0a677616b68252ec3@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Cenk,

Please see a few comments below.

On 2024-10-14 20:02, Cenk Uluisik wrote:
> Implements a slightly modified rk3588s-orangepi-5b.dts
> from the vendor. Unfortunately the &wireless_bluetooth
> and &wireless_wlan are not implemented yet.
> 
> Bigger parts of the rk3588s-orangepi-5.dts file were
> moved into a new rk3588s-orangepi-5.dtsi file, so
> that both device trees from the orangepi-5 and 5b
> include from it and avoid including from the .dts.
> 
> This changes the Orange Pi 5's sdmmc alias to be mmc1,
> breaking existing users if they used the /dev/mmc0 device
> file, so it's consistent with all the other rk3588 DTS,
> which, is also the new default that rockchip wants to use.
> https://github.com/orangepi-xunlong/linux-orangepi/commit/bce92d16b230b8e93c2831fb7768839fd7bbab04
> Therefore also add the sdhc alias to be mmc0 on the
> rk3588s-orangepi-5b.dts.

It would be good to reflow the patch description to use the
76-or-so-column width a bit better.

> How does this board differ from the original Orange Pi 5?
>   - the Orange Pi 5 has a M.2 NVMe M-key PCI 2.0x1
>     slot (hooked to combphy0_ps) whereas the Orange Pi 5b uses 
> combphy0_ps
>     for the WiFi.
>   - The Orange Pi 5 with the M.2 socket has a regulator defined hooked 
> to
>     "GPIO0_C5" (i.e. PCIE_PWREN_H) whereas the Orange Pi 5B has 
> GPIO0_C5
>     hooked to BT_WAKE_HOST.
>   - builtin eMMC storage
>   - no SPI NOR flash (u-boot, preboot etc. initiates
>       from within the eMMC
>       storage)
>   - ap6275p Wifi module (like the Orange Pi 5 Plus)
>   - builtin BlueTooth module
> 
> Signed-off-by: Cenk Uluisik <cenk.uluisik@googlemail.com>
> ---
>  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>  .../boot/dts/rockchip/rk3588s-orangepi-5.dts  | 798 +-----------------
>  ...orangepi-5.dts => rk3588s-orangepi-5.dtsi} |  36 +-
>  .../boot/dts/rockchip/rk3588s-orangepi-5b.dts |  27 +
>  4 files changed, 73 insertions(+), 789 deletions(-)

Please see my patch [1] that presents use of a set of git-diff(1)
parameters that could also, possibly, reduce the size of this patch
significantly and increase its readability.

[1] 
https://lore.kernel.org/linux-rockchip/f3d789c14fe34a53327cac03cd3837e530e21f5c.1728937091.git.dsimic@manjaro.org/

