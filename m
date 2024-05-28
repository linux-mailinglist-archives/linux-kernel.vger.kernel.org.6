Return-Path: <linux-kernel+bounces-192219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F708D1A39
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 13:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 623FEB255D1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 11:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC4D16C841;
	Tue, 28 May 2024 11:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="kZrDN7Hs";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="jn5/LwSM"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16A216ABE4
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 11:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716897031; cv=none; b=FDTbxNBbXoYpdaeVX2/9qGzoiJO/K0zf1t7F0vX3KDo1RNBVwI5kkhFpM0KElTMSutkR2Or6ll/tnOGrq03ek2K+N/6qiFpQdEz9/9pP6GhAPgDnSEJlpjiTLHoXbA2avb2vkSW78nWuyzG2IsS1GUEOXn1NwIl/ojkBkyfPF+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716897031; c=relaxed/simple;
	bh=McgWi6uyNI53NhifrEHGTgiMU4g/id++r0i7AzU8SbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LtDK/1h7FmyHdROWF6v9KRQI40bos2gCBOnrlnH9z5Zds4pQV+Ua7KUHGbPmgn+HTlYh2GTKQAXxYoSMO3fXqD55ylO/GcNoG15VPB5n15GJR8WEVgOJ4qBvJYKcvv8hf9LTCu1h+E9WGeMnaM/baAV2CZ2Dwrl2d4EAYIsHmpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=kZrDN7Hs; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=jn5/LwSM reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1716897027; x=1748433027;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/58gdiJpM0B3ImJiCbj+KqJdGf8LvDGPhKIR6a6hhbM=;
  b=kZrDN7Hsm4Z/nYi2ZPn5XtX18d7eVg6wLK2r7TrAPCbzAyCf494S4J+m
   3as9JVkCQtEl+10XnX/lw3yJAvENyWZjJ4HmE89Na+qcpkmvG20ddwfwB
   FH8cKb6fKDRIytDaXEWDNFIgpRdXiPxux0TZz1DPBX2tRVSnTwRir63w1
   PjiE9dTPGOdOOE/dvIpAtnEl72LJyfasbVU15vqRd0GeLCDod3LlpI3Yh
   KcvuUL6oanf53AIe4eFDLhYbSCKYrZiK9AV1/qAqQLLkJp8EUFsjCbn2u
   kw6p/ShbullEXx66H4yQjs7gJquNd2YrxY5jUYcm0MrHy9JDaiCqUz7J4
   Q==;
X-CSE-ConnectionGUID: PrY+tUZASFe3HnFpq9Lp/A==
X-CSE-MsgGUID: tuuXUIU6TLKb2D2PbQRM3w==
X-IronPort-AV: E=Sophos;i="6.08,195,1712613600"; 
   d="scan'208";a="37103537"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 28 May 2024 13:50:20 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1413D163F66;
	Tue, 28 May 2024 13:50:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1716897010;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=/58gdiJpM0B3ImJiCbj+KqJdGf8LvDGPhKIR6a6hhbM=;
	b=jn5/LwSMBdGE+BWjDxi0RR5faA1n+uSIqWJBNMw2n68YARuq3DbPhFy9cv9LpHRQy7b4mr
	3EyI+S3oMDZ1RJpbKokB2tD1kimPMkGYiAtLn8SHRLscQKrriuwoccm8p8nPevD/C+7DSE
	40FCnqHIPl6ZeVqdxKr3kxMwd1tcqN7hAZseS/96c3iYd8HvlhxMe6usl6aNb/WOkXLNb+
	zSQxEXBBYuxSVjTOgLljprQOvEvlEXa7ngGODLpFjVmnlSIHsfDgdKds2SFSe7BELkAPM/
	PKgDTUwI60WgyP6ScfOBU36jHZQ1WSKniQUjJJEuNRryo0K3TzxBzz/GvwlTUA==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Liu Ying <victor.liu@nxp.com>
Cc: dri-devel@lists.freedesktop.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] drm/bridge: imx93-mipi-dsi: Use dev_err_probe
Date: Tue, 28 May 2024 13:50:07 +0200
Message-ID: <2814548.mvXUDI8C0e@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <40bc3142-c7be-4dfc-a2ff-6ac209112aa6@nxp.com>
References: <20240528093922.194684-1-alexander.stein@ew.tq-group.com> <40bc3142-c7be-4dfc-a2ff-6ac209112aa6@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Last-TLS-Session-Version: TLSv1.3

Hi,

thanks for your feedback.

Am Dienstag, 28. Mai 2024, 12:02:29 CEST schrieb Liu Ying:
> On 05/28/2024, Alexander Stein wrote:
> > Although very unlike to occur (media_blk_ctrl needs 'syscon' compatible
> > removed), it lines up with the other error paths in probe function.
> >=20
> > Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > ---
> >  drivers/gpu/drm/bridge/imx/imx93-mipi-dsi.c | 8 +++-----
> >  1 file changed, 3 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/bridge/imx/imx93-mipi-dsi.c b/drivers/gpu/=
drm/bridge/imx/imx93-mipi-dsi.c
> > index 2347f8dd632f9..8331db3b4f054 100644
> > --- a/drivers/gpu/drm/bridge/imx/imx93-mipi-dsi.c
> > +++ b/drivers/gpu/drm/bridge/imx/imx93-mipi-dsi.c
> > @@ -841,11 +841,9 @@ static int imx93_dsi_probe(struct platform_device =
*pdev)
> >  		return -ENOMEM;
> > =20
> >  	dsi->regmap =3D syscon_regmap_lookup_by_phandle(np, "fsl,media-blk-ct=
rl");
> > -	if (IS_ERR(dsi->regmap)) {
> > -		ret =3D PTR_ERR(dsi->regmap);
> > -		dev_err(dev, "failed to get block ctrl regmap: %d\n", ret);
> > -		return ret;
> > -	}
> > +	if (IS_ERR(dsi->regmap))
> > +		return dev_err_probe(dev, PTR_ERR(dsi->regmap),
> > +				     "failed to get block ctrl regmap");
>=20
> Missing \n.
>=20
> And, a build warning:
> drivers/gpu/drm/bridge/imx/imx93-mipi-dsi.c: In function =E2=80=98imx93_d=
si_probe=E2=80=99:
> drivers/gpu/drm/bridge/imx/imx93-mipi-dsi.c:837:13: warning: unused varia=
ble =E2=80=98ret=E2=80=99 [-Wunused-variable]
>   837 |         int ret;
>       |             ^~~
>=20

Nice catch. Thanks. I'll send v2 tomorrow.

Best regards,
Alexander
=2D-=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
http://www.tq-group.com/



