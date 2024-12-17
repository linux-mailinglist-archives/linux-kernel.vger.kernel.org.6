Return-Path: <linux-kernel+bounces-449781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B45C9F5607
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 19:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4365816EAC7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 18:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5394F1F8932;
	Tue, 17 Dec 2024 18:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kBwVUpiV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7E01F76B1;
	Tue, 17 Dec 2024 18:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734459820; cv=none; b=GrOeFs89FR6h8qvoNPUBpIgCyHT2U4t2DAHQVK3i07z1EqOZnNRFqj2BqstKwY3fvIWL2PhzQdx2EphKoTn4UDEoAUGRb+s8dYp9d9jgolGjjBQSGyBNdy3GeT0wjflBkKybzKcRe7pa3DBUee68Uyjm3eL61S7yXMjsm+w9MsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734459820; c=relaxed/simple;
	bh=qU4aI3iB2bKVYl8+6gmws2EPMCPT94DaUUUVjJQ/3F0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UV3acbsiTn+c8MO5ZtB6St7qh+OYL3gsedgh8sPuw5geEHI0yAkuBtGEnIS+G3bEqWV9c7Hp/fQy1YVv6+sz25s29vQ6t8Jq0hevrBh4/qIe7mefJA0+rcrdzjTrIe54nx+RnPvUka/Rt/gh8fFwIHKTY3o4Lj6pYOcbKi5eas0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kBwVUpiV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9611AC4CED3;
	Tue, 17 Dec 2024 18:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734459820;
	bh=qU4aI3iB2bKVYl8+6gmws2EPMCPT94DaUUUVjJQ/3F0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kBwVUpiVXznsUiiNF2b2/xUSvktYGLaZZzUWlIlnOLy7UoULd/XSSGEBJoXjcnAPm
	 xHMtRGd1viqaDL3J5VR8PwUpqiIgv7tBkUxjWwvRBBofZ0snDRG8FylfZ00HsAvbT8
	 Ixx1JuobyqPwYiMllzBhqYh/QcrVuF6D3FYKjlZyCNx2IgVZc+Ez388+nQzOeQXCpQ
	 YDYIOiMiaK0CPhfjTojUV8jdEIoeSiiKKN19+twKn5a+Ot5x9CozaESTHhGe5WkIZU
	 lwe/imWuRYz9u5S1n9UMbZ4gaH3xr7m+uJzqG3TnazCxQEoiyUGa34oaIL9BFkLJpb
	 iPpwqsaoFC+og==
Date: Tue, 17 Dec 2024 18:23:36 +0000
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: interrupt-controller: arm,gic: Correct VGIC
 interrupt description
Message-ID: <20241217-refresh-decency-bf5b9e1ac493@spud>
References: <20241217061226.14139-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="q5T5qHJ4HblV4OaX"
Content-Disposition: inline
In-Reply-To: <20241217061226.14139-1-krzysztof.kozlowski@linaro.org>


--q5T5qHJ4HblV4OaX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 07:12:26AM +0100, Krzysztof Kozlowski wrote:
> The description of VGIC interrupt referenced obsolete "see below" after
> converting TXT to DT Schema in commit 66ed144f147a ("dt-bindings:
> interrupt-controller: Convert ARM GIC to json-schema"), because there is
> no dedicated "VGIC" chapter anymore below.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/interrupt-controller/arm,gic.yaml     | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/arm,g=
ic.yaml b/Documentation/devicetree/bindings/interrupt-controller/arm,gic.ya=
ml
> index a2846e493497..7173c4b5a228 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/arm,gic.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/arm,gic.yaml
> @@ -110,8 +110,8 @@ properties:
> =20
>    interrupts:
>      description: Interrupt source of the parent interrupt controller on
> -      secondary GICs, or VGIC maintenance interrupt on primary GIC (see
> -      below).
> +      secondary GICs, or VGIC maintenance interrupt on primary GIC (see =
"GICv2
> +      with virtualization extensions" paragraph in the "reg" property).

I don't think things like this /should/ need a dt ack, even if they
weren't from a dt maintainer - but in case one's expected
Acked-by: Conor Dooley <conor.dooley@microchip.com>

--q5T5qHJ4HblV4OaX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ2HBqAAKCRB4tDGHoIJi
0tV/AP0Wwmto6bZFtxfL8lxrdlvXGIEoKK7Agp7kMyPlfFvS+wD/UYF3nOvIOJDP
Stk2XSaKthz0Uw9kg+tRRO0ktYnG0wg=
=p5g/
-----END PGP SIGNATURE-----

--q5T5qHJ4HblV4OaX--

