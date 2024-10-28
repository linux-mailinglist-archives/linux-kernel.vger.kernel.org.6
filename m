Return-Path: <linux-kernel+bounces-385316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A37C49B3586
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 16:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D55031C21A9A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 15:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B951DE889;
	Mon, 28 Oct 2024 15:58:09 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC66F1DE4E0
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 15:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730131089; cv=none; b=ET/6R1he3Pmzn6ECaHQstA9rsWFl7KbrTFSHaeb3h3ouGC4/uYhw+yu+pK+H0MECxfOfxK6fmNcMfMdJkEALNBT98V15Snqz5PHjnnFEHCwt02SdJCMFQbqEaNuzSig87kzk08GPuSRtiWGOjYUgVr+e31CAZBDB10989AWEdcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730131089; c=relaxed/simple;
	bh=A3DHoerx2G5WQjS9czsUlNVk2nK6aAE0u9y767hzcHg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jFAPmQ70BJ7AmBtB7+wEJjskywaW4Rmv299bHlc9s2vDdxjg9yVrLJRrOXe4RpBkVwa57YpbuX3Ent6rb1n0GyIn3PryhqIZOC/PEk4R7zJj/WLAqOdgHxyjXqyqtEh0O8GFPclGgZ1bPBDkbYjwO7SjUjrDgCUyL+f9VPXrCiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <l.stach@pengutronix.de>)
	id 1t5S83-0004iB-5W; Mon, 28 Oct 2024 16:58:03 +0100
Message-ID: <3ee89e2d2263836de587e41c74370f6eb38de174.camel@pengutronix.de>
Subject: Re: [PATCH] drm/etnaviv: Drop the 'struct
 etnaviv_iommu_global::pta_lock' data member
From: Lucas Stach <l.stach@pengutronix.de>
To: Sui Jingfeng <sui.jingfeng@linux.dev>, Russell King
 <linux+etnaviv@armlinux.org.uk>, Christian Gmeiner
 <christian.gmeiner@gmail.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 28 Oct 2024 16:58:02 +0100
In-Reply-To: <20241025175136.414054-1-sui.jingfeng@linux.dev>
References: <20241025175136.414054-1-sui.jingfeng@linux.dev>
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

Am Samstag, dem 26.10.2024 um 01:51 +0800 schrieb Sui Jingfeng:
> Because it is not get used, drop it.
>=20
> Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>

Thanks, applied to etnaviv/next.

> ---
>  drivers/gpu/drm/etnaviv/etnaviv_mmu.h | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_mmu.h b/drivers/gpu/drm/etna=
viv/etnaviv_mmu.h
> index c01a147f0dfd..7f8ac0178547 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_mmu.h
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_mmu.h
> @@ -61,7 +61,6 @@ struct etnaviv_iommu_global {
>  			/* P(age) T(able) A(rray) */
>  			u64 *pta_cpu;
>  			dma_addr_t pta_dma;
> -			struct spinlock pta_lock;
>  			DECLARE_BITMAP(pta_alloc, ETNAVIV_PTA_ENTRIES);
>  		} v2;
>  	};


