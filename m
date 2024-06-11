Return-Path: <linux-kernel+bounces-210399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF9D904323
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 20:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7D9C1F25A78
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 18:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734845BAF0;
	Tue, 11 Jun 2024 18:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BKozxI8G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B4838FA1;
	Tue, 11 Jun 2024 18:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718129253; cv=none; b=dCCxK01Ll/6CW7nQea7AvoGA+TNkYS9quj9sjevFIoA67/MawUO3k6bmTaxjhbE3KaYJmcgQW3pEy/SL46h0FtRg5XXhpt6jN7XIANdoiroloP16IbkS04LB3/yxsWyoHWhyYy0F9xzFXVqWJe8iRKmI0rS25qcx+3ySySOel4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718129253; c=relaxed/simple;
	bh=q4ZS2OwCpxxeV67ovBwERfgyqxYXGvy54YBgY6MfW2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hntWRRR1ebdmO4gUL+wRt1vqoiFb+2OnzXMMN8EZVmJJWeXbMuQ+jB1Rd9vjzNiKnv+7p25kYU5osOpn13bF2tkqLudeM8dp9zTU7L6NZO9wNXh/UAGIoBy/+/ldJQWbARYlLYNNifuy7cjh0VT4HRVtmpr1Lqc21oMQ2Ex49ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BKozxI8G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D37D2C2BD10;
	Tue, 11 Jun 2024 18:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718129253;
	bh=q4ZS2OwCpxxeV67ovBwERfgyqxYXGvy54YBgY6MfW2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BKozxI8GgPA73uR1P6gT1vsk/yJQHb2TFCDkYWU+nLY9ttHzEZHv+Gr4gFgbCh/UY
	 3Yu0KevNqdZ6b2xzAXLbiX8KB4OEJMqC0CLkIWlj0xGJYrL4sgu/JN4A8j2FqXyriG
	 AuvPQCRvyZbDri+T0EWxs3AcT8pAq/Z8Ym5Krv4myK6d5iuUkn5a4no4ZHSlxIwQjo
	 kmasB1D9gohJi4qBWI+bDyyKq++i7ga6f3AsDPSE4G0bRMDZAmlNLPgIZKO7dffKbO
	 Y5KzLxP0UVSwU482LCUpDIFgKYZrcdcE4lnRM4ESl+Ygy60w2sJNx+hcMhkPeCP65h
	 y3Mat9pprabgA==
Date: Tue, 11 Jun 2024 19:07:28 +0100
From: Conor Dooley <conor@kernel.org>
To: Viacheslav <adeep@lexina.in>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 3/4] dt-bindings: arm: amlogic:
 amlogic,meson-gx-ao-secure: add secure-monitor property
Message-ID: <20240611-undying-earthy-00236ac251aa@spud>
References: <20240610084032.3096614-1-adeep@lexina.in>
 <20240610084032.3096614-4-adeep@lexina.in>
 <20240610-dropout-compress-6d6a9b749524@spud>
 <4866f6d4-2e3c-40c7-a8cb-ba4e422ffef6@lexina.in>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sJ1nEYGXW16faEE9"
Content-Disposition: inline
In-Reply-To: <4866f6d4-2e3c-40c7-a8cb-ba4e422ffef6@lexina.in>


--sJ1nEYGXW16faEE9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 01:25:11PM +0300, Viacheslav wrote:
> Hi!
>=20
> 10/06/2024 19.08, Conor Dooley wrote:
> > On Mon, Jun 10, 2024 at 11:39:49AM +0300, Viacheslav Bocharov wrote:
> > > Add secure-monitor property to schema for meson-gx-socinfo-sm driver.
> >=20
> > "bindings are for hardware, not drivers". Why purpose does the "secure
> > monitor" serve that the secure firmware needs a reference to it?
>=20
> This driver is an extension to the meson-gx-socinfo driver: it supplements
> information obtained from the register with information from the
> SM_GET_CHIP_ID secure monitor call. Due to the specifics of the module
> loading order, we cannot do away with meson-gx-socinfo, as it is used for
> platform identification in some drivers. Therefore, the extended informat=
ion
> is formatted as a separate driver, which is loaded after the secure-monit=
or
> driver.

Please stop talking about drivers, this is a binding which is about
hardware. Please provide, in your next version, a commit message that
justifies adding this property without talking about driver probing
order etc, and instead focuses on what service the "secure monitor"
provides etc.

> The ability to obtain additional information depends on the support for t=
he
> call in the secure-monitor, which can be described by an additional link
> from the amlogic,meson-gx-ao-secure node to the secure-monitor node, simi=
lar
> to how it is done for amlogic,meson-gxbb-efuse.
>=20
> >=20
> > Thanks,
> > Conor.
> >=20
> > >=20
> > > Signed-off-by: Viacheslav Bocharov <adeep@lexina.in>
> > > ---
> > >   .../bindings/arm/amlogic/amlogic,meson-gx-ao-secure.yaml      | 4 +=
+++
> > >   1 file changed, 4 insertions(+)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/arm/amlogic/amlogic,me=
son-gx-ao-secure.yaml b/Documentation/devicetree/bindings/arm/amlogic/amlog=
ic,meson-gx-ao-secure.yaml
> > > index 7dff32f373cb..1128a794ec89 100644
> > > --- a/Documentation/devicetree/bindings/arm/amlogic/amlogic,meson-gx-=
ao-secure.yaml
> > > +++ b/Documentation/devicetree/bindings/arm/amlogic/amlogic,meson-gx-=
ao-secure.yaml
> > > @@ -32,6 +32,10 @@ properties:
> > >     reg:
> > >       maxItems: 1
> > > +  secure-monitor:
> >=20
> > Missing a vendor prefix.
> >=20
> > > +    description: phandle to the secure-monitor node
> > > +    $ref: /schemas/types.yaml#/definitions/phandle
> > > +
> > >     amlogic,has-chip-id:
> > >       description: |
> > >         A firmware register encodes the SoC type, package and revision
> > > --=20
> > > 2.45.2
> > >=20
> > >=20
> > > _______________________________________________
> > > linux-amlogic mailing list
> > > linux-amlogic@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-amlogic
>=20
> --
> with regards,
> Viacheslav

--sJ1nEYGXW16faEE9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZmiSYAAKCRB4tDGHoIJi
0jycAQCDqoXCDGSzgqjdRrhl84TptzMFUZFgRNdHcGZOOTvlbQEA8E53g1Xc26vR
Urb8lH1R3nEkVzk3384ZJv7yIgQXtw8=
=wUCV
-----END PGP SIGNATURE-----

--sJ1nEYGXW16faEE9--

