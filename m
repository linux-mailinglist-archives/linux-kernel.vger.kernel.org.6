Return-Path: <linux-kernel+bounces-523965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21956A3DD6F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E09C916F726
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 14:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331E31D54CF;
	Thu, 20 Feb 2025 14:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="chPxyl7W";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="tUX07zcQ"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C281D5144;
	Thu, 20 Feb 2025 14:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740063389; cv=none; b=Zf/aG5NdZulYLA1cE49pQ/YOGfb+jC+t7mvzTHD1z+PA4RgQSpPPr7yOnPC4bGzq57n2M3yv4cEn77ja0OdOnjHl8pO/QcEcIzHI2VIHs5MG8Zqays3A90TNoiLyPn64S6wnEcfwWHLidtEpdDNTIUtc0HVXJ4WA3/cOB8WtOdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740063389; c=relaxed/simple;
	bh=iC9yPQyquPxEEH+5Z/jirN5ZPVULrgomJdmlfPFo6Ys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sp3Sfzhx0OQSbkCSISKrapCIUeQQG/EDQumuezadYpgok/iRPN0SoTbaI4NYvdKHKQZ/RIn/VZdIPZOH4yg9ydCAgzv9KWvwQAKUnC/jGT7YUfQW/LiF8wqL3k6uwIhc2MYoetfdJpohHcNbPTSyqvyge7fvtQ6p/xGIpWTyTM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=chPxyl7W; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=tUX07zcQ reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1740063385; x=1771599385;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p+oE9ycbC0603bsKVd233oRRg0AuABTZ4kzML2kwZR8=;
  b=chPxyl7WyR4/LyeOS3PJiRwZLK4gUiQk9n6sVOx1SiDgzcNeYU6cGF5k
   nckZBxXABC0E8RlNgvqzaz+8t6ePf4qZ3JVeShzdpRqsgvJBwiBfUyBGN
   cjrzOq40kQsTHIu6s8HTrdVXsMLiGehVKZg8RdoJQnNAMSqPOzGZAy1bw
   TtWYz+v2Ou90O6i5q8fX9B9PY/o8TJOTYjshkwmhFB1sbVkOEi27QFAPq
   ByyHr5zC57iWOg7Spg6tEe8fz482/q7CPQjYEFnhj1L2bLkGEx7rbD2La
   8NNRldAw123+WtAnOghGbiiurZt4rGpE99lCPWB5Vn8x1uvxNpFOsI2Wv
   w==;
X-CSE-ConnectionGUID: W4HPKULnSKKA4nSjoEUZoA==
X-CSE-MsgGUID: oTh/8wVLRz2R++zgJdaILA==
X-IronPort-AV: E=Sophos;i="6.13,301,1732575600"; 
   d="scan'208";a="41984277"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 20 Feb 2025 15:56:19 +0100
X-CheckPoint: {67B74293-15-EBA888C4-C1AC8B84}
X-MAIL-CPID: 7722C96904D91C2DA0956815BF213B70_0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B86101657D9;
	Thu, 20 Feb 2025 15:56:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1740063375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p+oE9ycbC0603bsKVd233oRRg0AuABTZ4kzML2kwZR8=;
	b=tUX07zcQfsKSY9PuQuU9pNewWK+34vb0xzSyr8Qt4p71UcWvC5mRGH50LmyoTdBaY8/GSu
	zNgdjzdvVuzHu7t4JkEedcoAukN5ghE02JKporcRii18vzoY/pgExznFOfCS2I5sSFQZpu
	s6LRHIlR4ClHIV3MYrbr6UMaLcg2X0jrRERyZ3VSoRPAaRqH/cU92QdI1RnhahcSEKs37o
	oaOqy5Bg6YtRPPSsZyevfhwYr9j5kFa5XSrqf4NIhklNu9RG6e+VxI6AHkVGg5OmRsOGqv
	WUKn7v43jWkUzxQgiHpCIQV/YyQOru6so0LklqqBBZSmGSTDSc/dXoPELiwQSw==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Daniel Baluta <daniel.baluta@gmail.com>
