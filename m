Return-Path: <linux-kernel+bounces-535609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD94DA47514
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 06:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4761316E1DE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 05:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C161E8357;
	Thu, 27 Feb 2025 05:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="rnXDS1IT"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105011E833A;
	Thu, 27 Feb 2025 05:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740633228; cv=none; b=JxlbTsacJxE2eVydeA02+8MbN8j892mdtbHO2J5Q1yNgLLv59I9jV3g1aMb9hDYbsQi0zk9Bp3k2mMjz4Ppwz2Z+dBTU+DF/LXGK09jzzQMDTXDE4HSO4rlexEntkGhaUxNwc5cDSCk2ZDb2MUknDcIf47gQ5JkYKCgRUtghppg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740633228; c=relaxed/simple;
	bh=6mPELG30QvwhvudxXkhUdp/eArCX2wGHM95Gv1mHh8A=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=R+0ci8aOKfbt9xnPmMtQkDGWrGvjE4FaGnlc3isFxj197XXUlFEfD6p6HTsWxkCmV5uPOFkS6GVw3eHnEccH+lkzm8hE/lX1Xw+SzsbwNMgdPiDRjb172HlpYsMcJjlECiUyzegw1uUc9oHAMHnSRa/cqO/qztVrQmivchceOEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=rnXDS1IT; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1740633224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jKlLjUCYt/7C/aUqa8V29qM6zcYxyzNvO3oU1xinEp8=;
	b=rnXDS1ITz7j5pdL6P+8n7fNPA479Gk8yJfvWPtE2+/sE/I/iwGI2FIj0MSQFyctqGhw+xg
	y/T92ZXJYsG9mjVaM9rAiZcANtjdpMkb55uSkqiIUWhh/WBUKyJ3wcK3ywnLWuzAfkkBsj
	Tg5vHQfSKvJ+RsfnpNnVkAKv6srOknOdZg5lHdVk4SyyQEPketV3SZyjMBNhGZSnLGgTpA
	V7+6iO8krA2trQOxU2frbjjxPzIMrjonr+T2a87mKMXzVWyttGhnltPsHpEPbnr6GWTog7
	OGJD0CQO8MefGCjC2Ff1T5IX61kTxJUSaDPY7ijjXEdF2v2bF2aEQNbtvw7jJQ==
Date: Thu, 27 Feb 2025 06:13:44 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: quentin.schulz@cherry.de, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, dse@thaumatec.com, Heiko Stuebner
 <heiko.stuebner@cherry.de>
Subject: Re: [PATCH v3 3/3] arm64: dts: rockchip: add overlay for tiger-haikou
 video-demo adapter
In-Reply-To: <20250226140942.3825223-4-heiko@sntech.de>
References: <20250226140942.3825223-1-heiko@sntech.de>
 <20250226140942.3825223-4-heiko@sntech.de>
Message-ID: <9cfe09a2dc108ddac16368687d43e88d@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Heiko,

On 2025-02-26 15:09, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
> 
> This adds support for the video-demo-adapter DEVKIT ADDON CAM-TS-A01
> (https://embedded.cherry.de/product/development-kit/) for the Haikou
> devkit with Tiger RK3588 SoM.
> 
> The Video Demo adapter is an adapter connected to the fake PCIe slot
> labeled "Video Connector" on the Haikou devkit.
> 
> It's main feature is a Leadtek DSI-display with touchscreen and a 
> camera
> (that is not supported yet). To drive these components a number of
> additional regulators are grouped on the adapter as well as a PCA9670
> gpio-expander to provide the needed additional gpio-lines.
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>

The additions to the Makefile introduced in this patch are looking
good to me, so please feel free to include

Reviewed-by: Dragan Simic <dsimic@manjaro.org> # Makefile

> ---
>  arch/arm64/boot/dts/rockchip/Makefile         |   5 +
>  .../rk3588-tiger-haikou-video-demo.dtso       | 153 ++++++++++++++++++
>  2 files changed, 158 insertions(+)
>  create mode 100644
> arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou-video-demo.dtso
> 
> diff --git a/arch/arm64/boot/dts/rockchip/Makefile
> b/arch/arm64/boot/dts/rockchip/Makefile
> index db6017272ff1..4cddb5d2807d 100644
> --- a/arch/arm64/boot/dts/rockchip/Makefile
> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> @@ -158,6 +158,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-rock-5b.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-rock-5b-pcie-ep.dtbo
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-rock-5b-pcie-srns.dtbo
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-tiger-haikou.dtb
> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-tiger-haikou-video-demo.dtbo
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-toybrick-x0.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-turing-rk1.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-coolpi-4b.dtb
> @@ -214,3 +215,7 @@ rk3588-rock-5b-pcie-ep-dtbs := rk3588-rock-5b.dtb \
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-rock-5b-pcie-srns.dtb
>  rk3588-rock-5b-pcie-srns-dtbs := rk3588-rock-5b.dtb \
>  	rk3588-rock-5b-pcie-srns.dtbo
> +
> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-tiger-haikou-video-demo.dtb
> +rk3588-tiger-haikou-video-demo-dtbs := rk3588-tiger-haikou.dtb \
> +	rk3588-tiger-haikou-video-demo.dtbo

