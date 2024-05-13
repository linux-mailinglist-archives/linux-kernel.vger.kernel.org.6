Return-Path: <linux-kernel+bounces-178037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 503798C47C4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 21:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1EF9B238B3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 19:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F5278C9A;
	Mon, 13 May 2024 19:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XLXdgBgr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412AD75813;
	Mon, 13 May 2024 19:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715629348; cv=none; b=AlTkZFWbXfPIMPGjQ2j0vJV0+sUi2eueyvwtuao0PDJTQwnXT3Ax7rL5Do1X7ok+xS70I691SVItbP3I1X1mO5EdfMkdhsr1cBppdVU4yuEKG65HdV7ml8gjm2YyIkedbrQp+/0qO9Un9NgqnSFbHuZSo0BArg1xdbVLJAgaBwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715629348; c=relaxed/simple;
	bh=PnA/t7uQTF+vxgn2P2JaqIe1cePISWFAFvcOkdI6CcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KC4ANTRCA//iieT+MEszDcGwf8vPdor6d+QAioYqQjdBCZpHz4lkSV+wOSHe+j+XY2oKFXsEhNGqGhmpm4C6V4SSL08wMTeP1k1EICzbVM34i7LDfQggTKpqJDf2ELKcDdwSjBH5srzhwbj24XefxN4r7tTMNo7t1x7S0vXrJr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XLXdgBgr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1F21C113CC;
	Mon, 13 May 2024 19:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715629348;
	bh=PnA/t7uQTF+vxgn2P2JaqIe1cePISWFAFvcOkdI6CcI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XLXdgBgry7YDf50oinDrReMP6MZJ7P+a8NaQQSQEqQoRIbWITK3Y+5uLU5OlMhzwn
	 WJruObfiD7IgVgKDEqbU8rN/kI/pC5zDc7P8R+LlG4l+qOGu8Y8PPQugG8WG5fWTWb
	 ngguETxU4vJH+MgGiHMBXMipJsKOGDlFcFMUo1Q898ENgROTbPxS2YlkpnlAsuHimb
	 3iXLtK1DHTzDN4Eiwdr0PBkM1kp40RKgEwtKrD6nJmnGtEmkFEAasAesaekxN55bC6
	 +os1o9OSgY96LF+LS2SsUXJhx00Dw06TQsKbSkYJWs2iev0AZzpaf87O78ViDfgOJj
	 kx+TtPa5WEX2Q==
Date: Mon, 13 May 2024 14:42:25 -0500
From: Rob Herring <robh@kernel.org>
To: Xiaxi Shen <shenxiaxi26@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org, lgirdwood@gmail.com,
	broonie@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	javier.carrasco.cruz@gmail.com, skhan@linuxfoundation.org
Subject: Re: [PATCH v2] ASoC: dt-bindings: ssm2602: convert to dt schema
Message-ID: <20240513194225.GA3013979-robh@kernel.org>
References: <20240512002456.267057-1-shenxiaxi26@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240512002456.267057-1-shenxiaxi26@gmail.com>

On Sat, May 11, 2024 at 05:24:56PM -0700, Xiaxi Shen wrote:
> Convert adi,ssm2602 binding to DT schema
> 
> The original adi,ssm2602.txt contains bindings for 3 devices
> SSM2602, SSM2603 and SSM2604. Since they share something
> in common. So I created one single yaml and name it 260x instead.
> Let me know if you think it should be done in another way.
> 
> It passed dt_binding_check and dtbs_check.
> 
> Signed-off-by: Xiaxi Shen <shenxiaxi26@gmail.com>
> ---
> Changes in v2:
>  - Change '2602' to '260x' in the variable $id and
>  it passed dt_binding_check and dtbs_check now.
> 
>  .../devicetree/bindings/sound/adi,ssm2602.txt | 19 -------
>  .../bindings/sound/adi,ssm260x.yaml           | 50 +++++++++++++++++++
>  2 files changed, 50 insertions(+), 19 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/adi,ssm2602.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/adi,ssm260x.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/adi,ssm2602.txt b/Documentation/devicetree/bindings/sound/adi,ssm2602.txt
> deleted file mode 100644
> index 3b3302fe399b..000000000000
> --- a/Documentation/devicetree/bindings/sound/adi,ssm2602.txt
> +++ /dev/null
> @@ -1,19 +0,0 @@
> -Analog Devices SSM2602, SSM2603 and SSM2604 I2S audio CODEC devices
> -
> -SSM2602 support both I2C and SPI as the configuration interface,
> -the selection is made by the MODE strap-in pin.
> -SSM2603 and SSM2604 only support I2C as the configuration interface.
> -
> -Required properties:
> -
> -  - compatible : One of "adi,ssm2602", "adi,ssm2603" or "adi,ssm2604"
> -
> -  - reg : the I2C address of the device for I2C, the chip select
> -          number for SPI.
> -
> - Example:
> -
> -	ssm2602: ssm2602@1a {
> -		compatible = "adi,ssm2602";
> -		reg = <0x1a>;
> -	};
> diff --git a/Documentation/devicetree/bindings/sound/adi,ssm260x.yaml b/Documentation/devicetree/bindings/sound/adi,ssm260x.yaml
> new file mode 100644
> index 000000000000..f465f9168a0a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/adi,ssm260x.yaml
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/adi,ssm260x.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices SSM2602, SSM2603 and SSM2604 I2S audio CODEC devices
> +
> +description:
> +  SSM2602 support both I2C and SPI as the configuration interface,
> +  

Why the blank line?

> +  the selection is made by the MODE strap-in pin.
> +
> +  SSM2603 and SSM2604 only support I2C as the configuration interface.
> +
> +maintainers:
> +  - Liam Girdwood <lgirdwood@gmail.com>
> +  - Mark Brown <broonie@kernel.org>
> +  - Rob Herring <robh@kernel.org>
> +  - Krzysztof Kozlowski <krzk+dt@kernel.org>
> +  - Conor Dooley <conor+dt@kernel.org>
> +
> +properties:
> +  compatible:
> +    description: One of "adi,ssm2602", "adi,ssm2603" or "adi,ssm2604"

Drop this. You say that with the schema below:

> +    enum:
> +      - adi,ssm2602
> +      - adi,ssm2603
> +      - adi,ssm2604
> +
> +  reg:
> +    description: the I2C address of the device for I2C, the chip select number for SPI.
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +   i2c {
> +     #address-cells = <1>;
> +     #size-cells = <0>;
> +     ssm2602@1a {
> +       compatible = "adi,ssm2602";
> +       reg = <0x1a>;
> +     };
> +   };
> -- 
> 2.34.1
> 

