Return-Path: <linux-kernel+bounces-385308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E4F9B356D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 16:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75C6A1C21D09
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 15:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8CF1DE4FF;
	Mon, 28 Oct 2024 15:55:07 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEBC1DD9A6
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 15:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730130906; cv=none; b=oMm1FBp3nJOayROqTzD6QVOZSrnpPdgYelpzoIOax/wI5LenPxf3SRLeSjCMvE+rAnVIDfLxgrEoa3N00LWYdDdLmr8T6iabyPSci8xuO5pXZ8SoBt1PXrcMx+f5d6GTi+V/UvKJFUV9Wb5/2tLMINyAE+boEDfQpSQ5JI/M8lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730130906; c=relaxed/simple;
	bh=IV+HK0si5bJwfaunJrOfqKaExrOGoqO65umfFzj3n18=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lQri/uJq2Sami0OqHAkbi6akALkBZq4+c/M7WawpVA44C18enRIC9Mqh8CRzCbOwKyMIMLP4xLFcNOrde32Z54H1/kVrugfK2JCz+diu4lp5Q5uwTbI0SNYGT4lMqWKixXwE1u1P/iBqcwzif3IEIN0gpvIq8tJobXe3uAWR0m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <l.stach@pengutronix.de>)
	id 1t5S4w-0004F2-N2; Mon, 28 Oct 2024 16:54:50 +0100
Message-ID: <0eb75d1a3d0da6ec4d520da9ba2061dcf69dadff.camel@pengutronix.de>
Subject: Re: [PATCH v2 1/5] drm/etnaviv: Use unsigned type to count the
 number of pages
From: Lucas Stach <l.stach@pengutronix.de>
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: Christian Gmeiner <christian.gmeiner@gmail.com>, Russell King
 <linux+etnaviv@armlinux.org.uk>, David Airlie <airlied@gmail.com>, Daniel
 Vetter <daniel@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>, Maxime
 Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org, 
 etnaviv@lists.freedesktop.org, linux-kernel@vger.kernel.org, Christian
 Gmeiner <cgmeiner@igalia.com>
Date: Mon, 28 Oct 2024 16:54:50 +0100
In-Reply-To: <20240908121107.328740-1-sui.jingfeng@linux.dev>
References: <20240908121107.328740-1-sui.jingfeng@linux.dev>
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

Am Sonntag, dem 08.09.2024 um 20:11 +0800 schrieb Sui Jingfeng:
> The drm_prime_pages_to_sg() function takes an 'unsigned int' argument to
> store the length of the page vector. The size of the object in number of
> CPU pages can not be negative, hence, use 'unsigned' variable to store
> the number of pages, instead of the 'signed' one.
>=20
> Reviewed-by: Christian Gmeiner <cgmeiner@igalia.com>
> Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>

Thanks, series applied to etnaviv/next.

> ---
>=20
> v2: Pick up tags and improve commit message
>=20
>  drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c b/drivers/gpu/dr=
m/etnaviv/etnaviv_gem_prime.c
> index 3524b5811682..6b98200068e4 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
> @@ -17,7 +17,7 @@ static struct lock_class_key etnaviv_prime_lock_class;
>  struct sg_table *etnaviv_gem_prime_get_sg_table(struct drm_gem_object *o=
bj)
>  {
>  	struct etnaviv_gem_object *etnaviv_obj =3D to_etnaviv_bo(obj);
> -	int npages =3D obj->size >> PAGE_SHIFT;
> +	unsigned int npages =3D obj->size >> PAGE_SHIFT;
> =20
>  	if (WARN_ON(!etnaviv_obj->pages))  /* should have already pinned! */
>  		return ERR_PTR(-EINVAL);


