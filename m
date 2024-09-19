Return-Path: <linux-kernel+bounces-333444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A2A97C8AC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 13:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E68B91F256B3
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 11:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E690719CC39;
	Thu, 19 Sep 2024 11:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="Exr18aGz"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF24419938D
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 11:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726745640; cv=none; b=o0S8s6E5cQ2h7CD/zgvHArkQ3KBqT3PQYnS9XCML8t35dzbsgiRkpsnwt02KeyswPheIMrkbHb8g0ytc1nsBomE8VlJvPOklvWgv83r4sXQmd/AZJa2ah/KRMGpDj0AIb9hwJi2vQmdBvr1bM9FTQJRcvMmDoLrPKRNIRqqxeqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726745640; c=relaxed/simple;
	bh=StTQ73UEBD/IaT5ThHNmotx/taGDNKC6P65MmYY9Ncs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VtfoFO4/zeaSGI9mLN532nXndyf6S1hpVqVXLHRFAQTGTgjPH2vmo6yXycthi+pOdkRz9Cn2Qb9vtqlwwRM7z6352++RqZLWvtlx4oe38VZv/fL7zZl3r/L+djEFock2YNBNqKmtO9viaMjYmHJA0R4OL7Fw0QJlWAkS5uA8Az8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=Exr18aGz; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1726745614;
 bh=AhnUxQ3TsikavWJSRf1+uBeZ6pR2rsbLiLx5LDOjo5M=;
 b=Exr18aGzknF7qMIYUL6cKZPk8nl6Ti0QlGINoO3KI/MFrhGtyMzmC7VDNG962e2XDrKbkPG2I
 TYioc8LK19oYW8FoGTgFnione75SOCeFvZy6Le6GxFFLqAE6US6iWPhIkKTOZZadxO2M3k0q84L
 ms1K0Xy+RSrHu/BI20F1dOn/J1ZFAnpzEhflKIJfYW/yT6VbaK4lCYaZSHXaUC/9m/xE/BK+T8a
 yZsA4s8V6QbwJEsiPvSFpxa8vXT5lFraztrwvvQhjrKicVi3ifRQTNj24RbuISycjUoTZEDEB21
 srPhBgXebANM+chN1LRNx+itySv13ZcEAmTYBQPyVBwA==
Message-ID: <a4d94eab-8543-45e1-b657-fa7f12470538@kwiboo.se>
Date: Thu, 19 Sep 2024 13:33:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] arm64: dts: rockchip: Add GPU power domain
 regulator dependency for RK3588
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Ulf Hansson <ulf.hansson@linaro.org>, Elaine Zhang
 <zhangqing@rock-chips.com>,
 =?UTF-8?Q?Adri=C3=A1n_Mart=C3=ADnez_Larumbe?=
 <adrian.larumbe@collabora.com>,
 Boris Brezillon <boris.brezillon@collabora.com>, Chen-Yu Tsai
 <wens@csie.org>, devicetree@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, kernel@collabora.com
References: <20240919091834.83572-1-sebastian.reichel@collabora.com>
 <20240919091834.83572-7-sebastian.reichel@collabora.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20240919091834.83572-7-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66ec0c0d5c923b6ab0c0bfa4

Hi Sebastian,

On 2024-09-19 11:12, Sebastian Reichel wrote:
> Enabling the GPU power domain requires that the GPU regulator is
> enabled. The regulator is enabled at boot time, but automatically
> gets disabled when there are no users.
> 
> If the GPU driver is not probed at boot time or rebound while
> the system is running the system will try to enable the power
> domain before the regulator is enabled resulting in a failure
> hanging the whole system. Avoid this by adding an explicit
> dependency.
> 
> Reported-by: Adrián Martínez Larumbe <adrian.larumbe@collabora.com>
> Tested-by: Adrian Larumbe <adrian.larumbe@collabora.com> # On Rock 5B
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3588-armsom-sige7.dts         | 4 ++++
>  arch/arm64/boot/dts/rockchip/rk3588-base.dtsi                | 2 +-
>  arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5.dtsi          | 4 ++++
>  arch/arm64/boot/dts/rockchip/rk3588-friendlyelec-cm3588.dtsi | 4 ++++
>  arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts               | 4 ++++
>  arch/arm64/boot/dts/rockchip/rk3588-ok3588-c.dts             | 4 ++++
>  arch/arm64/boot/dts/rockchip/rk3588-rock-5-itx.dts           | 4 ++++
>  arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts              | 4 ++++
>  arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi               | 4 ++++
>  arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts           | 4 ++++
>  arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts        | 4 ++++
>  arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts          | 4 ++++
>  12 files changed, 45 insertions(+), 1 deletion(-)
> 

Any reason why following rk3588 DTs was not updated?

rk3588-evb1-v10.dts
rk3588-nanopc-t6.dtsi
rk3588-quartzpro64.dts
rk3588s-gameforce-ace.dts
rk3588s-odroid-m2.dts

I also expect we may need to define domain-supply for the npu on rk3588
and also both gpu and npu on rk356x in a future series.

Similar freeze issue has been observed on rk356x when booting vendor
kernel with npu support enabled using mainline U-Boot and DT [1].

To work around that issue on rk356x the npu regulator could be changed
to always-on/boot-on to get past the kernel freeze [2].

[1] https://github.com/armbian/build/pull/7025#issuecomment-2291067748
[2] https://github.com/Kwiboo/u-boot-rockchip/commit/da31da4b68f858f54364a21b0dd00fef2ab0d0d6

Regards,
Jonas

