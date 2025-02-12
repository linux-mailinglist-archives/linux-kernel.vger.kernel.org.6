Return-Path: <linux-kernel+bounces-510931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB06A323BE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52B611884084
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 10:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB6120897F;
	Wed, 12 Feb 2025 10:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="ipMsuynH"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CF9208961;
	Wed, 12 Feb 2025 10:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739357000; cv=none; b=YEm0c0MR6DX3iR2CUpPjN9zNPhWO65mrtoahqUOyqTSEjf3kgRNDIL6EB8u/YY66/R2C4rkQi08zgfvs89U1TVoh6kmev1p9kT1/93QUOkmtvX0nRuD31jZ7H7TjQTRtrT0ZYFPq5gnU2B2wuc+4Sud/dBI2liWkf+82vz9yiV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739357000; c=relaxed/simple;
	bh=PEgLGi85wfBAgtN5wIrl+0UZJ/400teFw4uAAuk5YPA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uF+5DG6YabXRMx1dbs6wvF92oQf4dvDVKW2Nb6gs2ePDMHxlRrA+W8G72L+5+oeSnlSnATtTB3sv2WP00s/hZmsnhBG8lm92OSjXKrFExg1yw6L4OtDM1TXG0itwBo5JE4QRS6E2jqmOo1NiChw68prIYJ06M3lQr/kyIOGmrwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=ipMsuynH; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1739356995;
	bh=uSUshi7NvbExCIOeg3/gTpV9pPHrLdwXno3NtF6Kyik=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ipMsuynHo/i3tITOY5ChJQGTfGR0NQUUlmL8FYwqV9ps3bqgRizExv+KtShTdE7x9
	 eENJOFyWdGugkLBk2JG3Wb0N3PzLOHqTgWTupLcYRTc+Rd2D8H6VyKgO4J7rfP0URp
	 K4Cpn7pGRvxOAIvHAIGesjdj+BOjp6TqiCPAVRYYo8JaHjKOhpDJ6w1+zMLtKMcDCH
	 bkQHkAYTCQpf/z4IcCwTxd4IlQA33DbfkpjzGyxdW/gCjhs6+Xe8/noC6OmmNeNa4s
	 0UweQKkT51Plsf8F/W5x2QYXTO1fiQo+WV5wkfMLJQgnR/N0+kV6Utcpv92zfUa0WY
	 cGgCPH6AMuF5g==
Received: from [192.168.68.112] (58-6-175-176.dyn.iinet.net.au [58.6.175.176])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 28C7D757B6;
	Wed, 12 Feb 2025 18:43:14 +0800 (AWST)
Message-ID: <4619661d7375c71710a22520f6ebbf353a5aff59.camel@codeconstruct.com.au>
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: ir38060: Move & update dt
 binding
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Conor Dooley <conor@kernel.org>, Naresh Solanki
	 <naresh.solanki@9elements.com>
Cc: Guenter Roeck <linux@roeck-us.net>, broonie@kernel.org, Jean Delvare
 <jdelvare@suse.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Liam Girdwood
 <lgirdwood@gmail.com>, linux-hwmon@vger.kernel.org,
 devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org
Date: Wed, 12 Feb 2025 21:13:11 +1030
In-Reply-To: <20250206-camera-mashed-48cf0cf1715f@spud>
References: <20250204180306.2755444-1-naresh.solanki@9elements.com>
	 <20250204-mulled-evaluate-8a690cdfbd4d@spud>
	 <CABqG17jHKfwJEfZxto_YA4opS8=QwqTqfNdkku8kcEv2_iW+XA@mail.gmail.com>
	 <20250205-purge-debating-21273d3b0f40@spud>
	 <CABqG17j4tKXnMZ5=vcjBvfe6JwCLQ6NbkQmJC9ySK_bmGEv=iQ@mail.gmail.com>
	 <20250206-camera-mashed-48cf0cf1715f@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-02-06 at 18:09 +0000, Conor Dooley wrote:
