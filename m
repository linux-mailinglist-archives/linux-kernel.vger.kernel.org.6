Return-Path: <linux-kernel+bounces-425278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 385CB9DBFC9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 08:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F26412818A2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 07:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBBDC156885;
	Fri, 29 Nov 2024 07:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="g8MGZYwl"
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB51F184F
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 07:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.28.40.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732865826; cv=none; b=ULQRr/eR8HailZBmWzSUNltBQKJyg8bsCoO5HrUWF4sq0Ox5lGpkFmSvfVDCaClyrsS4yajGhHM35B2fhT6bEkLKTN1TQ4Jz8Z0zdNY7TtpzvoWApPlHEESTIG+yMad6ozalSsB6pI/Shza92swXbv3VdaP8ro7/b9/HpCUajwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732865826; c=relaxed/simple;
	bh=y5VO/Un+35kPaN3jJprqJUWDl14Dz3L48y2sTnifneQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TwXDvcdu7nxHMSVuvVB5jhWBzpNmpTPBESnCDzkdTQXv+3U1GTbBzdlyJ5dsXmyhbSU6m3pOG2ruHPHiF5sn2VRjNQegzTeI0Wz5KlvVGOb6PumiFzk2QF8kcw+dzmB0s36IMouwcJV/kDE9oGPcNker9E21v1iUCTV5ID+VFd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz; spf=pass smtp.mailfrom=nabijaczleweli.xyz; dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b=g8MGZYwl; arc=none smtp.client-ip=139.28.40.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabijaczleweli.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202405; t=1732865820;
	bh=y5VO/Un+35kPaN3jJprqJUWDl14Dz3L48y2sTnifneQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g8MGZYwlaiWo3rZJKImGEnLsW00t6LBkXxSxuQisrRDyjzofrqgygqEghkle3uWDV
	 qAbyiITWWddbc2Twv2TjHaH3WR9PW7JKHSYpNQssvtIelHRSrlIGkU6SEBoZLfo5R2
	 lgdUyaS9ptE1B1tUrEcIZfUdnsjBtxRHw9kMGR+vqn8/y0ktvLRSMVaivsZeC01CLt
	 OoSh9KzU6cuW8lIyEdRyQ4ZrAQZm5D3FE90zlzilixxVGGWf6bN/zD/0iyrkmxwi4z
	 z/Q4eU5RIKdKRPH5tnjiPVDLCLWkv+ru6j37XfHDtcOaWGJTTOnGb0Ra5qO6kwTuXe
	 QxIz8HgGP+RJA==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 99F2E95EE;
	Fri, 29 Nov 2024 08:37:00 +0100 (CET)
Date: Fri, 29 Nov 2024 08:37:00 +0100
From: =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To: Rui Ueyama <rui314@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Wislist for Linux from the mold linker's POV
Message-ID: <rlyzjcwn7jatyb7tufwtn6kkvimj7xz2f57jcahzusrlmxnoat@tarta.nabijaczleweli.xyz>
References: <CACKH++baPUaoQQhL0+qcc_DzX7kGcmAOizgfaCQ8gG=oBKDDYw@mail.gmail.com>
 <enqsr7otef2osf5kmxwlf56y2jegiggiusbzklqxmkd4puk3rq@tarta.nabijaczleweli.xyz>
 <CACKH++aCPZEwMwreYS7492qabmcj14NWbv9QE6Tp=WN09kE=1w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tqc3fidx7h6yli3x"
Content-Disposition: inline
In-Reply-To: <CACKH++aCPZEwMwreYS7492qabmcj14NWbv9QE6Tp=WN09kE=1w@mail.gmail.com>
User-Agent: NeoMutt/20231221-2-4202cf-dirty


--tqc3fidx7h6yli3x
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 29, 2024 at 04:25:09PM +0900, Rui Ueyama wrote:
> On Fri, Nov 29, 2024 at 4:17=E2=80=AFPM =D0=BD=D0=B0=D0=B1 <nabijaczlewel=
i@nabijaczleweli.xyz> wrote:
> > Hi! one quick q to clarify, if you don't mind.
> >
> > On Thu, Nov 28, 2024 at 11:52:35AM +0900, Rui Ueyama wrote:
> > > - exit(2) takes a few hundred milliseconds for a large process
> > >
> > > I believe this is because mold mmaps all input files and an output
> > > file, and clearing/flushing memory-mapped data is fairly expensive.
> > >
> > > To avoid this overhead, mold currently forks a child process, lets the
> > > child handle the actual linking task, and then, as soon as the child
> > > closes the output file, the parent exits (which takes no time since
> > > the parent is lightweight). Since the child is not an interactive
> > > process, it can afford to take its time for exit. While this works, I
> > > would prefer to avoid it if possible, as it is somewhat a hacky
> > > workaround.
> > Sooo am I reading it right that the output file is not valid when mold =
exits,
> > since you seem to be exiting /during/ exit->munmap->msync,
> > while the contents of the file are undefined,
> > so mold -o whatever && ./whatever is not valid
> > (while mold -o whatever then ./whatever later is)?
> No worries. The child mold process unmaps and closes an output file
> before notifying the parent mold process of completion. Therefore, the
> output file is guaranteed to be complete and valid when the parent
> exits.
Ah, that's alright then, naturally. To me, given the context in the
first para, the original phrasing read a little as-if mold did
  parent                                             exit() -> output undef=
ined -> ok
        \                                           / a few hundred millise=
conds  /
        child -> open() -> mmap() -> link -> close() ->    msync()/munmap()=
/exit()

Thanks :)

--tqc3fidx7h6yli3x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmdJbxoACgkQvP0LAY0m
WPGC8Q/8DSWmVrFtYsPiCDTcRZ+XxBKbqTyxKr66wb7rwwPaRusEqdJy9WEAxOIp
7H5AhFMTx2tlX1BIhVqZWMvJeMSpgycIQKUf6S/ZVP9roGrJzmxzTrsaKs25prG9
3Q3D+cuzXEnwsYUfJAf047jEoJs85UCAn7KmE3VFQ9xUGiHvCMpGY3F8Y+yWaYVu
QQCLyTq9lgb0MH9xAp0rLZzoE1ZVZ/X3R0xSVeX7xO5ygno+PTMJPxF6a9SPhZGZ
iIXqBlnBFOzCKvvBKj4t1g3BYf6AcdRzwnArqoyiQhGbFGeOLPiXEDHvXTJn6CwL
grqhkGS23rDoZ0MFlyZMX+NwQDQi0JKoW1yM0gHAtlGwT7g8Jp/pvowuyTKdGCSw
ah1NcIqybrMXENeapoc7Jn8ffnkiv75r+/3RtCdW5cyoOa51yhIM1lxa/Y+xhJ8E
YfAAChLVL5Ie/j17CV7Hle0473mp4pNb4oJtoMtF4Ec00apqEmh1ugu3nf8/zEzv
7xHgMQaiiMSpdXat/u7JACXsdOPT82reUQPaDCX5O0aU+7LOBtwgjcJRE6nb4Ak6
PKJzndSlekJjsihwuAAoiUKvcf3WsyhMdvDoCfyyzzZUAHzqBKLphqe2YM6DSUDC
fLtJuYrOlsKSEnjbKGzM1kwDZHzKQu/3Flnjc7I8VUZZapwojl0=
=S2ah
-----END PGP SIGNATURE-----

--tqc3fidx7h6yli3x--

