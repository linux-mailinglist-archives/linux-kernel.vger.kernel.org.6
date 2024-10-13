Return-Path: <linux-kernel+bounces-362971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 244DF99BBDD
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 22:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBA021F2150D
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 20:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61F61537AA;
	Sun, 13 Oct 2024 20:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="uAb3DIJj"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A26149E13;
	Sun, 13 Oct 2024 20:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728852963; cv=none; b=K3v4ib7w+0n3Wjan7T4vpI8v8zgGkYtfPMl8mDmYHtkgIwnNsMYFURZRF4vnPRW9qRTNo2hJ+1uO+nLPphcBbDzNBfSGX7PT07Qk+z6yU48yvXVtnyBsUf1ERc76cIyoy0Np/WE9ujuE82Hk0TkeKFIoDTMfXTlPsiOCgmc++Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728852963; c=relaxed/simple;
	bh=LVwogbIZf9dCBb2rSSLVdEj15lOo+Dvj0bAAKh1lAjk=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=bFZIb1DqvxPnt/h0ghjFclKv0DVVh43Rn3BhftInwMNUmRxo2y5Wc5Omiq0gVjYvIvGS4kck2lNkvcotDJTlYKAPK2SE5lYGuWOf11/kfrpmEzpQjwePJCKtfAKFkxZdOr3eqAy6FpFiyPsrucXRawtnZCMWLKtr0ZTmL2fqiZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=uAb3DIJj; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1728852958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MD/SPpvVFaQ7Z8UPvB4YaamXnme8WhZVptqS1G1BBmE=;
	b=uAb3DIJjun6Ex60NNKIpSO3rm8Qw2trBk/7L25KuK2IX5HcexVs8tTTxXO22UqO/H03aFX
	0TylSZ6FDmoiY/ImVHjdO3rbFiIpaGxDdtO+QjyqXH/2Pu9k2IYSISHSMdTNQS+rHf2lLz
	HRVugT1U4U7JMDtcUaKM3lmg+Zg9x4eGvlfdceQMWDwkXH6JZXJi+66K7LZftrhX3NadIA
	0DuqJyr6knbqJZVG0UuhayhBwOfsDP1ooASytD2Du4cdMgeuSXxg8zTD1KYWf+zPpSS2Nn
	YQ+v++J0gUPIsW/fWWZ2UCDe9vpC45iiOX844WEW+YB2qn+m17kkfY9Ut24I/g==
Date: Sun, 13 Oct 2024 22:55:57 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Cenk Uluisik <cenk.uluisik@googlemail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Chris
 Morgan <macromorgan@hotmail.com>, Jonas Karlman <jonas@kwiboo.se>, Michael
 Riesch <michael.riesch@wolfvision.net>, Andy Yan <andyshrk@163.com>, Jimmy
 Hon <honyuenkwun@gmail.com>, Jing Luo <jing@jing.rocks>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: rockchip: Add rk3588-orangepi-5b device
 tree and refactor
In-Reply-To: <20241013204446.303727-1-cenk.uluisik@googlemail.com>
References: <20241013204446.303727-1-cenk.uluisik@googlemail.com>
Message-ID: <bac3a8702d3e92c401bc4c4d9401258c@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Cenk,

On 2024-10-13 22:44, Cenk Uluisik wrote:
> Implements a slightly modified rk3588s-orangepi-5b.dts from the vendor.
> Unfortunately the &wireless_bluetooth and &wireless_wlan overlays don't 
> seem
> to compile, so I removed them for now:
> 
> Error: arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5b.dts:20.1-20
> Label or path wireless_bluetooth not found
> Error: arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5b.dts:24.1-15
> Label or path wireless_wlan not found
> 
> Bigger parts of the rk3588s-orangepi-5.dts file were moved into a new
> rk3588s-orangepi-5.dtsi file, so that both device trees from the
> orangepi-5 and 5b include from it and avoid including from the .dts.
> 
> How does this board differ from the original Orange Pi 5?
>   - builtin eMMC storage
>   - no SPI NOR flash (u-boot, preboot etc. initiates from within the 
> eMMC
>     storage)
>   - ap6275p Wifi module (like the Orange Pi 5 Plus)
>   - builtin BlueTooth module
> 
> Beside that everything is exactly the same as far as I know.
> 
> Signed-off-by: Cenk Uluisik <cenk.uluisik@googlemail.com>
> ---
>  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>  .../boot/dts/rockchip/rk3588s-orangepi-5.dts  | 760 +----------------
>  .../boot/dts/rockchip/rk3588s-orangepi-5.dtsi | 763 ++++++++++++++++++
>  .../boot/dts/rockchip/rk3588s-orangepi-5b.dts |  18 +
>  4 files changed, 784 insertions(+), 758 deletions(-)
>  create mode 100644 
> arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dtsi
>  create mode 100644 
> arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5b.dts

Please try using the --break-rewrites [*] to generate the patches,
which should produce much shorter diffs, easier to review.

Also, please enumerate the patch versions.  E.g., this should be v2,
and I'm not sure what happened with the multiple v1s you sent earlier.

[*] 
https://git-scm.com/docs/diff-options#Documentation/diff-options.txt---break-rewritesltngtltmgt

