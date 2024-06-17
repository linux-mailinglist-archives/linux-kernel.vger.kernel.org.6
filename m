Return-Path: <linux-kernel+bounces-217832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 453BE90B4E0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 17:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE0BF1F23290
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 15:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693E8156967;
	Mon, 17 Jun 2024 15:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DK3bqfLX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB818156875;
	Mon, 17 Jun 2024 15:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718637232; cv=none; b=mvmuoBpisd9r8LLMWQfAHrNoneC69FJNBQBkg8k8XYG3yyD8Jy1k5+b/bZZ/n+fTP76sCST7k3wLx8ZWqoXcV2wi+EvTVsMIb4dCOqZHpf3cDfE911q8GATZxuWpH3Exz1Xxf52wTeu3QdcBZ+k8JznmM0SNjwAQCDrOaVXsOKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718637232; c=relaxed/simple;
	bh=hIWzbXsh4mRighfIgGhRcgmXvHJgCqDvgPH9Ldm/Ioc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cguCEDKFwqs20KVEjHHrNURFzj+vNVdEtq7F6TWLwQSK1kLbjmWa2GY18rMMYpob3Vce5w9fZrQ+mwBjE88OpSZqgfSvo16V2gwFKM5K48z2n7Z+8JWoLU05U4FEMY/mWxfg0xHAT6EUrz2sWSeHsLSriklcr4dsr68+tFv/g6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DK3bqfLX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57F2FC4AF1D;
	Mon, 17 Jun 2024 15:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718637232;
	bh=hIWzbXsh4mRighfIgGhRcgmXvHJgCqDvgPH9Ldm/Ioc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DK3bqfLX0WxhffXPr5lbsmxoeHwQMsu+flSjBg8PWwwTJKZxnKGEo8YNAd90sgEqP
	 Zs5j/ab+R7s1TRE+6QDbmCWZSojGojXmTSMNuXzotxzOmEKRlNFHZyBzKhVHxyfCHc
	 JYQtGxatwp1DlQdbgPNVOHyoyKcM/a9OD5l9lhApRu3oO8El55tVrlsySaA45ZHhF8
	 +riQ7+R3GZgDqyxqRHcimWsXH6b/8gZBDtV20TcOxAdNFGh2CwRe1tPCJ1lKD/Sd9R
	 Phwm86BRC/DwPRz8r/HwlYGLkLUcpkYFIudTp9jSSyCspfG5eAjsKHqvT9mlDVLRP7
	 KGbONMEOjopAg==
Date: Mon, 17 Jun 2024 16:13:48 +0100
From: Conor Dooley <conor@kernel.org>
To: Etienne CARRIERE - foss <etienne.carriere@foss.st.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>, Lee Jones <lee@kernel.org>,
	Pascal PAILLET-LME <p.paillet@st.com>,
	"linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH v2] dt-bindings: mfd: dual licensing for st,stpmic1
 bindings
Message-ID: <20240617-shaky-amenity-5727816e00e1@spud>
References: <20240617092016.2958046-1-etienne.carriere@foss.st.com>
 <15b20cdd8b9148559352fdb2f02e4e53@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nDhD1gxr6ZJ9vEJW"
Content-Disposition: inline
In-Reply-To: <15b20cdd8b9148559352fdb2f02e4e53@foss.st.com>


--nDhD1gxr6ZJ9vEJW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 09:21:13AM +0000, Etienne CARRIERE - foss wrote:
> Hello Conor,
>=20
> >
> > From: Conor Dooley <conor@kernel.org>
> > Sent: Saturday, June 15, 2024 2:14 PM
> >
> > On Fri, Jun 14, 2024 at 05:33:46PM +0200, Etienne Carriere wrote:
> > > Change include/dt-bindings/mfd/st,stpmic1.h license model from GPLv2.0
> > > only to dual GPLv2.0 or BSD-3-Clause. I have every legitimacy to requ=
est
> > > this change on behalf of STMicroelectronics. This change clarifies th=
at
> > > this DT binding header file can be shared with software components as
> > > bootloaders and OSes that are not published under GPLv2 terms.
> > >
> > > In CC are all the contributors to this header file.
> > >
> > > Cc: Pascal Paillet <p.paillet@st.com>
> > > Cc: Lee Jones <lee.jones@linaro.org>
> > > Cc: Rob Herring <robh@kernel.org>
> > > Signed-off-by: Etienne Carriere <etienne.carriere@foss.st.com>
> > > ---
> > >  include/dt-bindings/mfd/st,stpmic1.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/include/dt-bindings/mfd/st,stpmic1.h b/include/dt-bindin=
gs/mfd/st,stpmic1.h
> > > index 321cd08797d9..957c48300cd4 100644
> > > --- a/include/dt-bindings/mfd/st,stpmic1.h
> > > +++ b/include/dt-bindings/mfd/st,stpmic1.h
> > > @@ -1,4 +1,4 @@
> > > -/* SPDX-License-Identifier: GPL-2.0 */
> > > +/* SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause */
> >
> > The usual dual license for bindings is BSD-2-Clause, was there a
> > specific request for the 3 version?
>=20
> My mistake. Thanks for spotting that.
> I have my company agreement for the 2 dual models: "OR BSD-2-Clause" and =
"OR BSD-3-Clause".
> We expect to conform to DT bindings preferred licensing model. Indeed the=
 kernel documentation explicitly mention "GPL-2.0-only OR BSD-2-Clause".
> We prefer to conform with it. I'll update my patch.
>=20
> By the way, I'll fix Lee Jones e-mail address that is deprecated.

I figure this is a send-email mistake cos you have to do something
god-forsaken to send plaintext mail from the st mail system.

--nDhD1gxr6ZJ9vEJW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnBSrAAKCRB4tDGHoIJi
0haXAQDscqmPiNOh0Bh+PkIiCfAxILuu6s2z2D2dalTF/DcSyAEA9mSKKJhCsVH1
gd9VVgFw5ZfTa4bXLVuLmNkIF+8wxwU=
=Nc3K
-----END PGP SIGNATURE-----

--nDhD1gxr6ZJ9vEJW--

