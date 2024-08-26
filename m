Return-Path: <linux-kernel+bounces-301787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9BD95F590
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 17:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03E631C21707
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 15:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADBDC194136;
	Mon, 26 Aug 2024 15:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eu86juEb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0CD4F215;
	Mon, 26 Aug 2024 15:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724687505; cv=none; b=njyRHWEk/+Mm7W/DrEwhue4QeGZS3mQo5nfaalel72z7TUDGXYYPYM7zTGyP+dy0uin3biDl4x2s8gHWytpF5ykt0X3H06J1U7+/iFJ4VOUCyWP/jGfMxnm052FeSMTPNgryyOYnpfdpFcbeG+pN4Aq2P2dQiGy3eQ47/fpzAFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724687505; c=relaxed/simple;
	bh=39MAFBC0ARo13JZKV+5ijTkxKLlQ4ap97jwXtmDSqZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T8FoU9EgOpdAwMcd5Ixls/ehs4A6/gz8cMjdK/nE5PiY822qNfcEwSdqu0qU4RKLJ9Xh968GBJS3U3rtGCYtZBwRek+359atGp/c7mKvL6gir1UK3PEz9IAFyFaYBw1IuFSmEUgpuj453cSCnVLuK+dA/u8ig7JdWzTOmVtcqrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eu86juEb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCEC7C4FF75;
	Mon, 26 Aug 2024 15:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724687505;
	bh=39MAFBC0ARo13JZKV+5ijTkxKLlQ4ap97jwXtmDSqZE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eu86juEbryBdB4uXclh2OM+ro70t8X9jdy+48GEErbb1rkGe7j2HFEX4ByrOB3QmQ
	 6ZkS7kb5DVuywzKFKbtCnuQVW673q0xXKl6H7jmyDZYZYnNXBeiO4Kc32HDnxHbft+
	 XUq8leoSpzK+gUX5MydYUgINQcI34O8vGXhcE3C1BT7d0yMBYDwtX5tbCtDQkwk/Z+
	 bpqw8ShYh+1fzHML9KCg5v/h0R8zF3zHi3L+A9JjhB6ieigGGuTFzM3N98bSaCAv1/
	 YbA0D6+LQTSvLAuDjK5u9Q5NduxjNRJnNrrPEUOKwpo2VeKOv2zNG4MYRDnGKfUqZx
	 vRD1ajmaUHLZA==
Message-ID: <62edecf4-6fc6-4aff-bd42-4fac171f5093@kernel.org>
Date: Mon, 26 Aug 2024 17:51:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: dt-bindings: cirrus,cs4271: Convert to dtschema
To: nikita.shubin@maquefel.me, David Rhodes <david.rhodes@cirrus.com>,
 Richard Fitzgerald <rf@opensource.cirrus.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc: linux-sound@vger.kernel.org, patches@opensource.cirrus.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240826-cs4271-yaml-v1-1-dad3f0b041ef@maquefel.me>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240826-cs4271-yaml-v1-1-dad3f0b041ef@maquefel.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/08/2024 11:53, Nikita Shubin via B4 Relay wrote:
> From: Nikita Shubin <nikita.shubin@maquefel.me>
> 
> Convert the Cirrus Logic CS4271 audio CODEC bindings to DT schema.
> 
> Cc: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> Link: https://lore.kernel.org/all/20240715-ep93xx-v11-0-4e924efda795@maquefel.me

I think Link goes above your SoB. Your Sob must be the last tag from you.

> ---
> This is complementary patch to ep93xx DT conversion series.

...

> +
> +title: Cirrus Logic CS4271 audio CODEC
> +
> +maintainers:
> +  - Alexander Sverdlin <alexander.sverdlin@gmail.com>
> +  - Nikita Shubin <nikita.shubin@maquefel.me>
> +
> +description:
> +  The CS4271 is a stereo audio codec. This driver supports both the I2C
> +  and the SPI bus.

Drop references to driver. You can say that device supports
configuration over I2C and SPI.

> +
> +allOf:
> +  - $ref: dai-common.yaml#
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +properties:
> +  compatible:
> +    const: cirrus,cs4271
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-cpha: true
> +
> +  spi-cpol: true
> +
> +  '#sound-dai-cells':
> +    const: 0

None of these three were present in original binding.

> +
> +  reset-gpio:

If it bases on cs4270, look there - there is no "gpio", but "gpios".
Mention changes in commit msg.


> +    description:
> +      This pin will be deasserted before communication to the codec starts.
> +    maxItems: 1
> +
> +  va-supply:
> +    description: Analog power supply.
> +
> +  vd-supply:
> +    description: Digital power supply.
> +
> +  vl-supply:
> +    description: Serial Control Port power supply.
> +
> +  port:
> +    $ref: audio-graph-port.yaml#
> +    unevaluatedProperties: false

This wasn't present in original binding and nothing in commit msg
explained changes from pure conversion. Explain them in commit msg.

> +
> +  cirrus,amuteb-eq-bmutec:
> +    description:
> +      When given, the Codec's AMUTEB=BMUTEC flag is enabled.
> +    type: boolean
> +
> +  cirrus,enable-soft-reset:
> +    description: |
> +      The CS4271 requires its LRCLK and MCLK to be stable before its RESET
> +      line is de-asserted. That also means that clocks cannot be changed
> +      without putting the chip back into hardware reset, which also requires
> +      a complete re-initialization of all registers.
> +
> +      One (undocumented) workaround is to assert and de-assert the PDN bit
> +      in the MODE2 register. This workaround can be enabled with this DT
> +      property.
> +
> +      Note that this is not needed in case the clocks are stable
> +      throughout the entire runtime of the codec.
> +    type: boolean
> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        cs4271: codec@0 {

Drop unused label.

> +            compatible = "cirrus,cs4271";
> +            reg = <0>;
> +            reset-gpio = <&gpio0 1 0>;

Use defines for flags.

Also, make the example complete. You  miss many properties.

> +        };
> +    };
> +
> +...
> \ No newline at end of file

This needs to be always fixed before posting.



Best regards,
Krzysztof


