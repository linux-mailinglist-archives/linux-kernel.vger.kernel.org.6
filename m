Return-Path: <linux-kernel+bounces-422676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4A09D9CCA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 18:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C49EE2833D7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 17:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AAF21DB95D;
	Tue, 26 Nov 2024 17:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KpKV1Hhq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55181CEE9B;
	Tue, 26 Nov 2024 17:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732643060; cv=none; b=J/NVmIh5AHoqPpuP3Yn0bq1aqD4oLJ8OrgCQEQpwnMmjDbVGl5G3HzHusTOK/xwcMZNbHsW/tmACJRvYqkNlVpvUwzJxvvhzUwNGmr8PIcN22/ietBzMuCWP+l777wOI9UIVY0MRXD5PoZIjqqgpHQ0TFyckUMJg1UbuEmmPuVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732643060; c=relaxed/simple;
	bh=H+B1pmwxkp1dv88qtjfJSxvPjDOd7r063O1/Yfy0BFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d67HZe9uo9w4tIYrQ+VWU9U/YYZmgul5ptB4k8hsPXOEf7fL4F9aBtHyJaIrN22BXc+tZTMZ0ox6/BCfmPAZCwtLw+K+zP+iUWkFraWGslLMCwvrWPP419+TI4GGo8NWjj6r+OqsbLjnQSG4Qt70/GFyRD0+1MQ2ugBl5rYPFQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KpKV1Hhq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B27BAC4CECF;
	Tue, 26 Nov 2024 17:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732643059;
	bh=H+B1pmwxkp1dv88qtjfJSxvPjDOd7r063O1/Yfy0BFU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KpKV1Hhq7cwiwPfR81pTvR4jA9M2AofYd8uf7eG5wecW99jo0uQaBEdqORgLa3oAH
	 tGnAJxDhuxiPdPOzioql4BcjDMVVJf1nKlAdSX96ZXo2eVUBzFjq12DmeyQ3XCU5Vt
	 Zl0J40NLZvc8b9SftfW79MnyGihjfn6LoJyha71k90VWumhTEghsyIsyQOH8AEmwtX
	 WBryR76k5fhob/QWDKTrPuvMi56i46c18MI5Ttchh0ShuurAEN7o9JN6TL9ogPelZc
	 0ybUgKvLxPmHG70OcuhGCw8EAmhpTUJCIbatDuiVPdpiHpjS7JLeGV7ErKPfxqIAa2
	 Lyd2nq4sVde5g==
Date: Tue, 26 Nov 2024 17:44:14 +0000
From: Conor Dooley <conor@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, quentin.schulz@cherry.de,
	sebastian.reichel@collabora.com, linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	dse@thaumatec.com, Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: Re: [PATCH v4 1/2] dt-bindings: phy: Add Rockchip MIPI C-/D-PHY
 schema
Message-ID: <20241126-pastrami-gusty-8b9df32ae00c@spud>
References: <20241126131736.465111-1-heiko@sntech.de>
 <20241126131736.465111-2-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="g+V6TT2oeeGyoz7X"
Content-Disposition: inline
In-Reply-To: <20241126131736.465111-2-heiko@sntech.de>


--g+V6TT2oeeGyoz7X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 02:17:34PM +0100, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
>=20
> Add dt-binding schema for the MIPI C-/D-PHY found on
> Rockchip RK3588 SoCs.
>=20
> Tested-by: Daniel Semkowicz <dse@thaumatec.com>
> Tested-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
> ---
>  .../phy/rockchip,rk3588-mipi-dcphy.yaml       | 87 +++++++++++++++++++
>  1 file changed, 87 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/rockchip,rk3588=
-mipi-dcphy.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/phy/rockchip,rk3588-mipi-d=
cphy.yaml b/Documentation/devicetree/bindings/phy/rockchip,rk3588-mipi-dcph=
y.yaml
> new file mode 100644
> index 000000000000..c8ff5ba22a86
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/rockchip,rk3588-mipi-dcphy.ya=
ml
> @@ -0,0 +1,87 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/rockchip,rk3588-mipi-dcphy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Rockchip MIPI D-/C-PHY with Samsung IP block
> +
> +maintainers:
> +  - Guochun Huang <hero.huang@rock-chips.com>
> +  - Heiko Stuebner <heiko@sntech.de>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - rockchip,rk3576-mipi-dcphy
> +      - rockchip,rk3588-mipi-dcphy

How many phys do each of these SoCs have?

--g+V6TT2oeeGyoz7X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ0YI7gAKCRB4tDGHoIJi
0uLsAQCgiUeTJIfJn0aeODBRIBm/tzLSKrztICS5Y7I3++Ae1QEAljjpGbDuyu90
nr0OwQId+7pypocuTFIbd8uRgymesAU=
=OpzG
-----END PGP SIGNATURE-----

--g+V6TT2oeeGyoz7X--

