Return-Path: <linux-kernel+bounces-511741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29660A32F00
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 19:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA628188A214
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 18:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14B4260A5E;
	Wed, 12 Feb 2025 18:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uq0bUH3b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F22625EFA6;
	Wed, 12 Feb 2025 18:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739386582; cv=none; b=pBmRfs02H1o8Wi4BGp1WxPcTXqz1FwXgqSSDfrpSkh6AL5BD/9sSbFnOIZ8+nao98UoRf0O5Hk8oqk25Dxp4EfJwA5bv3BLaTCPOobdHLq+tymIKzQhuREeSX6VmbcsTojyuj+SeDEhMUxGUzwV1zqPdQ5PtrC5pWtCMXljc3SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739386582; c=relaxed/simple;
	bh=9nADrqvmSd+RkR3Vu2+WkunRUqakk0t+t3TBqV79ouw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hISl+kW7LOv4geOZn5BHEjTfFNtljc7GAnGFQM8pFi0Az9wDuWFS+IF4HsWh5NVWxWAo2VjMwRud9SsGGBq0E+iHPEA0ECMTn1rI5pPVq+OgsFq963jBIuPFk2aEYwtEe37QUdCt3StGL4UqP+LKLlg3mwx0TFUb5lRWZpK9nGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uq0bUH3b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44C11C4CEDF;
	Wed, 12 Feb 2025 18:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739386581;
	bh=9nADrqvmSd+RkR3Vu2+WkunRUqakk0t+t3TBqV79ouw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uq0bUH3bmbJGBLRXLDHsBUanxoeiEjGF10s//SwSMGTEo3PAV0hRcgYrd+QL5joA/
	 nGX8ANYZNYyaQ5yHOqPWVtiKVUl6cAe51pDXBze/OHnt0MKJqRNwZJczGtN/8itEog
	 44wJBdHVRdJDliIEA8XhojiK+GOd/YSz8Fwayev1xRQzcSOjTy+E/M7ls2GVSQywFO
	 lmH4pG5W2WH7cwrFpczq44aEuK6QYEb/s613UYIXHIptsG4RsSdJUpjhWFRdKViz7Z
	 R7l1td34zJS6YVq68/rGVFlcOlU7fqcfEw1s7Zt2ptog6vsTdW3zWwvk5TMQjQKhTU
	 mV8PqmUTcITmQ==
Date: Wed, 12 Feb 2025 18:56:16 +0000
From: Conor Dooley <conor@kernel.org>
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Naresh Solanki <naresh.solanki@9elements.com>,
	Guenter Roeck <linux@roeck-us.net>, broonie@kernel.org,
	Jean Delvare <jdelvare@suse.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: ir38060: Move & update dt binding
Message-ID: <20250212-estate-tapeless-08fcdf5b5ca5@spud>
References: <20250204180306.2755444-1-naresh.solanki@9elements.com>
 <20250204-mulled-evaluate-8a690cdfbd4d@spud>
 <CABqG17jHKfwJEfZxto_YA4opS8=QwqTqfNdkku8kcEv2_iW+XA@mail.gmail.com>
 <20250205-purge-debating-21273d3b0f40@spud>
 <CABqG17j4tKXnMZ5=vcjBvfe6JwCLQ6NbkQmJC9ySK_bmGEv=iQ@mail.gmail.com>
 <20250206-camera-mashed-48cf0cf1715f@spud>
 <4619661d7375c71710a22520f6ebbf353a5aff59.camel@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Goqo5Z76kPyfbM/h"
Content-Disposition: inline
In-Reply-To: <4619661d7375c71710a22520f6ebbf353a5aff59.camel@codeconstruct.com.au>


