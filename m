Return-Path: <linux-kernel+bounces-217694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF28990B30F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 16:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E134A1C21E3F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 14:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC4761FEA;
	Mon, 17 Jun 2024 14:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jnyChMSR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E75B65E20;
	Mon, 17 Jun 2024 14:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718633059; cv=none; b=HmzmFZCeF8AlmP8VjqVlgPEJjQoACxumD0UjDbV+hVxFRfREVBKTgpR/DTrXNLJe+HaFaaNsLwfHcfmq9KuTEjcqhD5MvI2uPoqnFEH8jyXDYgS/ya/Wgp43nQ0H7DvsKpuiM26YeDrZurG+i8SkUsFFU/BdLILU9hPO1HWEQM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718633059; c=relaxed/simple;
	bh=ylXG9T1s/w0I5grxUZNmPMRkeKEwCLIrufq/Y8Gs9Rs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O13y4IQSfLlomO1Th/2fAa/JdIfro0XncUBDlhR0G5g2ZOag4fYeFBw86fQhWbGP1t2l1ykA8GAhSI6ObtzZgeQVv3mvGl6VcaGSA1FObusmaAQdPLAKcRLqVEHwdlSORe8Llw0XXI2hfBgZ0/Ln2bEqRGegWGtY2XFtUSZKaSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jnyChMSR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98D87C4AF48;
	Mon, 17 Jun 2024 14:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718633058;
	bh=ylXG9T1s/w0I5grxUZNmPMRkeKEwCLIrufq/Y8Gs9Rs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jnyChMSRTqGap+axtGx0PgnMUJhL7fWGOxxHrJ4eJKqbcBLlx54P5lhpajSLCck4P
	 aZdNwRs/gxYk1IDsmac/8hY25kHePZbOyU1NqopWpfnSozuFDkqvWf7S9PR7ib+LeM
	 KsmVlsaE6AgJ5uX8hVo9MIZsIXKHVZdCfGHlkxooXhz7I7Cu9sGaBW/XjL7Tlsv/YU
	 gQmUqNr1mmIELheHdZdntV+zfcm39HXm5UA+PkNW5NBhF56PvBCLqwwIi3jYCePOy9
	 Hq1Ns9KULEC44zeg6HagnjdiNfKNfdFL+wqaPqk23iyZso234UQzduTAyRk3Kjbdsk
	 vHjM8xjflSMGg==
Date: Mon, 17 Jun 2024 15:04:14 +0100
From: Mark Brown <broonie@kernel.org>
To: Simon Trimmer <simont@opensource.cirrus.com>
Cc: linux-sound@vger.kernel.org, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH] ASoC: cs35l56: Accept values greater than 0 as IRQ
 numbers
Message-ID: <917507e5-dc6c-4e18-a7e1-554625de604e@sirena.org.uk>
References: <20240617135338.82006-1-simont@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WSEc7iFNh20inuIX"
Content-Disposition: inline
In-Reply-To: <20240617135338.82006-1-simont@opensource.cirrus.com>
X-Cookie: Life is the urge to ecstasy.


--WSEc7iFNh20inuIX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 02:53:38PM +0100, Simon Trimmer wrote:
> IRQ lookup functions such as those in ACPI can return error values when
> an IRQ is not defined. The i2c core driver converts the error codes to a
> value of 0 and the SPI bus driver passes them unaltered to client device
> drivers.
>=20
> The cs35l56 driver should only accept positive non-zero values as IRQ
> numbers.

Have all architectures removed 0 as a valid IRQ?

--WSEc7iFNh20inuIX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZwQl0ACgkQJNaLcl1U
h9D9tQf/bEbw7y+SIWUsoPAb3wxezENJBQyjbCgq/zNceaWTonGZdtAALJsb6VAK
TkCrdKHl9fQIH+/wHHEPmB6t48a1K0W/GrdXL7kFPFEhMFXjyKsLCuhk2th2Rn0z
HNqYYofKazzQd/XbVXZKJ4/PFUHZatGoWxd3ChcDxJB1X5bvwmAIk3xjsX5mbKJA
cb+sneKM3cnbgeuTgWHMJrQ6PIdFwH03IGU5k76TnMJ+2Gd2vP9OGzBXpjUvx34i
gk6BtjC5T8hq8DFa8arA0OMKIqDhaluGAGKQvZIjWTYN2bR4qX7PYXxeWJCYfZ6Q
3EvIfRl7rpOx0FVkhQhxeCcEI59v1Q==
=9X7s
-----END PGP SIGNATURE-----

--WSEc7iFNh20inuIX--

