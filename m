Return-Path: <linux-kernel+bounces-553698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFCCA58DBA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7107818828EE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 08:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B12223327;
	Mon, 10 Mar 2025 08:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+66pxfo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE09B1DA614;
	Mon, 10 Mar 2025 08:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741594166; cv=none; b=t1HPm2+on0BtUBkLdhYhE5Y/CrSwlEUZpEVVUUF9D9TW5kF8CG4RSOF3rWFTFC9DU8WvsxwAL5Ap2nwg/XI9X3wEhGAuxrcOqCtd/+13cO3o3k+TsqMEqdnBb++AK+kf/Rpk9KfLG/2iH81TtQ2jmkqeApPLiFsA/7f4ATdImFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741594166; c=relaxed/simple;
	bh=gwas8E4kvvAA/eUvbABEADodAjBCs+rgr6xiwge6OXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pczyaievHnXjNOh1DFf1/k91dYGB+UzNnTBrwKP82vSqmu7g3Yp2fN5+iBFrkuq2CSlJZ9Ob45F0pcoj89jEkjpvQgVyQYP2x5jAXAhXN8PGHmryFhtqwrFOqn+t3nH20pNLEnsVV/WLyJvBM8+CXy4PlC1ub39W6RLccdnRmc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a+66pxfo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 590AEC4CEE5;
	Mon, 10 Mar 2025 08:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741594166;
	bh=gwas8E4kvvAA/eUvbABEADodAjBCs+rgr6xiwge6OXE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a+66pxfoikf19N4ZasCwPfg8jAydGU3Gk+jsm+rgiOAD3usvsqyWDS7W6OzK4ss47
	 JyaAG7IZNJHl3E0gHRNI0g0oUpdr0BeO/Wk1Cjtog4US8Elt69O3dllahJ8GrjQEcg
	 agdKCJ3hR+sOwTGvnQDAtc14qdFAwk6nc14R6CZhVyGKL2vove7TKEvpPur9qy5cxc
	 aEeH4JD80K987+bq+mfpRAecYzYAksY81JkSA9G9iuj7hCMpT3IRlA6xoK+oKOfY4K
	 IaeN09ULdgMOrS/mNZ4BCZDZRZLQLVj7087aDkIuex3SOUqq1/Xu4EKUi39Ju24HEK
	 64P5KU46tsj4Q==
Date: Mon, 10 Mar 2025 09:09:22 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>
Cc: Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	Jaroslav Kysela <perex@perex.cz>, Jerome Brunet <jbrunet@baylibre.com>, 
	Kevin Hilman <khilman@baylibre.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, linux-amlogic@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, 
	Mark Brown <broonie@kernel.org>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH v2 2/3] ASoC: dt-bindings: meson: t9015: add support for
 A1 SoC family
Message-ID: <20250310-smiling-gerbil-of-whirlwind-8fa4a5@krzk-bin>
References: <20250309181630.1322745-1-jan.dakinevich@salutedevices.com>
 <20250309181630.1322745-3-jan.dakinevich@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250309181630.1322745-3-jan.dakinevich@salutedevices.com>

On Sun, Mar 09, 2025 at 09:16:29PM +0300, Jan Dakinevich wrote:
> Add support for internal audio codec found A1 SoC family. On this SoC
> the component supports capturing from ADC and has specific configuration
> of input/output lines.
> 
> Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>
> ---
>  .../bindings/sound/amlogic,t9015.yaml         | 69 +++++++++++++++++--
>  1 file changed, 65 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/amlogic,t9015.yaml b/Documentation/devicetree/bindings/sound/amlogic,t9015.yaml
> index 5f5cccdbeb34..962795470601 100644
> --- a/Documentation/devicetree/bindings/sound/amlogic,t9015.yaml
> +++ b/Documentation/devicetree/bindings/sound/amlogic,t9015.yaml
> @@ -9,9 +9,6 @@ title: Amlogic T9015 Internal Audio DAC
>  maintainers:
>    - Jerome Brunet <jbrunet@baylibre.com>
>  
> -allOf:
> -  - $ref: dai-common.yaml#
> -
>  properties:
>    $nodename:
>      pattern: "^audio-controller@.*"
> @@ -21,7 +18,9 @@ properties:
>  
>    compatible:
>      items:
> -      - const: amlogic,t9015
> +      - enum:
> +          - amlogic,t9015
> +          - amlogic,t9015-a1
>  
>    clocks:
>      items:
> @@ -43,6 +42,17 @@ properties:
>  
>    sound-name-prefix: true
>  
> +  lineout-left:

Missing vendor prefix.

> +    $ref: /schemas/types.yaml#/definitions/string

enum with values

> +  lineout-right:
> +    $ref: /schemas/types.yaml#/definitions/string
> +  linein-left:
> +    $ref: /schemas/types.yaml#/definitions/string
> +  linein-right:
> +    $ref: /schemas/types.yaml#/definitions/string
> +  micbias:

use proper unit suffix name, e.g. microvolt

> +    $ref: /schemas/types.yaml#/definitions/string
> +
>  required:
>    - "#sound-dai-cells"
>    - compatible
> @@ -52,6 +62,57 @@ required:
>    - resets
>    - AVDD-supply
>  
> +

Only one blank line

> +allOf:
> +  - $ref: dai-common.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: amlogic,t9015-a1
> +    then:
> +      properties:
> +        lineout-left:
> +          items:

You do not have multiple items here, drop.

> +            - enum:
> +                - none
> +                - right
> +                - left-inverted
> +        lineout-right:
> +          items:
> +            - enum:
> +                - none
> +                - left
> +                - right-inverted
> +        linein-left:
> +          items:
> +            - enum:
> +                - none
> +                - differential
> +                - positive
> +                - negative
> +        linein-right:
> +          items:
> +            - enum:
> +                - none
> +                - differential
> +                - positive
> +                - negative

All these go to the top level.

> +        micbias:
> +          items:
> +            - enum:
> +                - 2.0V
> +                - 2.1V
> +                - 2.3V
> +                - 2.5V
> +                - 2.8V
> +    else:
> +      lineout-left: false
> +      lineout-right: false
> +      linein-left: false
> +      linein-right: false
> +      micbias: false

This is correct.

Best regards,
Krzysztof


