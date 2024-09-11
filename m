Return-Path: <linux-kernel+bounces-325389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6319975908
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 19:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FD8C288B8F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 17:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24781B0131;
	Wed, 11 Sep 2024 17:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="D/BokM6d"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F621AED41
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 17:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726074379; cv=none; b=AAhMlFeK53yr1t8L/tq5HKO3I+/yep5t9ycPornSIIEVB6jMC+sux6BrvB4Dzw1TjTBAix6SLRPS2DNdm5AOAqeOOS3a9i2faT8Wc8QUGxSnAEBNYqnSN+uG+rfu26QTYnVtdfvmhZOLEQ+iTOmyGa60RVlAvXsAVpZwJ8uPmJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726074379; c=relaxed/simple;
	bh=dKgWX6EapLt16fjrOqAJw7HZ940fYMwsui8Zx6v9XEY=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jtEyUtd9bZFTfwxt3p7ZtwQ47/QE95h0i6hS6BhmzkyQwG9iPl4Z9axjKsAVM1SQI6bU+Z0o1feIWC855AkJgMNXWfJ8gs8M9AYZ2h/XXP6QsRqyQjXfI8slT3c9Dg3K9b4aiNKrL1sp4iL0vUpjPMSg9RL50riu2g7Ed/guEk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=D/BokM6d; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 46CBB1C009C; Wed, 11 Sep 2024 19:06:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1726074367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=mFqY0KFyY732AACwjM7MDX9A4GXUTowlDA1UQTO14I0=;
	b=D/BokM6dk3zWeleVseiu4n6rGtx/zZAzbc407rmfrnUA7EQzk0ODzPUujYGaO1uwE9ZhA2
	hbnn0tQQKnlfJZbAh9JX2QxutydJ37NebmrgsNPeRJoaHKabELkEJFjpaRaBgSzQy4srtn
	0aFz+d6orCDgQAZKdkO2XMEtTVVk5Ec=
Date: Wed, 11 Sep 2024 19:06:06 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: Severe weather before Open Source Summit Europe
Message-ID: <ZuHN/sPfbQp8acrM@duo.ucw.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ldJlDx0zCOAT5nl2"
Content-Disposition: inline


--ldJlDx0zCOAT5nl2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I realize this is not strictly development related, but I guess some
of the readers will go to OSS EU.

This week, we have some rather severe weather predicted for east of
Czechia. ("In the period from Thursday 12. 9. to Sunday 15. 9. (total
for four days) are expected extreme precipitation, mostly above 300
mm.") Austria should not be affected as badly, and it is all
predictions for now, but if you plan to travel through Czechia,
well... there may be a little too much water around.

The water will not simply disappear, so flooding will move
downstream in the days after that. Parts of Austria are downstream of
Czechia, as are parts of Germany.

https://meteoalarm.org/en/live/warning/406902d3-4c95-4b61-908a-7ee4523199f6=
/97f6f345-872b-4e99-be62-93e84d4eee0c?t=3Dday3#list

If you plan to travel by land, you may want to check weather / flood
status before the trip. Travel by boat is not recommended :-). It is
all predictions at the moment, but it is starting to rain...

Best regards,
                                                                Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--ldJlDx0zCOAT5nl2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZuHN/gAKCRAw5/Bqldv6
8jDsAKCg14v71GzCd/TjCSIxFaahg3ncYACgrOr633f3nXDyVvLx18xUj6+9BHU=
=0HlM
-----END PGP SIGNATURE-----

--ldJlDx0zCOAT5nl2--

