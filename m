Return-Path: <linux-kernel+bounces-183992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 361AA8CA118
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 19:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE8F71F212D7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 17:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C4FD527;
	Mon, 20 May 2024 17:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BFm2fAhp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22511369B9;
	Mon, 20 May 2024 17:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716225304; cv=none; b=gU18CjM7DHp8bOazfRSsl7MbQGL1oygq6pdHi7InTXtEn9tZsum2Nv3clBIK7W0zTDfK9xpJao3y41geWvRq7w8naJAJpar9jc32/EaZzvr2FPZIhcoRfmhh5iUMnTJ4XakDEbEO0nT3UhdPabdKRFo7xkQaJ5I61EjBdsxnFvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716225304; c=relaxed/simple;
	bh=SMjqjtoCZgEa/aF+xDyzzTnAdHHH5RU9pSsvYcESxi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qA3oCqbcOzBEyc4JsOLNOwP0oIPTE+Pojd2Asik7L4hYon88J0MjMfsi5O1YfU8ZtayC0Lkpl6A2HEf3IrKVSagSEy284FH2SltleVrK8IK96PHbCx/hPVYHQ8rEQLkRpILZsE1NCMjbKJx8bANDI5Co1UUadn2TTo6PRR8Jumw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BFm2fAhp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9735C32789;
	Mon, 20 May 2024 17:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716225303;
	bh=SMjqjtoCZgEa/aF+xDyzzTnAdHHH5RU9pSsvYcESxi0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BFm2fAhp2kK4hwgAxUE8dPZ3alXKVzLERviGfnOgM+oaAVjDsxnPlhx905BnJOs8C
	 7ebgrSgvgZriA7u4NGaKlkk74fzRVeQNwWzgxsJqF2Go5FpV+WZkkPS197JjwBpI0A
	 nfz+TKzeGKtETFxRxbuHbONurDS7NSKKxLFgh38mTW7To/HA9SYEw00igMO0g+1pgR
	 OUNWRuPzdKGyGDprgwIWAnxAVCho6cH2mUoadi19efRa/ZZh7RPO1NiX+HRutcUeLp
	 C/oXgjxV0wFK+ynCSdEv77liMWCDsxgP9ugJp+P2/lP6NLFVKBJ3StsBHsjL47NAFL
	 mF/ugBYfiCQSw==
Date: Mon, 20 May 2024 18:14:58 +0100
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Roger Quadros <rogerq@kernel.org>, Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/5] dt-bindings: soc: ti: am645-system-controller: add
 AM654 syscon
Message-ID: <20240520-deskwork-unpinned-fb6b87cc7ffa@spud>
References: <20240518-dt-bindings-ti-soc-mfd-v1-0-b3952f104c9a@linaro.org>
 <20240518-dt-bindings-ti-soc-mfd-v1-2-b3952f104c9a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0al9K0Y79EnPUy/+"
Content-Disposition: inline
In-Reply-To: <20240518-dt-bindings-ti-soc-mfd-v1-2-b3952f104c9a@linaro.org>


--0al9K0Y79EnPUy/+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 18, 2024 at 10:07:17PM +0200, Krzysztof Kozlowski wrote:
> Add dedicated binding for the AM654 MCU SCM system controller registers,
> already used in the DTS to properly describe its children.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../soc/ti/ti,am654-system-controller.yaml         | 60 ++++++++++++++++=
++++++
>  1 file changed, 60 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/soc/ti/ti,am654-system-con=
troller.yaml b/Documentation/devicetree/bindings/soc/ti/ti,am654-system-con=
troller.yaml
> new file mode 100644
> index 000000000000..e79803e586ca
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/ti/ti,am654-system-controller=
=2Eyaml
> @@ -0,0 +1,60 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/ti/ti,am654-system-controller.yam=
l#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI AM654 System Controller Registers R/W

"R/W"? Is that a copy-paste mistake from the register map for this SoC?

Otherwise,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--0al9K0Y79EnPUy/+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZkuFEgAKCRB4tDGHoIJi
0m6dAP93xYp8ADQ/ZttCjnuveWAIRutjhPRI5gZc1jAbhGcspgD/WN2Lb9H7PkgN
XKd0YnLVM+On2SryiO2Ibp2Q/xvshgI=
=iMTG
-----END PGP SIGNATURE-----

--0al9K0Y79EnPUy/+--

