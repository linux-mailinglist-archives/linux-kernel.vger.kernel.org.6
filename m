Return-Path: <linux-kernel+bounces-215872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 297A1909827
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 14:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB0DE283109
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 12:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91C545034;
	Sat, 15 Jun 2024 12:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DOSocQWJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0485C4A3D;
	Sat, 15 Jun 2024 12:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718453693; cv=none; b=FTT7Rs5FotGsbpBqqBmdOj4clTXjK4yL2HGDCBof0qnp4GSsUsxmDWLt4lmBHeRMIgy37m4PpE6DKL77YRyuNKNygTTFeZT1va7VzdqNJjMvC1t4mRRyaakMs09udOp7q27J65g0IGOnNDqVB2H5b/VuP8MIue14hYG40Xw8vgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718453693; c=relaxed/simple;
	bh=/LLZqW6NRPMIgHsf4D4yiEdXEyv0x9KmjvDXqN9rvPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nDbV29Jl1pnn8eG/81OJ3Jtqq4zCKTeOEjUCWtglR/NLZUZ+Qyf9gDRmUHBaOUo7qtcBbxYbO45Fbrm6b1bVXuSYJvMEMj3fhmXcHMYZTkIiT1WujX79vMtBnKgRyXqQ/DJdzU6Am3qM3VHQYG/ChJNqAqcgxqHxcji8MTS2yP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DOSocQWJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4A1DC116B1;
	Sat, 15 Jun 2024 12:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718453692;
	bh=/LLZqW6NRPMIgHsf4D4yiEdXEyv0x9KmjvDXqN9rvPU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DOSocQWJgYuaU85qCoTzrQOouNRLjRV/D1FycJymW9L5a62sAH8NqX0ukgj4ZfEO8
	 7DAKtwAZbxH1nVCr0GwVLDDyeEWPLvmO/NCD+na1r4oU4ki1YvgAyk1dk4piI9oDMT
	 ZVZ0/wAL4TWKxGE4PaLLIuMJWjF1R15rGSgyTtlWPdTG3/dpFa3c/sQUjMOUGe0u9m
	 5Izk5n96LJ3k0GDrF6LD9KD2WSMVDWaNs9sJRQVYTc+ycbDyN5sbAxpU4yjFl3QfNg
	 aZwU1CjlvJDC4B10pwmHRkJ3BiOUde99wndg5ACrwGX6NuzUVOIWky6hv6i+YJ5Tc4
	 hgP4bsufWXGFQ==
Date: Sat, 15 Jun 2024 13:14:48 +0100
From: Conor Dooley <conor@kernel.org>
To: Etienne Carriere <etienne.carriere@foss.st.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>, Lee Jones <lee@kernel.org>,
	Pascal Paillet <p.paillet@st.com>, Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] dt-bindings: mfd: dual licensing for st,stpmic1 bindings
Message-ID: <20240615-booted-spoon-f538994dec8f@spud>
References: <20240614153346.2656871-1-etienne.carriere@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="r431OI/sWd8v5ceD"
Content-Disposition: inline
In-Reply-To: <20240614153346.2656871-1-etienne.carriere@foss.st.com>


--r431OI/sWd8v5ceD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 05:33:46PM +0200, Etienne Carriere wrote:
> Change include/dt-bindings/mfd/st,stpmic1.h license model from GPLv2.0
> only to dual GPLv2.0 or BSD-3-Clause. I have every legitimacy to request
> this change on behalf of STMicroelectronics. This change clarifies that
> this DT binding header file can be shared with software components as
> bootloaders and OSes that are not published under GPLv2 terms.
>=20
> In CC are all the contributors to this header file.
>=20
> Cc: Pascal Paillet <p.paillet@st.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Etienne Carriere <etienne.carriere@foss.st.com>
> ---
>  include/dt-bindings/mfd/st,stpmic1.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/dt-bindings/mfd/st,stpmic1.h b/include/dt-bindings/m=
fd/st,stpmic1.h
> index 321cd08797d9..957c48300cd4 100644
> --- a/include/dt-bindings/mfd/st,stpmic1.h
> +++ b/include/dt-bindings/mfd/st,stpmic1.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> +/* SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause */

The usual dual license for bindings is BSD-2-Clause, was there a
specific request for the 3 version?

>  /*
>   * Copyright (C) STMicroelectronics 2018 - All Rights Reserved
>   * Author: Philippe Peurichard <philippe.peurichard@st.com>,
> --=20
> 2.25.1
>=20

--r431OI/sWd8v5ceD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZm2FuAAKCRB4tDGHoIJi
0qU+AP9iFoNZNW+d5nIKaZnmqqhGLVRuf0oOYDQjVwO4tsBr0QD/VWwcj6LPsoPt
quIwpaRqzIzpaqShIvphrfgrY/wQKw4=
=/GST
-----END PGP SIGNATURE-----

--r431OI/sWd8v5ceD--

