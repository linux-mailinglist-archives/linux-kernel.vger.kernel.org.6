Return-Path: <linux-kernel+bounces-173841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 540D88C0649
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 23:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC41BB2409B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 21:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E277313248B;
	Wed,  8 May 2024 21:29:18 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BC312BF20
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 21:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715203758; cv=none; b=SEzKaD8PORdxfYMoRZwIObWF7LkZoWAozHtoBY/Lbt+0obeBromhksJnhWpJam2akGXNhu/zIwTDRoVnijXogR07wcsCZsdybQbQ4MjhbL1ZG1rLrupJZLA+0WfcY2QgJlPICD16zTCd8zVuVmH4ibcREjGwIQMfRtmdR8Pjdio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715203758; c=relaxed/simple;
	bh=xeUr75kZnnbSfVzuy78pZvlDf3Ckf0OA3LtMUAVF6c4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uG/mOb5bxuKuKXbPqbzmXoeHUj8yER/l4fGemp854Ka8ExZkmAjR1sIphMtyduhw5sMN3xY14N+tt4aZcgeDq5mtwD7dNt7wkKa8zSdQOzBAFSN6ovBWwe7RzuMczbCQZfGLNvDhhw93yMcWnfJNH4dMpcRuKQDSV7DjrgWvxjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mgr@pengutronix.de>)
	id 1s4oqZ-0002oe-Tu; Wed, 08 May 2024 23:29:07 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mgr@pengutronix.de>)
	id 1s4oqX-000LFt-Rc; Wed, 08 May 2024 23:29:05 +0200
Received: from mgr by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mgr@pengutronix.de>)
	id 1s4oqX-000iXc-2U;
	Wed, 08 May 2024 23:29:05 +0200
Date: Wed, 8 May 2024 23:29:05 +0200
From: Michael Grzeschik <mgr@pengutronix.de>
To: Wesley Cheng <quic_wcheng@quicinc.com>
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	michael.riesch@wolfvision.net, kernel@pengutronix.de,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: dwc3: gadget: create per ep interrupts
Message-ID: <ZjvuoVpVTnEcHRIH@pengutronix.de>
References: <20240507-dwc3_per_ep_irqthread-v1-1-f14dec6de19f@pengutronix.de>
 <518a046b-1056-287b-f505-149958ad9c9c@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Bu/eOJv20AIjpObb"
Content-Disposition: inline
In-Reply-To: <518a046b-1056-287b-f505-149958ad9c9c@quicinc.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--Bu/eOJv20AIjpObb
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 07, 2024 at 11:57:36AM -0700, Wesley Cheng wrote:
>Hi Michael,
>
>On 5/6/2024 4:06 PM, Michael Grzeschik wrote:
>>This patch is splitting up the interrupt event handling from one
>>interrupt thread to separate per endpoint interrupt threads.
>>
>
>I assume that the incentive from doing this is to improve overall=20
>throughput numbers.  Would you be able to share some data on the=20
>benefits of moving to per EP event management?

The main benefit is to make it possible to use high demanding usb
endpoints simultaneously. In our special case we saw that streaming
via uac and streaming via uvc was producing noise in the audio
stream. This was due to the fact, that the isoc feedback endpoint
that would adjust the samplerate was not being called fast enough
when there was heavy a lot of traffic in the uvc endpoint context.

By moving the endpoints into their own thread handlers the short
feedback requests are at least able to be scheduled in between the bursts
of the uvc packages. The next step is to have all threads running on
different cpu cores, without interfering each other. However, as we
still have not matrix irq allocator for arm, there still is no direct
benefit from that yet.


>>To achieve this we create a new dwc3 interrupt domain in which
>>we map all claimed interrupts to individual interrupt threads.
>>
>>Although the gadget layer is preparing the claimed parameter
>>of each usb_ep which could be checked if the endpoint is
>>to used or not, the claimed value was 0 for each ep in gadget_start.
>>This was tested when describing some composite gadget using configfs.
>>
>
>yeah... the claimed flag is cleared by the USB gadget, ie USB configfs=20
>(not sure if you're using this) whenever it adds a USB config.  This=20
>is to handle multi config situations, so subsequent USB configs can be=20
>assigned (resuse) endpoints, since only one config is active at a time=20
>for a USB device.
>
>This was a struggle for me as well when adding the TXFIFO resizing=20
>logic.  We won't actually know which EPs are going to be used until=20
>the host issues the set configuration packet to select a config, and=20
>the set_alt() callback issues usb_ep_enable().  So the implementation=20
>(TXFIFO resizing) is currently based on the maximum potential=20
>endpoints used by any USB configuration.
>
>Not sure if having 31 (potentially) different IRQ entries would be ok,=20
>but maybe it would be simpler to just to request IRQ for dwc->num_eps=20
>always?
>
>Have you tried this on a multi config device?

No, I didn't. I doubt that this will work after your explanation. So
thanks for the insides!

I tried putting the request_threaded_irq into the ep_enable function
but this does not work as I see a lot of schedule while atomic
errors. This is possible as ep_enable is called from an set alt
coming from ep0 interrupt thread context.

So there is probably now no other option left to have exact endpoint
interrupt threads. I will rework this back to request a kthread for each
endpoint even as we will probably would not be using them.

Regards,
Michael


--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--Bu/eOJv20AIjpObb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAmY77p0ACgkQC+njFXoe
LGTmAw//TWDPyBVnUlSATYNkGsDTLyZvMYRB6q2WOFT+d6anJfi621jHOV3b8YMo
oMKhCDRBp7fsxsebpTBzOvQi/wI9J0gDP5W0cQEcvtV8h3xns+HrHFvIpEKuVIJW
4Kn5/fsFhJbM2u9OURjVktAdIrEutctzBbHDYYdJv52BUuXRzCKBi3MLvvV+GRCr
iwWwRTB/DV8ICOTtiQnGVHePtaWTNJ4QWIpSwfSf1p+s/BNqzaxv8ZPt5fc5sQUs
PnVUxunVqWtIRKS/xVyTj2tTpSddaXSBn8VloqMQtnfylSey4+hk1WXdo7cZdhoN
ocGduhXyQtfl7sU8EvFuOUV8tZZ/TYg53Yp6CK+ezrE81uJoBVBRAldRSe0aJMAP
yGcLk+NcBZ6wPqGK7cA9l/vY3FqnGHBrSh9CiWZk+fjxl7Or5u7mFDN4+ktyb3oD
te83upxxWy2V9VHmWNb/GJfaxhFXf5krAyEWDz63vsI4jnzjrk4Buj0RohgCI7qs
TR6OyB+TXIT+cqk3bDF+Rc4y5YY8eBs74tjwTpLw0w0Ed+/7TNvXgnMDOeyy+iLe
yV+vWU66bglUAXqFwUVcLD3WnM/BuD53Ia79GhysUqtlF4w/Z1xDB4EZENZCa/9h
jjgyYsCki1e8GPO+/euvFJVUDQwUSJy1qP1zKA76ECgdSJsJrMg=
=5+Qo
-----END PGP SIGNATURE-----

--Bu/eOJv20AIjpObb--

