Return-Path: <linux-kernel+bounces-274415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3195B9477E0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 11:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6783B22A4B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 09:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5913154433;
	Mon,  5 Aug 2024 09:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G9JtxPbF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CCC15380B
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 09:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722848473; cv=none; b=qXRUAl2CHsmivwxq2Vq5ufnUcDCakVeIPvuYUguFAM+7HXYHVzqn1fK7UtgXnbGJxbRqgsolU3pFkXV5AQacryZnikCQKEhWynHDRT/bEb32ShGJU9yXLphL6YOlu18bYH070LxTWFbISHahVvabncvm/NAmeAEthlqZl2yHF08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722848473; c=relaxed/simple;
	bh=/9hl84gQd3/SwOJQ4KQR8ASh8B9epxHOoZ459l4GyK0=;
	h=Content-Type:Date:Message-Id:Subject:Cc:From:To:References:
	 In-Reply-To; b=ivWMaU/GooFFS2yNkPmVGg0J2lmkhJENnJTKXMLMG6lFMDMhBqAbnrkSJW8k/jSuZl8vl+vcyLxW4htHj5rJw/BLsDAVyJgCg773vYR2ZUHw2RnxowE1STYLOoGweGCGHBIYd3q3xeBefBh3jd7wKi5Jl8rBRCqqqq09JH1Mm3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G9JtxPbF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E86BC4AF0D;
	Mon,  5 Aug 2024 09:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722848473;
	bh=/9hl84gQd3/SwOJQ4KQR8ASh8B9epxHOoZ459l4GyK0=;
	h=Date:Subject:Cc:From:To:References:In-Reply-To:From;
	b=G9JtxPbFHX62rM/hMHDwnJyIw6FOP3T6QQo4PD3F1XqzOMUMSaKthamJPzon6p3Me
	 r+l0doJUgsQ8l14BlrGrAbgxlB9qcrLOlFcbwJm9PL5+LcKqlkVP6PVl8pg55ZXaTm
	 PrndtZSnrdx+TunNJ7RNMJ4/ZZT9y4FPnXeP+0FRuosbEDvNahEVhKatRySeDYMaol
	 8FNQN4PJWXQVdaGVUonh+V6HQi9UWktwmL3SAUnInr6O9WL6RnuMqq92+98DLrEcHK
	 4fDJew4tUhDBFCCZdJCZioHbCr5NdZbFOn/ooaoJ7sE0Eniq71ZkokHUm+p3OtxwRy
	 jZux3C1LTCKoA==
Content-Type: multipart/signed;
 boundary=39b3f79ce120f1030ba7edc1580bb2b21bb064927d8a128b2d0f6eb0e883;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Mon, 05 Aug 2024 11:01:09 +0200
Message-Id: <D37UT8JYBDX1.2OURSPGD336B1@kernel.org>
Subject: Re: [PATCH] mtd: spi-nor: micron-st: Add n25q064a WP support
Cc: "Tudor Ambarus" <tudor.ambarus@linaro.org>,
 <linux-mtd@lists.infradead.org>, "Miquel Raynal"
 <miquel.raynal@bootlin.com>, "Pratyush Yadav" <pratyush@kernel.org>,
 "Richard Weinberger" <richard@nod.at>, "Vignesh Raghavendra"
 <vigneshr@ti.com>, <linux-kernel@vger.kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Brian Norris" <computersforpeace@gmail.com>
X-Mailer: aerc 0.16.0
References: <20240726185825.142733-1-computersforpeace@gmail.com>
 <D32OADQF733D.3CVS3ZRPEBL2O@kernel.org>
 <454deacb-88cc-4ab0-80b4-006d863a56d2@linaro.org>
 <CAN8TOE8-9=P7p8Tkc+5kG5Sqan+RAWAc7k2VH-p5W9hR-bb_Xg@mail.gmail.com>
 <0685ef1b-b0e1-4c53-94dc-4d5de5be8e94@linaro.org>
 <D33LRTJ8BE0T.2EQJ1MGLG2NUS@kernel.org>
 <CAN8TOE--TYg8r8qCd_HAZ_w2+wRSPF6RUAuK3g-Po5QPVXdRLQ@mail.gmail.com>
