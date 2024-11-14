Return-Path: <linux-kernel+bounces-409213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B4D9C88FA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 12:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C6691F24D43
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 11:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63C91F8935;
	Thu, 14 Nov 2024 11:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lokdHtQK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F2C1F7799
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 11:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731583902; cv=none; b=rIY5RWHh87k0zpIgqypAwyV64LmCYQZI82qJ3ESa1zpecDYHoCnItuC2Mfaxl0jlnYFqyJjoh2PkB+bCzoAt0CoUxExAgHb4nO+MqMMiBunv0/33gU43PEk5NUcx6ClTmUIISRyLWAlFtNkYCIwshgQrPuXWmMOY6fTgROFlhSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731583902; c=relaxed/simple;
	bh=p95ar4tK2P4Xpt7HM4dy5N3R1DjPlC5C97j2VkMhnsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sQkmI1FvZ2h8k2L7Fi3AO8pd69qZTXTuBFrz47fQbXbtlLSYVzHwRdUwJ21T05D/5onoFh1osh8qTBYAadzmG9gsW3GeQoCHmeqlT42EY1F08/xqp19bPwENQhAttICYXERH1NVYpr8CVAihYVm2oMVGD/8xWOHDLp89g0N3p1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lokdHtQK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16DC8C4CECD;
	Thu, 14 Nov 2024 11:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731583901;
	bh=p95ar4tK2P4Xpt7HM4dy5N3R1DjPlC5C97j2VkMhnsM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lokdHtQKmMn9cwm0bDM5x9nDOWhWNCJrnHkQdAWmnDY6uxbhjynTOZBz9klQ3kc1c
	 fNeEx+gYIM4bM2ZF+Tb92L87CI65ykHK8ZOs9zU5l+07AWbQ8SjInSVLWH3vxaB3+v
	 FSKRq6UCROHlXSSlspwtIKmzqNQow3TINxZyJ1L/wvxfbfR2kDre2b2LkkFXGZtkcJ
	 R04tP1nxeeooVdCkPXqnsGh2ENgSJ2mbShuyjgV3l0Sc5GSgo/MCula3LaRwAqiezP
	 dvqrWFORJf2un2HX1/kGCVl7jpHocgd104aRcGgjS8iopwJOeXOBNAeHD68kH8OG8X
	 VV+lppW9TQj9w==
Date: Thu, 14 Nov 2024 11:31:38 +0000
From: Mark Brown <broonie@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Frank Li <Frank.Li@nxp.com>
Subject: Re: regmap I3C support
Message-ID: <ZzXfmonkRB-KaBhi@finisterre.sirena.org.uk>
References: <67d549d0-64c6-4d62-add6-0958ef24910f@roeck-us.net>
 <ZzSxKctLlLZexdF5@finisterre.sirena.org.uk>
 <feda265f-f7ba-4017-a08d-b35916aafe96@roeck-us.net>
 <ZzS6ph8KulEITt5C@finisterre.sirena.org.uk>
 <88f34137-b215-4bee-b117-3ff00402ba6c@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9+rHwng3GXGHWqIG"
Content-Disposition: inline
In-Reply-To: <88f34137-b215-4bee-b117-3ff00402ba6c@roeck-us.net>
X-Cookie: Editing is a rewording activity.


--9+rHwng3GXGHWqIG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 13, 2024 at 12:16:37PM -0800, Guenter Roeck wrote:
> On 11/13/24 06:41, Mark Brown wrote:

> > That's kind of my question.  If we are going to have this sort of stuff
> > we should also have it for I2C and SPI since it's such a common pattern.

> I'll take that as "we are not going to provide a dummy regmap i3c registration
> function". Thanks, that is all I needed to know.

It's not a definite no, it's a "is this just going to run into the same
problems we ran into with I2C and SPI and never get used?" or
alternatively "have people figured out a better solution to the problems
we had with I2C and SPI which we can adopt there?" - it's something we
wanted to do before but ran into trouble with.

--9+rHwng3GXGHWqIG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmc135kACgkQJNaLcl1U
h9AT5Af/TKX98ksQXVBFqIJwCEmJXUdOaCfWFHrAPSe+YSuPla1EXrCsfVH+efOy
C8k1ywASovP3iVHculHaOgFNKnXub9w5YLWkmdUHoNiOAmXHE3yBa6noraRJysgT
LKaMf1iBfEoTcDusg5MW9ajwfBA4hM5r/9fOdYyrfxb4S2UXE6o2dfX9MdIaR+3Q
TBDg8VxjitySmog3HU/LNhhNxkwH/MN6oxEe+XwH0Gqpzp3QUcJlV7n/w8k0MwBD
4dnH/inkdj4ct3uZyfQK2jbmDnoqDaIIQimzMTzz3QAWJHtwh4Er1mxPk2asZxRK
ZVTtIklAJlZZGq5n2H/QDbAl6E1NxQ==
=Etfx
-----END PGP SIGNATURE-----

--9+rHwng3GXGHWqIG--

