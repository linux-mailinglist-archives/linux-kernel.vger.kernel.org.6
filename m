Return-Path: <linux-kernel+bounces-412405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE25F9D08B1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 06:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 667931F21747
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 05:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B5613C9A9;
	Mon, 18 Nov 2024 05:14:33 +0000 (UTC)
Received: from sundtek.de (sundtek.de [85.10.198.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB14126C1C
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 05:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.10.198.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731906873; cv=none; b=lpLvFstuZF2DB7KeIGwb+JBW78oEroF4KKy1Lki4miXBV+wO4//xduCN8oFdpy+KzRjvWE4BfRMjqCoLUy9srCld4kvYwDsX/TtMSaP+TN3yP6qxoXFYU0KZebaMc6YRz+4YyS3PNQjYuSmzIwnDKtgp5Xffwd/QZp4jY3DC1oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731906873; c=relaxed/simple;
	bh=QENXeW/sJ1ZIGrsu67Dxc0YkIdtz94gfQCpiSJmi1mc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nKjRDugxaxBbIYeJ70dmRiF6tR1MfPEK8csHQt+tMPafdro3SEsfAngEpfm9cNGBiwRFmxz5i30oRqunNa7rY6ovymgzRXndOtgidoUeMpawZbznRO4bFjHvKMos7QJkUnqK8EXoinogM/QOPEw6m/rzrnvUjTWqID5p0MWR8Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sundtek.de; spf=pass smtp.mailfrom=sundtek.de; arc=none smtp.client-ip=85.10.198.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sundtek.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sundtek.de
Received: from Debian-exim by sundtek.de with spam-scanned (Exim 4.95)
	(envelope-from <linuxusb.ml@sundtek.de>)
	id 1tCu5j-0006LQ-LC
	for linux-kernel@vger.kernel.org;
	Mon, 18 Nov 2024 06:14:29 +0100
Received: from 1-175-135-24.dynamic-ip.hinet.net ([1.175.135.24] helo=[192.168.2.197])
	by sundtek.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <linuxusb.ml@sundtek.de>)
	id 1tCu5W-0006Kq-F5;
	Mon, 18 Nov 2024 06:14:14 +0100
Message-ID: <f34636ebeda843de9329ac0aa4ec51c6627a0e5c.camel@sundtek.de>
Subject: Re: Highly critical bug in XHCI Controller
From: Markus Rechberger <linuxusb.ml@sundtek.de>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 18 Nov 2024 13:14:09 +0800
In-Reply-To: <dff9f24a-4aa2-45aa-920f-20876cf4ccbf@rowland.harvard.edu>
References: <3905c1c88695e0ffcfabf700c06dd7223decef8d.camel@sundtek.de>
	 <dd4239c7b0538e1cd2f2a85307c73299117d5f0e.camel@sundtek.de>
	 <50f730ae-4918-4dac-88ec-b3632bee67e7@rowland.harvard.edu>
	 <35c051354414ae9ef6e6b32b1a15a5dedf471176.camel@sundtek.de>
	 <dff9f24a-4aa2-45aa-920f-20876cf4ccbf@rowland.harvard.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: linuxusb.ml@sundtek.de
X-SA-Exim-Scanned: No (on sundtek.de); SAEximRunCond expanded to false



On Sun, 2024-11-17 at 16:02 -0500, Alan Stern wrote:
> On Sun, Nov 17, 2024 at 11:47:52PM +0800, Markus Rechberger wrote:
> > On Sun, 2024-11-17 at 10:18 -0500, Alan Stern wrote:
> > > On Sun, Nov 17, 2024 at 08:44:16PM +0800, Markus Rechberger
> > > wrote:
> > > > Basically the issue comes from hub_port_connect.
> > > >=20
> > > > drivers/usb/core/hub.c
> > > >=20
> > > > hub_port_init returns -71 -EPROTO and jumps to loop
> > > > https://github.com/torvalds/linux/blob/master/drivers/usb/core/hub.=
c#L5450
> > > >=20
> > > > I'd question if usb_ep0_reinit is really required in loop which
> > > > is
> > > > running following functions:
>=20
> > This should only go down there in case an error happened earlier
> > no?
>=20
> Of course, since -EPROTO indicates there was an error.

Alan, first of all thank you for your feedback.

Do you know any practical way how to test this?

>=20
> > In case the hardware signed up correctly it should not even enter
> > that
> > code.
> >=20
> > My experience is just - reconnect the device in case an error
> > happened
>=20
> You can't reconnect some devices; they are permanently attached.=C2=A0
> There=20
> are other reasons why reconnecting might not be practical.


I understand what you mean here but isn't it primarily about downsizing
USB 2.0 -> USB 1.1?
The next point would be if eg. an endpoint of a webcam downsizes to 1.1
you don't have to expect a workable device because video would exceed
the bandwidth easily.
Do you know any practical example/hardware where this is really
relevant?

The failure handling will call the xhci reset which is not meant to be
run without fully initialized data structures. In my case the driver
returns -EPROTO (while the device is already disconnected), then first
of all it tries to reset the endpoint which in the upstream kernel
causes the NULL PTR exeption. For XHCI this code stream logic is simply
not meant to be applied in such an error.
My first submitted patch will solve the issue but just papers a higher
logic issue.=20

>=20
> > those
> > workarounds did not work properly for the device I deal with (but
> > yes
> > that's
> > why I'm asking - maybe someone else has different hardware with
> > different
> > experience).
>=20
> I doubt we will hear from these people, because they will not realize
> that anything was wrong.
>=20
> In any case, it is generally recognized that the type of errors
> leading=20
> to -EPROTO (bad CRC or no response, for instance) can be temporary or
> intermittent.=C2=A0 Retrying is an appropriate strategy.
>=20
> > > > As a second issue I found in usb_reset_and_verify device=20
> > > > https://github.com/torvalds/linux/blob/master/drivers/usb/core/hub.=
c#L6131
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D hub_port_init(pa=
rent_hub, udev, port1, i,
> > > > &descriptor);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret >=3D 0 || ret =
=3D=3D -ENOTCONN || ret =3D=3D -ENODEV) {
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
break;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > >=20
> > > > hub_port_init can also return -71 / -EPROTO, the cases should
> > > > be
> > > > very
> > > > rare when usb_reset_and_verify_device is triggered and that
> > > > happens.
> > >=20
> > > If that happens, the loop which this code sits inside will simply
> > > perform another iteration.=C2=A0 That's what=C2=A0 it's supposed to d=
o, not
> > > an=20
> > > issue at all.
> > >=20
> >=20
> > It doesn't cause any issue yes but it's not correct either.
>=20
> Why not?=C2=A0 What's wrong with it?
>=20
> > -EPROTO will be returned if I disconnect or short the device here.
> > So
> > initially someone
> > thought he should check for -ENODEV/-ENOTCONN (which should also
> > indicate that=C2=A0the=C2=A0device is gone), so -EPROTO should also be
> > checked in
> > that case.
> > Otherwise just remove all those error checks.
>=20
> -EPROTO does not necessarily indicate the device is gone; it
> indicates=20
> there was a problem communicating with the device.=C2=A0 The problem migh=
t
> be=20
> caused by a disconnection, or it might be caused by temporary=20
> electromagnetic interference (for example), or by something else.


a bad CRC response on a short cable -  something has gone very wrong
then.
If there are temporary EMI issues ... I'd consider that an as an a
absolute failure as well, they
need to be handled in HW rather than a software workaround.

In my experience with USB anything that is a 'temporary' failure can be
considered as 'permanent' failure and I've really seen a lot over the
last 1 1/2 decades.
However issues are mostly related to immature controllers / missing
quirks for some controllers.
Our devices in the field since 2008 usually pump around 100-300mbit
through the USB 2 link,
streaming  devices which usually run for a long period of time (up to
months / years).
'retrying' something on a link where something has gone wrong for sure
never worked properly for me, it would have continued with another
followup issue at some point.

I'm definitely in favor of telling the user if something went wrong
either reconnect or submit a bug report for that particular device to
add some quirk for special handling.

Anyway can you give a particular example where this 'retrying'
mechanism and reloading the endpoint size solves or solved a problem?
Over the years people will certainly forget why this was implemented
and take the code 'as is'
and the next ones will just say it was always like that don't change.
I don't mind keeping it as it is but it should be more clear / obvious
why it's really done that
way.

Markus
>=20
> Alan Stern
>=20


