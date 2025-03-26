Return-Path: <linux-kernel+bounces-577476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E5AA71DB4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 18:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA5CC3B984F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 17:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F351F3BAE;
	Wed, 26 Mar 2025 17:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="MJmSTM56"
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB0723E33C;
	Wed, 26 Mar 2025 17:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743010968; cv=none; b=qlkLDwUZdtibr6n0p8CIj5WGwTt7kwf0+hDQUIgmVly+dHkX4tBBXNzYlQMEZLdUH/QUtz41BDhwAe1cpsOo8oXvGMoHNX8g89YKRJJNqFbMDIy2egbL+3ivVhvOsqSKtlRAz52wOXuRrVHaJNE+wgRlyuQEOmbRr5JNyMygT1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743010968; c=relaxed/simple;
	bh=s4SUUegsP0Xvwjz+6/KqAagb2Ro37B9pp4MDN10deug=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rQHdo+0qUDc+FMYbqKv0ZHA1gmqtZgiMSLA/fpfPtbayiIVu+v4aSJveec3cj0UtzkQmwspNnHbKTUw1sLpRe5w8CkUBSTInzr8YijtiwsUnDDDThAjsqvWv+ivpIzNL+0EPcOe3nRT8H1tHchIrAqraBMcPydtq4+ERBTumc00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=MJmSTM56; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7C97710246DBE;
	Wed, 26 Mar 2025 18:42:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1743010963; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=rjAa5WF/DK+mr9RCoXIyNfqtKz1PWeF0hDFMiSwlHhA=;
	b=MJmSTM56RZp0ZLfMq5Jb1MHeT3VjZLDxk8sYg0QJIohSLm0nR+FdS49RymC7zQ7qI9pzsG
	VSnWqH5j2jZUDGD0SKgwSYopY6F0uqxAjj/YILNvn0dAOz4Qokhi99UlKOBZqNcU4X9nDc
	CJT9tZZXkRo7AJuBEtAKC9F4LNIohKqAd8nM5BDBPQJT6MmVS6HORmUDWvUPzTlw89xhaU
	89g+nuNWxxrqy6aQ24cSal3yiKQod/tLqs+RJ0VHgfaI44Ym9GojVm+cehCpoVMRs6J6Z6
	M6fPY06C8P/medDDnu7R0YZVT9PCUNsCjR2MPeK3yU3i730A6+FCLP+oGCyydQ==
Date: Wed, 26 Mar 2025 18:42:40 +0100
From: Lukasz Majewski <lukma@denx.de>
To: Conor Dooley <conor@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Guenter Roeck <linux@roeck-us.net>,
 Noah Wang <noahwang.wang@outlook.com>, Michal Simek <michal.simek@amd.com>,
 Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] dt-bindings: trivial-devices: Document SPI
 measurement on LWE boards
Message-ID: <20250326184240.77e2bdc9@wsk>
In-Reply-To: <20250326-unluckily-consuming-948176031b08@spud>
References: <20250326140930.2587775-1-lukma@denx.de>
	<20250326-unluckily-consuming-948176031b08@spud>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/PNZU+UuzjK28yn_7bV1y9Jg";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/PNZU+UuzjK28yn_7bV1y9Jg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Conor,

> On Wed, Mar 26, 2025 at 03:09:30PM +0100, Lukasz Majewski wrote:
> > The measurement device on Liebherr's (LWE) boards is used to monitor
> > the overall state of the device. It does have SPI interface to
> > communicate with Linux host via spidev driver. Document the SPI DT
> > binding as trivial SPI device.
> >=20
> > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> > --- =20
>=20
> You should not do a resend with no explanation as to why.
> Additionally, I would like to know why my review on the original
> patch was ignored:
> https://lore.kernel.org/all/20250225-despair-rural-dc10216005f4@spud/#t
>=20

I've made a mistake, as I've used the lwe prefix, which is the
different branch office for Liebherr.

As we discussed last time - it would be better to use the already
present 'lwn' vendor prefix as several other boards from this company
use it (display5, bk4, xea, btt3).

And this was apparent, after I've resent the patches. My mistake.

Regarding the comment - on xea, btt the binding would be used, as those
two boards (based on imx287) are using it.

Hence, single "trivial device" would be OK.

The v2 of this patch has the proper 'lwn,btt' binding.

> Cheers,
> Conor.
>=20
> >  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml
> > b/Documentation/devicetree/bindings/trivial-devices.yaml index
> > fadbd3c041c8..5d736a9792c2 100644 ---
> > a/Documentation/devicetree/bindings/trivial-devices.yaml +++
> > b/Documentation/devicetree/bindings/trivial-devices.yaml @@ -161,6
> > +161,8 @@ properties:
> >            - jedec,spd5118
> >              # Linear Technology LTC2488
> >            - lineartechnology,ltc2488
> > +            # Liebherr on-board measurement SPI device
> > +          - lwe,btt
> >              # 5 Bit Programmable, Pulse-Width Modulator
> >            - maxim,ds1050
> >              # 10 kOhm digital potentiometer with I2C interface
> > --=20
> > 2.39.5
> >  =20




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/PNZU+UuzjK28yn_7bV1y9Jg
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmfkPJAACgkQAR8vZIA0
zr0Gagf/dklRp8kz8q1hgDJ6m8iX/AInXsVqHHDg9GASxQ+5WZejYyf1rKF2SvKx
Z565Ge02sPriupqO644yljw9D1oz8cnSFHYLugK2EkgckHfqL1QbsMfAiwIn6DLZ
JfmNHbhlrzpzVhCaiuZ8/orx78ff7pvkZ/1kMqkVkl4AGp3kwQES6nOWhfcZWCDL
0Jyh2YBARy/lEMbGKXK9U2McK4bSB2L4kbO7SqJ4HEZBmco7PHZ5cPSWvAcoWYD7
H4hzD+abKHOoutG7Wyh8BXKaGjP0sRR9jzJE3c4yp6D+e3ytGsmR+Qlu4PtSVJzT
4/9X0lKiPX3but2ILbWXhxnzJhVd7g==
=f3j/
-----END PGP SIGNATURE-----

--Sig_/PNZU+UuzjK28yn_7bV1y9Jg--

