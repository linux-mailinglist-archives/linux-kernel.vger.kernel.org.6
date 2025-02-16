Return-Path: <linux-kernel+bounces-516551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 609B0A373E3
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 12:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3167B18908ED
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 11:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7516418C33B;
	Sun, 16 Feb 2025 11:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="lcnM8hqF"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3CA3209;
	Sun, 16 Feb 2025 11:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739704001; cv=none; b=hi1uWVFvKq7PNf2jmaJGVU808A1iuUG+nEgFH2MTUFQBDzE/M6Y6azgDwZwp9wX/4JjgTmF0oOhTB8nKm5rvHZf2vnxWTVMTmTdGxZvBtbVwzAJXtJvHrVC8zpGvQz0BTMMlaQETmryp2G2WNOYX5ku+ikn0nNOHUvA+vOSbHOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739704001; c=relaxed/simple;
	bh=2sLUpHPjXnj29AqxoEcLA40AhQ30jI32qBjj6pdtTe4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n/V25Kf3DNoOArujrrHeg3X/Thm3qqQy3y/hbZGYAtaH23mCeAbWo2goJCMtYe2bBiQ1DdaD6ch4QckS0eB01v/qob4CO7/aK55Lc/jQybg3I6RtMpIi/Wi2+6T4dzszTEe/kDbga71G4BkGI4ieHSkSnsL1walHO+s7P7GwtV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=lcnM8hqF; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1739703987;
	bh=Bk42sfpIFzn5GMpdjl9AQd6GOHPhbLJezzNmh2dxWdI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lcnM8hqFbq58IPUGvye+YYa8CDqNAZ4+c10uTczXKKfKy4UQRKFhHqFJhxMp3YGy+
	 It6LSQ28PpSGDEuIclpPbY39jqYFSTXlisv/xn0iEzBESIq/rdM+NsHdBgngysp71t
	 pvle0yyXmXKOWOksfHgdHlnINg/ASJpMj3JFsXBqo6Ss2aaqoyLoUFcHYIIt9ryhuP
	 SnGVjrOONWy7Fw9XpBx72z8xw4ivR73jC36El58558sLp6np0wTuW6Lj126ZLZHDyb
	 HQkUIV+jW8o4bf51YlMYc7/bNNZccEhRtQ2gNQ165L9uIqSutXGpVc4yVXjQ/tPiFO
	 bHzfXfMWSlQOw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Ywjdv1L6tz4wvg;
	Sun, 16 Feb 2025 22:06:27 +1100 (AEDT)
Date: Sun, 16 Feb 2025 22:06:11 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Matt Turner <mattst88@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PULL] alpha.git
Message-ID: <20250216220611.41e33084@canb.auug.org.au>
In-Reply-To: <CAEdQ38F6ts1qXj2xb+PN=O_byGwZAp1mvF8aRdTEq2zrzLBFSA@mail.gmail.com>
References: <w3rw6n4cbgmlcylf5gbzzocqhyxjoyjy3qiedb7fzvd7jdwgap@44d323cbjljd>
	<CAEdQ38F6ts1qXj2xb+PN=O_byGwZAp1mvF8aRdTEq2zrzLBFSA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/3OIeJvs353bilnFMy4SaGNU";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/3OIeJvs353bilnFMy4SaGNU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Matt,

On Fri, 14 Feb 2025 16:36:43 -0500 Matt Turner <mattst88@gmail.com> wrote:
>
> The last time I sent a pull request to Linus he noted that the commits
> weren't in linux-next. I meant to sort that out before next time, but
> well, better late than never!
>=20
> Could you please add
> https://git.kernel.org/pub/scm/linux/kernel/git/mattst88/alpha.git
> alpha-next to linux-next?

Added from tomorrow.  I have put just you as a contact for problems
with the tree (conflict, build failures ...), do you want anyone else -
or a mailing list?

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgement of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window.=20

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and=20
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

--=20
Cheers,
Stephen Rothwell=20
sfr@canb.auug.org.au

--Sig_/3OIeJvs353bilnFMy4SaGNU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmexxqQACgkQAVBC80lX
0Gx7eQf9H1IkgWlGsdKYPZJE0JpJsLZxJwLsmAm9j0rTCgLYoo0UxXBFRiQsNGJO
5YC/a7F/xjm/1TGb6Sk1ngjY+9o8QhtvjXJy2ZkzuHEDIy4GLj18igS5fdJkA9j2
cmt61ufgV5uw2IsNHvbUuIfj67EmPT7Xfo/ZTKTscOA1cqiKWUoe6kuoFxL5oVQq
ouogk6aVnbjTobyoW7IFMNNayFZ2yO2a8chmICin9+MzZg/HP84fAI7hE60X+N9w
44x/hXjDSjKrBfUgcnkQhxsEvPYUdBr6s8G6fReEtgO7wwQR+s4NhD1OOd8M4LY6
thp/S65/LwMASCbhEkdy+DATL1dtSA==
=1J1E
-----END PGP SIGNATURE-----

--Sig_/3OIeJvs353bilnFMy4SaGNU--

