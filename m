Return-Path: <linux-kernel+bounces-268825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C0F9429E9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 11:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7B1E1F25A3C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 09:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDEE91A8C0C;
	Wed, 31 Jul 2024 09:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lNnil4Fr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3721CF93
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 09:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722416733; cv=none; b=ok+qjarss0RUnidHstjvovQ94tkNmJEckRO+RlB/LoYlggrVxwmaW9xVvQLZlvYexlJI7AAGK/u4zDqy5tA6Ka4dw1fJTZVprdZ16QDN8+bQQnnKEVYdNsrMkzwfKjxZPr75aRbVNGN6g4LhEw/FD4CRkjqy15/5l4rjmdlDWcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722416733; c=relaxed/simple;
	bh=Ro4CC/zSYrlt8z3sidPNEcI48aXkedqmjE5LzRyUuc8=;
	h=Content-Type:Date:Message-Id:To:Subject:Cc:From:References:
	 In-Reply-To; b=Sm+BkAK7vrIK2cho7O4VAcWLpVawIUOE2MaMWj7qAYKY7217FF5m/mqUPKhMwS0xo+ouF9+yf4DvixeN79MHM6MapiWxpqgVXfGyIjezoft0XD4HqZbOOEp1YYIfKWhpN/jlPgmkMIf+Ck7bRwrxv8v5VkWb2GPFyE70ThJO5RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lNnil4Fr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48621C116B1;
	Wed, 31 Jul 2024 09:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722416732;
	bh=Ro4CC/zSYrlt8z3sidPNEcI48aXkedqmjE5LzRyUuc8=;
	h=Date:To:Subject:Cc:From:References:In-Reply-To:From;
	b=lNnil4Frb6ubY61aIf2jrWlCfiW4+FZl8q0jReeFJ7CeE4otqLrMOVibeAycl2c2B
	 qnvaYdh4ElzYcf39Xo1dMNlfLwa6FnRHkAlsb1N36PFPHKWVkBy2UXkTT3v+dw2iSn
	 kyf79udDQrXEzHuYh5/KOtPeVY/5Ae0MblgAWC427B44r8YQyORcKiDC3Jk2OzUV/B
	 E2kp6nC8jTG1IrwzIuQsK0xL5eUh44nNxJzUdeGJZsmlF+DLrZNhAqnIfl+TwFykSD
	 FD+CclK0cgZw6ruECELkV0VAqWcae2RPqiHwKVxDHQ4BaBeKKhvTjoNZmepC76upaY
	 PuDdL6uLOhZTw==
Content-Type: multipart/signed;
 boundary=8eb6641bb0e6348999b81d72124475a06d92e862735b04c092571de7dbda;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Wed, 31 Jul 2024 11:05:28 +0200
Message-Id: <D33LRTJ8BE0T.2EQJ1MGLG2NUS@kernel.org>
To: "Tudor Ambarus" <tudor.ambarus@linaro.org>, "Brian Norris"
 <computersforpeace@gmail.com>
Subject: Re: [PATCH] mtd: spi-nor: micron-st: Add n25q064a WP support
Cc: <linux-mtd@lists.infradead.org>, "Miquel Raynal"
 <miquel.raynal@bootlin.com>, "Pratyush Yadav" <pratyush@kernel.org>,
 "Richard Weinberger" <richard@nod.at>, "Vignesh Raghavendra"
 <vigneshr@ti.com>, <linux-kernel@vger.kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
X-Mailer: aerc 0.16.0
References: <20240726185825.142733-1-computersforpeace@gmail.com>
 <D32OADQF733D.3CVS3ZRPEBL2O@kernel.org>
 <454deacb-88cc-4ab0-80b4-006d863a56d2@linaro.org>
 <CAN8TOE8-9=P7p8Tkc+5kG5Sqan+RAWAc7k2VH-p5W9hR-bb_Xg@mail.gmail.com>
 <0685ef1b-b0e1-4c53-94dc-4d5de5be8e94@linaro.org>
In-Reply-To: <0685ef1b-b0e1-4c53-94dc-4d5de5be8e94@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--8eb6641bb0e6348999b81d72124475a06d92e862735b04c092571de7dbda
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

> >> Also, if you care, would be good to extend the SPI NOR documentation o=
n
> >> how one shall test the Block Protection.
> >=20
> > That sounds tougher. I don't know that there's really a standard
> > toolset for handling protection -- I guess the 'flash_{un,}lock'
> > utilities in mtd-utils qualify, but they aren't even packaged by
> > relevant distros (e.g., OpenWrt; but I guess they're in Debian). I
> > typically use flashrom, since that's what ChromiumOS uses, and it's
> > available in OpenWrt -- would that be an OK basis for docs?
>
> yes, why not. At least for people using OpenWrt.

We really need some kind of dump the relevant registers here. I have
some very old patch, which dumps the status register, but is has
it's own quirks. But IMHO we should (maybe additional to the
functional tests) look at the locking bits in the corresponding
registers. I.e.
 flash_lock foobar
 <verify the status register>
 flash_unlock foobar
 <verify the status register>
 flash_lock barfoo
 <verify the status register>
 etc.

Just inferring the correctness from behavior (exercised by writing
to the flash and verifying it) will lead to errors as it is hard to
catch all the corner cases.

From what I remember, flashrom has it's own drivers in userspace,
no?

-michael

> >=20
> > It's also highly conditional on what sort of range(s) the flash
> > supports. So it's almost like we might want a programmatic
> > write-protection test suite as part of mtd-utils/tests/, rather than a
> > bespoke narrative document. Which ... is getting a little larger than
> > I signed up for.
> >=20
>
> Some test in mtd-utils would be good indeed, but narrative shall be also
> ok for now. What I fear is that people just use just a flash lock/unlock
> all sectors test, which is not ideal. We shall also test locking on some
> sectors from the top and bottom, to verify the correctness of the TB
> bit, check if BP3 is working by locking some sectors in that area.
> Haven't looked at the BP area in a while, but you get my point, I feel
> testing is not ideal and a guideline would help.
>
> If you ever feel that you can spend some time on this, help is appreciate=
d.
>
> Thanks,
> ta


--8eb6641bb0e6348999b81d72124475a06d92e862735b04c092571de7dbda
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCZqn+WRIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/hbjgF/azqKN63u2DSxmAd/moICUxZu0hxP/IMk
NK9Pg9o7rQzcRs9Tzlbg/vM2L1jMHH3EAYDeLMwp2vCdyHy+eDz4n6aHbXccFpZg
yRnA4yWXxSi9l5WC4r+Zs/e4qxPHF6bIUDU=
=u2j1
-----END PGP SIGNATURE-----

--8eb6641bb0e6348999b81d72124475a06d92e862735b04c092571de7dbda--

