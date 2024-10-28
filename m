Return-Path: <linux-kernel+bounces-385315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 278C49B3583
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 16:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 593421C21BAB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 15:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0091DE88B;
	Mon, 28 Oct 2024 15:57:51 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F381DE4E0
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 15:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730131071; cv=none; b=Z9V2+kFqEALdlfwwmiAXPAZ0tu4NL9FmRG6R1MwK8hQq6zxtgqPHWk/hAet3xF+LbWBwNuDI2cjLO5OoC+vRuzVt5/t3lw3N393RM2RGkt8Cx4M1zYLi4K1T65mw1qr1cUhG+ZBpgIEkMtAyirIF7FSvaLyXkYXwkxBK+w8wjuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730131071; c=relaxed/simple;
	bh=90WPtQmJKampZow5LNNmYMynWlAKfic8tKYAiOoxp1E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mos+AWgNo+ky77R7MPRT3keNdnYVIQ05o9+B05PHmMzf46YfYIcD7jVH+K00S+9xoLNVhJakcPQtqQZsJ79AkrxJAt5V00fPtPeR+0DuzQuYtM7+s2UbpUSU5iZ/NKYjsMB2DtzxFjlE6aCLuVr+AZMtHh9/ujbT0F8U1H2p4oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <l.stach@pengutronix.de>)
	id 1t5S7l-0004et-32; Mon, 28 Oct 2024 16:57:45 +0100
Message-ID: <40137342e918a7d74d728d0d5fbbad56e7be5607.camel@pengutronix.de>
Subject: Re: [PATCH] drm/etnaviv: etnaviv_cmdbuf.c: Drop the unneeded
 include of drm_mm.h
From: Lucas Stach <l.stach@pengutronix.de>
To: Sui Jingfeng <sui.jingfeng@linux.dev>, Russell King
 <linux+etnaviv@armlinux.org.uk>, Christian Gmeiner
 <christian.gmeiner@gmail.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 28 Oct 2024 16:57:44 +0100
In-Reply-To: <20241025175620.414666-1-sui.jingfeng@linux.dev>
References: <20241025175620.414666-1-sui.jingfeng@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Am Samstag, dem 26.10.2024 um 01:56 +0800 schrieb Sui Jingfeng:
> The etnaviv_cmdbuf.c doesn't reference any functions or data members
> defined in drm_mm.h, remove unneeded headers may reduce kernel compile
> times.
>=20
> Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>

Thanks, applied to etnaviv/next.

> ---
>  drivers/gpu/drm/etnaviv/etnaviv_cmdbuf.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_cmdbuf.c b/drivers/gpu/drm/e=
tnaviv/etnaviv_cmdbuf.c
> index 66a407f1b3ee..7aa5f14d0c87 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_cmdbuf.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_cmdbuf.c
> @@ -5,8 +5,6 @@
> =20
>  #include <linux/dma-mapping.h>
> =20
> -#include <drm/drm_mm.h>
> -
>  #include "etnaviv_cmdbuf.h"
>  #include "etnaviv_gem.h"
>  #include "etnaviv_gpu.h"