Cc: p.zabel@pengutronix.de, robh@kernel.org, shawnguo@kernel.org,
 linux-arm-kernel@lists.infradead.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
 festevam@gmail.com, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 imx@lists.linux.dev, mathieu.poirier@linaro.org, shengjiu.wang@nxp.com,
 Frank.Li@nxp.com, peng.fan@nxp.com, laurentiu.mihalcea@nxp.com,
 iuliana.prodan@nxp.com, Daniel Baluta <daniel.baluta@nxp.com>
Subject: Re: [PATCH v2 2/8] dt-bindings: dsp: fsl,dsp: Add resets property
Date: Thu, 20 Feb 2025 15:56:13 +0100
Message-ID: <2359786.ElGaqSPkdT@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To:
 <CAEnQRZDU9HoiD9uBNi+inrZcn8KCRp3pUZQfRqaq5kauuxOi6Q@mail.gmail.com>
References:
 <20250219192102.423850-1-daniel.baluta@nxp.com>
 <12614210.O9o76ZdvQC@steina-w>
 <CAEnQRZDU9HoiD9uBNi+inrZcn8KCRp3pUZQfRqaq5kauuxOi6Q@mail.gmail.com>
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

Am Donnerstag, 20. Februar 2025, 14:11:30 CET schrieb Daniel Baluta:
> On Thu, Feb 20, 2025 at 12:37=E2=80=AFPM Alexander Stein
> <alexander.stein@ew.tq-group.com> wrote:
> >
> > Hi,
> >
> > Am Mittwoch, 19. Februar 2025, 20:20:56 CET schrieb Daniel Baluta:
> > > On i.MX8MP we introduced support for using a reset controller
> > > to control DSP operation.
> > >
> > > This patch adds reset property which is required for i.MX8MP.
> > >
> > > Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> > > ---
> > >  .../devicetree/bindings/dsp/fsl,dsp.yaml      | 19 +++++++++++++++++=
+-
> > >  1 file changed, 18 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml b/Doc=
umentation/devicetree/bindings/dsp/fsl,dsp.yaml
> > > index ab93ffd3d2e5..923e7f079f1b 100644
> > > --- a/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
> > > +++ b/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
> > > @@ -82,6 +82,13 @@ properties:
> > >      description:
> > >        Phandle to syscon block which provide access for processor ena=
blement
> > >
> > > +  resets:
> > > +    description:
> > > +      A pair consisting of phandle to audio-blk-control and an index=
 referencing
> > > +      the DSP Run/Stall bit in audiomix registers.
> > > +      See include/dt-bindings/reset/imx8mp-reset-audiomix.h for each=
 index meaning.
> > > +    maxItems: 1
> > > +
> > >  required:
> > >    - compatible
> > >    - reg
> > > @@ -164,6 +171,16 @@ allOf:
> > >              - const: txdb1
> > >              - const: rxdb0
> > >              - const: rxdb1
> > > +  - if:
> > > +      properties:
> > > +        compatible:
> > > +          contains:
> > > +            enum:
> > > +              - fsl,imx8mp-dsp
> > > +              - fsl,imx8mp-hifi4
> > > +    then:
> > > +      required:
> > > +        - "resets"
> > >
> > >  additionalProperties: false
> > >
> > > @@ -220,5 +237,5 @@ examples:
> > >                 <&mu2 3 0>;
> > >        memory-region =3D <&dsp_vdev0buffer>, <&dsp_vdev0vring0>,
> > >                        <&dsp_vdev0vring1>, <&dsp_reserved>;
> > > -      fsl,dsp-ctrl =3D <&audio_blk_ctrl>;
> > > +      resets =3D <&audio_blk_ctrl IMX8MP_AUDIOMIX_DSP>;
> >
> > Am I missing something here? fsl,dsp-ctrl is used to get the regmap fro=
m syscon.
>=20
> fsl,dsp-ctrl was used to control the DSP. This functionality for
> imx8mp have been now replaced by
> using the reset controller.
>=20
> The example where the diff happens is for imx8mp so for this reason I
> changed it to use the
> new way of doing the rest.

Okay, maybe add another example for 8ulp then.

Best regards,
Alexander
=2D-=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
http://www.tq-group.com/



