Return-Path: <linux-kernel+bounces-229283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 422E1916DCC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 18:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7297F1C21B27
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 16:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1840F17106D;
	Tue, 25 Jun 2024 16:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qv8Bx59N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580A71CABB;
	Tue, 25 Jun 2024 16:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719331857; cv=none; b=NaI1TxBWPBSLmbBS3chhNUSbawBVyDKJQvtub/q6RyDz8bsEOCpFLG1xWDO7Ik1ExdqpZ4Fs3KPoACDpAYTUecW+1x+NU2n/Ci8wQ5sRDBJvoG91P908F9l1nn49ITzG6sVVY58nPaYubhSdjmgEMH5XtZWG8FmgY8Wt1vK/UJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719331857; c=relaxed/simple;
	bh=z8HswIvlQx7OU8ilJWOJ4zvCY+3qACFutDcOZeef8Ys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U81nZv1i4IvOf1tz4hEsHvHP57iWAqXaFfgrFqBQxbeoQO9hoeV3oh0jVXJH9DABbcEeJau7NvkQoQvn7OugMTHwya3FryikA/QXWnsKMA/6lhr6eAwWt8REhxiRkC7jRz6qMHiilBIqO8NL6A96759EZbTCYo5UN/I5BfnNoyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qv8Bx59N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7963BC32781;
	Tue, 25 Jun 2024 16:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719331856;
	bh=z8HswIvlQx7OU8ilJWOJ4zvCY+3qACFutDcOZeef8Ys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qv8Bx59NIiTNVrL1XrPJ0UUqqJl0/uDAY0EcYnpt7MF23VrL3+V2Hqbw8bR0Gm8XP
	 8eRQMyKVM2GbOcrPj/8MI2uXuNAATdEQSi4J7gFWIL7DvXzM14qrmwC5ORvpDTWr8x
	 5KUmY1DcBxnTY9U7L3u+TXwOQx5sf4EfqkHzVhebwErtZf9/y5MMPH2FpVjg/D8Dwa
	 7EhDJTSeQZ5caBXLkVp33AfuUlUarHS+nWXJnv6+1nzch9Uf3mo9WIQIwVeIUhV9gD
	 9ArIrzlCaBdtM+wuAVehh5lpA1tC5RZEk1+gYP9ykAO1AOe20+CFhiR2xHe1ONMYbm
	 0gl4ZqPeVEoeg==
Date: Tue, 25 Jun 2024 17:10:52 +0100
From: Conor Dooley <conor@kernel.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Bao Cheng Su <baocheng.su@siemens.com>,
	Diogo Ivo <diogo.ivo@siemens.com>
Subject: Re: [PATCH 3/4] dt-bindings: soc: ti: am645-system-controller: add
 child nodes used by main domain
Message-ID: <20240625-stuffed-outgrow-702e37622fc6@spud>
References: <cover.1719210050.git.jan.kiszka@siemens.com>
 <52848094062ea55b0063e6fc37f27e6ed5035aa8.1719210050.git.jan.kiszka@siemens.com>
 <20240624-hula-fever-74499b22784d@spud>
 <0e0a9627-0e5c-4c39-b1f2-98f8095ba8c5@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HzLaPnRGBBlzqSMg"
Content-Disposition: inline
In-Reply-To: <0e0a9627-0e5c-4c39-b1f2-98f8095ba8c5@siemens.com>


--HzLaPnRGBBlzqSMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 10:23:37PM +0200, Jan Kiszka wrote:
> On 24.06.24 18:24, Conor Dooley wrote:
> > On Mon, Jun 24, 2024 at 08:20:49AM +0200, Jan Kiszka wrote:
> >> From: Jan Kiszka <jan.kiszka@siemens.com>
> >>
> >> Expand bindings to cover both the MCU and the main usage of the AM654
> >> system controller.
> >>
> >> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> >> ---
> >>  .../soc/ti/ti,am654-system-controller.yaml    | 29 +++++++++++++++++++
> >>  1 file changed, 29 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/soc/ti/ti,am654-system-=
controller.yaml b/Documentation/devicetree/bindings/soc/ti/ti,am654-system-=
controller.yaml
> >> index e79803e586ca..0eec807f38df 100644
> >> --- a/Documentation/devicetree/bindings/soc/ti/ti,am654-system-control=
ler.yaml
> >> +++ b/Documentation/devicetree/bindings/soc/ti/ti,am654-system-control=
ler.yaml
> >> @@ -34,6 +34,35 @@ patternProperties:
> >>      type: object
> >>      $ref: /schemas/phy/ti,phy-gmii-sel.yaml#
> >> =20
> >> +  "^mux-controller$":
> >> +    type: object
> >> +    description:
> >> +      This is the SERDES lane control mux.
> >=20
> > Where is this object described?
> >=20
>=20
> Nowhere so far - I've only followed the pattern in
> mfd/ti,j721e-system-controller.yaml. Would adding "ref:
> /schemas/mux/reg-mux.yaml" be enough?

I think that would be okay, yea

--HzLaPnRGBBlzqSMg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnrsDAAKCRB4tDGHoIJi
0kWxAP964V9Lk0QTCjeBj4XYhp9yppMMx1ApO1OCrtpbBjq5pQD7BKYT/UgapUTg
PuhFZNyuMFXVagzZCesfL56uD9PAOw8=
=ql76
-----END PGP SIGNATURE-----

--HzLaPnRGBBlzqSMg--

