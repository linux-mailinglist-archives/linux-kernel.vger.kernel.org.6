Return-Path: <linux-kernel+bounces-512653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE01A33C27
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 11:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7970D3A9B98
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 10:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10EA211A37;
	Thu, 13 Feb 2025 10:09:11 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB5B20B7FF
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 10:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739441351; cv=none; b=JirVeTC53poR6CAxiNxNcsAScMUpjJaN1GzZDPcUGfFNfNnSCjv0RmFgTaOwC7+RAUNhm7l+k84wOGHUKtJxmt8u1btCFErwXE1q5HyQDQiuHtcR8U+eQ2zVkjxlJC2KN+nW4VFr41ed5Y/+sP+FCxs+Y4GcdXJIMdTVUvn8YlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739441351; c=relaxed/simple;
	bh=Y5FUp5kLJYW5mox92ZooldkZMGROpVAVdRn0fHlo0FI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FDydcm+bgdUGaWHDSV5qbdCm31VZz9b5oouPb75gitnwHMwpIi/OCI8CKFIPcWgnjydCuMte5/XqQWmd0CkoOEfKkM2od2DQE93vlC9yRzAq+mdPfBB6D9kNcbr4Yh195ioRleTaSWUg7NosP4gzN+4ykvEN2lsCaWff5r/xw7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tiW9T-00079j-E1; Thu, 13 Feb 2025 11:08:59 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tiW9T-000jXg-0a;
	Thu, 13 Feb 2025 11:08:59 +0100
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tiW9T-0002x5-0P;
	Thu, 13 Feb 2025 11:08:59 +0100
Message-ID: <de7dedf98e2085c895a93ba56c4e5fa50e298d05.camel@pengutronix.de>
Subject: Re: [PATCH 1/4] dt-bindings: reset: add generic bit reset controller
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Inochi Amaoto <inochiama@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chen Wang <unicorn_wang@outlook.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,  Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sophgo@lists.linux.dev, linux-riscv@lists.infradead.org, Yixun Lan
	 <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Date: Thu, 13 Feb 2025 11:08:59 +0100
In-Reply-To: <20250213020900.745551-2-inochiama@gmail.com>
References: <20250213020900.745551-1-inochiama@gmail.com>
	 <20250213020900.745551-2-inochiama@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Do, 2025-02-13 at 10:08 +0800, Inochi Amaoto wrote:
> Some SoCs from Aspeed, Allwinner, Sophgo and Synopsys have
> a simple reset controller by toggling bit. It is a hard time
> for each device to add its own compatible to the driver.
> Since this device share a common design, it is possible to
> add a common device to reduce these unnecessary change.
>=20
> Add common binding for these kind generic reset controller.
>=20
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> ---
>  .../bindings/reset/reset-simple.yaml          | 42 +++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/reset-simple.=
yaml
>=20
> diff --git a/Documentation/devicetree/bindings/reset/reset-simple.yaml b/=
Documentation/devicetree/bindings/reset/reset-simple.yaml
> new file mode 100644
> index 000000000000..77584e23e8e8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reset/reset-simple.yaml
> @@ -0,0 +1,42 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/reset/reset-simple.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Generic BIT Reset Controller
> +
> +maintainers:
> +  - Inochi Amaoto <inochiama@gmail.com>
> +
> +description:
> +  Some reset controller devices uses a simple method to perform
> +  assert/deassert by toggling bit. Some SoCs from Aspeed, Allwinner,
> +  Sophgo and Synopsys have this kind of reset controller instances.

I think some properties should be documented that make reset
controllers "simple" according to this binding.

For example, right now, the reset-simple driver assumes the following:

  - There is a single, contiguous range of 32-bit registers.
  - All bits in each register directly control a reset line.
     - There are no self-deasserting resets.
     - There are no timing requirements.
     - The bits are exclusively resets, nothing else.
  - All bits behave the same, so all reset bits are either
    active-high or all are active-low.
  - The bits can be read back, but the read status may
    be active-low independently from the writes.

> +properties:
> +  compatible:
> +    enum:
> +      - reset-simple-high
> +      - reset-simple-low

I wonder if it would be better to have a single

  compatible:
    const: reset-simple

and a boolean property, e.g.

  active-low:
    type: boolean

like in leds/common.yaml. Also it should be documented clearly what
this means for reads and writes.

> +  reg:
> +    maxItems: 1
> +
> +  "#reset-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#reset-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    reset-controller@1000000 {
> +        compatible =3D "reset-simple-high";

The example should probably include a SoC specific compatible?

regards
Philipp

