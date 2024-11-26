Return-Path: <linux-kernel+bounces-422682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CA59D9CE5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 18:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 328932841F1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 17:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094FA1DBB3A;
	Tue, 26 Nov 2024 17:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZqZyTvwh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FCE182BC;
	Tue, 26 Nov 2024 17:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732643456; cv=none; b=hqZ4luFU5ceyydpri9wIIorXe7sB6WCOmA1LxWDlXLI4AGCCo+HrDtJO0ZDM/QtLH7EE37oA/OJemkFDse03vaUlaesulpGIs8ot5lppWJN0No9Vr2Klt759cG3Vyl2YQnwO2zFtvEP/UtpQmqMFNnTeU+pClmTSOAVV1xaSsDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732643456; c=relaxed/simple;
	bh=1DHm33+nWlMW/ddeJDObXBwfsVPCV4BRLDeq6xv2wko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ieHkdmxs4zzWSb85wV4NoxjDxVDW1NpMxALTlj8NsOk6Xa29tbHLR0CAwSpisV2Gz/B0fJX7AloFOLUUdOfpZXOde5/i+n+5CXbo8Qt2K7/TMCHVpLECZau9NYqfgdQNK8BtY/pNxajPRrUt8OhWNr0DPNmGBS+xAEfXUdJJaEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZqZyTvwh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D032C4CED0;
	Tue, 26 Nov 2024 17:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732643455;
	bh=1DHm33+nWlMW/ddeJDObXBwfsVPCV4BRLDeq6xv2wko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZqZyTvwhXugY0c+2UWdmDVxUgh7efgeOon4J4wUR5uRQQm2ZEqtDgEhkFBQFGECct
	 MkLhICN7p0cfzrPw1ctoTKxvtHXqfY2im98LWnrF9iA+IMy6p4e/b0HAK7533EPxVq
	 IJMUh0a3EJmAAzqdHeA/Xhy1cOJq2Lue6UR7WDZaudS8c3QdBO7jgBIM80G2fvhJKu
	 k70cw/W4kWIAdR0QgCGyKkYSUWafRF9JfYdwQYqcuw97EoLl5PE7FooZQVF90P6d1S
	 +XK4eF9d17hvPqgtYTQu5PpZWsK0RIXspm/jkjwBpmsvoLZjn/nqPyURKLMuJaeIOQ
	 Jb1LJjV/eyyJA==
Date: Tue, 26 Nov 2024 17:50:50 +0000
From: Conor Dooley <conor@kernel.org>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: Wojciech Macek <wmacek@chromium.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chen-Yu Tsai <wenst@chromium.org>, Rafal Milecki <rafal@milecki.pl>,
	Hsin-Yi Wang <hsinyi@chromium.org>,
	Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: mediatek: Add MT8186 Starmie
 Chromebooks
Message-ID: <20241126-angles-unequal-3578ea6bb01b@spud>
References: <20241125082130.2390310-1-wmacek@chromium.org>
 <20241125082130.2390310-2-wmacek@chromium.org>
 <20241125-snowcap-sulphate-34944bd70cf3@spud>
 <CAGb2v655Bfx44XBPH24FKuEFTJ3ngjbAPEpNBn5vyLZfNGKt+Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="a8AIRgZYs3rO0/Bl"
Content-Disposition: inline
In-Reply-To: <CAGb2v655Bfx44XBPH24FKuEFTJ3ngjbAPEpNBn5vyLZfNGKt+Q@mail.gmail.com>


--a8AIRgZYs3rO0/Bl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 12:36:08PM +0800, Chen-Yu Tsai wrote:
> On Tue, Nov 26, 2024 at 2:34=E2=80=AFAM Conor Dooley <conor@kernel.org> w=
rote:
> >
> > On Mon, Nov 25, 2024 at 08:21:28AM +0000, Wojciech Macek wrote:
> > > Add an entry for the MT8186 based Starmie Chromebooks, also known as =
the
> > > ASUS Chromebook Enterprise CM30 Detachable (CM3001). The device is
> > > a tablet style chromebook.
> > >
> > > Signed-off-by: Wojciech Macek <wmacek@chromium.org>
> > > ---
> > >
> > > Changelog v2-v1:
> > >  - Fixed items/const bidings description in mediatek.yaml
> > >
> > >  Documentation/devicetree/bindings/arm/mediatek.yaml | 13 +++++++++++=
++
> > >  1 file changed, 13 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Do=
cumentation/devicetree/bindings/arm/mediatek.yaml
> > > index 1d4bb50fcd8d9..6191a5320c148 100644
> > > --- a/Documentation/devicetree/bindings/arm/mediatek.yaml
> > > +++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
> > > @@ -263,6 +263,19 @@ properties:
> > >            - const: google,steelix-sku196608
> > >            - const: google,steelix
> > >            - const: mediatek,mt8186
> > > +      - description: Google Starmie (ASUS Chromebook Enterprise CM30=
 (CM3001))
> > > +        items:
> > > +          - const: google,starmie-sku0
> > > +          - const: google,starmie-sku2
> > > +          - const: google,starmie-sku3
> >
> > Compatible order here is back to making little sense. Why is the oldest
> > SKU, in both cases, appearing first?
>=20
> FWIW the SKU number has no particular ordering. They were released togeth=
er.
> SKU denotes different configurations (memory, storage, touchscreen and ot=
her
> component options). OOTH revisions would actually have chronological mean=
ing.

I see, that's fine then I suppose.
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--a8AIRgZYs3rO0/Bl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ0YKegAKCRB4tDGHoIJi
0v3ZAP9s6/k+4zLgrMT7vndOHggRKcA/mY2xxhRmyiJtJNDvgwEAhWO7UfTEpvj4
HibsduIJN6ZIFYDBYKi7+ZDbhZUKqQI=
=cu+D
-----END PGP SIGNATURE-----

--a8AIRgZYs3rO0/Bl--

