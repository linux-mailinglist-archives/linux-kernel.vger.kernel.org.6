Return-Path: <linux-kernel+bounces-402013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B73469C223F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 17:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78C07287FBF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 16:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A162192D97;
	Fri,  8 Nov 2024 16:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="wvuCdy/Y"
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47706167DB7
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 16:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731083891; cv=none; b=urM9Up5LOw+HrhbxJj63xyoOIxKjTDifaJwll3Sby5BiziQ8rzPJb/3zZdRTNwv+5v1Kht/rwuBwWOJ13kwsWtc6JkyB0snnmoOv6OPrrKyNc95F/AmbTYeRURciUYvd3iNdWaMU4dba0qK0ebwA8p5D7wZuyj7D3oqcKO2K1zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731083891; c=relaxed/simple;
	bh=cX52sRS6FW3d71KiB+Z72yKhmMW3ZWSIUkmzYzcDwIc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=F6wTOkOY8WkgDimFo3/j5eZbo8AvNXGSvyhls+4fGvKK89hRJ4AkULfmaS0GimGuS6pTu+nt3CqEwZRHdjrTGW4RBHv0u8lzxbHtr1sJBzkcYvXSuDbfXYzX4+AltQWyGft0a1GBYDVEkcniKuuNonDeFu2AJVZFw0wZptTHb30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=wvuCdy/Y; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1731083886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y8isQ+eC1NBDJ85mhmgiRP01XgjT4qvdr3jwt+UY19g=;
	b=wvuCdy/YsQr5y2ZLd7wKdSKLnnl9GdvdfoZrAkccd2PyafwFPUA5adoDCjZ0A2W0ehzRdu
	QyWalDT08pxaTLAk3zchX7qLvtLa2fTTAGrUwABmQ88jbZl6/P7Yp/6RofZUJzni1JZpMx
	/hJ84YXohGcqC4Ul/QvWzE4juichAa3wz0l72E0w7Sp3SXUEU4YpoBz9tbnuZZO9yj7T8D
	+UUtjE85ItWVYdfZ4yGC2LGisf6PrGQ2OW8aXy0m1/ZDpa3CRhCVVntYe+qKbb+bUJLoO+
	sxksUg6DJ9RR/+CiD26PqZ3X66Jg9ZmKloCi2N/Ytf2/fbSslOltMB2xQURPAw==
Content-Type: multipart/signed;
 boundary=342aba1a373c0c1c659dff9cb9078d09b156ee41058742d4af8979a7c0b6;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Fri, 08 Nov 2024 17:37:51 +0100
Message-Id: <D5GY0NXYFLS9.1YHBZ5502R764@cknow.org>
Cc: <dsimic@manjaro.org>, <andy.yan@rock-chips.com>,
 <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <linux-kernel@vger.kernel.org>, "Heiko Stuebner"
 <heiko.stuebner@cherry.de>
Subject: Re: [PATCH] drm/rockchip: dsi: convert to dev_err_probe in probe
 function
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 <linux-rockchip@lists.infradead.org>, <dri-devel@lists.freedesktop.org>
References: <20241108144425.1009916-1-heiko@sntech.de>
 <D5GWE4WJZMM8.1MPHPPQR2QW46@cknow.org> <3594835.iIbC2pHGDl@diego>
In-Reply-To: <3594835.iIbC2pHGDl@diego>
X-Migadu-Flow: FLOW_OUT

--342aba1a373c0c1c659dff9cb9078d09b156ee41058742d4af8979a7c0b6
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Fri Nov 8, 2024 at 5:31 PM CET, Heiko St=C3=BCbner wrote:
> Am Freitag, 8. November 2024, 16:21:24 CET schrieb Diederik de Haas:
> > On Fri Nov 8, 2024 at 3:44 PM CET, Heiko Stuebner wrote:
> > > From: Heiko Stuebner <heiko.stuebner@cherry.de>
> > >
> > > DRM_DEV_ERROR is deprecated and using dev_err_probe saves quite a num=
ber
> > > of lines too, so convert the error prints for the dsi-driver.
> > >
> > > Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
> >=20
> > Should this have a Fixes tag?
> > Because in the PineTab2 case it reported an error, which was actually
> > just a deferred probe.
>
> A deferred-probe is an error ;-)   -517 in fact  ... just that convention
> nowadays is to not actively report on it but "fail" silently.

Good to know, thanks :)

> So personally I don't really consider it a fix, but more a style thing.
> I guess I'll let others chime in for that.

Then I agree that it should not have a Fixes tag.

Cheers,
  Diederik

--342aba1a373c0c1c659dff9cb9078d09b156ee41058742d4af8979a7c0b6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZy4+ZgAKCRDXblvOeH7b
bm7IAQDlu5u1RUaHveltxvLYbs1Lkju/X4N1ZMHhqsGMKvP6MwEApHelYqAyAA1h
JBDYWaKldiIhOrBuZQvjbtUN4ic/EQQ=
=BFts
-----END PGP SIGNATURE-----

--342aba1a373c0c1c659dff9cb9078d09b156ee41058742d4af8979a7c0b6--

