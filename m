Return-Path: <linux-kernel+bounces-526975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A6AA405CE
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 07:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27C1C3A3559
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 06:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BB11FAC56;
	Sat, 22 Feb 2025 06:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=erdfelt.com header.i=@erdfelt.com header.b="uV73Vx4s"
Received: from out.bound.email (out.bound.email [141.193.244.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483DE4A05;
	Sat, 22 Feb 2025 06:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.193.244.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740204946; cv=none; b=OjuSxMFvXFtf4tPlLqbfl3FgEP175oFIYmRDKB4GqkQqjOPNqNG1Q7Gla2U1UMemqCncF//9vjX9DS3SZlZOM1hfictSwoqJy+aG+IpEL9W0SfyIrK3vvy/CP7cv7zlxGRBAqNXEeoxhkdIn5ju0EA2s3K6ztwzabhczHw3dzOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740204946; c=relaxed/simple;
	bh=NkxqM4Lv0sByK76JhZAcSL/vEVa0mALpE8utZEX25YY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nujhxil4a75gc95Dx+s3FIyAwsQRGZWM3xzm/s+AsQ06cid1kDRPRBnA9pgpwKBzOZhIc2SfIGF3hNb5PV5PxWYCeEIVyfN2A/3fuEz7fiEQtEPPx3qIVsKXsS8HyILYUMyXwQPWvkNQu6bEZyGn1YFKn2UUeEgMczG7yB3fxac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=erdfelt.com; spf=pass smtp.mailfrom=erdfelt.com; dkim=pass (1024-bit key) header.d=erdfelt.com header.i=@erdfelt.com header.b=uV73Vx4s; arc=none smtp.client-ip=141.193.244.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=erdfelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=erdfelt.com
Received: from mail.sventech.com (localhost [127.0.0.1])
	by out.bound.email (Postfix) with ESMTP id 9DDFA8A0A03;
	Fri, 21 Feb 2025 22:10:43 -0800 (PST)
Received: by mail.sventech.com (Postfix, from userid 1000)
	id 8445F160036F; Fri, 21 Feb 2025 22:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=erdfelt.com;
	s=default; t=1740204643;
	bh=ipBg/kh10xlLbTfqW90iojp94rB9+YUQQbr3OHMLVXY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uV73Vx4sYe6+zf3jjzrwt+ECW446OAMMZzdBgrfnLwS0sg+2CL30u2R73aA5DxYnl
	 7zGJFwOIa47n8pyBbaz2HQA4i+QHZtwNJYfU2M9GMUIDBsUNddjp4oUf+mneWRdxff
	 SK+LnfDuirmuLBci97mXWUpZILvcPoCSkgWk7tu0=
Date: Fri, 21 Feb 2025 22:10:43 -0800
From: Johannes Erdfelt <johannes@erdfelt.com>
To: Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>
Cc: Jianfeng Liu <liujianfeng1994@gmail.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	simona@ffwll.ch, devicetree@vger.kernel.org, conor+dt@kernel.org,
	robh@kernel.org, maarten.lankhorst@linux.intel.com,
	hjc@rock-chips.com, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
	mripard@kernel.org, tzimmermann@suse.de, andy.yan@rock-chips.com,
	krzk+dt@kernel.org, kernel@collabora.com, airlied@gmail.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/4] arm64: dts: rockchip: Add HDMI1 PHY PLL clock source
 to VOP2 on RK3588
Message-ID: <20250222061043.GW16911@sventech.com>
References: <1919367.CQOukoFCf9@diego>
 <20250218121749.1382322-1-liujianfeng1994@gmail.com>
 <lnuceofdwm6lgibworaghcujp6rrncvn4e2xc2vzltimjw3rqu@jur7x5cxt5ue>
 <2425191.NG923GbCHz@diego>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2425191.NG923GbCHz@diego>
User-Agent: Mutt/1.11.4 (2019-03-13)

On Tue, Feb 18, 2025, Heiko Stübner <heiko@sntech.de> wrote:
> I was more thinking about fixing the correct thing, with something like:
> 
> ----------- 8< ----------
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index cf7720b9172f..50faafbf5dda 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -5258,6 +5258,10 @@ of_clk_get_hw_from_clkspec(struct of_phandle_args *clkspec)
>         if (!clkspec)
>                 return ERR_PTR(-EINVAL);
> 
> +       /* Check if node in clkspec is in disabled/fail state */
> +       if (!of_device_is_available(clkspec->np))
> +               return ERR_PTR(-ENOENT);
> +
>         mutex_lock(&of_clk_mutex);
>         list_for_each_entry(provider, &of_clk_providers, link) {
>                 if (provider->node == clkspec->np) {
> ----------- 8< ----------
> 
> Because right now the clk framework does not handle nodes in
> failed/disabled state and would defer indefinitly.

I've been testing the recent patches Jimmy Hon has posted to add the
Orange Pi 5 Ultra DT and I ran into this bug. The Ultra uses HDMI1 for
the HDMI TX.

This patch successfully fixes the issue I was seeing.

JE


