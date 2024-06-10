Return-Path: <linux-kernel+bounces-208377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3BE90242F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 16:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B80F0B252F9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 14:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0703E12F5BF;
	Mon, 10 Jun 2024 14:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3chULbw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D78980BE5
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 14:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718030217; cv=none; b=PQT1awYl9NB/XeYMDoM2zXdJs6Dx5u9YHqUCBacT/XP/PcoJy3oilv0UjN5D90iXAgIZKO1IV0nPZgs7WNN/Mbash/HABgwoKwISOniQlKLSfOYJN4c5TbsiFu2tvH/Veju2CmOkf8v5TNXeDlbckwMRAP0SuQuePIiEpDd0wWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718030217; c=relaxed/simple;
	bh=lmIcFZU5RRRgEYs4/qm+atg4wKBYaXhptBwoSBVVN2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EyOeQgRHmwduABH2wqCg1e43araakUvyyiDsS6utp6eBGCFezcWOQhxVWGc/cHA+O4Yv3rF7jyhAhllQn1hkSjZbG4NGQVKzlYy8vsZGAypF9a/fqtdabKSbI2BTsQeo01mktV1JkM/fKMizPO+S5P+UXUgUI94ZsqlHFjHHA5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G3chULbw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EED81C32786;
	Mon, 10 Jun 2024 14:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718030216;
	bh=lmIcFZU5RRRgEYs4/qm+atg4wKBYaXhptBwoSBVVN2w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G3chULbwGU8BpKbNrkqJOpMEg4ogjZdkYTrKg3S0KUr/QIdjOO2JgTvNZY7WCGKK0
	 tJT2IVmAFx6E3M9zxRAhYxV0/6BobYCl98nQyYrMtgk5MkBmxd3nTlYpou7jc1wTY5
	 ikeblHlfPgesMJn+E4L/RX9Jc17Or2sv8AK1STx+tLzxoS+I1pHNozKo+VsDh0hsNg
	 PkCKQApaAsxMVp+7lSFPKq0BwcdO2Xhuhsycr2UkUHeU1Mr7VbGfL/fUtAw6EAoWSW
	 iNAWcZZkpYolI7VKOA8spg0yw1dEkE5auoaaJ8BfUp+U+mAJJfkOrmbbBrKVBscoXl
	 /oUl0i1AhJvtA==
Date: Mon, 10 Jun 2024 15:36:53 +0100
From: Mark Brown <broonie@kernel.org>
To: George Stark <gnstark@salutedevices.com>
Cc: lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel@salutedevices.com
Subject: Re: [PATCH 0/1] pwm-regulator with voltage table problem
Message-ID: <ZmcPhROQrlVFixt4@finisterre.sirena.org.uk>
References: <20240610120025.405062-1-gnstark@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IVvzEz26o63yAVPj"
Content-Disposition: inline
In-Reply-To: <20240610120025.405062-1-gnstark@salutedevices.com>
X-Cookie: Your love life will be... interesting.


--IVvzEz26o63yAVPj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 03:00:24PM +0300, George Stark wrote:
> Here is the situation we've met on an ARM SoC:

Please don't send cover letters for single patches, if there is anything
that needs saying put it in the changelog of the patch or after the ---
if it's administrative stuff.  This reduces mail volume and ensures that=20
any important information is recorded in the changelog rather than being
lost.=20

--IVvzEz26o63yAVPj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZnD4QACgkQJNaLcl1U
h9DHWwf/VbbjDle/MnjU558BHTbAL/y7uOLrYU5u8mWDTy8ewGyXvelWtofL/iV7
V/d+lAeVUpLobkaZ5qfersKERomJXXisSDMU2bq+17TMk5l7thpnafA3h3tiY4uv
f28DV9GcslxOTRUpknSGJlo9cAJSe4K+t8v6rYehoTr3oz6KgvfGXe740GRL2vl2
Q6NTX8ENrBp3a/iuDwnhkdeFlCNy3d7iRI4mJp3ajKY9n+WxjJfimpCd0S/tTpxi
XzSXo6zPAQXNM/PbbytbChdBRh3ra1no6JdSVkxQ1uvUPjA591gyvQYeCCVM2+v+
o+W5GSw/K2OMxuf2PaERPVfiwHELOw==
=4nLd
-----END PGP SIGNATURE-----

--IVvzEz26o63yAVPj--

