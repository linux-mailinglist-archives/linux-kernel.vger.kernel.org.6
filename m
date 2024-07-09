Return-Path: <linux-kernel+bounces-246714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D3692C5A9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 23:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51E331C222CE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 21:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31BD185605;
	Tue,  9 Jul 2024 21:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="frC0CHfX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEB739FD9;
	Tue,  9 Jul 2024 21:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720561523; cv=none; b=OlKlFXnk5c2C9begasYHcl4lXoDUHU6HahdCjmi1dweG6oedrMebTZwtOGhNeN1DgJgOCFqAi3Vs6N27b/wZypDNK2H4UwDE5PvKpu/8b1EVOK4CB/EMuCXKX19THuuhySMBnctNhztDS49MLBB0TH5neNRB8w6OOyYAxgb3s6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720561523; c=relaxed/simple;
	bh=L7UCNM+c3AvSjhbiLx4WoUJDX1N1mNGU5BEXO5uWjzc=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=ftJrsdkShBx3pxMU79sL83MPNV+Pd6wEFVSHzp5aTJT3wOj55aM1r9lMLwDwnwIXh1HJ8kekryMVIkWtupiwJu+DdhCELhgi+CfrMXQMY8jRrKORR6T1H8v2+Kz2NplKDE1gTyEDY6yav4RL09kr0O0LyhVMH3vC1tu4R2/DbD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=frC0CHfX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5AA9C3277B;
	Tue,  9 Jul 2024 21:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720561523;
	bh=L7UCNM+c3AvSjhbiLx4WoUJDX1N1mNGU5BEXO5uWjzc=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=frC0CHfXu1bTRMyhetfceQWH82xLTzJheQuXuE0434yrS81Mb5rQudZ/hcCgMHeBs
	 ENsAbpfbkyWHg2pXiLNjfCuH+3EDroTgysl/0iZP8DRVr/ohdG7ajVfKrg85paOdr1
	 ufJw+uUDx/vcJpwXj/5x0Zf+plkcsiHR9Hc8/5dThk+6zpimocysjXtYohnaYXCRfq
	 940XequIFcEM893M5FJQXsD48a7SUeDOCZR8fMbysS43IlO+V/DkQmoHH9wWoaoVuP
	 ZT6yoVsSsimYP4MaH8fkUPEWF3R/l2gXLBbs6Ob3iUky1KWexnO9/tb7piaMvZEVYV
	 s8+6xMozhLbfQ==
Message-ID: <2e5852b9e94b9a8d0261ce7ad79f4329.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240709123121.1452394-2-heiko@sntech.de>
References: <20240709123121.1452394-1-heiko@sntech.de> <20240709123121.1452394-2-heiko@sntech.de>
Subject: Re: [PATCH 1/6] dt-bindings: clocks: add binding for generic clock-generators
From: Stephen Boyd <sboyd@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de, quentin.schulz@cherry.de, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
To: Heiko Stuebner <heiko@sntech.de>, mturquette@baylibre.com
Date: Tue, 09 Jul 2024 14:45:20 -0700
User-Agent: alot/0.10

Quoting Heiko Stuebner (2024-07-09 05:31:16)
> In contrast to fixed clocks that are described as ungateable, boards
> sometimes use additional clock generators for things like PCIe reference
> clocks, that need actual supplies to get enabled and enable-gpios to be
> toggled for them to work.
>=20
> This adds a binding for such clock generators that are not configurable
> themself, but need to handle supplies for them to work.

Sounds like vdd-supply is required?

>=20
> While in a lot of cases the type of the IC used is described in board
> schematics, in some cases just a generic type description like
> "100MHz, 3.3V" might also be used. The binding therefore allows both
> cases. Specifying the type is of course preferred.
>=20
> The clock-frequency is set in devicetree, because while some clock
> generators have pins to decide between multipls output rates, those
> are generally set statically on the board-layout-level.
>=20
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  .../bindings/clock/clock-generator.yaml       | 62 +++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/clock-generat=
or.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/clock/clock-generator.yaml=
 b/Documentation/devicetree/bindings/clock/clock-generator.yaml
> new file mode 100644
> index 0000000000000..f44e61e414e89
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/clock-generator.yaml
> @@ -0,0 +1,62 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/clock-generator.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Simple clock generators
> +
> +maintainers:
> +  - Heiko Stuebner <heiko@sntech.de>
> +
> +properties:
> +  $nodename:
> +    anyOf:
> +      - description:
> +          Preferred name is 'clock-<freq>' with <freq> being the output
> +          frequency as defined in the 'clock-frequency' property.
> +        pattern: "^clock-([0-9]+|[a-z0-9-]+)$"
> +      - description: Any name allowed
> +        deprecated: true

Drop the deprecated stuff from the fixed-clock binding?

> +
> +  compatible:
> +    oneOf:
> +      - const: clock-generator
> +      - items:
> +          - enum:
> +              - diodes,pi6c557-03b

I see this datasheet[1]. Can that link be included somewhere? That shows
there's a clock input pin, which means I expect a 'clocks' property.

Maybe instead of creating a generic binding just make a binding for
these diodes parts? It certainly looks like a generic binding could come
later when another vendor supports the same binding.

> +              - diodes,pi6c557-05b
> +          - const: clock-generator
> +
> +  "#clock-cells":
> +    const: 0
> +
> +  clock-frequency: true
> +
> +  clock-output-names:
> +    maxItems: 1
> +
> +  enable-gpios:
> +    description:
> +      Contains a single GPIO specifier for the GPIO that enables and dis=
ables
> +      the clock generator.
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description: handle of the regulator that provides the supply voltage
> +
> +required:
> +  - compatible
> +  - "#clock-cells"
> +  - clock-frequency

This is the same required properties as fixed rate clocks. I'd guess
that at least 'enable-gpios' or 'vdd-supply' should also be required, or
the node would simply use fixed-clock compatible.

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    clock {
> +      compatible =3D "clock-generator";
> +      #clock-cells =3D <0>;
> +      clock-frequency =3D <1000000000>;
> +    };

[1] https://diodes.com/assets/Datasheets/PI6C557-03B.pdf

