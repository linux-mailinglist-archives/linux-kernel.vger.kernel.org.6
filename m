Return-Path: <linux-kernel+bounces-516508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 715E3A37302
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 10:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7D63169289
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 09:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00B217C208;
	Sun, 16 Feb 2025 09:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="v15MyCK5"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D7815534D
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 09:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739697309; cv=none; b=otH5CbFbHh7kqq7cCAr+TkB8NtI3mci+of0YN4/Z6rHKdcxca8XRW/BzKZYDEC9MkMJNj+0y3SD37V/G+s4R7u3w5SrAXCutFIVXG+8d0/aPyVUevGYZ5JiOPz8Zt3rRFfEra++PP4Oh8IS5gV5HZ89NwHKcPVhcN9QmbUHrJKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739697309; c=relaxed/simple;
	bh=PxYmHzX6Vea9psEbnwUgV8Ka+0cOnKnaPVob6sHO1F8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=fY6qzNlAfNQu6Nq3S7zwosEmnKtWbxaT582+m2/TM4Qyt50BXpbVU2WemqGdUx0HafztP4kDzNLXrrpSm7ZaMp+pyklQJlDrn95tpuUkXC5N2MF8NL9rofFcpfZwptb5e6lN27PBK5vXBiafs4BcJlIIMp28a6WFld6jL0BFuxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=v15MyCK5; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1739697294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rt5BxxZTV58xNDbNgF1327IOm+eImblrMkl1NBTJjbU=;
	b=v15MyCK5VSdUac9qEUd85mvpHjw/ERNDvC8jyAnhFW4zew4w21adQpj3/P92SrQYd1kn0y
	jnOKakNZqFiXmeBcBRE7fS/5f2ziYRGsaYJufmuoGYHaVoJegCLYDNOv5aVFXunU907H2k
	VdIhzB7Vb4+DF8Jqghfrdfe5QQMAAQttkA/yUHZkhUEoNd2mlrynfR/tIlZR1L2SyKEo7u
	ftai2xalUGo5519NOkkwyeW5Fs+UMGAYa7woGgZkts2cRZk7d1RLfVzbGymyE/qzpkhIBy
	xkCS3BIawEmDQuuMVLIGDtcdjHDh/LP54/ZWiOiN39FPk506Bl9PEi9P9ZyVPA==
Content-Type: multipart/signed;
 boundary=d97e42a6c6353b7a4f9cd5bcce86d935721f1028ac7c8ebefddaa40ab478;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Sun, 16 Feb 2025 10:14:45 +0100
Message-Id: <D7TR7VP9UPQA.2U5BL328HNSXU@cknow.org>
Cc: <linux-arm-kernel@lists.infradead.org>,
 <linux-samsung-soc@vger.kernel.org>, <linux-phy@lists.infradead.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/4] dt-bindings: phy: add
 samsung,exynos2200-snps-eusb2-phy schema file
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: "Ivaylo Ivanov" <ivo.ivanov.ivanov1@gmail.com>, "Vinod Koul"
 <vkoul@kernel.org>, "Kishon Vijay Abraham I" <kishon@kernel.org>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Alim Akhtar"
 <alim.akhtar@samsung.com>, "Philipp Zabel" <p.zabel@pengutronix.de>
References: <20250215122409.162810-1-ivo.ivanov.ivanov1@gmail.com>
 <20250215122409.162810-2-ivo.ivanov.ivanov1@gmail.com>
In-Reply-To: <20250215122409.162810-2-ivo.ivanov.ivanov1@gmail.com>
X-Migadu-Flow: FLOW_OUT

--d97e42a6c6353b7a4f9cd5bcce86d935721f1028ac7c8ebefddaa40ab478
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Sat Feb 15, 2025 at 1:24 PM CET, Ivaylo Ivanov wrote:
> The Exynos2200 SoC uses Synopsis eUSB2 PHY. Add a dt-binding schema
> for the new driver.
>
> Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
> ---
>  .../samsung,exynos2200-snps-eusb2-phy.yaml    | 75 +++++++++++++++++++
>  1 file changed, 75 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/samsung,exynos2=
200-snps-eusb2-phy.yaml
>
> diff --git a/Documentation/devicetree/bindings/phy/samsung,exynos2200-snp=
s-eusb2-phy.yaml b/Documentation/devicetree/bindings/phy/samsung,exynos2200=
-snps-eusb2-phy.yaml
> new file mode 100644
> index 000000000..d69a10f00
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/samsung,exynos2200-snps-eusb2=
-phy.yaml
> @@ -0,0 +1,75 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/samsung,exynos2200-snps-eusb2-phy=
.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Samsung SNPS eUSB2 phy controller
> +
> +maintainers:
> +  - Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
> +
> +description:
> +  eUSB2 controller supports LS/FS/HS usb connectivity on Exynos chipsets=
.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - samsung,exynos2200-snps-eusb2-phy
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#phy-cells":
> +    const: 0
> +
> +  clocks:
> +    items:
> +      - description: Reference clock
> +      - description: APB clock
> +      - description: Control PCLK
> +
> +  clock-names:
> +    items:
> +      - const: ref
> +      - const: apb
> +      - const: ctrl
> +
> +  phys:
> +    maxItems: 1
> +    description:
> +      Phandle to USBCON phy
> +
> +  vdd-supply:
> +    description:
> +      Phandle to 0.88V regulator supply
> +
> +  vdda12-supply:
> +    description:
> +      Phandle to 1.2V regulator supply
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#phy-cells"
> +  - clocks
> +  - clock-names
> +  - vdd-supply
> +  - vdda12-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/samsung,exynos2200.h>
> +
> +    usb_hsphy: phy@10ab0000 {
> +        compatible =3D "samsung,exynos2200-snps-eusb2-phy";
> +        reg =3D <0 0x10ab0000 0 0x10000>;
> +        clocks =3D <&cmu_hsi0 CLK_MOUT_HSI0_USB32DRD>,
> +                 <&cmu_hsi0 CLK_MOUT_HSI0_NOC>,
> +                 <&cmu_hsi0 CLK_DOUT_DIV_CLK_HSI0_EUSB>;
> +        clock-names =3D "ref", "apb", "ctrl";
> +        #phy-cells =3D <0>;
> +        phys =3D <&usbcon_phy>;
> +    };

Shouldn't the example have at least all the *required* properties?
Same for patch 2 of this series.

Cheers,
  Diederik


--d97e42a6c6353b7a4f9cd5bcce86d935721f1028ac7c8ebefddaa40ab478
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZ7GshwAKCRDXblvOeH7b
bkU8AQCibICp1eXeMpoYosoeOHqF70rWCWBxmLXFVyJRfJNcqAEAjc2hyFVdJERG
U1ReV+OtGUBaTo1Ha+wF3AZwDhfJlwE=
=3NNk
-----END PGP SIGNATURE-----

--d97e42a6c6353b7a4f9cd5bcce86d935721f1028ac7c8ebefddaa40ab478--

