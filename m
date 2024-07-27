Return-Path: <linux-kernel+bounces-264026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCAE93DE0B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 11:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA707283E35
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 09:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58605644E;
	Sat, 27 Jul 2024 09:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FzmnWdzd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3608481B9;
	Sat, 27 Jul 2024 09:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722071173; cv=none; b=czXuDSekFacMhwb7wQq/mpQMZo+W2Mi2Djxc6M/YdRmZqgD0v/rs/NPohE3XnsYaONgG0rR/WPKQ53VQPWaJTcQj6yfc1c+0LFjaUKWMYXDBprohXejfv8orMOoINs5XN0GuetvL700t+qirefkaoG3kOTMYMJ4zdoaG5c6jLHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722071173; c=relaxed/simple;
	bh=Z4hMzwjlVCw7IekS4CNQPfHlyOxqR5j69BIvedqQkYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K0uVk5BncFkvwPZXfcBlJzT6Ct4s9Tj5MRSgGjicwCLDuZCVZLGJ5sZRkDuDdgTVUiV1Zz669Y1b0zJscAToKdvYEH3sWdwzvYL6ikStT75ihcd9elX4tBDrCHk0uqn6GQZPdYDtF8y9bVc2J963K8eFhUSN8LjvVEqe0v0pu74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FzmnWdzd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80738C32781;
	Sat, 27 Jul 2024 09:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722071172;
	bh=Z4hMzwjlVCw7IekS4CNQPfHlyOxqR5j69BIvedqQkYU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FzmnWdzdi28nnYKKzar3Td0ojsbTV+BNYCbunFUaUEW26slgC+e/wBHnb7SIXh+aY
	 PUEmA/vkv/uaZsztqLEdq3jWQO/8VHeUpb3PlkpkVh6U2OOTMmnLUK8urqiz2AUTVx
	 2JC8umjUoW614G+/KiuYtN9r6uoXllcoxbhpHCzN9FNp3pRlfiAOw7ylW5IgM02lJk
	 DR6wpflN4JmYrjWEGEaUAmJKBzc9ibOA4snp+iz28S/UdmZU3R+EZchluooNborlDt
	 JUYksZa7rLeQxWNyBSZ3bMd2b3Q+1b9uHPaffF9fih6YsG4+4YqPp9UhCRZmSiadVl
	 IftGTbEs85aOg==
Message-ID: <52bf1aa6-449f-4f77-992e-45e510fe6e7f@kernel.org>
Date: Sat, 27 Jul 2024 11:06:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: display: Add Sharp Memory LCD
 bindings
To: Alex Lanzano <lanzano.alex@gmail.com>, mehdi.djait@bootlin.com,
 christophe.jaillet@wanadoo.fr,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240725004734.644986-1-lanzano.alex@gmail.com>
 <20240726194456.1336484-1-lanzano.alex@gmail.com>
 <20240726194456.1336484-2-lanzano.alex@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240726194456.1336484-2-lanzano.alex@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/07/2024 21:44, Alex Lanzano wrote:
> Add device tree bindings for the monochrome Sharp Memory LCD
> 
> Signed-off-by: Alex Lanzano <lanzano.alex@gmail.com>
> Co-developed-by: Mehdi Djait <mehdi.djait@bootlin.com>
> Signed-off-by: Mehdi Djait <mehdi.djait@bootlin.com>

The order of tags is incorrect. Who developed it first? Please read at
Submitting patches - it explained this case quite precisely.

> ---
>  .../bindings/display/sharp,ls010b7dh04.yaml   | 94 +++++++++++++++++++
>  1 file changed, 94 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/sharp,ls010b7dh04.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/sharp,ls010b7dh04.yaml b/Documentation/devicetree/bindings/display/sharp,ls010b7dh04.yaml
> new file mode 100644
> index 000000000000..79bde7bf0d7d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/sharp,ls010b7dh04.yaml
> @@ -0,0 +1,94 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/sharp,ls010b7dh04.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sharp Memory LCD panels
> +
> +maintainers:
> +  - Alex Lanzano <lanzano.alex@gmail.com>
> +
> +description:
> +  Sharp Memory LCDs are a series of monochrome displays that operate over
> +  a SPI bus when the chip select is high. The displays require a signal (VCOM)
> +  to be generated to prevent DC bias build up resulting in pixels being
> +  unable to change. Three modes can be used to provide the VCOM signal
> +  ("software", "external", "pwm").
> +
> +properties:
> +  compatible:
> +    enum:
> +      - sharp,ls010b7dh04
> +      - sharp,ls011b7dh03
> +      - sharp,ls012b7dd01
> +      - sharp,ls013b7dh03
> +      - sharp,ls013b7dh05
> +      - sharp,ls018b7dh02
> +      - sharp,ls027b7dh01
> +      - sharp,ls027b7dh01a
> +      - sharp,ls032b7dd02
> +      - sharp,ls044q7dh01
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-cs-high: true

<form letter>
This is a friendly reminder during the review process.

It seems my or other reviewer's previous comments were not fully
addressed. Maybe the feedback got lost between the quotes, maybe you
just forgot to apply it. Please go back to the previous discussion and
either implement all requested changes or keep discussing them.

Thank you.
</form letter>

> +
> +  spi-max-frequency:
> +    maximum: 2000000
> +
> +  sharp,vcom-mode:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description: |
> +      software - This mode relies on a software operation to send a
> +      "maintain display" message to the display, toggling the vcom
> +      bit on and off with each message
> +
> +      external - This mode relies on an external clock to generate
> +      the signal on the EXTCOMM pin

External clock? Then you might be missing clocks property.
> +
> +      pwm - This mode relies on a pwm device to generate the signal
> +      on the EXTCOMM pin

That's an enum. Otherwise why "pony" would be a correct vcom-mode?

> +
> +  enable-gpios: true
> +
> +  pwms:
> +    maxItems: 1
> +    description: External VCOM signal
> +
> +required:
> +  - compatible
> +  - reg
> +  - spi-cs-high
> +  - sharp,vcom-mode
> +
> +allOf:
> +  - $ref: panel/panel-common.yaml#
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +  - if:
> +      properties:
> +        sharp,vcom-mode:
> +          const: pwm
> +    then:
> +      required:
> +        - pwms
> +
> +additionalProperties: false

Instead:
unevaluatedProperties: false

> +
> +examples:
> +  - |
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        display@0{

Missing space (see DTS coding style or any DTS)

> +            compatible = "sharp,ls013b7dh03";
> +            reg = <0>;
> +            spi-cs-high;
> +            spi-max-frequency = <1000000>;
> +            sharp,vcom-mode = "software";
> +        };
> +    };
> +...

Best regards,
Krzysztof


