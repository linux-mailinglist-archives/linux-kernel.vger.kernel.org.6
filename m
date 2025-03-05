Return-Path: <linux-kernel+bounces-547257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7C1A504F5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 17:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 466A3175629
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 16:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D09517C7C4;
	Wed,  5 Mar 2025 16:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PdkYWWY5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE08481C4;
	Wed,  5 Mar 2025 16:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741192288; cv=none; b=CgbKTM1hsbNZrewFqz5Mqoihs8ZsqW2+w9KMRV0Iyx7Tyr2Gws28zNx8oLuW18GqnVnrXzrArIfYJkO6x+lmggczPJ5hFWTz0fNxQmUpQKPCsEnzN4fWA8zSFc14R0NVmqZuO/guEC6gVIxR701ByAYlpD9MGVQ+8TJCrBBpC1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741192288; c=relaxed/simple;
	bh=mjfercYvHY6XW4hH6LajRSUm1yvoytFiSmictk11u7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XMG9dr453VANWN5opIuo/dACLQWFkbJYvwQJiwnd3zxNP5XKlPNN+kxUvfJ48K2ioq6ZLDHjb9ja2qIyRJMaMoE31gQg4FoeUTEZZR5gct2dmy+1kOKVLzRQ/cACwauX0gqmO6IdoX8X9JF6Uf7Upzjozt8m9v5dv5zKkOhJJPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PdkYWWY5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCFF4C4CED1;
	Wed,  5 Mar 2025 16:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741192288;
	bh=mjfercYvHY6XW4hH6LajRSUm1yvoytFiSmictk11u7I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PdkYWWY56USlcELtkXOwMTB0B7NndvMTFbHWm5Ez1ffZ0OqyMcPXJw/cZOJ7PvwWQ
	 M7dU8sf4Zuc6QsozhigHmnHDk23XVG4RDTxL+4VJFuNWDjqDgEFxlsC+GDS5cALLVD
	 VRXXDM6ZHQpf+Nl0iLbwdqs4K9ud2YMqVG8V484AYlfl2Zcs38b4WZtkGI8kx4n8Ex
	 zttMpJTanbvdpSEmZoTTnnrPD5LcMiTek6zeT18QEJWDSj+XwLSeXK5fgoc97bcv1U
	 KA9HSh9MhayMoQSl907mwR6zeVrPoSEvAxf0Ove4v0BFWrdq3inptn1Gw+Jjzgbz87
	 KbLsJf+5Ko0Rg==
Date: Wed, 5 Mar 2025 16:31:23 +0000
From: Conor Dooley <conor@kernel.org>
To: Jjian Zhou <jjian.zhou@mediatek.com>
Cc: Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Project_Global_Chrome_Upstream_Group@mediatek.com,
	Jason-ch Chen <jason-ch.chen@mediatek.com>
Subject: Re: [PATCH RFC 3/3] dt-bindings: mailbox: mtk,vcp-mbox: add mtk
 vcp-mbox document
Message-ID: <20250305-chewing-henchman-aea98c18b412@spud>
References: <20250305082047.15746-1-jjian.zhou@mediatek.com>
 <20250305082047.15746-4-jjian.zhou@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wpgFucSmUGsB0HoE"
Content-Disposition: inline
In-Reply-To: <20250305082047.15746-4-jjian.zhou@mediatek.com>


--wpgFucSmUGsB0HoE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 05, 2025 at 04:20:40PM +0800, Jjian Zhou wrote:
> This patch adds document for mediatek vcp mbox.
>=20
> Signed-off-by: Jjian Zhou <jjian.zhou@mediatek.com>
> ---
>  .../bindings/mailbox/mtk,vcp-mbox.yaml        | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/mtk,vcp-mbo=
x.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/mailbox/mtk,vcp-mbox.yaml =
b/Documentation/devicetree/bindings/mailbox/mtk,vcp-mbox.yaml
> new file mode 100644
> index 000000000000..d5afe295af14
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/mtk,vcp-mbox.yaml

When you go !RFC, filename matching compatible please.

> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mailbox/mtk,vcp-mbox.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek Video Companion Processor (VCP) mailbox
> +
> +maintainers:
> +  - Jjian Zhou <Jjian.Zhou@mediatek.com>
> +
> +description: |
> +  The MTK VCP mailbox enables the SoC to communicate with the VCP by pas=
sing
> +  messages through 64 32-bit wide registers. It has 32 interrupt vectors=
 in
> +  either direction for signalling purposes.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - mediatek,mt8196-vcp-mbox
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  "#mbox-cells":
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - "#mbox-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    vcp_mailbox0: mailbox@31b80000 {

label here is unused, please drop it.

Cheers,
Conor.

> +        compatible =3D "mediatek,mt8196-vcp-mbox";
> +        reg =3D <0x31b80000 0x1000>;
> +        interrupts =3D <GIC_SPI 789 IRQ_TYPE_LEVEL_HIGH 0>;
> +        #mbox-cells =3D <0>;
> +    };
> --=20
> 2.45.2
>=20

--wpgFucSmUGsB0HoE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ8h8WwAKCRB4tDGHoIJi
0rmzAQDC6tROpS/C3bfqeRalnd+CJF3nrU5drTadY8j4LSJBswD/SAnH+kW5P5Zz
1XAoP++vVC0+C1lqWccMOwxtkJk6nwo=
=N2nw
-----END PGP SIGNATURE-----

--wpgFucSmUGsB0HoE--

