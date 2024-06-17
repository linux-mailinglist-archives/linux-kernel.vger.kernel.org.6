Return-Path: <linux-kernel+bounces-217835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4600E90B4E7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 17:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4CA61F21437
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 15:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FC0157480;
	Mon, 17 Jun 2024 15:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CRZl9kIp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AE928F3;
	Mon, 17 Jun 2024 15:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718637356; cv=none; b=qNG5QW77SImJKbExcDJBuFnZpzWU6nNMG4fN7gQEpX2PjQEHvFPixzOy47zsNEvXUgb2m+icoLtpwFHSRpRIiYA3s//y5zN2ku3XJxU6EVAGg32rhlvW5A6gA4RkFPqNy5bIFuGVy1tvmzb2fBQEbQRN3f1Pofxfp19tSSIYrSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718637356; c=relaxed/simple;
	bh=QmJ3aVwAViSIqgxOAxftmSPyWcZ6L9f2BtcyPa3y1x0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jgjO314gtTnF2nyfEW+IA5gRcjP8TzMisj/1uNLQxS+ATnsOt+HGjMrRcW5c23/rIv2VJkWFfTQtGJj9C1jT8EiiOHZ+x2WIQHlt+7esQKdfIar+/qzL43psk5JCdtGB7RDAuikC2FXKjWKNLV7XvbqgUIPjPGQJse8oLrxFdPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CRZl9kIp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A0C6C4AF1C;
	Mon, 17 Jun 2024 15:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718637356;
	bh=QmJ3aVwAViSIqgxOAxftmSPyWcZ6L9f2BtcyPa3y1x0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CRZl9kIpv4MuNy3RiRdGncDI35HIuaw/aYjmjoNIOrUHwE8BAEtI2N0aBJ5MU+mwk
	 DYHlof4ocpRGZS/QtJSZmv3oFMWX2zVRaxSeYYOWUxyuzgXwWxvrCCFEj//S7q/6Ve
	 6cJksg6gZcKwbHqECnWNz6bJfTdLNlSRXDAO5NEkJkC2t4iOljRNLoHCeNMWMk6v4q
	 vD3Gv90VJvK1Erec4vi7zzenow+poaVtL47jkAQ1xD2hmlX+FbI/mlULCRYZvHxHwW
	 CkDQ+RlVBtS0Mo844cU4yBZtAuBSDO9ZGV46y8jzimUEzcmj4JNTaQK/aQpK+q94ls
	 xyuNmRPj+qJBA==
Date: Mon, 17 Jun 2024 16:15:52 +0100
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
Message-ID: <20240617-provolone-dubiously-b572b6b92a67@spud>
References: <20240617092016.2958046-1-etienne.carriere@foss.st.com>
 <15b20cdd8b9148559352fdb2f02e4e53@foss.st.com>
 <20240617-shaky-amenity-5727816e00e1@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nHrgKeoucDqHGyar"
Content-Disposition: inline
In-Reply-To: <20240617-shaky-amenity-5727816e00e1@spud>


--nHrgKeoucDqHGyar
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 04:13:48PM +0100, Conor Dooley wrote:
> On Mon, Jun 17, 2024 at 09:21:13AM +0000, Etienne CARRIERE - foss wrote:
> > Hello Conor,
> >=20
> > >
> > > From: Conor Dooley <conor@kernel.org>
> > > Sent: Saturday, June 15, 2024 2:14 PM
> > >
> > > On Fri, Jun 14, 2024 at 05:33:46PM +0200, Etienne Carriere wrote:
> > > > Change include/dt-bindings/mfd/st,stpmic1.h license model from GPLv=
2.0
> > > > only to dual GPLv2.0 or BSD-3-Clause. I have every legitimacy to re=
quest
> > > > this change on behalf of STMicroelectronics. This change clarifies =
that
> > > > this DT binding header file can be shared with software components =
as
> > > > bootloaders and OSes that are not published under GPLv2 terms.
> > > >
> > > > In CC are all the contributors to this header file.
> > > >
> > > > Cc: Pascal Paillet <p.paillet@st.com>
> > > > Cc: Lee Jones <lee.jones@linaro.org>
> > > > Cc: Rob Herring <robh@kernel.org>
> > > > Signed-off-by: Etienne Carriere <etienne.carriere@foss.st.com>
> > > > ---
> > > >  include/dt-bindings/mfd/st,stpmic1.h | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/include/dt-bindings/mfd/st,stpmic1.h b/include/dt-bind=
ings/mfd/st,stpmic1.h
> > > > index 321cd08797d9..957c48300cd4 100644
> > > > --- a/include/dt-bindings/mfd/st,stpmic1.h
> > > > +++ b/include/dt-bindings/mfd/st,stpmic1.h
> > > > @@ -1,4 +1,4 @@
> > > > -/* SPDX-License-Identifier: GPL-2.0 */
> > > > +/* SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause */
> > >
> > > The usual dual license for bindings is BSD-2-Clause, was there a
> > > specific request for the 3 version?
> >=20
> > My mistake. Thanks for spotting that.
> > I have my company agreement for the 2 dual models: "OR BSD-2-Clause" an=
d "OR BSD-3-Clause".
> > We expect to conform to DT bindings preferred licensing model. Indeed t=
he kernel documentation explicitly mention "GPL-2.0-only OR BSD-2-Clause".
> > We prefer to conform with it. I'll update my patch.
> >=20
> > By the way, I'll fix Lee Jones e-mail address that is deprecated.
>=20
> I figure this is a send-email mistake cos you have to do something
> god-forsaken to send plaintext mail from the st mail system.

"this" being that you sent a v1 reply in the thread of the v2, before
then sending it again against v1.



--nHrgKeoucDqHGyar
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnBTJwAKCRB4tDGHoIJi
0i8IAQCzn/8d+y9j/xoe6e+dTeApGgYrRn5RV0JLgNvLQk8x7AEAp74HmuIN4/5z
w96zqtOzK7ZLgdUm9nZYOXa7YIa3igE=
=LcBY
-----END PGP SIGNATURE-----

--nHrgKeoucDqHGyar--

