Return-Path: <linux-kernel+bounces-534431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64292A466A1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 17:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F1857A21BE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65510220694;
	Wed, 26 Feb 2025 16:32:35 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D671F16B
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 16:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740587555; cv=none; b=QChwJ5j/C74gknhDoMg8shValMY8rSQwwpfofWSlPcGFHp/S/gfjkmYOPM1DW1sXKzTYoYIjXDEDswsXIEexFj9toACI3VQ7OYKLFl2wIRL9Rqv9QkJib/lW2d6ZQRIJqSgDdsT7v/bP+qjjflHl1jQ9mDwCF63t1/hu8bHOmNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740587555; c=relaxed/simple;
	bh=dw1wfjrIgg5Yfzrk6knIB6Q7CAuRt+Ztip3fcneRWB0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QpET9Q6wPGLeshIbYrxfOofQKE8yUK+ppJy1sVRhMgymV9t0egsbcu0Y5CKs3Ob7rBh2DE4Fpx+w81oVZQfvT3Lt/tOLZWNZfP63Ks5p6TrdeXb8QmCUx0Fp/Zyx82c4OZhnRYSlJj49xhADb13wypgCMQMoAAk6xVUWHI59EGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tnKKd-0005Fo-3P; Wed, 26 Feb 2025 17:32:23 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tnKKc-002yqg-2M;
	Wed, 26 Feb 2025 17:32:22 +0100
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tnKKc-000CSv-27;
	Wed, 26 Feb 2025 17:32:22 +0100
Message-ID: <5cc5cd05e0a481773212fff0bce574dcfea3f74d.camel@pengutronix.de>
Subject: Re: [PATCH v3] reset: mchp: sparx5: Fix for lan966x
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Horatiu Vultur <horatiu.vultur@microchip.com>, 
	Steen.Hegelund@microchip.com, daniel.machon@microchip.com, 
	UNGLinuxDriver@microchip.com, herve.codina@bootlin.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Wed, 26 Feb 2025 17:32:22 +0100
In-Reply-To: <20250226144645.1950451-1-horatiu.vultur@microchip.com>
References: <20250226144645.1950451-1-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Mi, 2025-02-26 at 15:46 +0100, Horatiu Vultur wrote:
> With the blamed commit it seems that lan966x doesn't seem to boot
> anymore when the internal CPU is used.
> The reason seems to be the usage of the devm_of_iomap, if we replace
> this with of_iomap, this seems to fix the issue as we use the same
            ^^^^^^^^
The is not accurate anymore.

> region also for other devices.
>=20
> Fixes: 0426a920d6269c ("reset: mchp: sparx5: Map cpu-syscon locally in ca=
se of LAN966x")
> Reviewed-by: Herve Codina <herve.codina@bootlin.com>
> Tested-by: Herve Codina <herve.codina@bootlin.com>

Is this still correct?

> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
> v2->v3:
> - forward error from of_address_to_resource
> - use devm_ioremap instead of_iomap
> v1->v2:
> - make sure to use iounmap when driver is removed
> ---
>  drivers/reset/reset-microchip-sparx5.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/reset/reset-microchip-sparx5.c b/drivers/reset/reset=
-microchip-sparx5.c
> index aa5464be7053b..176b3f46e9243 100644
> --- a/drivers/reset/reset-microchip-sparx5.c
> +++ b/drivers/reset/reset-microchip-sparx5.c
> @@ -8,6 +8,7 @@
>   */
>  #include <linux/mfd/syscon.h>
>  #include <linux/of.h>
> +#include <linux/of_address.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/property.h>
> @@ -72,14 +73,19 @@ static struct regmap *mchp_lan966x_syscon_to_regmap(s=
truct device *dev,
>  						    struct device_node *syscon_np)
>  {
>  	struct regmap_config regmap_config =3D mchp_lan966x_syscon_regmap_confi=
g;
> -	resource_size_t size;
> +	struct resource res;
>  	void __iomem *base;
> +	int err;
> +
> +	err =3D of_address_to_resource(syscon_np, 0, &res);
> +	if (err)
> +		return ERR_PTR(err);
> =20
> -	base =3D devm_of_iomap(dev, syscon_np, 0, &size);
> -	if (IS_ERR(base))
> -		return ERR_CAST(base);

It would be nice to add a comment here that devm_of_iomap() can't be
used because the resource is shared with other devices. Do you know
which ones?

Otherwise, this looks good to me.


regards
Philipp