In-Reply-To: <CAN8TOE--TYg8r8qCd_HAZ_w2+wRSPF6RUAuK3g-Po5QPVXdRLQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--39b3f79ce120f1030ba7edc1580bb2b21bb064927d8a128b2d0f6eb0e883
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

> > We really need some kind of dump the relevant registers here. I have
> > some very old patch, which dumps the status register, but is has
> > it's own quirks. But IMHO we should (maybe additional to the
> > functional tests) look at the locking bits in the corresponding
> > registers. I.e.
> >  flash_lock foobar
> >  <verify the status register>
> >  flash_unlock foobar
> >  <verify the status register>
> >  flash_lock barfoo
> >  <verify the status register>
> >  etc.
>
> I don't actually think that would be a very good test. It would be
> testing the implementation more than the functionality. What do you
> "verify" in the status register? Would the test just re-implement the
> swp.c protection-range logic? And notably, this omits *all* checks
> that the protection register actually protects from anything (write,
> erase).
>
> Or maybe I'm misinterpreting what you mean.

No that's what I've meant. Maybe I'm having another perspective and
I'm biased because of that, but I'm really not trusting the software
layer, esp. not when it comes to flash locking. Because most of the
time this involves the "very last resort recovery" on our products.
So we really have to ensure the flash is locked and therefore, one
*must* look at the corresponding bits in the hardware (using the
simplest method possible). The beauty of the lock bits is that if
you know they are set, there is nothing software can do to write or
erase these sectors. Once you know all the bits are set correctly,
you can just skip the write/erase/read test.

> > Just inferring the correctness from behavior (exercised by writing
> > to the flash and verifying it) will lead to errors as it is hard to
> > catch all the corner cases.
>
> Why would that lead to errors?

Ever tried to lock two different ranges after another? Or unlock a
smaller range than the one that is currently locked? IIRC, that
should work. But I've never tried it myself. Or just locking (parts)
of a smaller partition (i.e. an mtd device which doesn't cover the
whole spi flash).

> It should be relatively easy to:
>
> 1. enumerate the supported protection ranges (MEMLOCK / MEMUNLOCK
> ioctls on known-likely ranges, looking for EINVAL return codes)
> 2. iterate through all such ranges; for a given range:
> 2(a). erase the whole flash
> 2(b). write the whole flash with a known pattern
> 2(c). read the whole flash
> 2(d). ensure that the expected-protected range remains 0xff
> 2(e). ensure that the expected-unprotected range contains the known patte=
rn

Not sure 2(a) will work or if some flashes will reject the chip
erase command if some sectors are locked. To sidestep this I guess
you should use the smallest possible erase (i.e. ususally the 4k
erase opcode).

But yeah, once this is all in place you can probably do that with a
tool, otherwise it's really tedious work and doing it by hand is
error prone.

> I suppose step #1 can be tough, because the full slate of possible
> protection ranges is technically ... enormous. But "likely" ranges are
> much fewer, with a few power-of-2 patterns, top/bottom, and maybe some
> "both top and bottom" ranges on some flashes? Anyway, like I said in
> my other reply, this should take on the order of 60 minutes on some
> flashes, which is expensive but not prohibitive.

Well we support 4 block protection bits and one TB bit. So there are
2^5 different configurations?

-michael

> > From what I remember, flashrom has it's own drivers in userspace,
> > no?
>
> Yes, and that's all rather ugly. But it also has a linux_mtd backend
> since a few years back:
>
> https://review.coreboot.org/plugins/gitiles/flashrom/+/HEAD/linux_mtd.c
>
> Brian


--39b3f79ce120f1030ba7edc1580bb2b21bb064927d8a128b2d0f6eb0e883
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCZrCU1RIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/hSxgGAt69h5Yor03kSvbs95kOS0BWCwy6nCBJK
AZ6IQ3p/fdUD2daoju7HC/4Pf7yIFP0iAXoC2DgCm8PICAbscuEgVW42burOLSZ7
1XzurCNGAkDkCSHRuDx5kpQYGSuHMUybqBk=
=oDFf
-----END PGP SIGNATURE-----

--39b3f79ce120f1030ba7edc1580bb2b21bb064927d8a128b2d0f6eb0e883--

