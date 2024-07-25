Return-Path: <linux-kernel+bounces-261971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF0093BECF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 11:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D16FE1C213B8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 09:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C322E198845;
	Thu, 25 Jul 2024 09:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="wgXe2iLw"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1092197559
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 09:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721898846; cv=none; b=AmB1b5vTrNytuAjTrNaxEZKg8ETBC4qH7nMDXotbw+4+hpBkp9jnfoJ6CT5JWTNry3K3VHfFArvxes4qVUtt9daRSEcO2a6gaWkgwtCMZ+MCC54DDwODNmDi4J0KlVtVSelBkMVzKfHhtLWWZCU8cFDOF1MGuhtP/cyU1N2+sCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721898846; c=relaxed/simple;
	bh=udl5LjHEcSA9ybzRnuheOsQzwD8ouVKu2jbaxP7TeJE=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=lph6c4rQmHAtUs1VGE4FjM+h2n+U4diHHyYKz+l+alQZJFR4TFDl3ZtijKoEa0PR6XkDD6Y5J8UjKpppUxNQpwn7g1XmGaQNfdj0tLMgaS85htkLAJ0HzCXO3jwo1Fi2C8UVBgA0X9duOIQBrTkMnr1DDu/Mpz4hDNzOq7cJPN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=wgXe2iLw; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (cpc89244-aztw30-2-0-cust6594.18-1.cable.virginm.net [86.31.185.195])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id CF31645B;
	Thu, 25 Jul 2024 11:13:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1721898792;
	bh=udl5LjHEcSA9ybzRnuheOsQzwD8ouVKu2jbaxP7TeJE=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=wgXe2iLwDpVM8w4vfGOyysqwBicSVJHdd/4z0P2sJdBv/mGWgz+1KxaYmSgGCeA/A
	 W9nPcPgBAV4RhMFLS6b9X0AtVw2e3K9D/q1rpHCLSv+DXHnhj39NwUn/4EIt/JUjw9
	 U95GzaQ6bQODCAg0ZKwi0CDVfa7d7QfO+QvBUAWc=
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <48989a76-f2b0-4cbc-80f0-bfd0d4c44bcb@collabora.com>
References: <20240723185856.92814-1-robert.mader@collabora.com> <4rkbs3adnnxalbi237u5anydgm326nvu2ztgiyzufpl6r23vc5@d345nvc4zdqc> <48989a76-f2b0-4cbc-80f0-bfd0d4c44bcb@collabora.com>
Subject: Re: [PATCH] media: i2c: imx355: Parse and register properties
From: Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc: linux-kernel@vger.kernel.org, jacopo@jmondi.org, sakari.ailus@linux.intel.com, javierm@redhat.com
To: Jacopo Mondi <jacopo.mondi@ideasonboard.com>, Robert Mader <robert.mader@collabora.com>
Date: Thu, 25 Jul 2024 10:13:54 +0100
Message-ID: <172189883420.392292.18276116110750673176@ping.linuxembedded.co.uk>
User-Agent: alot/0.10

Quoting Robert Mader (2024-07-24 21:17:23)
> Hi Jacopo,
>=20
> thanks for the quick review!
>=20
> Should I send a v2 for that (adding V4L2_CID_CAMERA_ORIENTATION and your =

> RB to the commit message) - and if so should I first wait for more=20
> reviews or is that unnecessary/unlike to happen?

Reviews are usually slow, but this found it's way into my inbox because
of a libcamera mention :-D (I do appreciate lore/lei for topic based
subscriptions!)

I don't think theres a specific need to wait for further reviews, but
this might make it easier for you to send a v2 and know it's done ;-)

Reviewed-by: Kieran Bingham <kieran.bingham@ideasonboard.com>

>=20
> Regards,
>=20
> Robert
>=20
> On 24.07.24 09:31, Jacopo Mondi wrote:
> > Hi Robert
> >
> > On Tue, Jul 23, 2024 at 08:58:56PM GMT, Robert Mader wrote:
> >> Analogous to e.g. the imx219. This enables propagating
> >> V4L2_CID_CAMERA_SENSOR_ROTATION values so that libcamera
> > and V4L2_CID_CAMERA_ORIENTATION
> >
> >> can detect the correct rotation from the device tree
> >> and propagate it further to e.g. Pipewire.
> > Well, yes, that's a consequence. As long as Linux is concerned, this
> > serves to register the two above mentioned controls.
> >
> >> Signed-off-by: Robert Mader <robert.mader@collabora.com>
> > Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
> >
> > Thanks
> >    j
> >
> >> ---
> >>   drivers/media/i2c/imx355.c | 12 +++++++++++-
> >>   1 file changed, 11 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/media/i2c/imx355.c b/drivers/media/i2c/imx355.c
> >> index 7e9c2f65fa08..0dd25eeea60b 100644
> >> --- a/drivers/media/i2c/imx355.c
> >> +++ b/drivers/media/i2c/imx355.c
> >> @@ -1520,6 +1520,7 @@ static const struct v4l2_subdev_internal_ops imx=
355_internal_ops =3D {
> >>   static int imx355_init_controls(struct imx355 *imx355)
> >>   {
> >>      struct i2c_client *client =3D v4l2_get_subdevdata(&imx355->sd);
> >> +    struct v4l2_fwnode_device_properties props;
> >>      struct v4l2_ctrl_handler *ctrl_hdlr;
> >>      s64 exposure_max;
> >>      s64 vblank_def;
> >> @@ -1531,7 +1532,7 @@ static int imx355_init_controls(struct imx355 *i=
mx355)
> >>      int ret;
> >>
> >>      ctrl_hdlr =3D &imx355->ctrl_handler;
> >> -    ret =3D v4l2_ctrl_handler_init(ctrl_hdlr, 10);
> >> +    ret =3D v4l2_ctrl_handler_init(ctrl_hdlr, 12);
> >>      if (ret)
> >>              return ret;
> >>
> >> @@ -1603,6 +1604,15 @@ static int imx355_init_controls(struct imx355 *=
imx355)
> >>              goto error;
> >>      }
> >>
> >> +    ret =3D v4l2_fwnode_device_parse(&client->dev, &props);
> >> +    if (ret)
> >> +            goto error;
> >> +
> >> +    ret =3D v4l2_ctrl_new_fwnode_properties(ctrl_hdlr, &imx355_ctrl_o=
ps,
> >> +                                          &props);
> >> +    if (ret)
> >> +            goto error;
> >> +

In the future (definitely not here) I hope there will be a way for us to
factor out all of this common code from sensor drivers to make things
more consistent.


> >>      imx355->sd.ctrl_handler =3D ctrl_hdlr;
> >>
> >>      return 0;
> >> --
> >> 2.45.2
> >>
> --=20
> Robert Mader
> Consultant Software Developer
>=20
> Collabora Ltd.
> Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
> Registered in England & Wales, no. 5513718
>

