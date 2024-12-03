Return-Path: <linux-kernel+bounces-429963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D71E9E29BE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 18:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A213716501C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 17:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72AFE1FC10C;
	Tue,  3 Dec 2024 17:43:23 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E571FAC5B
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 17:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733247803; cv=none; b=IziUcROvVBR33Lzq4eneANIOlLpbYrsHOHZnHHuJ/h4p+y79ddy/ckcLoEj+4LMgCDKtN5EyNqqNhYyBfVgD63VTJcAXVkiaYYq5RsKxYtLgSWHtXtHfm9y7Fv+jHO2liYm4Ls5ZRMb94/cNutrRW7UtnetbgUGGh6O8TLj9dtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733247803; c=relaxed/simple;
	bh=ATGRiuGwIEEHOK3XARiOz99IrAgjSbwKrMAHIzCy98s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dapeEpxHRDYRce41filk2fJeXH3vNVEYxhYrK2b/8tJ8fY8a80rQnP+6UNwZ8nD9FAidtgKnWancVFjeUjIapFP9fs/px0f2gTJen+ra1IWswhOxxfZZP7rSoSmSfjx27aRq804mn0L8XUvAV/JPxXONLMftEwYH+0ka7ZqZwvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <l.stach@pengutronix.de>)
	id 1tIWvB-000397-BW; Tue, 03 Dec 2024 18:42:49 +0100
Message-ID: <805cd97f8050a9f7baa122e3c77f7fd4f8b4a353.camel@pengutronix.de>
Subject: Re: [PATCH] drm/etnaviv: Drop the 'struct
 etnaviv_iommu_global::pta_lock' data member
From: Lucas Stach <l.stach@pengutronix.de>
To: Sui Jingfeng <sui.jingfeng@linux.dev>, Russell King
 <linux+etnaviv@armlinux.org.uk>, Christian Gmeiner
 <christian.gmeiner@gmail.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Date: Tue, 03 Dec 2024 18:42:48 +0100
In-Reply-To: <20241025175136.414054-1-sui.jingfeng@linux.dev>
References: <20241025175136.414054-1-sui.jingfeng@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
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
Thanks, applied to etnaviv/next.

Regards,
Lucas

> Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
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


