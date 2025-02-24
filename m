Return-Path: <linux-kernel+bounces-529554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA13FA427C7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2702A16ABE8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 16:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D557263C7C;
	Mon, 24 Feb 2025 16:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y/+ZcIpE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FED263C69;
	Mon, 24 Feb 2025 16:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740414107; cv=none; b=LJDum/Ylzh5oIds6t+BRTexFxOI5RkCAPlvTmwM3dRTX+FigXLV5EJql7/fnk2zyp23d+60AbGx09eLx2t94NFQMl8gIWtcDGak11m4CqmVKbDii84eQ+CijuumdKX6UmoixSB1gVwjbwYrXtMeMjnhRitwh9HiouCsi6roURAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740414107; c=relaxed/simple;
	bh=Lr9tC3OPhMIm2aynOnUc9KvklvbS+WkokRngNbMDBgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RbidMBDdIVQ+eCDF0BjVn5upHvRfrYw7t/qUl8dnd5CkPP7EfXaTsEDYqKXpXKim6RwzFROcL9v4QqSY1uMKqkdoJ1gtD1RyHOXr0ka2p4eEQ0nD4y68Q6Af1/DYoMBfSjoxE8kARzJp+KCyge8a1C5V2iTsGDbkASeMx8qSCv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y/+ZcIpE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1650C4CED6;
	Mon, 24 Feb 2025 16:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740414107;
	bh=Lr9tC3OPhMIm2aynOnUc9KvklvbS+WkokRngNbMDBgI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y/+ZcIpEkf/1hwnk2XUTViZrlBTtHV5r5doUi5I0OXkxaYPXmDc8dj73iAGvVR+qX
	 +Rzy2fYSTw/coPlsSMlNKr3cwpJVlwDUbdwc863DOhOGQyUmqOCf/Y5pkiJ5fTvxIv
	 DG53aUXv/shjg4FIGK+wPwoj1d80Gi7l4g7sM11Z/7uV4tlYEsbF4d12y23ChZw0RD
	 VsJK82ew++ESSrtMC73AXlkBYFxNctbsPXbcOOiohI6B44Pjoze+K7jx1LDTKNFebh
	 8yokvpnx2CxQvCTCZ55FiAHkWXhKxZvatej3u5RmyNbQ0BYua8TLfAigakYtVvD0gD
	 cGGSt/eu3nkqA==
Date: Mon, 24 Feb 2025 16:21:42 +0000
From: Mark Brown <broonie@kernel.org>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>, kernel@collabora.com,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: dapm-graph: set fill colour of turned on nodes
Message-ID: <ff241f0f-ee96-4d4d-ad7c-69b7ab0af6a4@sirena.org.uk>
References: <20250221-dapm-graph-node-colour-v1-1-514ed0aa7069@collabora.com>
 <20250224163311.0611da3f@booty>
 <3d15fd23-3756-4a17-a447-b5ccb2c564df@sirena.org.uk>
 <6130937.lOV4Wx5bFT@workhorse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="km7elSEnchdgEA/j"
Content-Disposition: inline
In-Reply-To: <6130937.lOV4Wx5bFT@workhorse>
X-Cookie: Phone call for chucky-pooh.


--km7elSEnchdgEA/j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 05:09:36PM +0100, Nicolas Frattaroli wrote:
> On Monday, 24 February 2025 16:42:08 Central European Standard Time Mark =
Brown=20
> wrote:
> > On Mon, Feb 24, 2025 at 04:33:11PM +0100, Luca Ceresoli wrote:

> > As documented in submitting-patches.rst please send patches to the
> > maintainers for the code you would like to change.  The normal kernel
> > workflow is that people apply patches from their inboxes, if they aren't
> > copied they are likely to not see the patch at all and it is much more
> > difficult to apply patches.

> I used b4 to submit the patch, which runs get-maintainer when I run b4 pr=
ep --
> auto-to-cc. You can see that even running get_maintainer manually for thi=
s=20
> file, you're not one of the recipients:

That should probably be fixed, but in general note that you always need
to apply a bit of thought to the output of get_maintainer.pl rather than
just trust it blindly - it's prone to both false positives and false
negatives.

--km7elSEnchdgEA/j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAme8nJYACgkQJNaLcl1U
h9DMkAf+KFYUkPp0N4dT00WpE46tVxcgRkKrkWrkth6IzcZ5WJsP+SF2X7L5XEMi
blMvuCUs5DqVSYtgwJkBvL5Oe2MGrXkxC1jiYliZjzQrs/bjDykcq57t4HZGbbdj
kcJyhtsf/QzUUX7ElqKgxAjGA2qk6gTSpINXGspjqDofAebnlxNR6L7AKBpRsPsc
arT3vAW5lWZETvscN53ttAmSYsnEhSRHk7IhGob6GEWU84aDutady8y10zlY3buU
Rludt2kPtULf8LcFZ4jd9AWcj4nyvHi2tM/usPmbUkBfypeMNunEjU9KqCDpl+Yq
VwKq4qV2LZR9NB0G8O67AcVagLukOA==
=dpir
-----END PGP SIGNATURE-----

--km7elSEnchdgEA/j--

