Return-Path: <linux-kernel+bounces-448751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B6D9F4501
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 08:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 315E0166943
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 07:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274EF18C008;
	Tue, 17 Dec 2024 07:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="raql7gm5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CC214600D;
	Tue, 17 Dec 2024 07:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734420134; cv=none; b=oiChA5OdQccDaohmunawzdUM7pcykhutuJJ0mFWZQdhExTHzEbKa1xPs35j/tjilklhIr5OLLPHj9ZQFTuHtPmbzR4hHnNlJpBACUQvOCMrdvE3wW67eXmWxgcAFm5z241xNsV8ID7QboNgVOTMA85uEsM/sBwelmuddUYJqXos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734420134; c=relaxed/simple;
	bh=NcOfgRFZrInx2wut2TWlz7O9nf0wpgq17dcJDM1ha5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t5NJsTVMY9RPymw42CkldQAquzc7ZdTt/5zLF5yDVl7z4p4WW1p2vYW6OcLBskGKb8H8ttKY8FeQ0jDS/1RI7QHet3IyTWObmDUwFdYZMqCwGv3PhDAvE3yNZOIVWfwt0yvet4GqZOQ9+4SFBTEutTPGk9C6nBlW1EG7v1vr2fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=raql7gm5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BCCDC4CED3;
	Tue, 17 Dec 2024 07:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734420134;
	bh=NcOfgRFZrInx2wut2TWlz7O9nf0wpgq17dcJDM1ha5Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=raql7gm5PHGc+0eiM5wxwyAVl/RN+fN0VyAydoNJtDtVu/65KerdPEWdja/liWbQ8
	 a+fIv8ycUByOzlGl0LKY9cy4uz+bzznXQGjfRlIFB619r8f8V1rfP4w8xxulPJ8pzB
	 btN9mkvP3nnRa0Qznk6L2so1OIoPC08COOfdC9HSd04XCpmKRxEIWh9TRDVFC1bsNh
	 JZlc6XbswNijpRiR9H9k2MaoQjQx4SYrf6jSz+cApoIJ7S+31NHcpr8g+98zgZZpVu
	 zWh032t6EQkTsaNHdt/oZid4z7eXbvUjhhXDYWVhPKMm6z0KrwSXgr4h/3ETWgkSiy
	 jJ0HP58yB4xcQ==
Date: Tue, 17 Dec 2024 08:22:10 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kanak Shilledar <kanakshilledar@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Carvalho Chehab <mchehab@kernel.org>, linux-usb@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: usb: dwc3-st: convert to dt schema
Message-ID: <4drvnvgitdqyokwm7vcpmeiepd47czvfsssclnvbx76bsz2iwe@532ojratwr4j>
References: <20241213051559.6066-1-kanakshilledar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241213051559.6066-1-kanakshilledar@gmail.com>

On Fri, Dec 13, 2024 at 10:45:55AM +0530, Kanak Shilledar wrote:
> removed st,syscon from the required property, added st,syscfg
> property.

Please say in the commit msg why.

> 
> Signed-off-by: Kanak Shilledar <kanakshilledar@gmail.com>
> ---
>  .../devicetree/bindings/usb/dwc3-st.txt       |  66 ----------
>  .../bindings/usb/st,stih407-dwc3.yaml         | 123 ++++++++++++++++++
>  2 files changed, 123 insertions(+), 66 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/usb/dwc3-st.txt
>  create mode 100644 Documentation/devicetree/bindings/usb/st,stih407-dwc3.yaml

...

> diff --git a/Documentation/devicetree/bindings/usb/st,stih407-dwc3.yaml b/Documentation/devicetree/bindings/usb/st,stih407-dwc3.yaml
> new file mode 100644
> index 000000000000..709cdb17f28d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/st,stih407-dwc3.yaml
> @@ -0,0 +1,123 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/usb/st,stih407-dwc3.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ST DWC3 glue logic
> +
> +description:
> +  This binding describes the parameters for the dwc3-st driver,
> +  which controls the glue logic used to configure the DWC3 core on
> +  STiH407-based platforms.
> +
> +maintainers:
> +  - Mauro Carvalho Chehab <mchehab@kernel.org>
> +
> +properties:
> +  compatible:
> +    const: st,stih407-dwc3
> +
> +  reg:
> +    # minItems: 2

Drop line

> +    items:
> +      - description: Glue logic base address.
> +      - description: USB syscfg ctrl register offset.
> +
> +  reg-names:
> +    # minItems: 2

Drop line

> +    items:
> +      - const: reg-glue
> +      - const: syscfg-reg
> +
> +  st,syscon:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: Phandle to system configuration node which.

which?

> +
> +  resets:
> +    maxItems: 2
> +
> +  reset-names:
> +    items:
> +      - const: powerdown
> +      - const: softreset
> +
> +  st,syscfg:

What's this? Missing type, description.

> +    maxItems: 1
> +
> +  '#address-cells':

Keep consistent quotes, either ' or "

> +    const: 1
> +
> +  '#size-cells':
> +    const: 1
> +
> +  pinctrl-names:
> +    items:
> +      - const: default

Drop property

> +
> +  pinctrl-0:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description: |
> +      Pin control group
> +      See: Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
> +

Drop property

> +  ranges:
> +    description: Valid 1:1 translation between child's and parent's address space.

Drop description, just :true


> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - resets
> +  - reset-names
> +  - pinctrl-names
> +  - pinctrl-0


address/size cells should be required. This device makes no sense
without actual DWC3 core.


> +  - ranges
> +
> +additionalProperties: false
> +
> +patternProperties:

patternProperties follow immediately "properties:" block.

> +  "^usb@[0-9a-f]+$":
> +    type: object
> +    description: DWC3 core sub-node
> +    $ref: snps,dwc3.yaml#
> +    unevaluatedProperties: false
> +    properties:
> +      dr_mode:
> +        enum:
> +          - host
> +          - device

That's odd, device is not a valid value. I guess you took it from the
old binding, but it was not correct. I don't think you tested this part
with different values.

> +        description: |
> +          Specifies the operating mode. The default value "otg" is not
> +          supported by this SoC. Valid values are "host" or "device".
> +          See: Documentation/devicetree/bindings/usb/usb-drd.yaml

Drop description, redundant.

> +
> +examples:
> +  - |
> +    #include <dt-bindings/phy/phy.h>
> +    #include <dt-bindings/reset/stih407-resets.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    st_dwc3: dwc3@8f94000 {
> +        compatible	= "st,stih407-dwc3";

Only one space before '='

> +        reg		= <0x08f94000 0x1000>, <0x110 0x4>;
> +        reg-names	= "reg-glue", "syscfg-reg";
> +        st,syscfg	= <&syscfg_core>;
> +        resets		= <&powerdown STIH407_USB3_POWERDOWN>,
> +              <&softreset STIH407_MIPHY2_SOFTRESET>;

Some total misalignment.

Best regards,
Krzysztof


