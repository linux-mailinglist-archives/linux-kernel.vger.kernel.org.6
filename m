Return-Path: <linux-kernel+bounces-517254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5E7A37E43
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C744188B23A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 09:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064441FE47C;
	Mon, 17 Feb 2025 09:17:35 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71B91FDA7C
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 09:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739783854; cv=none; b=bQ+SCtyziBhd6kL33Z4rvIHbNDtx6Bhgkt0FcOTDpA4frHu4MOQj35brZa/EitAwdnqgBadCjkgq+UweXSnKw7maFIGoyr8GJ1Z0sR5hS0uX9Z2ja9m6OBTZ/HpJTxm96IZf2QFaG7s8KJcOgPP8gpt8aa6GdXUXjnwR8fdWdG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739783854; c=relaxed/simple;
	bh=maAJSSeJ1A1VrlOykhbpi2GRW3Z5GwNWyVLw64ajt54=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mh2daTvDSfHVHb3IzglNyGs7wVw3ckaUGIkJS1txWeuZXjQBGelx6NkwUuiukzYRvpKZL2hQdJDdkIHiJmafYuXRl4C6VC61VNpjtt23ojcAWc1kV8FvwdRJbLLMJLpaFwf5V1VA02ZdPgYRJXVtqTclF5XcfJpsPRm7jgJCPeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tjxFZ-0008U5-7G; Mon, 17 Feb 2025 10:17:13 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tjxFX-001Nlp-37;
	Mon, 17 Feb 2025 10:17:11 +0100
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tjxFX-000479-2q;
	Mon, 17 Feb 2025 10:17:11 +0100
Message-ID: <67fe157ce8ca3c3c4e08451da52f7c94f73439b2.camel@pengutronix.de>
Subject: Re: [PATCH v3 1/8] dt-bindings: spi: Add STM32 OSPI controller
From: Philipp Zabel <p.zabel@pengutronix.de>
To: patrice.chotard@foss.st.com, Mark Brown <broonie@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>,  Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Catalin
 Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org,  linux-kernel@vger.kernel.org,
 christophe.kerello@foss.st.com
Date: Mon, 17 Feb 2025 10:17:11 +0100
In-Reply-To: <20250210131826.220318-2-patrice.chotard@foss.st.com>
References: <20250210131826.220318-1-patrice.chotard@foss.st.com>
	 <20250210131826.220318-2-patrice.chotard@foss.st.com>
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

On Mo, 2025-02-10 at 14:18 +0100, patrice.chotard@foss.st.com wrote:
> From: Patrice Chotard <patrice.chotard@foss.st.com>
>=20
> Add device tree bindings for the STM32 OSPI controller.
>=20
> Main features of the Octo-SPI controller :
>   - support sNOR / sNAND / HyperRAM=E2=84=A2 and HyperFlash=E2=84=A2 devi=
ces.
>   - Three functional modes: indirect, automatic-status polling,
>     memory-mapped.
>   - Up to 4 Gbytes of external memory can be addressed in indirect
>     mode (per physical port and per CS), and up to 256 Mbytes in
>     memory-mapped mode (combined for both physical ports and per CS).
>   - Single-, dual-, quad-, and octal-SPI communication.
>   - Dual-quad communication.
>   - Single data rate (SDR) and double transfer rate (DTR).
>   - Maximum target frequency is 133 MHz for SDR and 133 MHz for DTR.
>   - Data strobe support.
>   - DMA channel for indirect mode.
>   - Double CS mapping that allows two external flash devices to be
>     addressed with a single OCTOSPI controller mapped on a single
>     OCTOSPI port.
>=20
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>  .../bindings/spi/st,stm32mp25-ospi.yaml       | 105 ++++++++++++++++++
>  1 file changed, 105 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/st,stm32mp25-os=
pi.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/spi/st,stm32mp25-ospi.yaml=
 b/Documentation/devicetree/bindings/spi/st,stm32mp25-ospi.yaml
> new file mode 100644
> index 000000000000..5f276f27dc4c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/st,stm32mp25-ospi.yaml
> @@ -0,0 +1,105 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/st,stm32mp25-ospi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: STMicroelectronics STM32 Octal Serial Peripheral Interface (OSPI)
> +
> +maintainers:
> +  - Patrice Chotard <patrice.chotard@foss.st.com>
> +
> +allOf:
> +  - $ref: spi-controller.yaml#
> +
> +properties:
> +  compatible:
> +    const: st,stm32mp25-ospi
> +
> +  reg:
> +    maxItems: 1
> +
> +  memory-region:
> +    description:
> +      Memory region to be used for memory-map read access.
> +      In memory-mapped mode, read access are performed from the memory
> +      device using the direct mapping.
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  resets:
> +    items:
> +      - description: phandle to OSPI block reset
> +      - description: phandle to delay block reset

Are you positive that these will only ever have to be reset together?
Otherwise I'd add a reset-names property just in case.

regards
Philipp