> On Thu, Feb 06, 2025 at 09:23:03PM +0530, Naresh Solanki wrote:
> > On Thu, 6 Feb 2025 at 01:43, Conor Dooley <conor@kernel.org> wrote:
> > > On Wed, Feb 05, 2025 at 03:51:25PM +0530, Naresh Solanki wrote:
> > > > On Wed, 5 Feb 2025 at 00:52, Conor Dooley <conor@kernel.org>
> > > > wrote:
> > > > > On Tue, Feb 04, 2025 at 11:33:03PM +0530, Naresh Solanki
> > > > > wrote:
> > > > > > Move dt binding under hwmon/pmbus & align accordingly.
> > > > > >=20
> > > > > > Signed-off-by: Naresh Solanki
> > > > > > <naresh.solanki@9elements.com>
> > > > > > ---
> > > > > > =C2=A0.../hwmon/pmbus/infineon,ir38060.yaml=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 61
> > > > > > +++++++++++++++++++
> > > > > > =C2=A0.../bindings/regulator/infineon,ir38060.yaml=C2=A0 | 45 -=
------
> > > > > > -------
> > > > > > =C2=A02 files changed, 61 insertions(+), 45 deletions(-)
> > > > > > =C2=A0create mode 100644
> > > > > > Documentation/devicetree/bindings/hwmon/pmbus/infineon,ir38
> > > > > > 060.yaml
> > > > > > =C2=A0delete mode 100644
> > > > > > Documentation/devicetree/bindings/regulator/infineon,ir3806
> > > > > > 0.yaml
> > > > > >=20
> > > > > > diff --git
> > > > > > a/Documentation/devicetree/bindings/hwmon/pmbus/infineon,ir
> > > > > > 38060.yaml
> > > > > > b/Documentation/devicetree/bindings/hwmon/pmbus/infineon,ir
> > > > > > 38060.yaml
> > > > > > new file mode 100644
> > > > > > index 000000000000..e1f683846a54
> > > > > > --- /dev/null
> > > > > > +++
> > > > > > b/Documentation/devicetree/bindings/hwmon/pmbus/infineon,ir
> > > > > > 38060.yaml
> > > > > > @@ -0,0 +1,61 @@
> > > > > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > > > > > +%YAML 1.2
> > > > > > +---
> > > > > > +$id:
> > > > > > http://devicetree.org/schemas/hwmon/pmbus/infineon,ir38060.yaml=
#
> > > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > > +
> > > > > > +title: Infineon Buck Regulators with PMBUS interfaces
> > > > > > +
> > > > > > +maintainers:
> > > > > > +=C2=A0 - Not Me.
> > > > >=20
> > > > > How the hell did this get merged!
> > > > >=20
> > > > > > +
> > > > > > +properties:
> > > > > > +=C2=A0 compatible:
> > > > > > +=C2=A0=C2=A0=C2=A0 enum:
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - infineon,ir38060
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - infineon,ir38064
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - infineon,ir38164
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - infineon,ir38263
> > > > > > +
> > > > > > +=C2=A0 reg:
> > > > > > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > > > > > +
> > > > > > +=C2=A0 regulators:
> > > > > > +=C2=A0=C2=A0=C2=A0 type: object
> > > > > > +=C2=A0=C2=A0=C2=A0 description:
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list of regulators provided by =
this controller.
> > > > >=20
> > > > > Can you explain why this change is justified? Your commit
> > > > > message is
> > > > > explaining what you're doing but not why it's okay to do.
> > >=20
> > > > This is based on other similar dt-bindings under hwmon/pmbus.
> > >=20
> > > Okay, but what I am looking for is an explanation of why it is
> > > okay to
> > > change the node from
> > >=20
> > > > regulator@34 {
> > > > =C2=A0 compatible =3D "infineon,ir38060";
> > > > =C2=A0 reg =3D <0x34>;
> > > >=20
> > > > =C2=A0 regulator-min-microvolt =3D <437500>;
> > > > =C2=A0 regulator-max-microvolt =3D <1387500>;
> > > > };
> > As I have understood the driver, this isn't supported.
> > >=20
> > > to
> > >=20
> > > > regulator@34 {
> > > > =C2=A0=C2=A0=C2=A0 compatible =3D "infineon,ir38060";
> > > > =C2=A0=C2=A0=C2=A0 reg =3D <0x34>;
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0 regulators {
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vout {
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
regulator-name =3D "p5v_aux";
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
regulator-min-microvolt =3D <437500>;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
regulator-max-microvolt =3D <1387500>;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> > > > =C2=A0=C2=A0=C2=A0 };
> > Above is the typical approach in other pmbus dt bindings.
> > Even pmbus driver expects this approach.
> > >=20
> > > ?
> > >=20
> > > Will the driver handle both of these identically? Is backwards
> > > compatibility with the old format maintained? Was the original
> > > format
> > > wrong and does not work? Why is a list of regulators needed when
> > > the
> > > device only provides one?
> > Driver doesn't support both.
> > Based on the pmbus driver original format was wrong.
> > pmbus driver looks for a regulator node to start with.
> >=20
> > Reference:
> > https://github.com/torvalds/linux/blob/master/drivers/hwmon/pmbus/pmbus=
.h#L515
>=20
> Then all of the in-tree users are all just broken? They're in aspeed
> bmcs, so I would not be surprised at all if that were the case.

Can you unpack the intent of this remark for me a little?

The history of the problem from what I can see looks like:

   1. pmbus regulator support exploiting "regulators" as an OF child
      node was merged for 3.19[1]
   2. The infineon driver support was merged with trivial bindings[2]
      and released in v5.17
   3. A patch was proposed that extracted the Infineon regulator
      compatibles and provided a dedicated binding[3], however it
      lacked the "regulators" object property=20
   4. The patch in 3 was merged as [4] with relevant tags, and was
      released in v6.9
   5. The system1 devicetree was merged and released in v6.10, and sbp1
      is merged in v6.14-rc1 for release in v6.14. Both devicetrees, as
      far as I'm aware, conform to the binding as written.

In addition to keeping an eye out for Rob's bot, I check all Aspeed-
related devicetree patches against the bindings using the usual tooling
while applying them. I would like to avoid diving into driver
implementations as a blocker to applying devicetree patches where
possible - the formalised bindings and tooling should exist to separate
us from having to do that.

If the complaint is that people submitting Aspeed devicetree patches
are regularly not testing them to make sure they behave correctly on
hardware, then sure, that's something to complain about. Otherwise, I'm
well aware of the (Aspeed) bindings and warnings situation; we've
spoken about it previously. If there's something I should change in my
process (beyond eventually addressing all the warnings) please let me
know, but I don't see that there is in this specific instance.

Andrew

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/com=
mit/?id=3Dddbb4db4ced1ba784fcd3500179a7291b6c5d7b7
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/com=
mit/?id=3Dca003af3aa1574646b784abee861626a52d345ea
[3]: https://lore.kernel.org/all/20240223-blabber-obnoxious-353e519541a6@sp=
ud/
[4]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/com=
mit/?id=3Dbad582f9879812bcf74adb520e005051eb021cfb


