Return-Path: <linux-kernel+bounces-344699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6228E98ACF7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 21:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 280BE284972
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 19:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E7C199252;
	Mon, 30 Sep 2024 19:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b="XPSnJ4Pw"
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5A015688E;
	Mon, 30 Sep 2024 19:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727724764; cv=pass; b=hm4E68QmA8UzJWZocAAhrmGxVaSDSU5G7vKRNAm3bgTrGANS2D6KmRgsqWlVUQWYG+A+DLKVqSARGtPL4f0mlbjtoKbzjo1gBSArsrs/0bEiak2MZfC6ED7Fv1Fg8a12XcQDCCrJuktY/PphZvhG9sf6obTk+zfkAtGGtVA3fJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727724764; c=relaxed/simple;
	bh=RBoi7N/sKhsCyPshxhYEgBR1FsRi0/3/okNp1KjmqwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pv8sSVQg2mL7AdNoBi7FPxrAcXSR15+W9CJXPWD5ysMEs8LZylOE0diRPwa0t0PUH4y01ULTMPL7oywtbO5qct7nSGXNHmgmh93LOOgpj05mP/GskPOyKXtFzKlPAGBY0D8f0p1oXFFCEmRy4dN/BDcvbkjMaX1EiPEPgm+01jQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b=XPSnJ4Pw; arc=pass smtp.client-ip=136.143.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1727724736; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=GJkV9CjD8jC04jOyzsBM72sQtQf+y+uqRofBTvwUlLP3EuYS0iOPBfN6zLgQq8suuW2aFbozDQV3AY7drpupiFuIhIo59sCC0JsUyPfLZeihFIXDrTzarp+ORpNY6r5AYCIfKX+wlh3vH63gts3qzKtD/YwOl25qekEYYmpAaCM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1727724736; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=clwvoUXnFfSRxwtaKvOxsC6+Wuer1OagShHRee9wI2I=; 
	b=GWJnXDbQLZZxdad5Kkj78XPkuBqlbC+f6vaYslFA5asgTWalOssDFTlF4W2jKhJHaZe3Gav1N3H9KJU2QJxqoDV2Cg74bGKZQ0IiW0KsObhvFvvplu3Bwx8mNBMkxD0IUot8+oUxqpTSn3Lw35Sd3WLqgqOwfTtpthijc1n2AVY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=detlev.casanova@collabora.com;
	dmarc=pass header.from=<detlev.casanova@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1727724736;
	s=zohomail; d=collabora.com; i=detlev.casanova@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=clwvoUXnFfSRxwtaKvOxsC6+Wuer1OagShHRee9wI2I=;
	b=XPSnJ4PwlQp0goLtVkf21cII+W7yq7RJzGGC58TnW3M0FVa5qNLFj1oQKATfwS9O
	cI8qTP9PUb9Y5vs6/59LqKjz+oG1flh/OrWJBARnH8pYB2OIsdVO4kVwRX9zFQeRuUD
	xMcshM1GmDfz+V/Pg3HKO9Q9a8l0y/M74X+LKfa8=
Received: by mx.zohomail.com with SMTPS id 1727724734268228.14685023694335;
	Mon, 30 Sep 2024 12:32:14 -0700 (PDT)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: heiko@sntech.de, Andy Yan <andyshrk@163.com>
Cc: hjc@rock-chips.com, krzk+dt@kernel.org, robh@kernel.org,
 conor+dt@kernel.org, s.hauer@pengutronix.de, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 derek.foreman@collabora.com, minhuadotchen@gmail.com,
 Andy Yan <andy.yan@rock-chips.com>
Subject: Re: [PATCH v3 00/15] VOP Support for rk3576
Date: Mon, 30 Sep 2024 15:32:12 -0400
Message-ID: <5826037.DvuYhMxLoT@bootstrap>
In-Reply-To: <20240920081626.6433-1-andyshrk@163.com>
References: <20240920081626.6433-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-ZohoMailClient: External

Hi Andy,

I tested these on the RK3576 Armsom Sige 5 board:

Tested-by: Detlev Casanova <detlev.casanova@collabora.com>

Regards,
Detlev.

On Friday, 20 September 2024 04:16:24 EDT Andy Yan wrote:
> From: Andy Yan <andy.yan@rock-chips.com>
> 
> 
> Thanks for the basic work from Collabora, I can bringup a HDMI
> display out on rk3576.
> 
> PATCH 1 is a carryover from the working when add support for rk3588,
>         is very usefull when some people want me help debug some issue
>         online, so I really hope it can be merged at this round.
> PATCH 2~5 are bugfix of rk3588 alpha blending which report and test by
>          Derek
> PATCH 6~13 are preparations for rk3576 support
> PATCH 14~15 are real support for rk376
> 
> The hdmi depends on WIP patch from Cristian[1]
> I test it with a 1080P/4K HDMI output with modetest and weston output.
> 
> If there are some one want to have a try, I have a tree here[2]
> 
> [0]
> https://patchwork.kernel.org/project/linux-rockchip/cover/20231211115547.17
> 84587-1-andyshrk@163.com/ [1]
> https://lore.kernel.org/lkml/20240819-b4-rk3588-bridge-upstream-v4-0-6417c7
> 2a2749@collabora.com/ [2]
> https://github.com/andyshrk/linux/tree/rk3576-vop2-upstream-v3
> 
> Changes in v3:
> - Add comments for why we should treat rk3566 with special care.
> - Add hardware version check
> - Add description for newly added interrupt
> - Share the alpha setup function with rk3568
> - recoder the code block by soc
> 
> Changes in v2:
> - split it from main patch add support for rk3576
> - Add platform specific callback
> - Introduce vop hardware version
> - Add dt bindings
> - Add platform specific callback
> 
> Andy Yan (15):
>   drm/rockchip: vop2: Add debugfs support
>   drm/rockchip: Set dma mask to 64 bit
>   drm/rockchip: vop2: Fix cluster windows alpha ctrl regsiters offset
>   drm/rockchip: vop2: Fix the mixer alpha setup for layer 0
>   drm/rockchip: vop2: Fix the windows switch between different layers
>   drm/rockchip: vop2: include rockchip_drm_drv.h
>   drm/rockchip: vop2: Support 32x8 superblock afbc
>   drm/rockchip: vop2: Add platform specific callback
>   drm/rockchip: vop2: Support for different layer selet configuration
>     between VPs
>   drm/rockchip: vop2: Introduce vop hardware version
>   drm/rockchip: vop2: Register the primary plane and overlay plane
>     separately
>   drm/rockchip: vop2: Set plane possible crtcs by possible vp mask
>   drm/rockchip: vop2: Add uv swap for cluster window
>   dt-bindings: display: vop2: Add rk3576 support
>   drm/rockchip: vop2: Add support for rk3576
> 
>  .../display/rockchip/rockchip-vop2.yaml       |   13 +-
>  drivers/gpu/drm/rockchip/rockchip_drm_drv.c   |    4 +-
>  drivers/gpu/drm/rockchip/rockchip_drm_vop2.c  | 1572 ++++---------
>  drivers/gpu/drm/rockchip/rockchip_drm_vop2.h  |  274 ++-
>  drivers/gpu/drm/rockchip/rockchip_vop2_reg.c  | 1948 ++++++++++++++++-
>  5 files changed, 2683 insertions(+), 1128 deletions(-)





