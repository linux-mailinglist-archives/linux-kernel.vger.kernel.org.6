Return-Path: <linux-kernel+bounces-342256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA45F988CA7
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 00:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 636F01F21961
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 22:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78ED1B653B;
	Fri, 27 Sep 2024 22:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eFcETG81"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28802188CA1;
	Fri, 27 Sep 2024 22:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727477894; cv=none; b=ad/wivvH0E8oVu1bhE/famhjKX6ZliFvc0NE7ZO8f70WSCbz25wvIFE2KUawjh3XymdgvMq+QqhxeNsPbFTdRR4ri/034tFIRcWdyL7qvtWE13RAE1HOT5Xbb6EmsuwBT1Jsa0V4ZqRgtU8YWs6vfM0sT7niiryAMbN1816TSGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727477894; c=relaxed/simple;
	bh=yrRZGlfYTshe02Szz0JVhV3pS+xPGgunl3lCOJQlCDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qc79Xcou+lF/1WWQ1d+U9HtF+BddNMwoHqYBGmvYR3F2mRTgzRSdFRy765tk8nhAcbPbHkyeqajG9RWy0NIICLmk8xtI0c4JaXSZl3rxCS6nIGFFtkj9qKkeNjjBGeY1rLsqeECJvr0u7yViA2Ia+0Pbv883zSA+zc17/JGQ3tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eFcETG81; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80381C4CEC4;
	Fri, 27 Sep 2024 22:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727477893;
	bh=yrRZGlfYTshe02Szz0JVhV3pS+xPGgunl3lCOJQlCDY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eFcETG81zwjiDPvoAunXoGwIipb7TyFWN1wZKb6M/cWCvDKO5c+Ym6ReTV3RyAc9w
	 woxom2VmxmFu1JT+VBu+FiLjwLUy9NaX5yJS4I0qmj3DgeflvUTkHx6faTn3F91iAj
	 fHgXgMkSZciUSOBOITyBsx4KtA8qO42RTRIqUm+2hj50IIQxHE0+X5c+ntlE7/BNUs
	 m6pmyw6lzV6EudPBiloTk0oOu8uTCmrG36n7hpVV/1scJ7TsoAGkqwySRUUrK3MmjO
	 o5fIrCfdWOTY0/BgoPf1TAuFMqSgBwPeAujGRXIu1KhQ27KGNdl6pF7KsGxU5KyR/h
	 HLntf2Xjoi3UQ==
Date: Fri, 27 Sep 2024 17:58:11 -0500
From: Rob Herring <robh@kernel.org>
To: Maya Matuszczyk <maccraft123mc@gmail.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: platform: Add bindings for Lenovo Yoga
 Slim 7x EC
Message-ID: <20240927225811.GA169571-robh@kernel.org>
References: <20240927185345.3680-1-maccraft123mc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240927185345.3680-1-maccraft123mc@gmail.com>

On Fri, Sep 27, 2024 at 08:53:40PM +0200, Maya Matuszczyk wrote:
> This patch adds devicetree binding documentation for Lenovo Yoga Slim 7x
> EC driver.
> 
> Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
> ---
>  .../platform/lenovo,yoga-slim7x-ec.yaml       | 50 +++++++++++++++++++
>  MAINTAINERS                                   |  5 ++
>  2 files changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/platform/lenovo,yoga-slim7x-ec.yaml
> 
> diff --git a/Documentation/devicetree/bindings/platform/lenovo,yoga-slim7x-ec.yaml b/Documentation/devicetree/bindings/platform/lenovo,yoga-slim7x-ec.yaml
> new file mode 100644
> index 000000000000..32f8a0b5d667
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/platform/lenovo,yoga-slim7x-ec.yaml
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/platform/lenovo,yoga-slim7x-ec.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Lenovo Yoga Slim 7x Embedded Controller.
> +
> +maintainers:
> +  - Maya Matuszczyk <maccraft123mc@gmail.com>
> +
> +description:
> +  The Lenovo Yoga Slim 7x has an EC which handles some minor functions, like
> +  power LED or some special keys on the keyboard. This bindings describes
> +  how it is connected
> +
> +properties:
> +  compatible:
> +    const: lenovo,yoga-slim7x-ec
> +
> +  reg:
> +    const: 0x76
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |+

Drop the '+'

> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c5 {

i2c {

> +        clock-frequency = <400000>;

Not really relevant for the example.

> +
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        embedded-controller@76 {
> +            compatible = "lenovo,yoga-slim7x-ec";
> +            reg = <0x76>;
> +
> +            interrupts-extended = <&tlmm 66 IRQ_TYPE_LEVEL_HIGH>;
> +        };
> +    };
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 00716c1faff6..0d4bfdde166d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12902,6 +12902,11 @@ S:	Maintained
>  W:	http://legousb.sourceforge.net/
>  F:	drivers/usb/misc/legousbtower.c
>  
> +LENOVO YOGA SLIM 7X EC DRIVER
> +M:	Maya Matuszczyk <maccraft123mc@gmail.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/platform/lenovo,yoga-slim7x-ec.yaml
> +
>  LETSKETCH HID TABLET DRIVER
>  M:	Hans de Goede <hdegoede@redhat.com>
>  L:	linux-input@vger.kernel.org
> -- 
> 2.45.2
> 

