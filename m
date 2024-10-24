Return-Path: <linux-kernel+bounces-380308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AF89AEC2A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 18:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C4291F24614
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 16:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01CD1F80C0;
	Thu, 24 Oct 2024 16:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KRG/5R8S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5711C16F910;
	Thu, 24 Oct 2024 16:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729787543; cv=none; b=SkHbRsa5JCngDISMxO2tL/4HVKBI1xgGFnf7R4+2jNdj8f9oPqF0VEjRUEmd1TxsFYUqkuxwH4U0IIkbzUkkrVPd/Kpeq8W/VluOtlFdZP4ES2eyX7BE/X/QbOTn66BvkRWAYP1iTdsW9udX91AigVarTOdqUAiFiESecFnk4rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729787543; c=relaxed/simple;
	bh=m95z8iH/UX1yb0zy7MzsTJvsN9Ux+fqmIhv/rf5X4so=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m/d6L/pUgpJDhvItcRXK5hrOFY4kBDgJGkJq5oVQk2vJESbNA4LrWz10/r/EbeFwUfmsfbGqlEqPGKuBQWTlfPH/zbjUHvAH46TwM2GfDNiXqsZErB9XeXfeDlUdWcUGpoW8jy7PJZ+UhiJc0TNaWG3bB9wSej+VZ005dCFUozI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KRG/5R8S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33F73C4CEC7;
	Thu, 24 Oct 2024 16:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729787542;
	bh=m95z8iH/UX1yb0zy7MzsTJvsN9Ux+fqmIhv/rf5X4so=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KRG/5R8SsVbmNTBjl+70/A6rOmFqCt/bRet8OIHbYcunqWi537fm3kZabzNRNEXkK
	 1ALrnhsrDrjqvcRTfTO1rqlcI+GVXjCsQyjrhtDzpNanFZXv1XvUcdmcLlUfzOPSvf
	 bkaYa56j8Y0IRJ5GFpJc4iV1P0sfXsFAve2fBiDAaFuw/qeI1qgGP7RZMWeqdpVv/c
	 hkc2XU/EYw3lDZDWeROaEkU9/HJlQ9nwDmthxNxik7YjoRVD25h27rhRf0t8gEkKoQ
	 mkMHAEFn9xNxtbtGdm5+Nvo4YM4QUuofnxQDWK6T8H1sBXnmp8X72NzlIj9AhmFivA
	 +7gz6r1OzzgCw==
Date: Thu, 24 Oct 2024 17:32:19 +0100
From: Conor Dooley <conor@kernel.org>
To: Wenliang <wenliang202407@163.com>
Cc: linux@roeck-us.net, jdelvare@suse.com, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org,
	krzk+dt@kernel.org
Subject: Re: [PATCH v3 2/2] dt-bindings: modified ina2xx to match SY24655
Message-ID: <20241024-skyline-cahoots-6783be97795a@spud>
References: <80bfd968-8f12-46b1-9b72-837502ccdb2a@roeck-us.ne>
 <20241024083055.82047-1-wenliang202407@163.com>
 <20241024083055.82047-2-wenliang202407@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PtgwF3ZykohAFRAA"
Content-Disposition: inline
In-Reply-To: <20241024083055.82047-2-wenliang202407@163.com>


--PtgwF3ZykohAFRAA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 04:30:55AM -0400, Wenliang wrote:
> Adding Silergy's sy24655 as an adapter chip for Ina2xx drivers.
>=20
> Because it is similar to INA226, the supply voltage and pin definitions
> are the same. It also supports IIC communication, with only two
> additional registers added for configuring and calculating average power.
>=20
> Signed-off-by: Wenliang <wenliang202407@163.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

The series has been send in response to an invalid message id:
https://lore.kernel.org/all/20241024083055.82047-2-wenliang202407@163.com/

Don't send new versions as replies to earlier versions, that tends to
get things lost in people's mailboxes.

Cheers,
Conor.

--PtgwF3ZykohAFRAA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZxp2kwAKCRB4tDGHoIJi
0oJhAP0YCVXkodAYLEdP1KFIpEzsAg9TxUz8TQk1bQIOqevHhQEAmtDum6JvJ0Qw
F1ZBBzFDfTfwsXdMie9PwMuhSOVYzQQ=
=hEh0
-----END PGP SIGNATURE-----

--PtgwF3ZykohAFRAA--

