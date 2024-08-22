Return-Path: <linux-kernel+bounces-297474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F8295B8D8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 16:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B7041F26039
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 14:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63EF71CC896;
	Thu, 22 Aug 2024 14:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vf/9Nta3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06351CC173;
	Thu, 22 Aug 2024 14:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724337959; cv=none; b=mfYoygfjtriW1Twb9Xho9zpD+PMD8wnf53/duAkztki5QQn2sWRuU5HStAb+Vhbvsx3E6GnifVPmeTd3cdi80s6lZK7PsGtHJkpuub3JokybyG94tM5+947J4G/UbxNerE+jXyZD1wG6lNOV4yoHBhR1/0bNMehtEPf9+DNtwOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724337959; c=relaxed/simple;
	bh=x0e29J9g52f8NEmIe2hsAYq/rb04QNT+gdvduOEJ1Wc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sKHLvZW4LqiI92TUB9NcPcspkUuwMHqukX4VARl+KVuEDdsXbZ0v75CQfDs0wqVYLulhhnuNtPzyQq8D/3+QB3I6l+pKM5XnFint/Y2Gx/60M5TcgWqOKQYxOvQtWDAlOHD//cvHhXgBkM0dUUQxfv7CuDp8xdc9Jr011y9E8Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vf/9Nta3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 690B1C32782;
	Thu, 22 Aug 2024 14:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724337959;
	bh=x0e29J9g52f8NEmIe2hsAYq/rb04QNT+gdvduOEJ1Wc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Vf/9Nta37Ucz9t7QAy2ohdXznWnvO3b6dts/6ERC3dR035ogV9Y5RsDeXVtjRctCA
	 IfpvZ3/+iB0dL99vJ6uJvJ8Aei8S4V1erVBv97vduuCek7VO8U1YHdcEc1aYhklvX8
	 E1s88DDeuqZL1wn+wNwEUfNnygTT3zOTfJiWomEyljPSh3kvWXuLYfelSCUKTL1MpG
	 Bahm/K6E5OsEyxZXOqt3QGbPEMi9hb0i8rPxpWtJMsUk6H1eeqENbzQcUbsSbgoOpP
	 g0ERss+Qc9+8TMBaA6RSFldaL/NbuyVnius+b5Il7SH/60xm6fCfGtzm9QloLctvjH
	 ghJbWyo+nlPVw==
Message-ID: <b4b96be5-fad6-458c-a236-9b6761eac968@kernel.org>
Date: Thu, 22 Aug 2024 23:45:56 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] dt-bindings: extcon: convert extcon-usb-gpio.txt to
 yaml format
To: Frank Li <Frank.Li@nxp.com>, MyungJoo Ham <myungjoo.ham@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,
 "open list:EXTERNAL CONNECTOR SUBSYSTEM (EXTCON)"
 <linux-kernel@vger.kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>
Cc: imx@lists.linux.dev
References: <20240812201754.3830198-1-Frank.Li@nxp.com>
From: Chanwoo Choi <chanwoo@kernel.org>
Content-Language: en-US
In-Reply-To: <20240812201754.3830198-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

24. 8. 13. 05:17에 Frank Li 이(가) 쓴 글:
> Convert binding doc extcon-usb-gpio.txt to yaml format to fix below
> warning:
> arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dtb: /extcon-usb0:
>     failed to match any schema with compatible: ['linux,extcon-usb-gpio']
> 
> Additional change:
> - rename id-gpio to id-gpios
> - rename vbus-gpio to vbus-gpios
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../bindings/extcon/extcon-usb-gpio.txt       | 21 ----------
>  .../extcon/linux,extcon-usb-gpio.yaml         | 38 +++++++++++++++++++
>  2 files changed, 38 insertions(+), 21 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/extcon/extcon-usb-gpio.txt
>  create mode 100644 Documentation/devicetree/bindings/extcon/linux,extcon-usb-gpio.yaml
> 
> diff --git a/Documentation/devicetree/bindings/extcon/extcon-usb-gpio.txt b/Documentation/devicetree/bindings/extcon/extcon-usb-gpio.txt
> deleted file mode 100644
> index dfc14f71e81fb..0000000000000
> --- a/Documentation/devicetree/bindings/extcon/extcon-usb-gpio.txt
> +++ /dev/null
> @@ -1,21 +0,0 @@
> -USB GPIO Extcon device
> -
> -This is a virtual device used to generate USB cable states from the USB ID pin
> -connected to a GPIO pin.
> -
> -Required properties:
> -- compatible: Should be "linux,extcon-usb-gpio"
> -
> -Either one of id-gpio or vbus-gpio must be present. Both can be present as well.
> -- id-gpio: gpio for USB ID pin. See gpio binding.
> -- vbus-gpio: gpio for USB VBUS pin.
> -
> -Example: Examples of extcon-usb-gpio node in dra7-evm.dts as listed below:
> -	extcon_usb1 {
> -		compatible = "linux,extcon-usb-gpio";
> -		id-gpio = <&gpio6 1 GPIO_ACTIVE_HIGH>;
> -	}
> -
> -	&omap_dwc3_1 {
> -		extcon = <&extcon_usb1>;
> -	};
> diff --git a/Documentation/devicetree/bindings/extcon/linux,extcon-usb-gpio.yaml b/Documentation/devicetree/bindings/extcon/linux,extcon-usb-gpio.yaml
> new file mode 100644
> index 0000000000000..1caf58c297d34
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/extcon/linux,extcon-usb-gpio.yaml
> @@ -0,0 +1,38 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/extcon/linux,extcon-usb-gpio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: USB GPIO Extcon device
> +
> +maintainers:
> +  - Frank Li <Frank.Li@nxp.com>
> +
> +description:
> +  This is a virtual device used to generate USB cable states from the USB ID pin
> +  connected to a GPIO pin.
> +
> +properties:
> +  compatible:
> +    const: linux,extcon-usb-gpio
> +
> +  id-gpios:
> +    description: gpio for USB ID pin. See gpio binding.
> +  vbus-gpios:
> +    description: gpio for USB VBUS pin.
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    extcon_usb1 {
> +        compatible = "linux,extcon-usb-gpio";
> +        id-gpios = <&gpio6 1 GPIO_ACTIVE_HIGH>;
> +    };
> +

Applied it. Thanks.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi


