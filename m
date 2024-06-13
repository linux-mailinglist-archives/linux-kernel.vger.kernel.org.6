Return-Path: <linux-kernel+bounces-213085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62529906AE8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 13:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8663B2179F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 11:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC88D142E99;
	Thu, 13 Jun 2024 11:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="hbVeMKrJ"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F200713C9DE
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 11:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718277786; cv=none; b=J0jlCVTOWBGi6jwHeTY0CKDnYQRWMhrCfze0Ub/4Pi1HPZCA96Crrd6UAkSVdYP8dk9pKifdlAkUfcN9KbNKx/3GbjEAo0424KfTv7ruK4g993xeJ2s/mMIDt3elww2sIEfWhEAqJQLOdGD7Q7y5i13SFACNTI1etcC0imp7oW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718277786; c=relaxed/simple;
	bh=CDyNStZ50/nTcxN8ymQWd9ggFhJ6lu1rYVQY4z6nbQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jv0hzEdwElWp7mN3d3HjjHnmKMjCd/xJNAFpIgCciG9bKVHufBzv8Yl3UYHNQdmYX4H4LwKB004m31VbHD0iDAfnj9DPya93Pqwig72p5UIUWrMCbqoW5oWJiKxFK4TX8b8nIo+3ffRvq2op9vysuqRCV0sSNjRxyu0cxBGF5KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=hbVeMKrJ; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 4331A1C0082; Thu, 13 Jun 2024 13:23:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1718277782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DMzo8GPEsm06S3emcaw3hI99WSQx/4NdFDt55Ih5P4Y=;
	b=hbVeMKrJ93oi3atxOde0i3ihAU0Cax1a0a+sIIpRVrjNjHPEe7o1O8ESCkAhhd+45S2Z2J
	jRvCyHiePTgEweGMZo9VE4SmyPKfuRrkeOqXpWcphHMZe1e7s2iSowJPl90CA+Q1jkJDbw
	5HdJ9jLc28oJ9UWpRLgiFg0m6YHKUDI=
Date: Thu, 13 Jun 2024 13:23:01 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Artem S. Tashkinov" <aros@gmx.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Takashi Iwai <tiwai@suse.de>,
	Stas Sergeev <stsp@users.sourceforge.net>,
	Vsevolod Volkov <home+kernel@vvv.kiev.ua>
Subject: Re: PC speaker doesn't work under Linux, works in GRUB/EFI
Message-ID: <ZmrWlflQxZa0rdv1@duo.ucw.cz>
References: <186367bb-9ed4-42de-add2-59d3f50ec170@gmx.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JidO8v5d520oD7f5"
Content-Disposition: inline
In-Reply-To: <186367bb-9ed4-42de-add2-59d3f50ec170@gmx.com>


--JidO8v5d520oD7f5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 2024-06-02 12:53:26, Artem S. Tashkinov wrote:
> Hello,
>=20
> There's a bug filed in the kernel bugzilla where Vsevolod is unable to
> figure out why he cannot make his pc speaker work under Linux:
>=20
> https://bugzilla.kernel.org/show_bug.cgi?id=3D218918
>=20
> Strangely, it works just fine as an EFI module and a GRUB module.
>=20
> What are the ways to debug the issue?

Is PC speaker even expected to work under linux?
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--JidO8v5d520oD7f5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZmrWlQAKCRAw5/Bqldv6
8ndeAKCldggASaBdopEBSXepw7RNcKk4GQCeJJGe1NPMOWXCop/o353nZM/Swc0=
=wBSl
-----END PGP SIGNATURE-----

--JidO8v5d520oD7f5--

