Return-Path: <linux-kernel+bounces-346166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C84098C0B5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 16:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C141B1C2418A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 14:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C061C9B72;
	Tue,  1 Oct 2024 14:51:09 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C6C1BF7F8
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 14:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727794269; cv=none; b=fNniIzlN3p5BRXu4fllmU7dn742BWjuebBa3cayZDc2vW67+K89ejPtGQ/8a/bPD2xMeRi8mIFJ6E9su+pn6ADw8WDySuNNgsyQ+/Uy9IrCz+2iQpoAmm3LZhUzi/sx4pjlFFcIus5prORn5B05fFm08zc/MgKRY2dFksrD4keY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727794269; c=relaxed/simple;
	bh=AMPWG09ijUQ6HTLD7Z2CrDUC7/eS/Zy0+89nC6dSVrg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NRlRvMHvQtyYetW8und4ZL/NnuYhVuwKZHbLQ8YzR8JCYl+q5KLdmprw+LjArodNVz/g72pDDZDpsurbdW1W+awsw8yPNz0gSFFv+cYbKjoVHvk4ze2FraZB4N42wp53/LNJv23YQZwjIZwQtzWABmOBkNkEU6jQAsPVQxvkKj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <l.stach@pengutronix.de>)
	id 1sveDO-0004wV-Qj; Tue, 01 Oct 2024 16:51:02 +0200
Message-ID: <2b5afbe1d32c984f67555d73a35ae24eed60dd68.camel@pengutronix.de>
Subject: Re: [PATCH v15 18/19] drm/etnaviv: Allow userspace specify the
 domain of etnaviv GEM buffer object
From: Lucas Stach <l.stach@pengutronix.de>
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: Christian Gmeiner <christian.gmeiner@gmail.com>, Russell King
	 <linux+etnaviv@armlinux.org.uk>, dri-devel@lists.freedesktop.org, 
	etnaviv@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Tue, 01 Oct 2024 16:51:02 +0200
In-Reply-To: <20240908094357.291862-19-sui.jingfeng@linux.dev>
References: <20240908094357.291862-1-sui.jingfeng@linux.dev>
	 <20240908094357.291862-19-sui.jingfeng@linux.dev>
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

Am Sonntag, dem 08.09.2024 um 17:43 +0800 schrieb Sui Jingfeng:
> Otherwise we don't know where a etnaviv GEM buffer object should put when
> we create it at userspace.
>=20
> Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
> ---
>  drivers/gpu/drm/etnaviv/etnaviv_drv.c |  9 +++++++++
>  include/uapi/drm/etnaviv_drm.h        | 12 ++++++++++++
>  2 files changed, 21 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etna=
viv/etnaviv_drv.c
> index f10661fe079f..cdc62f64b200 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> @@ -331,11 +331,20 @@ static int etnaviv_ioctl_gem_new(struct drm_device =
*dev, void *data,
>  		struct drm_file *file)
>  {
>  	struct drm_etnaviv_gem_new *args =3D data;
> +	u32 domain;
> +
> +	domain =3D args->flags & ETNA_BO_DOMAIN_MASK;
> +
> +	args->flags &=3D ~ETNA_BO_DOMAIN_MASK;

This is not a proper input validation, as it would accept data in the
domain mask range that doesn't correspond to valid flags. You need to
add your new valid flag bits to the check below.

> =20
>  	if (args->flags & ~(ETNA_BO_CACHED | ETNA_BO_WC | ETNA_BO_UNCACHED |
>  			    ETNA_BO_FORCE_MMU))
>  		return -EINVAL;
> =20
> +	if (domain =3D=3D ETNA_BO_PL_VRAM)
> +		return etnaviv_gem_new_vram(dev, file, args->size,
> +					    args->flags, &args->handle);
> +
>  	return etnaviv_gem_new_handle(dev, file, args->size,
>  			args->flags, &args->handle);
>  }
> diff --git a/include/uapi/drm/etnaviv_drm.h b/include/uapi/drm/etnaviv_dr=
m.h
> index 61eaa8cd0f5e..00e778c9d312 100644
> --- a/include/uapi/drm/etnaviv_drm.h
> +++ b/include/uapi/drm/etnaviv_drm.h
> @@ -99,6 +99,18 @@ struct drm_etnaviv_param {
>  /* map flags */
>  #define ETNA_BO_FORCE_MMU    0x00100000
> =20
> +/* domain (placement) flags */
> +#define ETNA_BO_DOMAIN_MASK  0x00f00000

How does this work? Has this been tested? This define masks different
bits than the placement flags defined below.
>=20
> +
> +/* CPU accessible, GPU accessible pages in dedicated VRAM */
> +#define ETNA_BO_PL_VRAM      0x01000000

Other drivers call this the visible VRAM range.

> +/* CPU accessible, GPU accessible pages in SHMEM */
> +#define ETNA_BO_PL_GTT       0x02000000
> +/* Userspace allocated memory, at least CPU accessible */
> +#define ETNA_BO_PL_USERPTR   0x08000000

How is this a valid placement? If it's userspace allocated memory, the
driver has no influence on placement. All it can do is to pin the pages
and set up a GART mapping.

> +/* GPU accessible but CPU not accessible private VRAM pages */
> +#define ETNA_BO_PL_PRIV      0x04000000
> +

VRAM_INVISIBLE would be a more descriptive name for the flag than PRIV.

However I'm not sure if we can make the distinction between visible and
invisible VRAM at allocation time. What needs to be CPU visible may
change over the runtime of the workload, which is why real TTM drivers
can migrate BOs in and out of the visible region.

Regards,
Lucas

>  struct drm_etnaviv_gem_new {
>  	__u64 size;           /* in */
>  	__u32 flags;          /* in, mask of ETNA_BO_x */


