Return-Path: <linux-kernel+bounces-409874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F181E9C92C6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 20:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C600B29479
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 19:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDA51A9B5D;
	Thu, 14 Nov 2024 19:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uLozVyed"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986371A3AA9;
	Thu, 14 Nov 2024 19:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731614344; cv=none; b=uwo6It2l1gEwR/+AYUFlcfgqQv3a/q6vXS/1LFyq5LwId5SR1FVKjJGzQlRIaSwP4AW1fnp+N2/S9AW4eJUJwGEWzrpF8KpDXs3WT6aVphHW/BH0vZGO+XdNuZgHk52HZjz8gg6Nj04MfP1c+WpQamExXBDuWgefDn8ehTNEOTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731614344; c=relaxed/simple;
	bh=SQSJuA5ZJjGxcHd3x3HQbygt6rb02hRsoGOjMLmtHig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pnvtsqxIPjAmii10rEV6nhr3JlqiwtLWtBCwcSH8EfL/SS4GBTcVwYL0//t8woG+n5QCgcSATa4erWDCFrYAQjFJ66174mxd3b71eW8pQtooZz9ZT7tTuk0RI372nEJ77bF1IH3t85Wd4hzMnAwfUHEOAwXtlGV7G0gm8ESbS14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uLozVyed; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51C55C4CECD;
	Thu, 14 Nov 2024 19:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731614344;
	bh=SQSJuA5ZJjGxcHd3x3HQbygt6rb02hRsoGOjMLmtHig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uLozVyedExT8zIs+JijAW90zDcwsSRsuqDYGJdkdrTD0yK5jqDTVrU1zGPN8/HEnm
	 Gotj68MrXcARYpXsf59YUZfZKMNMTPrkEtNWkxZBb1b30rcpXqRjxeP9W0pZvei7kx
	 WkXADi0wR2m1gW3cXV0m6C0iRSGww6p+P1Dkg9IC7tEHtV6KI/oXf9K9SHBBkFB9yf
	 kM5x5OeJo9/53uhuUfMggsB/9rjU/xnW6hb83uczrXfDWVrZqofWlOzmtG8m/REQjB
	 3YMtl0qGfBj6aFL7M00i4W6NrzPxoNhjLLqqLg38XNEBGzz+zUYFOkl5aS8isRxU11
	 2YGCsPo36Y4SA==
Date: Thu, 14 Nov 2024 19:59:00 +0000
From: Conor Dooley <conor@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mtd: fixed-partitions: Fix "compression"
 typo
Message-ID: <20241114-deniable-conical-a57b36ae6dc3@spud>
References: <20241113225632.1783241-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="P8FMnCtoSWhax0MH"
Content-Disposition: inline
In-Reply-To: <20241113225632.1783241-1-robh@kernel.org>


--P8FMnCtoSWhax0MH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 04:56:31PM -0600, Rob Herring (Arm) wrote:
> The example erroneously has "compress" property rather than the
> documented "compression" property.
>=20
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--P8FMnCtoSWhax0MH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZzZWgwAKCRB4tDGHoIJi
0iEjAP44UzO5FUVwEujbOdAmPlMfUvh+QrvwrlPQbzT8f7/UqgEAuJsfYUidXWg6
dLl/3ZvUusQEqoD33r/hyZV/Hq6mcg0=
=+bY1
-----END PGP SIGNATURE-----

--P8FMnCtoSWhax0MH--

