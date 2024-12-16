Return-Path: <linux-kernel+bounces-447429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F337F9F3226
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 15:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71B0216700E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 14:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35F4205AD6;
	Mon, 16 Dec 2024 14:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kIiEfrtf"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA11FF9DA;
	Mon, 16 Dec 2024 14:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734357769; cv=none; b=urC1XqntdE/ESgsJJ6bHliBHu2TZyTiSy3neeNhFJVZTdQi5LLRY154Dk6CfWCcjF4tmilBtDmga9Q6gephvLns+5/3uzvKxOKgs9MiWfj+rUAgbSKEZrUlxaNxr0FaH5TD3KzL8w1T5SNuhnP4GCVOf2fIzKI+mqh/w1Kd64RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734357769; c=relaxed/simple;
	bh=UpednncarOQ8uK9wD0CLma7myJeHPhCom6wqghlcoQ8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=ZR0NF6AnTNWx/FbrZn9uGM5OUWNkSWnEUEAPTD3yfbfR8p+SI56jaT+c6no7Y1dcvqUdB3+qcFl8KwHOEfZVREN6+RpFsWdn2OJeRURDfooX3PB7emM4ZpYYeUQkDjF8BefYt/69TmP/A0vOyZbkAhATi3xE4zsTjgi6izLgPfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kIiEfrtf; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 55484C0008;
	Mon, 16 Dec 2024 14:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1734357764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nsC82Wd9lmhMc2NXzvbxJLGnofV5wKYtTRbR551/o5c=;
	b=kIiEfrtfzMWUuA0roxlDj4ymfnC3HZWYW3Wmn26dipReYS+XJ8NMS0mG+ibMjXcta0D+cI
	ZfDipGxIEY6C9LRlMI47/F79h9n5KOKRa+HUOieiUFx1E4m3UqMcRaWYRosjO+zu3dDoqv
	SyI28SdB4oI3/uurYKFAj6zBd6oSJBpNipheV12EjL3ZbayGBC+AAk5Y5s4g216BXjyn7a
	IC2s+QcBG8RXg0AScGTeeQQn1cnIDrZfHWFUMNRhghEc11mKx/AfUwbgGpLZgWF5JeVa6s
	mprOI3LEG8ZyRZ5PXvpSZd7oavPsGxo6nTmYr93iduJOp9IvWAfq8vTBsSl11Q==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Dec 2024 15:02:43 +0100
Message-Id: <D6D6IL1RNGA8.3U3GIJQJX2L3J@bootlin.com>
Cc: "Pawel Laszczak" <pawell@cadence.com>, "Roger Quadros"
 <rogerq@kernel.org>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Mathias Nyman" <mathias.nyman@intel.com>, =?utf-8?q?Gr=C3=A9gory_Clement?=
 <gregory.clement@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, <linux-usb@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Peter Chen" <peter.chen@kernel.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH v6 2/5] usb: cdns3-ti: run HW init at resume() if HW was
 reset
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20241210-s2r-cdns-v6-0-28a17f9715a2@bootlin.com>
 <20241210-s2r-cdns-v6-2-28a17f9715a2@bootlin.com>
 <20241214084940.GA4102926@nchen-desktop>
In-Reply-To: <20241214084940.GA4102926@nchen-desktop>
X-GND-Sasl: theo.lebrun@bootlin.com

On Sat Dec 14, 2024 at 9:49 AM CET, Peter Chen wrote:
> On 24-12-10 18:13:36, Th=C3=A9o Lebrun wrote:
> > At runtime_resume(), read the W1 (Wrapper Register 1) register to detec=
t
> > if an hardware reset occurred. If it did, run the hardware init sequenc=
e.
> >=20
> > This callback will be called at system-wide resume. Previously, if a
> > reset occurred during suspend, we would crash. The wrapper config had
> > not been written, leading to invalid register accesses inside cdns3.
> >=20
> > Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> > ---
> >  drivers/usb/cdns3/cdns3-ti.c | 25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> >=20
> > diff --git a/drivers/usb/cdns3/cdns3-ti.c b/drivers/usb/cdns3/cdns3-ti.=
c
> > index d704eb39820ad08a8774be7f00aa473c3ff267c0..d35be7db7616ef5e5bed7db=
d53b78a094809f7cc 100644
> > --- a/drivers/usb/cdns3/cdns3-ti.c
> > +++ b/drivers/usb/cdns3/cdns3-ti.c
> > @@ -188,6 +188,12 @@ static int cdns_ti_probe(struct platform_device *p=
dev)
> >  	data->vbus_divider =3D device_property_read_bool(dev, "ti,vbus-divide=
r");
> >  	data->usb2_only =3D device_property_read_bool(dev, "ti,usb2-only");
> > =20
> > +	/*
> > +	 * The call below to pm_runtime_get_sync() MIGHT reset hardware, if i=
t
> > +	 * detects it as uninitialised. We want to enforce a reset at probe,
> > +	 * and so do it manually here. This means the first runtime_resume()
> > +	 * will be a no-op.
> > +	 */
> >  	cdns_ti_reset_and_init_hw(data);
> > =20
> >  	pm_runtime_enable(dev);
> > @@ -232,6 +238,24 @@ static void cdns_ti_remove(struct platform_device =
*pdev)
> >  	platform_set_drvdata(pdev, NULL);
> >  }
> > =20
> > +static int cdns_ti_runtime_resume(struct device *dev)
> > +{
> > +	const u32 mask =3D USBSS_W1_PWRUP_RST | USBSS_W1_MODESTRAP_SEL;
> > +	struct cdns_ti *data =3D dev_get_drvdata(dev);
> > +	u32 w1;
> > +
> > +	w1 =3D cdns_ti_readl(data, USBSS_W1);
> > +	if ((w1 & mask) !=3D mask)
> > +		cdns_ti_reset_and_init_hw(data);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct dev_pm_ops cdns_ti_pm_ops =3D {
> > +	RUNTIME_PM_OPS(NULL, cdns_ti_runtime_resume, NULL)
>
> Why only runtime resume, but without runtime suspend?

I don't see any situation where we would want "runtime suspend" be
equivalent to "reset the cdns3 wrapper". It implies losing child
states, triggering rediscovery of all USB devices at resume. Is that a
desired property of runtime suspend on any discoverable bus?

Sidenote: also, in our implementation, we do the standard thing of using
pm_runtime_force_suspend|resume() as suspend callback implementations.
With that, if we did reset the wrapper at suspend, we would:
 - always have to rediscover USB devices at resume and,
 - break wakeup sources.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


