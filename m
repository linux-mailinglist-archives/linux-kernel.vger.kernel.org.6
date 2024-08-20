Return-Path: <linux-kernel+bounces-294368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B425958CB6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 19:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABC42B23467
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 17:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C291BBBE8;
	Tue, 20 Aug 2024 17:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BPmy9uwe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8021922D3;
	Tue, 20 Aug 2024 17:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724173461; cv=none; b=s/exacOuWkNSc6NHUWRe8nzAPHd+xjl2xuaE8x9V8nhsjZxio3CU1x19lCnlp33LAJRo2C34naAvX2SQcg/D3zxyONmxMw64r5zv+HLdKCTsr/drjpfloADgfmjgXsCR4pqnRLUm7Y0EhqMTT/GTf06m3pXpKGO3PiLPP/H2gpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724173461; c=relaxed/simple;
	bh=rhCBflYnsE+VlN0qMJCYvnpElVO5XXvwydRVbxjg9f0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZvLvJ5FLcvOW3QPzmTRt0PgwB7akxOE5IKR5SH/MjPVZUxr05dQ/USYLY9i6PD6FgUhdaDbts9uSYxaVFO4IRY8SCjXMm0AEfPQITq6HIZurB5QERj5lHmaWhnz2ckSeP4bpIIwaImEKpXE2YNi0K77C166NaG8VCOk+I8+JfH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BPmy9uwe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 233A2C4AF0F;
	Tue, 20 Aug 2024 17:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724173461;
	bh=rhCBflYnsE+VlN0qMJCYvnpElVO5XXvwydRVbxjg9f0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BPmy9uwe4OFWQwhK72xhU//2sRb1bhArPDmTwvqjQxW1wgOXLKLOCwkWYTyJjtrWZ
	 HJgOf8qRbZmV/zWDaGH4fKgIYbC85rJGIP/5xhrxhV2zqCslBFCbqYflioirOhxNN9
	 j+Y70SGYBNWCRbxa68CZZcO3Lzr9owsleGUMng7+/rXunBpiVc520tBWMzHtvp7HJW
	 aWb7GgaXvSaz4B+wL0RJ8EXcpHWp5VpC0hJJouShTsf+Qm0AVpf2rFIaoaqLJcEV4S
	 NyJx5yhkARySLlVlXbazuD2YX7Y8vBhCTc5BvbypZiqabPq4Aw0hlU4d32lvCMoSzQ
	 +GQM+SuBM8jVw==
Date: Tue, 20 Aug 2024 18:04:17 +0100
From: Mark Brown <broonie@kernel.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] ASoC: dapm-graph: add component on/off and route
 names to graph
Message-ID: <c4e2580f-1675-48b0-b59f-a076eced7675@sirena.org.uk>
References: <20240607-dapm-graph-v1-0-bb302970d055@bootlin.com>
 <20240820184406.6ff2654e@booty>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GTj5jUgnIgrntciP"
Content-Disposition: inline
In-Reply-To: <20240820184406.6ff2654e@booty>
X-Cookie: You are false data.


--GTj5jUgnIgrntciP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 06:44:06PM +0200, Luca Ceresoli wrote:
> On Fri, 07 Jun 2024 09:41:50 +0200
> Luca Ceresoli <luca.ceresoli@bootlin.com> wrote:

> > This small series adds some improvements to dapm-graph in order to prod=
uce
> > a more correct and informative graph.

> Gentle ping about this series.

> It applies and works fine on current master.

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, so sending again is generally a better approach though there are
some other maintainers who like them - if in doubt look at how patches
for the subsystem are normally handled.

--GTj5jUgnIgrntciP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbEzJAACgkQJNaLcl1U
h9Dwwgf/f9R+9cMsCsCkNmxM5xmsdD4DzyAvnr4d0MeWlRgJzW48jnRTTmqP4PT0
dDV1tH/4ey0Gpbb0OAKPrO8tjKCC5nH8LrGuW7loYi1gR/TpLhICcZHVUmzzoDyZ
nb7gwX33X+6kDHdP9wn2B9qFLp6LjGEGEcMKbm5v5U8TAwS3zoyCS4WXsI66pjPq
Jroo9WKIoBsww8/cTv0BxlbjCC4zJlwHLTy6zkMK/QOVxDbmS79ZT6vMMkKzaQMe
jyVYU0JqzAFAF27zPiQO0mHW69nQuenykpAWEtkrz0OQuEbs0bYgPODamjXZg9pi
4GPuSJJpRwmY4qjXt83LlBi890lqYw==
=N0+b
-----END PGP SIGNATURE-----

--GTj5jUgnIgrntciP--

