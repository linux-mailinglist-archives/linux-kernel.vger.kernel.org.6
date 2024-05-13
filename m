Return-Path: <linux-kernel+bounces-178031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DCB8C47A6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 21:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 744A02865C0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 19:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D627BB12;
	Mon, 13 May 2024 19:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/RwX359"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F6777F13;
	Mon, 13 May 2024 19:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715629106; cv=none; b=kw0lWqftToYYmcqliusNiOG2EeZAruB72E7qfP+K8Ej67dxMfCbWkEiqFNWw2T7o+wbGiV+jBfrNjJILuX7Adz+q9AdeVgepNDTOH8LLMCjzg1xVXQ/FXubhgIkf4sCM4yAY/bY7q2sgpmOVbezUqzsawpvVAwA7rl0foKkJeMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715629106; c=relaxed/simple;
	bh=FDhzjixi9qj4qYYv/pF0kkgOWecQpxha+5i6/ywXIAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cs/Bvxs9KVsDLYdcox3ZNQa6uZaGFHzrwBYSpcmfOc4lFLHkn49RlYz70dtxpPbXM/+OOslk2cmcQCKvhndAoI3wrlsnrqy+J4voUdauAA6cL76gBt+uOTx0/0bUiUSJ7/86NOkN1IgbCN9cLsAZubrCW6wbI27fiJ7rEGlR+K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n/RwX359; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4B62C113CC;
	Mon, 13 May 2024 19:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715629105;
	bh=FDhzjixi9qj4qYYv/pF0kkgOWecQpxha+5i6/ywXIAo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n/RwX3595HOJ8PBr6qaPAAsTXAIOVM9woIeVmAwgKv7oyt9UYae1QPTgGEk0Kr/Jc
	 l76XD5FXCghLL3c+yZOUhsnDB0gXh+S5K0r40ujM+vMEYxnVB44zXVJvRhEOAwq/i2
	 TFK/DtQ2dRjjZ8OxHknblkB/vpcBYN9zguPlL+K6KJtMK9SNH+ZQaoD+25i9bO2yY3
	 uRvyaFk1mtLNpKODWs6D6ugnPf0Evx+V0gtlpJeanUZHA3tVusrw/mDB0omJeB0pi3
	 wdXKBhM9BeAp9qWaDkjf73JTHYZ4YQSwFNnq8CAZORfl6/Vj2CjGEJlGCqVsefk1iS
	 Bku1bukNMpe4g==
Date: Mon, 13 May 2024 14:38:23 -0500
From: Rob Herring <robh@kernel.org>
To: Xiaxi Shen <shenxiaxi26@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org, lgirdwood@gmail.com,
	broonie@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	javier.carrasco.cruz@gmail.com, skhan@linuxfoundation.org
Subject: Re: [PATCH] ASoC: dt-bindings: ak4118: convert to dt schema
Message-ID: <20240513193823.GA3006391-robh@kernel.org>
References: <20240511214624.242579-1-shenxiaxi26@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240511214624.242579-1-shenxiaxi26@gmail.com>

On Sat, May 11, 2024 at 02:46:24PM -0700, Xiaxi Shen wrote:
> Convert ak4118 binding to DT schema
> 
> It passed dt_binding_check and dtbs_check. Let me know
> if you think it should include something else

This doesn't belong in the commit message.

> 
> Signed-off-by: Xiaxi Shen <shenxiaxi26@gmail.com>
> ---
>  .../devicetree/bindings/sound/ak4118.txt      | 22 -------
>  .../bindings/sound/asahi-kasei,ak4118.yaml    | 58 +++++++++++++++++++
>  2 files changed, 58 insertions(+), 22 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/ak4118.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/asahi-kasei,ak4118.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/ak4118.txt b/Documentation/devicetree/bindings/sound/ak4118.txt
> deleted file mode 100644
> index 6e11a2f7404c..000000000000
> --- a/Documentation/devicetree/bindings/sound/ak4118.txt
> +++ /dev/null
> @@ -1,22 +0,0 @@
> -AK4118 S/PDIF transceiver
> -
> -This device supports I2C mode.
> -
> -Required properties:
> -
> -- compatible : "asahi-kasei,ak4118"
> -- reg : The I2C address of the device for I2C
> -- reset-gpios: A GPIO specifier for the reset pin
> -- irq-gpios: A GPIO specifier for the IRQ pin
> -
> -Example:
> -
> -&i2c {
> -	ak4118: ak4118@13 {
> -		#sound-dai-cells = <0>;
> -		compatible = "asahi-kasei,ak4118";
> -		reg = <0x13>;
> -		reset-gpios = <&gpio 0 GPIO_ACTIVE_LOW>
> -		irq-gpios = <&gpio 1 GPIO_ACTIVE_HIGH>;
> -	};
> -};
> diff --git a/Documentation/devicetree/bindings/sound/asahi-kasei,ak4118.yaml b/Documentation/devicetree/bindings/sound/asahi-kasei,ak4118.yaml
> new file mode 100644
> index 000000000000..abbce999eb30
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/asahi-kasei,ak4118.yaml
> @@ -0,0 +1,58 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/asahi-kasei,ak4118.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: AK4118 S/PDIF transceiver
> +
> +allOf:
> +  - $ref: dai-common.yaml#
> +
> +maintainers:
> +  - Liam Girdwood <lgirdwood@gmail.com>
> +  - Mark Brown <broonie@kernel.org>
> +  - Rob Herring <robh@kernel.org>
> +  - Krzysztof Kozlowski <krzk+dt@kernel.org>
> +  - Conor Dooley <conor+dt@kernel.org>

Again, should be someone with the h/w or that cares about it.

(If you are new to bindings (or anything else), it would be best to send 
1 patch out and wait for comments before sending more and repeating the 
same problems on multiple ones.

> +
> +properties:
> +  compatible:
> +    const: asahi-kasei,ak4118
> +
> +  reg:
> +    description: The I2C address of the device for I2C
> +    maxItems: 1
> +
> +  "#sound-dai-cells":
> +    const: 0    
> +
> +  reset-gpios:
> +    description: A GPIO specifier for the reset pin
> +    maxItems: 1
> +
> +  irq-gpios:
> +    description: A GPIO specifier for the IRQ pin
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - reset-gpios
> +  - irq-gpios
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +   i2c {
> +     #address-cells = <1>;
> +     #size-cells = <0>;
> +     ak4118@13 {

Node names should be generic:

spdif@13

> +       #sound-dai-cells = <0>;
> +       compatible = "asahi-kasei,ak4118";
> +       reg = <0x13>;
> +       reset-gpios = <&gpio 0 0>;
> +       irq-gpios = <&gpio 1 1>;
> +     };
> +   };
> -- 
> 2.34.1
> 

