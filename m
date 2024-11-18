Return-Path: <linux-kernel+bounces-413483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA3C9D199E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 21:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62DEB283180
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 20:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF341E7676;
	Mon, 18 Nov 2024 20:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VbEEmDcR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF2C1E7655;
	Mon, 18 Nov 2024 20:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731961522; cv=none; b=SEu+532BDyPAMOAY/3fVhJGrulpAFKyjfhETfvu9kuOjHIHgk007iUakfdrLlWYuRFfERnne2FzVhyDsGlYQ6Urq2XZrszZTf8hf+NZ6tHLsuKU/TDkU3VXJd9t8Mvm86uvociNBES1Nd7owTZd8UW97RTuN+zSrpEM/rCLXvgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731961522; c=relaxed/simple;
	bh=tHTvg4MfuD+UxaEmJVzZwhlcaSNbdm8PdeBvNrw1sYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=quqJorc3rJ7qQ4uinY9bline7F9npsWNasvPeb0ctQOyzsgNFHzcM+GNt9X3jrTvubL+YelXhZQirmrjAhQXjBwGslrPa/IHkidBCUKRm4xLrt5W8aJCV3KSjLtkEwdIScJuXjTWX5N659DdjNPz0cC5QiXDg+rfQjI5Ivb1s10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VbEEmDcR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F60EC4CECC;
	Mon, 18 Nov 2024 20:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731961522;
	bh=tHTvg4MfuD+UxaEmJVzZwhlcaSNbdm8PdeBvNrw1sYA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VbEEmDcR622t8z5N/L+cdxuOQUuf+bI5nBCT2ZK4uq0PdiDd94qlJVYrRJRSe6LFb
	 y+KiQ5JTETwyW0HsQd647uSPD8izpVIUy1wVfo2+7caCkMjdEihMO9Il3mxuH+KOCw
	 41G0lVqpUl7Rs7Eb8H2+yxXkSdyQ8JAWx6WbuCy89qRYjhRpBElK5rASzCSVWorJaI
	 VCvsm3eTnlgkw1A2WC6lx9nJ8lmmtbO3pYa+SFtaKZ/AaP1fwqwHxUlplcWs4IftQy
	 jCKFptgrwu6XegkJb+whbNThFRri0/y14O2iDmQ3Xlb0pEraHr+eTDbd9EwGLOrdil
	 HOyUcN7b4Zq/w==
Date: Mon, 18 Nov 2024 14:25:20 -0600
From: Rob Herring <robh@kernel.org>
To: "Sung-Chi, Li" <lschyi@chromium.org>
Cc: Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <groeck@chromium.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
	linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: chrome: add new binding
 google,cros-ec-chrage-state
Message-ID: <20241118202520.GA3273373-robh@kernel.org>
References: <20241118-add_charger_state-v1-0-94997079f35a@chromium.org>
 <20241118-add_charger_state-v1-2-94997079f35a@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118-add_charger_state-v1-2-94997079f35a@chromium.org>

On Mon, Nov 18, 2024 at 05:33:47PM +0800, Sung-Chi, Li wrote:
> Add new dt bindings for charge chip control. The charge chip control
> dt configuration is used by the driver 'cros-ec-charge-state', which is
> added in the commit "platform/chrome: cros_ec_charge_state: add new
> driver to control charge".
> 
> As these charge chip controls are connected under the ChromeOS Embedded
> Controller (EC), also add the patternProperties to the
> mfd/google,cros-ec bindings.
> 
> Signed-off-by: Sung-Chi, Li <lschyi@chromium.org>
> ---
>  .../bindings/chrome/google,cros-charge-state.yaml  | 62 ++++++++++++++++++++++
>  .../devicetree/bindings/mfd/google,cros-ec.yaml    |  4 ++
>  2 files changed, 66 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/chrome/google,cros-charge-state.yaml b/Documentation/devicetree/bindings/chrome/google,cros-charge-state.yaml
> new file mode 100644
> index 000000000000..40e8f6988769
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/chrome/google,cros-charge-state.yaml
> @@ -0,0 +1,62 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/chrome/google,cros-charge-state.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Google Chrome OS EC(Embedded Controller) charge state driver.
> +
> +maintainers:
> +  - Sung-Chi, Li <lschyi@chromium.org>
> +
> +description:
> +  Chrome OS devices have an Embedded Controller(EC) which has access to
> +  battery charger IC. This node is intended to allow the host to read and
> +  control the charger current. The node for this device should be under a
> +  cros-ec node like google,cros-ec-spi.
> +
> +properties:
> +  compatible:
> +    const: google,cros-ec-charge-state
> +
> +  min-milliamp:
> +    description: min current in milliamp.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  max-milliamp:
> +    description: max current in milliamp.
> +    $ref: /schemas/types.yaml#/definitions/uint32

Use standard units defined in property-units.yaml.

No constraints? 4000000 amps is okay?

> +
> +  type:

Too generic. Property types are global. You need a vendor prefix for 
starters.

> +    description: current limit type.
> +    enum:
> +      - charge
> +      - input

What if you need to describe both?

> +
> +required:
> +  - compatible
> +  - min-milliamp
> +  - man-milliamp
> +  - type
> +
> +additionalProperties: false
> +
> +examples:
> +  - |+
> +    spi {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      cros_ec: ec@0 {
> +        compatible = "google,cros-ec-spi";
> +        reg = <0>;
> +        interrupts = <35 0>;
> +
> +        charge_chip_battery_current: charge-chip-battery {
> +          compatible = "google,cros-ec-charge";
> +          type = "charge";
> +          min-milliamp = <150>;
> +          max-milliamp = <5000>;
> +        };
> +      };
> +    };
> diff --git a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> index aac8819bd00b..3db4a48d5176 100644
> --- a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> +++ b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> @@ -166,6 +166,10 @@ patternProperties:
>      type: object
>      $ref: /schemas/extcon/extcon-usbc-cros-ec.yaml#
>  
> +  "^charge-chip-*":
> +    type: object
> +    $ref: /schemas/chrome/google,cros-charge-state.yaml#
> +
>  required:
>    - compatible
>  
> 
> -- 
> 2.47.0.338.g60cca15819-goog
> 

