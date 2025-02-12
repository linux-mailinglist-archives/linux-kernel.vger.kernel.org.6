Return-Path: <linux-kernel+bounces-511719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B61A32EBE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 19:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4B6E1882DBF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 18:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0216A25E463;
	Wed, 12 Feb 2025 18:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZnJsAKTn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547FE21772B;
	Wed, 12 Feb 2025 18:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739385213; cv=none; b=bMnPB36UqcwiXMuEV5er07BXZCJh0vc8zHcpZND7wz7ju43ZbL/Xozc01Qf1xlL7FLNTowFupdXqyxz4BrSDFRvoTrflqSyttmsC7q+Zw7ZkleDOjC84huqoAFh4oOFWwTQLfOX2Ldoi28UhyKJTOwszo/NjDHJA9IRZpHFY1jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739385213; c=relaxed/simple;
	bh=4bOM/FIXiCKAaqtu0rcCrL4oIkDHbGqukW89B+sSCgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=faX3pABHVBvQzGMFa7oepO6tD8CTEydBcKQmb06PQ60a/oNMHYpbtP4AcYNw5Bw5uvNSa9bqnP7bygGkqsvXoeVZMBDDmcvmqltUhEBK4fYDt4/rDi/ZrMXDMiY8ov/4mASBTFCxLxIJY1kVcO5/CSjwLww1YmW+04jH1wi3dBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZnJsAKTn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50441C4CEDF;
	Wed, 12 Feb 2025 18:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739385212;
	bh=4bOM/FIXiCKAaqtu0rcCrL4oIkDHbGqukW89B+sSCgs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZnJsAKTnr7BFRmGY4myKt1mjjTTdzUBZFxzsIr21Bl5GenPsBB4jyFpxPtarKAz/h
	 JxsS1KymIOO3kmRvTRsxcnDyUZSe29xrjfagP2JICYCm7CGKrRS8+lcPBoj+dHyhww
	 AWRmNG9iaAG8s+KmMYYJsiHban3KhOCDOakKonq288MCUGwaWqG82Gk6gGwP/p1mRK
	 KTUQgH0nwfyEyqNDCGAM88xGEtoIdHVw4EP3hlr84JWXqHosQtBDqblbHSBBm0D+CN
	 rMqX00OyvjCKlwN0oR1E1Nk0lUHNpCImv7pdKCm3xMjmDuthzkLBeh9+cIois7EtpN
	 gSxJl6a3gqbew==
Date: Wed, 12 Feb 2025 18:33:27 +0000
From: Conor Dooley <conor@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Naresh Solanki <naresh.solanki@9elements.com>,
	Guenter Roeck <linux@roeck-us.net>, broonie@kernel.org,
	Jean Delvare <jdelvare@suse.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Patrick Rudolph <patrick.rudolph@9elements.com>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: ir38060: Move & update dt binding
Message-ID: <20250212-concierge-apricot-e5d3627afe93@spud>
References: <20250207132806.3113268-1-naresh.solanki@9elements.com>
 <20250212175713.GA4032715-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="q86RRbylpu2fsoJR"
Content-Disposition: inline
In-Reply-To: <20250212175713.GA4032715-robh@kernel.org>


--q86RRbylpu2fsoJR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 11:57:13AM -0600, Rob Herring wrote:
> On Fri, Feb 07, 2025 at 06:58:03PM +0530, Naresh Solanki wrote:
> > Move dt binding under hwmon/pmbus & align accordingly.
> >=20
> > Previously the DT binding was invalid & wouldn't work with pmbus driver.
> > Pmbus driver expects a regulator node & hence added the same.
>=20
> 2 out of 3 (schema, dts, driver) agree. Fix the driver.
>=20
> >=20
> > Fixes: 1d333cd641fb ("ARM: dts: aspeed: sbp1: IBM sbp1 BMC board")
> > Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> > ---
> > Changes in V2:
> > 1. Update commit message
> > 2. Add Fixes tags
> > ---
> >  .../hwmon/pmbus/infineon,ir38060.yaml         | 61 +++++++++++++++++++
> >  .../bindings/regulator/infineon,ir38060.yaml  | 45 --------------
> >  2 files changed, 61 insertions(+), 45 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/hwmon/pmbus/infin=
eon,ir38060.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/regulator/infineo=
n,ir38060.yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/hwmon/pmbus/infineon,ir3=
8060.yaml b/Documentation/devicetree/bindings/hwmon/pmbus/infineon,ir38060.=
yaml
> > new file mode 100644
> > index 000000000000..e1f683846a54
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/hwmon/pmbus/infineon,ir38060.ya=
ml
> > @@ -0,0 +1,61 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/hwmon/pmbus/infineon,ir38060.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Infineon Buck Regulators with PMBUS interfaces
> > +
> > +maintainers:
> > +  - Not Me.
>=20
> Nothing new here, but WTF. Expect a meta-schema change to warn on this.

And it was fucking me that did it, that's the best/worst part about it.

--q86RRbylpu2fsoJR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ6zpdwAKCRB4tDGHoIJi
0pPhAQDm9PaQGFUozl6rpFK+5IJJiMv1pvPRBjbcc9czvxlCZAD/S2UXhp/ZKU9c
4DvwhwsglyEPYXtoKDMimf41Vc/x+AE=
=i2Ft
-----END PGP SIGNATURE-----

--q86RRbylpu2fsoJR--

