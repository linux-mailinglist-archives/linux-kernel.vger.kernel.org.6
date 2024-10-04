Return-Path: <linux-kernel+bounces-350718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0D5990868
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 18:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42F521F20FF5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 16:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877D01C305E;
	Fri,  4 Oct 2024 16:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r3jNf24c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95501E3765;
	Fri,  4 Oct 2024 16:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728057746; cv=none; b=K2fIwALzhqemd5wqd04E7nrED0S+kBmeUa5XnizRWjWzUWUHQNVV3xBlmVN5GXtBHLrRc4gK3EWqZlYBfZ5vMqV462dja8VX4XQzJ5Nr3xacpdNbReI6bGujaCY5N0caZr9FtznCfwskdCU37vBkmzBu0gpVVMGDb2G7mgt8U/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728057746; c=relaxed/simple;
	bh=33tPyCvrAOcvV+7O6+RLla52zkKYuAa9S3xf+ijQPTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LtfiCoyvQ/pFaPDVLPrYrFNTiqoGQdi8lgnDX9xoGqIpRjV+O+wpzCc466Itmb4POQ0qkoWJqyiom0ptmhMRlqTihyMwHM4cCYRvL6coyulTnQbna9aMtsP5V0t8RUvjFZB/vM/KAHVgOAIUnCUlj6FDxeKVsX9bQdENWKMp4Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r3jNf24c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BC82C4CEC6;
	Fri,  4 Oct 2024 16:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728057745;
	bh=33tPyCvrAOcvV+7O6+RLla52zkKYuAa9S3xf+ijQPTk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r3jNf24cXdAIg8YTKOl5JpyTemjP/MP1fzObQ1SRsxOeQGaTc7LP2/Bk80LQMTkQV
	 NW3T7+EM41usYFJF838Lpcv/NbFdihIRR0TiFsk22ud3DxA21HsYDfl6sTgzBPnUZS
	 ARh75ISqVZumJLceZN5fJjYtnTEMJBLemy836mdYflIdFMSxXvdiZuMUTJt9uSD+zl
	 UT+7bUt6Nobx9+MTz7cW/tcEZM521+lgdbq7ZNngoduaFIWWmq4wdAbf7VYfbWKo7E
	 EJdgAsYRj5YNeKjxLsb3bNGaVdbTF2Ys3okiCG8vBGAQfLVXovAoSn8k8VIAPZqwgD
	 B0AmfixzObzBA==
Date: Fri, 4 Oct 2024 17:02:21 +0100
From: Conor Dooley <conor@kernel.org>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Parth Pancholi <parth.pancholi@toradex.com>,
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: usb: add TUSB73x0 PCIe
Message-ID: <20241004-subtitle-bulk-a56af82de67a@spud>
References: <20241004124521.53442-1-francesco@dolcini.it>
 <20241004124521.53442-2-francesco@dolcini.it>
 <20241004-calzone-sitcom-0f755e244497@spud>
 <ZwAKOKQ96sCoxsMN@gaggiata.pivistrello.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WlmiziZ1ocnCX/fq"
Content-Disposition: inline
In-Reply-To: <ZwAKOKQ96sCoxsMN@gaggiata.pivistrello.it>


--WlmiziZ1ocnCX/fq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 04, 2024 at 05:31:04PM +0200, Francesco Dolcini wrote:
> Hello Conor,
>=20
> On Fri, Oct 04, 2024 at 04:23:18PM +0100, Conor Dooley wrote:
> > On Fri, Oct 04, 2024 at 02:45:20PM +0200, Francesco Dolcini wrote:
> > > From: Parth Pancholi <parth.pancholi@toradex.com>
> > >=20
> > > Add device tree bindings for TI's TUSB73x0 PCIe-to-USB 3.0 xHCI
> > > host controller. The controller supports software configuration
> > > through PCIe registers, such as controlling the PWRONx polarity
> > > via the USB control register (E0h).
> > >=20
> > > Similar generic PCIe-based bindings can be found as qcom,ath11k-pci.y=
aml
> > > as an example.
> > >=20
> > > Datasheet: https://www.ti.com/lit/ds/symlink/tusb7320.pdf
> > > Signed-off-by: Parth Pancholi <parth.pancholi@toradex.com>
> > > Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > > ---
> > >  .../bindings/usb/ti,tusb73x0-pci.yaml         | 60 +++++++++++++++++=
++
> > >  1 file changed, 60 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/usb/ti,tusb73x0=
-pci.yaml
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/usb/ti,tusb73x0-pci.ya=
ml b/Documentation/devicetree/bindings/usb/ti,tusb73x0-pci.yaml
> > > new file mode 100644
> > > index 000000000000..bcb619b08ad3
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/usb/ti,tusb73x0-pci.yaml
> > > @@ -0,0 +1,60 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/usb/ti,tusb73x0-pci.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: TUSB73x0 USB 3.0 xHCI Host Controller (PCIe)
> > > +
> > > +maintainers:
> > > +  - Francesco Dolcini <francesco.dolcini@toradex.com>
> > > +
> > > +description:
> > > +  TUSB73x0 USB 3.0 xHCI Host Controller via PCIe x1 Gen2 interface.
> > > +  The TUSB7320 supports up to two downstream ports, the TUSB7340 sup=
ports up
> > > +  to four downstream ports.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: pci104C,8241
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  ti,tusb7320-pwron-polarity-invert:
> >=20
> > To me, "polarity-invert" makes less sense than calling this "active-hig=
h"
> > making the property a flag. active-low would then be the case where the
> > property is not provided. Given you don't make the property required,
> > what you've got here is effectively a flag anyway.
>=20
> We had the same doubt when deciding which property name to propose, looki=
ng
> at the existing bindings it seemed that "polarity-invert" was more common.
>=20
> FTR the datasheet explicetly name the signals with a # suffix (PWRON1#,
> PWRON2#, ...), they are defined as active-low by default.
>=20
> With that said, if we prefer to have `ti,tusb7320-pwron-active-high`, I a=
m 100%
> good with it.

I think "active-high" is more explicit about what it does, but I'm not
too bothered about it. Given it isn't a required property and the
absence of the property means active-low (for backwards compatibility
and alignment with the default hardware behaviour) the property is a
flag, not a boolean, so it does need a type change at the very least.

Cheers,
Conor.

--WlmiziZ1ocnCX/fq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZwARjQAKCRB4tDGHoIJi
0h3NAP917btguu42PpJH87OJzJXq3Vt4fBleinmRdbEH7aPZ6gD+Jrb8ReHNCB7F
dmbiAbKvHr+Bw+EwddORsppu5ZcICgU=
=sN0O
-----END PGP SIGNATURE-----

--WlmiziZ1ocnCX/fq--

