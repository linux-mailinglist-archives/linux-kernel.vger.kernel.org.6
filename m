Return-Path: <linux-kernel+bounces-353123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D02992903
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 12:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 041C81C22B2D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 10:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF7718BC12;
	Mon,  7 Oct 2024 10:20:27 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAF31E519
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 10:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728296427; cv=none; b=V2/bNE0BbpANVQQFVJAsxYHSzWqjAcYDn5HAkd5jcVR9jWyMveL3uv6P7yaHlyPvUIfybHM42xFdF6HJxWTuzLu3iVf7wsVmygeV9GKb4GF3d+tcSRZzllTyUfi1u83uuCiL2c2knQ1zFylWF3IsV/SNp8tk9Zf/CAj/z/SACug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728296427; c=relaxed/simple;
	bh=Wm8kdy6aTftbQEwbF1CmQKvFcXQkUP0BTRxDgKb+Kbk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tCD7r8Nc4bHvVIE5+B4RnNJyLTxUHiDd88+MsIwIMYj6AC/BruxwQ1n+25GAvqQwTxc7bKblrouFtmRRCq4BmD0V30mmIhAFkp1pjE8T3Jg8uLIMl3pR+LTkD79AQTiKNuiG2HzJ5DBpqTOp8eh+mhXXGGcUOZfELcXYXHHd2vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <l.stach@pengutronix.de>)
	id 1sxkqg-0006jO-HY; Mon, 07 Oct 2024 12:20:18 +0200
Message-ID: <fb5ae5769442f4c84098acd674d423cd3f00bc66.camel@pengutronix.de>
Subject: Re: [PATCH 3/3] drm/etnaviv: Print an error message if inserting
 IOVA range fails
From: Lucas Stach <l.stach@pengutronix.de>
To: Sui Jingfeng <sui.jingfeng@linux.dev>, Russell King
 <linux+etnaviv@armlinux.org.uk>, Christian Gmeiner
 <christian.gmeiner@gmail.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 07 Oct 2024 12:20:18 +0200
In-Reply-To: <20241004194207.1013744-4-sui.jingfeng@linux.dev>
References: <20241004194207.1013744-1-sui.jingfeng@linux.dev>
	 <20241004194207.1013744-4-sui.jingfeng@linux.dev>
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

Am Samstag, dem 05.10.2024 um 03:42 +0800 schrieb Sui Jingfeng:
> Print an error message to help debug when such an issue happen, since it'=
s
> not so obvious.
>=20
> Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
> v0 -> v1: Use dev_err_ratelimited() to prevent spamming the logs
>=20
> v0 is at https://lore.kernel.org/dri-devel/20240930221706.399139-1-sui.ji=
ngfeng@linux.dev/
> ---
>  drivers/gpu/drm/etnaviv/etnaviv_mmu.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_mmu.c b/drivers/gpu/drm/etna=
viv/etnaviv_mmu.c
> index a52ec5eb0e3d..37866ed05c13 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
> @@ -300,8 +300,12 @@ int etnaviv_iommu_map_gem(struct etnaviv_iommu_conte=
xt *context,
>  		ret =3D etnaviv_iommu_insert_exact(context, node, user_size, va);
>  	else
>  		ret =3D etnaviv_iommu_find_iova(context, node, user_size);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		dev_err_ratelimited(context->global->dev,
> +				    "Insert iova failed: 0x%llx(0x%x)\n",
> +				    va, user_size);
>  		goto unlock;
> +	}
> =20
>  	mapping->iova =3D node->start;
>  	ret =3D etnaviv_iommu_map(context, node->start, user_size, sgt,