--Goqo5Z76kPyfbM/h
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 09:13:11PM +1030, Andrew Jeffery wrote:
> On Thu, 2025-02-06 at 18:09 +0000, Conor Dooley wrote:
> > On Thu, Feb 06, 2025 at 09:23:03PM +0530, Naresh Solanki wrote:
> > > On Thu, 6 Feb 2025 at 01:43, Conor Dooley <conor@kernel.org> wrote:
> > > > On Wed, Feb 05, 2025 at 03:51:25PM +0530, Naresh Solanki wrote:
> > > > > On Wed, 5 Feb 2025 at 00:52, Conor Dooley <conor@kernel.org>
> > > > > wrote:
> > > > > > On Tue, Feb 04, 2025 at 11:33:03PM +0530, Naresh Solanki
> > > > > > wrote:
> > > > > > > +=A0 regulators:
> > > > > > > +=A0=A0=A0 type: object
> > > > > > > +=A0=A0=A0 description:
> > > > > > > +=A0=A0=A0=A0=A0 list of regulators provided by this controll=
er.
> > > > > >=20
> > > > > > Can you explain why this change is justified? Your commit
> > > > > > message is
> > > > > > explaining what you're doing but not why it's okay to do.
> > > >=20
> > > > > This is based on other similar dt-bindings under hwmon/pmbus.
> > > >=20
> > > > Okay, but what I am looking for is an explanation of why it is
> > > > okay to
> > > > change the node from
> > > >=20
> > > > > regulator@34 {
> > > > > =A0 compatible =3D "infineon,ir38060";
> > > > > =A0 reg =3D <0x34>;
> > > > >=20
> > > > > =A0 regulator-min-microvolt =3D <437500>;
> > > > > =A0 regulator-max-microvolt =3D <1387500>;
> > > > > };
> > > As I have understood the driver, this isn't supported.
> > > >=20
> > > > to
> > > >=20
> > > > > regulator@34 {
> > > > > =A0=A0=A0 compatible =3D "infineon,ir38060";
> > > > > =A0=A0=A0 reg =3D <0x34>;
> > > > >=20
> > > > > =A0=A0=A0 regulators {
> > > > > =A0=A0=A0=A0=A0=A0=A0 vout {
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 regulator-name =3D "p5v_aux";
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 regulator-min-microvolt =3D <43=
7500>;
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 regulator-max-microvolt =3D <13=
87500>;
> > > > > =A0=A0=A0=A0=A0=A0=A0 };
> > > > > =A0=A0=A0 };
> > > Above is the typical approach in other pmbus dt bindings.
> > > Even pmbus driver expects this approach.
> > > >=20
> > > > ?
> > > >=20
> > > > Will the driver handle both of these identically? Is backwards
> > > > compatibility with the old format maintained? Was the original
> > > > format
> > > > wrong and does not work? Why is a list of regulators needed when
> > > > the
> > > > device only provides one?
> > > Driver doesn't support both.
> > > Based on the pmbus driver original format was wrong.
> > > pmbus driver looks for a regulator node to start with.
> > >=20
> > > Reference:
> > > https://github.com/torvalds/linux/blob/master/drivers/hwmon/pmbus/pmb=
us.h#L515
> >=20
> > Then all of the in-tree users are all just broken? They're in aspeed
> > bmcs, so I would not be surprised at all if that were the case.
>=20
> Can you unpack the intent of this remark for me a little?
>=20
> The history of the problem from what I can see looks like:
>=20
>    1. pmbus regulator support exploiting "regulators" as an OF child
>       node was merged for 3.19[1]
>    2. The infineon driver support was merged with trivial bindings[2]
>       and released in v5.17
>    3. A patch was proposed that extracted the Infineon regulator
>       compatibles and provided a dedicated binding[3], however it
>       lacked the "regulators" object property=20
>    4. The patch in 3 was merged as [4] with relevant tags, and was
>       released in v6.9
>    5. The system1 devicetree was merged and released in v6.10, and sbp1
>       is merged in v6.14-rc1 for release in v6.14. Both devicetrees, as
>       far as I'm aware, conform to the binding as written.
>=20
> In addition to keeping an eye out for Rob's bot, I check all Aspeed-
> related devicetree patches against the bindings using the usual tooling
> while applying them. I would like to avoid diving into driver
> implementations as a blocker to applying devicetree patches where
> possible - the formalised bindings and tooling should exist to separate
> us from having to do that.
>=20
> If the complaint is that people submitting Aspeed devicetree patches
> are regularly not testing them to make sure they behave correctly on
> hardware, then sure, that's something to complain about. Otherwise, I'm
> well aware of the (Aspeed) bindings and warnings situation; we've
> spoken about it previously. If there's something I should change in my
> process (beyond eventually addressing all the warnings) please let me
> know, but I don't see that there is in this specific instance.

Ye, it's not a jab at aspeed maintainership, it's about the bmc stuff in
particular. I saw far too many warnings from Rob's bot on series with a
version number where the submitter should know better, so the idea that
it had not been tested in other ways wasn't exactly a stretch.

I made a mistake how I pulled these devices out of trivial-devices.yaml,
given the existing driver didn't work with that binding, but I don't
really see why there's a requirement for a regulator child here in the
first place. I get it for something like the lm25066 that is a monitor
IC that you connect a regulator to, as the regulator is a distinct
device - but the ir38060 is a regulator that has a pmbus interface so
both describe the same device.

--Goqo5Z76kPyfbM/h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ6zu0AAKCRB4tDGHoIJi
0g5gAP9XawTv8CeajYNDtlFLghvuq9+6wI71Nn8SIJaxFGjF/QD+NL5Y8YL3A0/q
aWbx+PzMnYTfBOtgcwsjm5/rq9cexg8=
=u98b
-----END PGP SIGNATURE-----

--Goqo5Z76kPyfbM/h--

