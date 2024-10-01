Return-Path: <linux-kernel+bounces-346114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A6298BFC5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 16:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EFED1C23D53
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 14:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73EBD1C6F72;
	Tue,  1 Oct 2024 14:22:01 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9148B1C6F6E
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 14:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727792521; cv=none; b=Bqr+kw9Wx8exmuLQriN4DX5bK0LQuMQ8LF7CYnXeb9J5aytz0DsOwsJ/6c88sI7uhUCrDhrtUwI78hwrz9cftK6mw4DzeIiTNaGYTUEbHD/kUtaiHm4l9F4cOb/G21/YqJKw7znZPQPocTCo1ph2lyUFC2c35uKZIXtjKT/520o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727792521; c=relaxed/simple;
	bh=8sODrAwkilDxy0hsvtvysVrlzMQL2gmFxCt5uELlXK0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rvyfy9ecmZOCvrRH6N5YssMkCIf4gkEcx+V89xGxGBcSwjkfr7rE5pUPIuGDBfZ++0eHh1/2QttK8N+37tJWg9vyHV/L5nXRvFNCtBAjaTLnv2rWpzACZP6ccz6V/j6lCkw2bQANwRDKbsrshvcM6Z/H2SHeT/ni7h/eid2yGa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <l.stach@pengutronix.de>)
	id 1svdlC-0005r6-D6; Tue, 01 Oct 2024 16:21:54 +0200
Message-ID: <45b8eb9a0a2b91d85f9dd6b7e66a1796398fa27c.camel@pengutronix.de>
Subject: Re: [PATCH v15 11/19] drm/etnaviv: Add etnaviv_gem_obj_remove()
 helper
From: Lucas Stach <l.stach@pengutronix.de>
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: Christian Gmeiner <christian.gmeiner@gmail.com>, Russell King
	 <linux+etnaviv@armlinux.org.uk>, dri-devel@lists.freedesktop.org, 
	etnaviv@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Tue, 01 Oct 2024 16:21:53 +0200
In-Reply-To: <20240908094357.291862-12-sui.jingfeng@linux.dev>
References: <20240908094357.291862-1-sui.jingfeng@linux.dev>
	 <20240908094357.291862-12-sui.jingfeng@linux.dev>
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
> Which is corresonding to the etnaviv_gem_obj_add()
>=20
While symmetry is nice, it's still not really symmetric, as this
function isn't exported into the PRIME parts of the driver like
etnaviv_gem_obj_add(). Given that I don't really see how this patch
improves code legibility.

Regards,
Lucas

> Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
> ---
>  drivers/gpu/drm/etnaviv/etnaviv_gem.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.c b/drivers/gpu/drm/etna=
viv/etnaviv_gem.c
> index 39cfece67b90..3732288ff530 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> @@ -19,6 +19,8 @@
>  static struct lock_class_key etnaviv_shm_lock_class;
>  static struct lock_class_key etnaviv_userptr_lock_class;
> =20
> +static void etnaviv_gem_obj_remove(struct drm_gem_object *obj);
> +
>  static void etnaviv_gem_scatter_map(struct etnaviv_gem_object *etnaviv_o=
bj)
>  {
>  	struct drm_device *dev =3D etnaviv_obj->base.dev;
> @@ -555,15 +557,12 @@ void etnaviv_gem_free_object(struct drm_gem_object =
*obj)
>  {
>  	struct drm_device *drm =3D obj->dev;
>  	struct etnaviv_gem_object *etnaviv_obj =3D to_etnaviv_bo(obj);
> -	struct etnaviv_drm_private *priv =3D obj->dev->dev_private;
>  	struct etnaviv_vram_mapping *mapping, *tmp;
> =20
>  	/* object should not be active */
>  	drm_WARN_ON(drm, is_active(etnaviv_obj));
> =20
> -	mutex_lock(&priv->gem_lock);
> -	list_del(&etnaviv_obj->gem_node);
> -	mutex_unlock(&priv->gem_lock);
> +	etnaviv_gem_obj_remove(obj);
> =20
>  	list_for_each_entry_safe(mapping, tmp, &etnaviv_obj->vram_list,
>  				 obj_node) {
> @@ -595,6 +594,16 @@ void etnaviv_gem_obj_add(struct drm_device *dev, str=
uct drm_gem_object *obj)
>  	mutex_unlock(&priv->gem_lock);
>  }
> =20
> +static void etnaviv_gem_obj_remove(struct drm_gem_object *obj)
> +{
> +	struct etnaviv_drm_private *priv =3D to_etnaviv_priv(obj->dev);
> +	struct etnaviv_gem_object *etnaviv_obj =3D to_etnaviv_bo(obj);
> +
> +	mutex_lock(&priv->gem_lock);
> +	list_del(&etnaviv_obj->gem_node);
> +	mutex_unlock(&priv->gem_lock);
> +}
> +
>  static const struct vm_operations_struct vm_ops =3D {
>  	.fault =3D etnaviv_gem_fault,
>  	.open =3D drm_gem_vm_open,


