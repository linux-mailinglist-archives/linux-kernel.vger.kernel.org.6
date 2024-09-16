Return-Path: <linux-kernel+bounces-330863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B028E97A55C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 17:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79E2D283B87
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 15:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6698B158D6A;
	Mon, 16 Sep 2024 15:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jG4D9/W3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68F826AD3;
	Mon, 16 Sep 2024 15:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726500791; cv=none; b=JOsFRypqNYk3oSOnMMMuEmOlRIXM3vw0DL0uhAF4arAggzTApAz7JlOciWw98bKWuRnEDbHw9NfaxOtKjVHw+1B8cNCDovreyFh0v3fyE/YXcyeOZMTCNRID/s8eLR4Jho2tZKk51QDhYfDWkaW5GXJaufTEyV/74ajPRRNTo8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726500791; c=relaxed/simple;
	bh=fvCAW49HWtfdjAIL050rgmIiTlHJz8PHGcnFkw1Ppq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GWHC6t6Cmv9M8oPlV8q45/VonZWFq/B7UKBaS++WJtRkGRSrL3E6aR8nDxxYH5fR0Kps4SaGnyHAZTB1Fjy2ZwMTaivfx+Ue3aggwmIS8LHzXydB2AJ+tkr26MQYGHk2OxzMT6Gy3X8EdDICWRZaLL3fojSTibIleLW5kjJBGvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jG4D9/W3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AA30C4CEC4;
	Mon, 16 Sep 2024 15:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726500791;
	bh=fvCAW49HWtfdjAIL050rgmIiTlHJz8PHGcnFkw1Ppq8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jG4D9/W3xyJwEIxQUvSD1o6dLD9X7vglkFtM16njr0VX+K+EjC73NN0OvjW7xaIIQ
	 2mILZ0ROMt0Nbu4SXwMhjwOwrGJUMpmU+RAH7CUq6JMs3+//k8k5B4LnoGk3uixUDN
	 n50E9qxYqCdzTyMhhZI24hRfMBmCJfyVNqaumWXdHjDzIfMp2CKii0RWOGT+T1F/F5
	 M9PK72+ffMTaNIA9GNkm7fOTKX8K16LJLtbG5cjW1uPL4XxYg3RoxQlDcmcbuALT2z
	 nWFTOesGJdGztipH3VWAstO3bNJOPkNu2Ws/naKaETYwmdoMJbhA6n9Vwa4llIdjOL
	 rEWN2J7y+KacQ==
Date: Mon, 16 Sep 2024 16:33:06 +0100
From: Conor Dooley <conor@kernel.org>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: clock: add support for lan969x
Message-ID: <20240916-foster-improvise-8019e7e0c023@spud>
References: <20240916-lan969x-clock-v1-0-0e150336074d@microchip.com>
 <20240916-lan969x-clock-v1-1-0e150336074d@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kPX2Kx7cBCQm6ZKc"
Content-Disposition: inline
In-Reply-To: <20240916-lan969x-clock-v1-1-0e150336074d@microchip.com>


--kPX2Kx7cBCQm6ZKc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 16, 2024 at 11:49:19AM +0200, Daniel Machon wrote:
> Lan969x is going to reuse the existing lan966x clock driver - document
> that by adding compatible strings for the different SKU's that we
> support.
>=20
> Signed-off-by: Daniel Machon <daniel.machon@microchip.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

> ---
>  .../devicetree/bindings/clock/microchip,lan966x-gck.yaml    | 13 +++++++=
+++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/clock/microchip,lan966x-gc=
k.yaml b/Documentation/devicetree/bindings/clock/microchip,lan966x-gck.yaml
> index df2bec188706..16106e8b637f 100644
> --- a/Documentation/devicetree/bindings/clock/microchip,lan966x-gck.yaml
> +++ b/Documentation/devicetree/bindings/clock/microchip,lan966x-gck.yaml
> @@ -16,7 +16,18 @@ description: |
> =20
>  properties:
>    compatible:
> -    const: microchip,lan966x-gck
> +    oneOf:
> +      - enum:
> +          - microchip,lan966x-gck
> +          - microchip,lan9691-gck
> +      - items:
> +          - enum:
> +              - microchip,lan9698-gck
> +              - microchip,lan9696-gck
> +              - microchip,lan9694-gck
> +              - microchip,lan9693-gck
> +              - microchip,lan9692-gck
> +          - const: microchip,lan9691-gck
> =20
>    reg:
>      minItems: 1
>=20
> --=20
> 2.34.1
>=20

--kPX2Kx7cBCQm6ZKc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZuhPsgAKCRB4tDGHoIJi
0hEaAQCO90t6Ag+nnyWSBLH16pNMwcU0v0g9LpAkFS/Aml3JfAEAmZQXnUzRo9zC
Dt49fBk7OkDAc/UXPkcr9wnJ6g2hWwA=
=vh5t
-----END PGP SIGNATURE-----

--kPX2Kx7cBCQm6ZKc--

