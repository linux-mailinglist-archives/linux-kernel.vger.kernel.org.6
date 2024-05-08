Return-Path: <linux-kernel+bounces-173380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4F48BFFAD
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 16:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA904B27557
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 14:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ABE885658;
	Wed,  8 May 2024 14:01:37 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1918E85293
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 14:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715176896; cv=none; b=iO+GKA7VbshtHy7r8B0ys3aY6DWqgFLFFx7nDCdx3PJU3lefebQ67rAV6QRKjdgmlvRyf3YuuL1A2yu0mXp5GdAMIFWFqilmKmTlbaY/lwfL4x422XHwOE4DW2EgUB9tLp/DvjVuoMQL8tlLcaSkDfHkchR1MaxCSXiRAdeYQ0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715176896; c=relaxed/simple;
	bh=IV0S5XgdXVZYhr4uGixNKYowOT2aO4wKgjnXQUn9W1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ojQI0YEcoak9qYwd+c7J7ZpMdnZR2LtniB+HULZ0PTg454DSsDp6bks/TyqNB5cr0jmPoJ2rECmmQA4AemViPc/2lh0ixyblZdGNHg5xwy4aAPH5JEx6UrbwYwGN3dPjFttqAlfT2fEy6hQjzmwR2y7GWO99q2G6ojQ3faQYxJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1s4hrO-00071d-U7; Wed, 08 May 2024 16:01:30 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1s4hrO-000HkG-H7; Wed, 08 May 2024 16:01:30 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1s4hrO-000ZqS-1R;
	Wed, 08 May 2024 16:01:30 +0200
Date: Wed, 8 May 2024 16:01:30 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Bjorn Andersson <andersson@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel@pengutronix.de, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] samples: qmi: Convert to platform remove callback
 returning void
Message-ID: <ealrtx5jnk43tt47rvjyipj2vr7f6noau44p5mw74invmb23oj@wvbovzbx54tt>
References: <d30beb557e0e97ea194028f62d3c4c10841d3e7c.1709886922.git.u.kleine-koenig@pengutronix.de>
 <g5iy5jov5uufi4oxdfgagqln6odwgdilrbbhsg3lkdidkvybbg@qbmsipcojt4t>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="m4oghvifu5wblbtt"
Content-Disposition: inline
In-Reply-To: <g5iy5jov5uufi4oxdfgagqln6odwgdilrbbhsg3lkdidkvybbg@qbmsipcojt4t>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--m4oghvifu5wblbtt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Bjorn,

On Fri, Apr 12, 2024 at 02:20:12PM +0200, Uwe Kleine-K=F6nig wrote:
> On Fri, Mar 08, 2024 at 09:51:21AM +0100, Uwe Kleine-K=F6nig wrote:
> > The .remove() callback for a platform driver returns an int which makes
> > many driver authors wrongly assume it's possible to do error handling by
> > returning an error code. However the value returned is ignored (apart
> > from emitting a warning) and this typically results in resource leaks.
> >=20
> > To improve here there is a quest to make the remove callback return
> > void. In the first step of this quest all drivers are converted to
> > .remove_new(), which already returns void. Eventually after all drivers
> > are converted, .remove_new() will be renamed to .remove().
> >=20
> > Trivially convert this driver from always returning zero in the remove
> > callback to the void returning variant.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>=20
> This patch didn't receive any feedback yet, I guess because I used an
> old email address for Bjorn. I updated the address for this mail now.
>=20
> Would you consider applying this patch; please tell me if I should
> resend.

I intend to change struct platform_driver after the upcoming merge
window. So if this patch doesn't go in, please accept me sending it
together with the actual change to struct platform_driver to Greg.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--m4oghvifu5wblbtt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmY7hbkACgkQj4D7WH0S
/k7ugggAjUAp2rVIn3jp5rWIgRqZKk++gUBBMI67muZgf3E7t6W4M62OivR9Frli
ChqbfrudlzqZMhSnx0mWEBCqVC/Em9/YAdT9VSr6+sPH/WhZ8XcoqGh6aGLt/4rM
YYeoOKar8liBdHvP9rrWlSkDgLxzI6hJwvJmbkDMooFBT9yObNzeNUl622R4erNb
LUXp+RE6txHZ3Z8ru6P0VJHmytUm33QYXs9ziLu1iQFOFOvWuhCTvRgcKtCnIzz+
0oM2o7YlclU/YRwttHPjabum8jITp03UMEeJeE8rtFL+eaj9Mn3N0jpFI39jnVxt
HaG2ut+4A6c+KwnqdhWLmsshQH9bGQ==
=Mtim
-----END PGP SIGNATURE-----

--m4oghvifu5wblbtt--

