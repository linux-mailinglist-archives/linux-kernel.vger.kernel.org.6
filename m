Return-Path: <linux-kernel+bounces-361289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E3099A646
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 16:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37E561C21099
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 14:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8B72194A9;
	Fri, 11 Oct 2024 14:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MraT0TRZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62FD212F13;
	Fri, 11 Oct 2024 14:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728656831; cv=none; b=HewVgGEIwNJ2iDno7O/ARJmUagkhYeIG5D2aVPc4n7o1x5OOKR6S859k2rP0/0aTe2fkYkIL7viWEA+rzufEBMLQzX23Dj5QS1XQKrvlAYYqjDn6FyjLQGGe7naQE4PBZIuIXFI843KEl9xWm31EseCA/Ds3HPeBmBMiIhk4dGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728656831; c=relaxed/simple;
	bh=pUd9AMdtvemQ98FlMluaPmqLuijLZiDm9z3uByCDb8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LKfN6QzKIagih0Ttbl2b6J1wvL685eIYynyNCHQkbtllILBNS+m4DK/LJNITDlf7P1rQASIJkChhYQXR8yQXQ9b0jrNao/3c4ClL0bvyzfrNuuDOpeADkSNlkj45xYAH2+acqgOf/Mvt7DiTKoV3DnC/DKVlAlGoe4kfI2TIIYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MraT0TRZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FD10C4CEC3;
	Fri, 11 Oct 2024 14:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728656831;
	bh=pUd9AMdtvemQ98FlMluaPmqLuijLZiDm9z3uByCDb8s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MraT0TRZ+85TeEd3wb1RuFlN9IT8vBcK35E9VxW0iq+VprEF69kk2WTAJdNReynhg
	 EVfh+0M96X/fDjxXlTYIsAN4O2du+oecC3eyBzbb/oS33oRzJ/Cc7a/L9VqDlMXknV
	 RYqFe5D+8NmRqi9Uh5vDJ3pnRZjiszoElr/df1sgiZ732MT1kwjIPnTejYfs9NlKui
	 4RIfSGPlE7t3is56gdSGe04ruAVmnyFUT954EdFCBIEdS/Xpe9/pqCmy8/3eyffCSL
	 0PX0Aj9QN/8hKXPWTVhsaY7YG8TLyKz4Jyqxk4aOaVySvX/Tp9xiV7IN/5Zm4+g19d
	 uWHmyqW6x+uIw==
Date: Fri, 11 Oct 2024 09:27:09 -0500
From: Rob Herring <robh@kernel.org>
To: Jakob Hauser <jahau@rocketmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 1/4] dt-bindings: display: panel: Add Samsung
 S6E88A0-AMS427AP24 bindings
Message-ID: <20241011142709.GA2289410-robh@kernel.org>
References: <cover.1728582727.git.jahau@rocketmail.com>
 <3d754a2ee538d4c99ab71340706297d54b767c35.1728582727.git.jahau@rocketmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d754a2ee538d4c99ab71340706297d54b767c35.1728582727.git.jahau@rocketmail.com>

On Thu, Oct 10, 2024 at 08:31:48PM +0200, Jakob Hauser wrote:
> Add bindings for Samsung AMS427AP24 panel with S6E88A0 controller.
> 
> Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
> ---
> Patch is based on https://gitlab.freedesktop.org/drm/misc/kernel.git
> current branch drm-misc-next.
> ---
>  .../panel/samsung,s6e88a0-ams427ap24.yaml     | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/samsung,s6e88a0-ams427ap24.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/samsung,s6e88a0-ams427ap24.yaml b/Documentation/devicetree/bindings/display/panel/samsung,s6e88a0-ams427ap24.yaml
> new file mode 100644
> index 000000000000..7010d3bbd07f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/samsung,s6e88a0-ams427ap24.yaml
> @@ -0,0 +1,68 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/samsung,s6e88a0-ams427ap24.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Samsung AMS427AP24 panel with S6E88A0 controller
> +
> +maintainers:
> +  - Jakob Hauser <jahau@rocketmail.com>
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: samsung,s6e88a0-ams427ap24
> +
> +  reg:
> +    maxItems: 1
> +
> +  port: true
> +  reset-gpios: true
> +
> +  vdd3-supply:
> +    description: core voltage supply
> +
> +  vci-supply:
> +    description: voltage supply for analog circuits
> +
> +  flip-horizontal:
> +    description: boolean to flip image horizontally
> +    type: boolean

This is already used in another panel. Please move it to 
panel-common.yaml.

> +
> +required:
> +  - compatible
> +  - reg
> +  - port
> +  - reset-gpios
> +  - vdd3-supply
> +  - vci-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    dsi {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            panel@0 {
> +                    compatible = "samsung,s6e88a0-ams427ap24";
> +                    reg = <0>;
> +
> +                    vdd3-supply = <&pm8916_l17>;
> +                    vci-supply = <&pm8916_l6>;
> +                    reset-gpios = <&tlmm 25 GPIO_ACTIVE_LOW>;
> +                    flip-horizontal;
> +
> +                    port {
> +                            panel_in: endpoint {
> +                                    remote-endpoint = <&mdss_dsi0_out>;
> +                            };
> +                    };
> +            };
> +    };
> -- 
> 2.39.5
> 

