Return-Path: <linux-kernel+bounces-544382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC2AA4E0A3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78F4D18879BB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C06204F6C;
	Tue,  4 Mar 2025 14:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AwL3mjOw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE17249E5;
	Tue,  4 Mar 2025 14:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741097976; cv=none; b=XZWQ3xUwJx7NXB+aoOrXgTg1510+VqV624dL6wWJswzGH0Msofz3wwDrlHh0Um0JpEm1Lq5hwHNZeBj71WbVkP6oYNuvoSDt2gbswkZIUKz9fFpGaLxpRy31ogX8CO9r1JoHgX/NHNs1jX0e2kHj3Lc3jZF+owL2mMuHP67B0+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741097976; c=relaxed/simple;
	bh=8jHtcSbIl6KMW0jgkbyI/Ws4v68dSrEq5fvmCHAfE7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f3KQhxYuVQnXvSOhT1eg6NGe0DJ8ErVh/pgGdh9J7RGCGeCIK0u87I0lanyd63gZrDO7YINdHIPTQu8RkQehpjIx0e5Ruhi5pZmPpcCMeny2Hsv4iSk/+HqmBn3m8jJBY7L8h4OFmcSXNdQprNIjyDxsyBf9heIALKwXovJUoCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AwL3mjOw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70751C4CEE5;
	Tue,  4 Mar 2025 14:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741097975;
	bh=8jHtcSbIl6KMW0jgkbyI/Ws4v68dSrEq5fvmCHAfE7w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AwL3mjOwXgWUC1OD8LtZoy5XIgAH2/zu3uezpVQKogKMMMQlEAMZmgmFuiOwlq2nb
	 bqNAPpDmz87vwFK10kZKxU+0LJTS4pLxwBSOumM0zCLuhAO1J/UUFChIQOyvRH/i52
	 o2aoemQsfaEJbdQbwZauG/lzaQR4cf8yt2JnLhLGVQr45SFxlbR4+BG+fNYzqGCjhV
	 AcL/SwBCRyUwz1mFMu2Q14bBjeaLXMjdjHUm+LkeL/HtGYurU0qGzSNGRcl1nKz7g8
	 64NLm2xxcIMSnHAmGqTEoYfeh35788XJoruCGCPRs883If2bpkDZ6NsroiXTsGY4O2
	 1g0sWDKhHVh6A==
Date: Tue, 4 Mar 2025 08:19:33 -0600
From: Rob Herring <robh@kernel.org>
To: Artur Weber <aweber.kernel@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Stanislav Jakubek <stano.jakubek@gmail.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v6 02/10] dt-bindings: mfd: brcm,bcm59056: Add compatible
 for BCM59054
Message-ID: <20250304141933.GA2543583-robh@kernel.org>
References: <20250304-bcm59054-v6-0-ae8302358443@gmail.com>
 <20250304-bcm59054-v6-2-ae8302358443@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304-bcm59054-v6-2-ae8302358443@gmail.com>

On Tue, Mar 04, 2025 at 07:20:33AM +0100, Artur Weber wrote:
> The BCM59054 MFD is fairly similar to the BCM59056, and will use
> the same driver. Add compatible and specify the allowed regulator
> nodes.
> 
> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
> ---
> Changes in v6:
> - Replace mfd/brcm,bcm590xx.yaml with mfd/brcm,bcm59056.yaml
> 
> Changes in v5:
> - Replace mfd/brcm,bcm59056.yaml with mfd/brcm,bcm590xx.yaml in
>   regulator bindings description
> 
> Changes in v4:
> - Fix yamllint errors (missing unevaluatedProperties)
> - Drop comment with regulator name list
> - Use full schema paths for $reg
> - Change description of regulator binding to mention BCM59054
>   explicitly
> - Drop quotes around vbus reg name
> - Change "Power Management IC" to "Power Management Unit" to match
>   official Broadcom naming
> 
> Note that I did not end up moving the regulator refs from
> allOf compatible matches; I explained my reasoning in [1].
> 
> [1] https://lore.kernel.org/lkml/ab853605-859d-44c6-8cbd-44391cd677e6@gmail.com/
> 
> Changes in v3:
> - Split regulator node into separate file
> - Removed quotes around compatible
> ---
>  .../devicetree/bindings/mfd/brcm,bcm59056.yaml     | 26 +++++++++-
>  .../bindings/regulator/brcm,bcm59054.yaml          | 56 ++++++++++++++++++++++
>  2 files changed, 80 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/brcm,bcm59056.yaml b/Documentation/devicetree/bindings/mfd/brcm,bcm59056.yaml
> index b387ef9885c3ac524e0782545dbca9c0e81a556c..b67d7a723fc242869e5bdc6b3602785f62af45bd 100644
> --- a/Documentation/devicetree/bindings/mfd/brcm,bcm59056.yaml
> +++ b/Documentation/devicetree/bindings/mfd/brcm,bcm59056.yaml
> @@ -11,7 +11,9 @@ maintainers:
>  
>  properties:
>    compatible:
> -    const: brcm,bcm59056
> +    enum:
> +      - brcm,bcm59054
> +      - brcm,bcm59056
>  
>    reg:
>      maxItems: 1
> @@ -21,7 +23,6 @@ properties:
>  
>    regulators:
>      type: object
> -    $ref: /schemas/regulator/brcm,bcm59056.yaml#

Just do:

additionalProperties: true
properties:
  compatible:
    contains:
      enum:
        - brcm,bcm59056
        - brcm,bcm59054

(This patch should just add the last line)

And drop the allOf below.

>  
>  required:
>    - compatible
> @@ -30,6 +31,27 @@ required:
>  
>  additionalProperties: false
>  
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: brcm,bcm59054
> +    then:
> +      properties:
> +        regulators:
> +          $ref: /schemas/regulator/brcm,bcm59054.yaml#
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: brcm,bcm59056
> +    then:
> +      properties:
> +        regulators:
> +          $ref: /schemas/regulator/brcm,bcm59056.yaml#
> +
>  examples:
>    - |
>      #include <dt-bindings/interrupt-controller/arm-gic.h>

