Return-Path: <linux-kernel+bounces-180124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC0B8C6A61
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 18:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D5C1B22EF0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 16:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57018156644;
	Wed, 15 May 2024 16:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6qIVGEa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9882F155A52;
	Wed, 15 May 2024 16:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715789806; cv=none; b=OIFDTIz40oUGTBfB+n2Q9t2Soak6VqqaYwBOelN8JbZowgisym8ctj3MKmrLj+1GV1+OgTJYRVWDrAWONjz8dGHx0gl+x4MKp+GoD8vUfOJeTv/acG+sKcTYzvm/m8YNkYwtyK/K+QOSL9f/0XEr0ugoeU+whikNNofeVFzNz8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715789806; c=relaxed/simple;
	bh=xDZhxo2QplN3zn+XNt8i1T5RG4aqrvvLKOCpHXdE4pI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YYQ29VMBAKnAFLrP8Jz8fmQ2tPsZQ+Id1JcZt2dLta9thT1zHUuzwAAvLt9K4DP85+17zzWMX8TJnWngZai796INZGBU6JDkj+TNEOSj+dABhbitmjyUSVPv/2VM8CjGK9R1JpGx5lZEiqK3JzKXu9eWiHMgHNIGBxLtSljM+Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z6qIVGEa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAF46C116B1;
	Wed, 15 May 2024 16:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715789806;
	bh=xDZhxo2QplN3zn+XNt8i1T5RG4aqrvvLKOCpHXdE4pI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z6qIVGEais/NIxmx1G/nwvoPhkR0OvWRsnuvgW6rJwkh/gfRIfUfXjo8tYqaUGqPm
	 2oH1wIdigSnX+XUxUjg932yo3Pd5boqHMaIvsT087GTfCT/Iaa0yOIGY8jHahJgISG
	 AkgF9yD0+gxh5uFEhCCS07v62KqPXeIkAaF/2PD5ezlaSGhMSSuzknlllkEuaYay7I
	 DxuPu3g3B+C7HQrE7o4pCnI5zQFet4XEVLOgFIrP6e33qRJ3GDGcEA4o3UMAiXvB1i
	 KF22fgNjmNIyjg4FPMZUl5E+vQbDkH00kAT232JHjymB/nf/Gmb3ErtBNM1s5Ay0h3
	 mMPJWApyZ0Sgw==
Date: Wed, 15 May 2024 17:16:41 +0100
From: Conor Dooley <conor@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Alina Yu <alina_yu@richtek.com>,
	Conor Dooley <conor.dooley@microchip.com>, lgirdwood@gmail.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, johnny_lai@richtek.com,
	cy_huang@richtek.com
Subject: Re: [PATCH v3 6/6] regulator: dt-bindings: rtq2208: Add property to
 get ldo of RTQ2208 is adjustable or not
Message-ID: <20240515-karate-hexagram-0e24d4f595b7@spud>
References: <cover.1715340537.git.alina_yu@richtek.com>
 <6a3a90d9aa2022dfb92e124e417f3e72c2f28b0b.1715340537.git.alina_yu@richtek.com>
 <20240513-tissue-repave-13d2e3bf88fd@spud>
 <d97752ed-4032-4681-b28f-17f149fdc3d4@sirena.org.uk>
 <20240514-plunging-chair-803d9e342e6f@spud>
 <20240515073830.GA12525@linuxcarl2.richtek.com>
 <20240515-wrinkle-engross-ab6b089baae3@wendy>
 <20240515090229.GA15889@linuxcarl2.richtek.com>
 <20240515-gigantic-justifier-1fa140b59de6@spud>
 <35bfdfa3-0b4d-4457-988f-1f861dc5c125@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pr6nnWP3Ccms1w04"
Content-Disposition: inline
In-Reply-To: <35bfdfa3-0b4d-4457-988f-1f861dc5c125@sirena.org.uk>


--pr6nnWP3Ccms1w04
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 05:04:32PM +0100, Mark Brown wrote:
> On Wed, May 15, 2024 at 04:51:30PM +0100, Conor Dooley wrote:
>=20
> > BTW, you should probably change the example so that the voltage you add
> > there is actually outside of the range, rather than identical to one of
> > the range's constraints :)
>=20
> No, that'd be invalid - the constraints need to include a value offered
> by the regulator, in this case the one fixed voltage.  For a fixed
> voltage regulator it's probably better to just not specify a voltage
> range since it can't be changed anyway.

I see. Clearly I got your previous explanation of why the property was
needed arseways.



--pr6nnWP3Ccms1w04
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZkTf6QAKCRB4tDGHoIJi
0l2JAQCJeMWvRCKSDmWruIf+Td9I9Nh1UlSAhdjk9wLI5NRGvQEA8k8UXspuNV6Q
NWS4+M4ZKDZ7I+bIMbXnMA3QpcAt6Ac=
=crMt
-----END PGP SIGNATURE-----

--pr6nnWP3Ccms1w04--

