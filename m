Return-Path: <linux-kernel+bounces-425273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04EA69DBFB8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 08:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDD96281AC9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 07:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A097157A5A;
	Fri, 29 Nov 2024 07:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="VCHrfQup"
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7A145C14
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 07:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.28.40.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732864960; cv=none; b=FG3Je5LlfFPU8e4jr/08pV6pWTNXLkkvoqf0b3EFJtN/ivFl9exE9g1Lr00MZVECLxho/JjaeTGL0Fm7jQ3uHkssjxiUQ2utbB3Xjf1oscAcMI0jj1eBlYkUhSSIDj1okQpruMHpimkIcWxm1iHt7JGi7APxYinPiyED9jroQPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732864960; c=relaxed/simple;
	bh=hs1yApbpDZL/oadtYLt4c89Vl0iVNqyoVARy+SVs+dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CsWTpMgYhRXAppBMrtgr+opA5LcHaMDlO5rB2PPbTRTZPq3/U+VMADoX05srNJPhbtZXBsFSIUWb9UjECzEDujUqNF3RZHCcNB9zv1UBkai78IQHeVDyKLS+nAUeWE+CBOVMWBTq/TukpXgMF/kNr6EG/Hubhi+wR3O1luCMA9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz; spf=pass smtp.mailfrom=nabijaczleweli.xyz; dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b=VCHrfQup; arc=none smtp.client-ip=139.28.40.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabijaczleweli.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202405; t=1732864625;
	bh=hs1yApbpDZL/oadtYLt4c89Vl0iVNqyoVARy+SVs+dg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VCHrfQupxOGuub2qScBmyNXW+ib85ei1VhIsNl9MTsJMGL83ykvs1L8UvOJh+swxn
	 4MBa3TrL8D5wk0jPduEl2AJO9hnTche+NvQuX6mOR25Kic/w2XxuavDlqNabjQSaE5
	 GkJPSPqd+tLvuzY/gTOwgcOKaA+Swua6Zqo0u0lHDviYGwC/Cp5V5km7YewTzJsibt
	 Va7ZuiiQytwlG+FRwyF3iyv41/l65HbhEcq23jogGIqNyn9em15sO4HwnHM1jWnikt
	 BM7hKQ4WFdJcABvld0xQ+Mkb5vAYkxwslvK40RHt16dji7tT8Is/l5Z4Xt0DQ8F2jy
	 RqbJ4KrxADRCw==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 656839CB0;
	Fri, 29 Nov 2024 08:17:05 +0100 (CET)
Date: Fri, 29 Nov 2024 08:17:05 +0100
From: =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To: Rui Ueyama <rui314@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Wislist for Linux from the mold linker's POV
Message-ID: <enqsr7otef2osf5kmxwlf56y2jegiggiusbzklqxmkd4puk3rq@tarta.nabijaczleweli.xyz>
References: <CACKH++baPUaoQQhL0+qcc_DzX7kGcmAOizgfaCQ8gG=oBKDDYw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fmewhgv2r7hsugjw"
Content-Disposition: inline
In-Reply-To: <CACKH++baPUaoQQhL0+qcc_DzX7kGcmAOizgfaCQ8gG=oBKDDYw@mail.gmail.com>
User-Agent: NeoMutt/20240329


--fmewhgv2r7hsugjw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi! one quick q to clarify, if you don't mind.

On Thu, Nov 28, 2024 at 11:52:35AM +0900, Rui Ueyama wrote:
> - exit(2) takes a few hundred milliseconds for a large process
>=20
> I believe this is because mold mmaps all input files and an output
> file, and clearing/flushing memory-mapped data is fairly expensive.
>=20
> To avoid this overhead, mold currently forks a child process, lets the
> child handle the actual linking task, and then, as soon as the child
> closes the output file, the parent exits (which takes no time since
> the parent is lightweight). Since the child is not an interactive
> process, it can afford to take its time for exit. While this works, I
> would prefer to avoid it if possible, as it is somewhat a hacky
> workaround.
Sooo am I reading it right that the output file is not valid when mold exit=
s,
since you seem to be exiting /during/ exit->munmap->msync,
while the contents of the file are undefined,
so mold -o whatever && ./whatever is not valid
(while mold -o whatever then ./whatever later is)?

Thanks,

--fmewhgv2r7hsugjw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmdJamsACgkQvP0LAY0m
WPEeixAAu0UXC0rAXbYpe+sh7NaOvHVpm7nWxq6ZX2Ce6MB6ybzMhdjsJfIP1jWq
B2xGq0RNNv/jEmmgQkLBSBQKNsv/IeTZzKeLxhQBm3wrOAWnuHoYDRqHlBdMwSHO
9CjUrbhJ69qPIi+tBsN4tcOUsGMb0QunSsWbxqUCb3PVop5xrP5ICmW5g87B3/WP
W3mw+2FSyTpzP21oT3Na5YK8GrRKhCeEOx2vs+COcmJuS87na0f7p80enRuqp16G
Wv1TPq08957MulvOEidu+O/GrKnmdMLAHLebo2wwbkxNL++wOgnUxtHioI3TkZJ7
lHpuIGd3LxS7RjdoNy7rpYsD5gsy4GAXPWs9zVTjFy+FcqL9mbr/xbGZGCfcBEjs
La5pHEXg3326NKRtEuPOmYRpjlnC84+bSUhr19gJ7Pz8h6f/5kujHQxqRTA+8Lio
TenV8ouB/LS+sfc97yA471QYhHwOtRHZGWiSb88r3CEgpkjA7h8oXO9wgLC0T1ut
2LEZ138a0WMFeH54Uzq9QPHn3L+qFcDWcFk+yoN5gt93YWUEoo6pvKg5uNgi2cn9
RQSySFErKExskyuIIeHiybgDZNyW/3wmyzEAT2KQy3Tz4EqxBjZgqQp2uCsOZUKO
d8I/3XWdokCvBYXBYrmt3yLW2oKXOjiM/IX7svXmt0d22ThlGPs=
=WcG3
-----END PGP SIGNATURE-----

--fmewhgv2r7hsugjw--

