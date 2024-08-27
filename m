Return-Path: <linux-kernel+bounces-304066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F005E96196F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 23:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30020B21CE2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 21:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD901D365B;
	Tue, 27 Aug 2024 21:51:15 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E8F13B293
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 21:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724795474; cv=none; b=Xx7gE5IZZt3okkBvs9rdIU5maThxwHHEC2VU2RyOADKb2YGdX5WiKOFw2QBfOgn0oYJHdg+gOnW43Mqtt/o/W5GFpqRpuYzpn21MpaBg9hIE1wIp8XL+ogzreMI+hFCKM4Lx6ZPhot3qZFha3U/v3bXr1wSNqxtHyYBnHmSZwNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724795474; c=relaxed/simple;
	bh=QJ99Z/hOF+NMBrD7AHcyx395awrT076ifVBo98TdqxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u38Pk2e8/k/JJbsExUG41eVvpqG4h/IiN2MXZ+a4osKyIhnKR1fFdCAGFO0nHu6Sqq/VYBRKmAKJLEDggfnJX9zbZetDrINv+0Pf4cPzfp4LTdJ7oGqhYf9t0SzEiyibSPr4naHt+pMQMoQykmhk30eWogPvq4MV5BbeALnyT40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mgr@pengutronix.de>)
	id 1sj45k-00039p-Hm; Tue, 27 Aug 2024 23:51:08 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mgr@pengutronix.de>)
	id 1sj45k-003WWr-36; Tue, 27 Aug 2024 23:51:08 +0200
Received: from mgr by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mgr@pengutronix.de>)
	id 1sj45j-0094p7-3C;
	Tue, 27 Aug 2024 23:51:08 +0200
Date: Tue, 27 Aug 2024 23:51:07 +0200
From: Michael Grzeschik <mgr@pengutronix.de>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-kernel@vger.kernel.org,
	Daniel Scally <dan.scally@ideasonboard.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Avichal Rakesh <arakesh@google.com>, linux-usb@vger.kernel.org,
	linux-media@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Mark UVC gadget driver as orphan
Message-ID: <Zs5KSxkNiFuoTrId@pengutronix.de>
References: <20240813104447.25821-1-laurent.pinchart@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7/l6Kwp3E/JabG5g"
Content-Disposition: inline
In-Reply-To: <20240813104447.25821-1-laurent.pinchart@ideasonboard.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--7/l6Kwp3E/JabG5g
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 01:44:47PM +0300, Laurent Pinchart wrote:
>I haven't had time to maintain the UVC gadget driver for a long while.
>Dan Scally confirmed he is also in a similar -ENOTIME situation with no
>short term hope of fixing that. Being listed as maintainers doesn't help
>progress, so mark the driver as orphan to reflect the current state.
>
>Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>---
>Dan, could you please ack this patch ?
>
>Michael, feel free to take over if you want. You have been active on the
>code base recently, so that makes you the best candidate, even if I
>disagree with most of your technical decisions. I'm a bit sad to leave a
>driver I cared about without trust in its future, hopefully the future
>will prove I was wrong.

This is really sad to hear. For now I will not take over maintenance
since I for myself am unsure about the time that will be available in
the future for this project.

I understand that the path that I took to get the uvc driver working is
not to your liking. Although we did never had some proper discussion how
to tackle the obstacles that are obviously in the way since you know the
spec better.

For now the users are stuck to the v4l2sink backend which highly depends
on the v4l2 ioctls. But as long we can not properly tell the OS that
this is an limited v4l2 device which mostly using the vb2 api to share
buffer data, it seems legit to just implement these callbacks and use
them. Your mentioned "doubtful" progress which is not as invasive IMHO.

However regarding the uvc-gadget project I think it still is the way
to go and should be used to implement the state and workflow of e.g. the
uvcsink gstreamer element and other applications wanting to stream via
the uvc gadget.

I for now am happy that the code is working smooth enough to properly
fill the video pipeline. While only implementing parts of the uvc spec
for now.

So the next steps from my POV would be to rework the uvcsink to use the
libusbgadget instead of the v4l2sink defaults and implement all missing
parts that are currently working in the libusbgadget so it will be an
drop in replacement.

Parallel to that it should be clear what parts of the v4l2 framework
are really necessary and we could think of some kind of flag to tell the
userspace that this device is limited so that e.g. v4l2-compliance
would not even worry testing it. And with that the implemented callbacks
that will then not be needed anymore can be safely removed.

Thanks,
Michael

>---
> MAINTAINERS | 4 +---
> 1 file changed, 1 insertion(+), 3 deletions(-)
>
>diff --git a/MAINTAINERS b/MAINTAINERS
>index 8766f3e5e87e..e6df197f1a58 100644
>--- a/MAINTAINERS
>+++ b/MAINTAINERS
>@@ -23819,10 +23819,8 @@ F:	drivers/media/usb/uvc/
> F:	include/uapi/linux/uvcvideo.h
>
> USB WEBCAM GADGET
>-M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>-M:	Daniel Scally <dan.scally@ideasonboard.com>
> L:	linux-usb@vger.kernel.org
>-S:	Maintained
>+S:	Orphan
> F:	drivers/usb/gadget/function/*uvc*
> F:	drivers/usb/gadget/legacy/webcam.c
> F:	include/uapi/linux/usb/g_uvc.h
>
>--=20
>Regards,
>
>Laurent Pinchart
>
>

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--7/l6Kwp3E/JabG5g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAmbOSkkACgkQC+njFXoe
LGSGow/8DG9t6VpoP2vTXIwkw0kTtJmIQqbR5gIDYK5qxjfkjYwDiNtJ3OhNFCPt
ddHzGW8iojihSx/aBl0BnNXdbzFodCOMA9sI4XQwA6Jh5NudGN7eoc6lip2NSCMF
7HVg+41h9ruaEa8FrzeMZ2dhr/hjUFlTvK8jxmQJNyvRexZ/ypieEcWqt0fXTjlC
fPLdacfPxWSnse5IJWq3bb9eI+Rq+q9ZIOwFvN9SYYLpIET0+ONU+RSDTxHIM4Hv
GRzRacR0pJuTxiJ7O+0hAh5PwQP2TXEhMlEwhU3Ws6161ktTWtwgYRI5ixZQrfb4
KdeFjsdaP9A9yE85dJDxxkrngaAVTAcUX93V++3ROqUIhUfrKjCC5dDCQ/69Vs2G
Sj8qsWMBgnHnyS5uTsQKiFdGoqVCmdjOe7wQptQgNa1isxzuaTqizSzEUmHEx69G
mDXT7cAMFGp+luxak75Y2LBtozjve6NCP84HuVshZe/cOxoAI4alXTb0BgI+Sssq
v1aPI4Sg7LnW2Lr6+eTeHxqkbEwyCeDVEDbWdToq1AIyuMb8lEu9wzq2qmhcUjK0
7PoPgY4/D6KG2qTr0bWrdH/r2qHZ3hDVrej5mIkg8BJXQasFHPE03r7I/I0Hmv5i
OgjaI9BqSogtDn23y18gY8xoxW+GZd+3rFnbwzx25aFjSLYb86Q=
=kqdW
-----END PGP SIGNATURE-----

--7/l6Kwp3E/JabG5g--

