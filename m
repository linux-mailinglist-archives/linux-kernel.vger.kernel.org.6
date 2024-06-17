Return-Path: <linux-kernel+bounces-217834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C75890B6DD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 18:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABA38B225A4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 15:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784EB156F42;
	Mon, 17 Jun 2024 15:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tTDSqNl6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9217156F31;
	Mon, 17 Jun 2024 15:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718637320; cv=none; b=RMV/UVjQYXZ4nxhdIo/egSfC3h9m8LXQ9QEr09SgV2IAC29G3fI/PrcyjT4+CzDFYFkY6/mMjPh1c/pCoFXxgoqxFvCKrQ18oIU8UbMWUTE2gEzf+N8CmURGrnCyibcxD9htHe7Cz2tAuIzSWr06oRFOmOEUq6UKqa4QzvZBr98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718637320; c=relaxed/simple;
	bh=WHkOQwgQ0OkCBXBRQiaSNopJdYpyKdAicFRU5wIC1SQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZpG0T9YavOcbEn3NgZSeSU/JlqO9ZFKxMpYRGUcj98KZahv91VNHUA1x9cLskLBZ8yCv3f8b9+u+2PnYh8rItVeLbVatB1XB37jS0qy7S+415kCY3oQHsqfjpTlUWvc60KNiEij5lUDj2JSbRicUTqqE2DnsbEjPRGGF4NdD6J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tTDSqNl6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DF4FC4AF1D;
	Mon, 17 Jun 2024 15:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718637320;
	bh=WHkOQwgQ0OkCBXBRQiaSNopJdYpyKdAicFRU5wIC1SQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tTDSqNl6jdkQtMK7cX4KvwKmvrBJb0KCpntchLkDEBpXVtz9ZsmfVQxHWSh5mN5z+
	 aVyoZ3f/+5/qbSwFd98WTmEA7DvU4/Xg7wVF7KoZ8vx/VkgmimhKuf6+sQWFuKHiKF
	 cy5DkUrz32DOkakoe8npzIfF6Lb3+vccSr1XWfpRCByMEnge/d8mx8C8aDFh7Ot4Rc
	 du0vaGJDecUhWxZdzrG/75SYdzOx7NSPrOjtAAhBg2aVx6+VbtwG41y2Fi9qTyl3ic
	 GORXm32SmliFyw7N3vj+KMQkoSxh6GNgfuR4Ir+bPVT4mf4Sorm43SZUUgyiIr5iq/
	 Uv0uqk7dNXr8w==
Date: Mon, 17 Jun 2024 16:15:16 +0100
From: Conor Dooley <conor@kernel.org>
To: Etienne Carriere <etienne.carriere@foss.st.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>, Lee Jones <lee@kernel.org>,
	Pascal Paillet <p.paillet@st.com>,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v2] dt-bindings: mfd: dual licensing for st,stpmic1
 bindings
Message-ID: <20240617-schilling-unfreeze-1151ed3ffe3c@spud>
References: <20240617092016.2958046-1-etienne.carriere@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lGPyMPYHL/8mRCAF"
Content-Disposition: inline
In-Reply-To: <20240617092016.2958046-1-etienne.carriere@foss.st.com>


--lGPyMPYHL/8mRCAF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 11:20:16AM +0200, Etienne Carriere wrote:
> Change include/dt-bindings/mfd/st,stpmic1.h license model from GPLv2.0
> only to dual GPLv2.0 or BSD-2-Clause. I have every legitimacy to request
> this change on behalf of STMicroelectronics. This change clarifies that
> this DT binding header file can be shared with software components as
> bootloaders and OSes that are not published under GPLv2 terms.
>=20
> In CC are all the contributors to this header file.
>=20
> Cc: Pascal Paillet <p.paillet@st.com>
> Cc: Lee Jones <lee@kernel.org>
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Etienne Carriere <etienne.carriere@foss.st.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

> ---
> Changes since v1:
> - Change request license from "GPL-2.0-only OR BSD-3-Clause" to
>   "GPL-2.0-only OR BSD-2-Clause".
> - Update Lee's e-mail address.
> ---
>  include/dt-bindings/mfd/st,stpmic1.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/dt-bindings/mfd/st,stpmic1.h b/include/dt-bindings/m=
fd/st,stpmic1.h
> index 321cd08797d9..9dd15b9c743e 100644
> --- a/include/dt-bindings/mfd/st,stpmic1.h
> +++ b/include/dt-bindings/mfd/st,stpmic1.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> +/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
>  /*
>   * Copyright (C) STMicroelectronics 2018 - All Rights Reserved
>   * Author: Philippe Peurichard <philippe.peurichard@st.com>,
> --=20
> 2.25.1
>=20

--lGPyMPYHL/8mRCAF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnBTBAAKCRB4tDGHoIJi
0qIWAPkBJ9q1i4xsdPxz3hLLu+JG/FRYZ1wTgLB3J64D5AYvrwEA8FkkvfvaQHtM
/MSFQyC8O7LR6GsPUulaf3eF0NkDXwc=
=80iE
-----END PGP SIGNATURE-----

--lGPyMPYHL/8mRCAF--

