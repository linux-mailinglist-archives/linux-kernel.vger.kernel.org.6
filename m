Return-Path: <linux-kernel+bounces-551471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C48A56CD6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBFA67A624C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 15:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE3422156B;
	Fri,  7 Mar 2025 15:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LqROB/MQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7DC220683;
	Fri,  7 Mar 2025 15:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741363076; cv=none; b=Q/NGAe1EGStTrR6jXwDDor0duL7eE6iCIa1rAGEZVv8oaTktKYmdvyBtqI0goY3OGVzvWpCeGvQiW8HgPy2Pu5Q/xWdGJeKTUpdmMZRJpTkVSgtTkfiaMDjeGN+9sfjGbuJSXUNMuSxAbCMR5HYPlB6dq40lgldRLBsau8Kj1gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741363076; c=relaxed/simple;
	bh=QT1XHh/w8QwT1pLRiOGWxMsbky6BpHG6YvS1p8T0uU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ayrXSB+ZnN0+oOyFlxvz0CQJkBpjFba3icDqefdoW4O5PXD0mtF/N5LOVLCIYJ9iJiGvY4gVVcqXzG1j+u8ACKR8Z9bnhIW7Ax2HKzys0WKoRr7hCpzxzn0hwmh81R4IwTKMaqo1gEUNIWEgqC01TNdPrzMnTyGmRi/HMsBvgyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LqROB/MQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AF12C4CED1;
	Fri,  7 Mar 2025 15:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741363074;
	bh=QT1XHh/w8QwT1pLRiOGWxMsbky6BpHG6YvS1p8T0uU8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LqROB/MQjqgP6Rxj7Ka2JK/VyG82Yw1XNISbXOGkuJVwtsqWRhMcXuyrPpAXmqbMf
	 eqJ8MhwoTh0o8qu8D7AU14C5aWPnC8IV4XMCsGy1R4YdhKH1k93ZTUbU/ehUZPoxTZ
	 RF+kya+bNA+vAWYvH4UlgWJgBeA6vu19p0A5O8gEJ0Lu1NgvvaaJY6JC6uM8KA5iPK
	 gp2r/4730w41fI6wZfjxOPNY2hpkbmQsVusd1q2NB/iUMH2PWFWwEhDb2DFdb7J5Gr
	 9SOTUOE25hNfyv5M3STCc95jPsDlzkbqExLIN7e3so/vWoMJrlhXXetaSVv0ITUnEK
	 qwkAK5IRMJQBg==
Date: Fri, 7 Mar 2025 15:57:49 +0000
From: Conor Dooley <conor@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Bai Ping <ping.bai@nxp.com>,
	"open list:CLOCKSOURCE, CLOCKEVENT DRIVERS" <linux-kernel@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	imx@lists.linux.dev
Subject: Re: [PATCH] dt-bindings: timer: nxp,sysctr-timer: Add i.MX94 support
Message-ID: <20250307-popular-margarita-f16341b53f30@spud>
References: <20250306170902.241057-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MqHaBOafbLChmy6G"
Content-Disposition: inline
In-Reply-To: <20250306170902.241057-1-Frank.Li@nxp.com>


--MqHaBOafbLChmy6G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 06, 2025 at 12:09:02PM -0500, Frank Li wrote:
> Add compatible string "nxp,imx94-sysctr-timer" for the i.MX94 chip, which
> is backward compatible with i.MX95. Set it to fall back to
> "nxp,imx95-sysctr-timer".

Acked-by: Conor Dooley <conor.dooley@microchip.com>

>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../devicetree/bindings/timer/nxp,sysctr-timer.yaml   | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/timer/nxp,sysctr-timer.yam=
l b/Documentation/devicetree/bindings/timer/nxp,sysctr-timer.yaml
> index 891cca0095281..6b80b060672e5 100644
> --- a/Documentation/devicetree/bindings/timer/nxp,sysctr-timer.yaml
> +++ b/Documentation/devicetree/bindings/timer/nxp,sysctr-timer.yaml
> @@ -18,9 +18,14 @@ description: |
> =20
>  properties:
>    compatible:
> -    enum:
> -      - nxp,imx95-sysctr-timer
> -      - nxp,sysctr-timer
> +    oneOf:
> +      - enum:
> +          - nxp,imx95-sysctr-timer
> +          - nxp,sysctr-timer
> +      - items:
> +          - enum:
> +              - nxp,imx94-sysctr-timer
> +          - const: nxp,imx95-sysctr-timer
> =20
>    reg:
>      maxItems: 1
> --=20
> 2.34.1
>=20

--MqHaBOafbLChmy6G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ8sXfQAKCRB4tDGHoIJi
0o+GAQDkXHThxI93oIJC0azv+CB0mG0BDZBf4Kg7YZh9Ts8v3wEAgq0KKkRnfRel
dWTh3Aam6YBVKAh9krDuOp956tpoTAo=
=atln
-----END PGP SIGNATURE-----

--MqHaBOafbLChmy6G--

