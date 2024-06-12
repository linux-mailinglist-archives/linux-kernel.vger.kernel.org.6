Return-Path: <linux-kernel+bounces-211906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 564EB9058A0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 18:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52B781C20CDA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CF81822EC;
	Wed, 12 Jun 2024 16:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CVBcWI08"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45C61822E0;
	Wed, 12 Jun 2024 16:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718209189; cv=none; b=XVf5z7isTnkOXNQuG3UWj5fmuToMjCjDPhWLQ7GchU/iK3964tNp49e/GqXnJk2RffZoeu2HKywtbHjq/ujA0E96GmiKf2RBeYfH0PX46NY3oOMchLnxZfHdrAf7kLCyJHBYUxIJGHuIeNQJRf4h6qsFRuYEl5cm5FTU26Rs/jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718209189; c=relaxed/simple;
	bh=1kMwASwF/fLvQv2/fWpYLQ565/D1kQiwKagnKpmGE2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JcnIcM6XY7nNcanLBQ9HLc6wmewXsdLkAX6ATyX2PncYXpsrPu0VY5EtS219DpED1JrReq8bI+gKDKsS8emX7da8+QFc270k/e3TXWO4XAoFmP7mpEzjeuYXPhR+dkAHCmASAGcL/+bZmjOYDsandFrhuBXedBpa2Urir6Jjsyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CVBcWI08; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F47CC116B1;
	Wed, 12 Jun 2024 16:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718209189;
	bh=1kMwASwF/fLvQv2/fWpYLQ565/D1kQiwKagnKpmGE2c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CVBcWI08iAaUWI7Ug8lmkqPcVh51pvGzj0hSIW84SuFslY0snbfB9CRUYtE4Q0GEU
	 P07Dy9tOMVz7wObCbIwVx5gVeP7cP87clB/PACF6DzHaLS2GMPMHR4ixaFOMnn4mP9
	 mPZ4hf22H1gh0wFqTjWrY/SyktF0+HJNBVv4eJHj0GSjVUJVdT8YRN9oI/X3FM5BJD
	 qqAwFexwS5ugfXY+KYQv7niNs600pykSCPEtSyj5RvdKK+6kcoiJNnmrG3XnUkGbeX
	 iAaULFmVHabb1L+GNuDwlT6ljPA9jBQSg24Q+turX73fhN/SCLG4nkEHd3vaXMYe7I
	 rvgOKeFG5bVxQ==
Date: Wed, 12 Jun 2024 17:19:45 +0100
From: Conor Dooley <conor@kernel.org>
To: Andrew Davis <afd@ti.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: interrupt-controller: lsi,zevio-intc:
 convert to YAML
Message-ID: <20240612-undamaged-upload-16f8669a54ad@spud>
References: <20240612151023.27187-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BnaIEh7lDvD7TND6"
Content-Disposition: inline
In-Reply-To: <20240612151023.27187-1-afd@ti.com>


--BnaIEh7lDvD7TND6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 10:10:23AM -0500, Andrew Davis wrote:
> Convert Zevio interrupt controller bindings to DT schema.
>=20
> Signed-off-by: Andrew Davis <afd@ti.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--BnaIEh7lDvD7TND6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZmnKoQAKCRB4tDGHoIJi
0mwiAP0UQRB1U1lkOthVawdYrFoAl1t/N/BgUSqSAcBkj6It1wEA4jAcgfMqrwwZ
MHiVWxiAEx3s7YNb8wdSiGi+2sga8QQ=
=GOT9
-----END PGP SIGNATURE-----

--BnaIEh7lDvD7TND6--

