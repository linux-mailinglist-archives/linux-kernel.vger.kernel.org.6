Return-Path: <linux-kernel+bounces-181356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC6F8C7AEC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 19:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B209B21BCA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 17:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2221A1553B1;
	Thu, 16 May 2024 17:13:19 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE492154BF0
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 17:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715879598; cv=none; b=aAb8IHGcSVdhrJqjFcrDgg3LZnLZqsAkbuIg46Mwv+d2vSWDSV5f0aFMCbtioRwUDLCBw8Cf/u5JwaPJLhW5yBN5aBco5FgPQ11X+VVKfPJvn8yDHGCZTpDxEkMdI+VkED7+2ltOOQIZLHW7+5utK2kuC1qsHoD3hmfsQIrVufU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715879598; c=relaxed/simple;
	bh=Ntp9s3ZQjej96T2DegVyNKETmpnMIscSNouwatw/mIA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JCBlZmilI+XBDFW4yPuwfEaRmK0cjxxdxiFr/Ty+EEa0yN9dvUCuLVPhW63eEcoXvUs0GA8bl1AKm3kgu381O/ADvQVF2nH5pL8gtZTxm6sALLwkaG+vswzXIqUsfSl1qjFwvSmpBegts2w3o325yWJjc7K6JP/Y5VDfX5eSa4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <l.stach@pengutronix.de>)
	id 1s7efD-0005Hj-LM; Thu, 16 May 2024 19:13:07 +0200
Message-ID: <2c5b62e0898efc61da7bec7a261d10e89ccd4a1e.camel@pengutronix.de>
Subject: Re: [PATCH] drm/etnaviv: drop driver owner assignment
From: Lucas Stach <l.stach@pengutronix.de>
To: Christian Gmeiner <christian.gmeiner@gmail.com>, Krzysztof Kozlowski
	 <krzysztof.kozlowski@linaro.org>
Cc: Russell King <linux+etnaviv@armlinux.org.uk>, David Airlie
	 <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 16 May 2024 19:13:06 +0200
In-Reply-To: <CAH9NwWfU5eaBRSqhgJgHwgphtL+KUAiX3Tx_7vO11N_BV7qUQQ@mail.gmail.com>
References: <20240330205241.92711-1-krzysztof.kozlowski@linaro.org>
	 <CAH9NwWfU5eaBRSqhgJgHwgphtL+KUAiX3Tx_7vO11N_BV7qUQQ@mail.gmail.com>
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

Am Montag, dem 01.04.2024 um 12:26 +0200 schrieb Christian Gmeiner:
> >=20
> > Core in platform_driver_register() already sets the .owner, so driver
> > does not need to.  Whatever is set here will be anyway overwritten by
> > main driver calling platform_driver_register().
> >=20
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>=20
> Reviewed-by: Christian Gmeiner <cgmeiner@igalia.com>

Applied to the etnaviv/next branch.

Regards,
Lucas

>=20
> > ---
> > =C2=A0drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 1 -
> > =C2=A01 file changed, 1 deletion(-)
> >=20
> > diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/et=
naviv/etnaviv_gpu.c
> > index 734412aae94d..87b31cfee41d 100644
> > --- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> > +++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> > @@ -1995,7 +1995,6 @@ static const struct dev_pm_ops etnaviv_gpu_pm_ops=
 =3D {
> > =C2=A0struct platform_driver etnaviv_gpu_driver =3D {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.driver =3D {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0.name =3D "etnaviv-gpu",
> > -               .owner =3D THIS_MODULE,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0.pm =3D pm_ptr(&etnaviv_gpu_pm_ops),
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0.of_match_table =3D etnaviv_gpu_match,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0},
> > --
> > 2.34.1
> >=20
>=20
>=20


