Return-Path: <linux-kernel+bounces-234593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A89C91C860
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 23:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35BD21F26DD2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 21:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12BEE7FBBF;
	Fri, 28 Jun 2024 21:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KW8vMAWW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507F36BFA3;
	Fri, 28 Jun 2024 21:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719611117; cv=none; b=Rql0xFpF4BdpWJgvYU2htsjbOLUfw9V1VI6HCvwKsaAvua9ngG+/CN9ln04BYsMrAmbKHhZEyJra4so01HKVVNQyK/vzTLYY6qG/uvQ5l83Mg0tpX7iErvifi9/mflv1Lycm2Ovl16cjRK86bmkE7rRFdVkTwH1nzVsvOaf6QrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719611117; c=relaxed/simple;
	bh=y7GscZKAEhTTav+2EsjnRaIb7jLEj21bhOW5nSQvK60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iiXo5SQA7Zay4G591SNrKt3kErx4rEOynAzh3T/FrG8OhNCOQ5EDhNa5VtzqLT7zTY2C9xikn8qItMOwphvsXnG+itfslmYExBggvJho5aahO8Hcejz23yzdXEiaq3ihvZ/Amlcn6hjNxzgWLPi55UosrPTEBzDgjs3EsirZIAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KW8vMAWW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F8FEC116B1;
	Fri, 28 Jun 2024 21:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719611116;
	bh=y7GscZKAEhTTav+2EsjnRaIb7jLEj21bhOW5nSQvK60=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KW8vMAWWZcfPHw3Mb17QOnNZZKplGLh3fA1qGjPXHt++83tZJmr8QU+KVsoX58j3U
	 eOi9cYzb43rWb7+Y+MOjAOxcGuFbBAw/gdcvoidweTOgVoIZpKAE46+YbwkH9ddKmZ
	 e5QLo1oUU+ubYXWa/9Ik1RqvKF+ghUtQ8tf2i5gdF3b1L4ysCFvD99AlBfJuGyAzhE
	 MUFJhr3x9DGPDduw0+rbMcQswqvzvQm5OrGQP3JnF2zt8cz+vZbwrJ7VLg1+o5DYZw
	 tSzIcNtI0fon0EVgdnUSN2eSy27FiWuzRNyQ8Epy0WiLAaQbD3eiTvEuYHJFMevF0C
	 7PQi5IEZx7xbg==
Date: Fri, 28 Jun 2024 15:45:14 -0600
From: Rob Herring <robh@kernel.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Bao Cheng Su <baocheng.su@siemens.com>,
	Diogo Ivo <diogo.ivo@siemens.com>
Subject: Re: [PATCH v2 3/4] dt-bindings: soc: ti: am645-system-controller:
 add child nodes used by main domain
Message-ID: <20240628214514.GA258254-robh@kernel.org>
References: <cover.1719376928.git.jan.kiszka@siemens.com>
 <1ac6bf9ef2d77dfc606a825d768bd4d23853052a.1719376928.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ac6bf9ef2d77dfc606a825d768bd4d23853052a.1719376928.git.jan.kiszka@siemens.com>

On Wed, Jun 26, 2024 at 06:42:07AM +0200, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Expand bindings to cover both the MCU and the main usage of the AM654
> system controller.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  .../soc/ti/ti,am654-system-controller.yaml    | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/ti/ti,am654-system-controller.yaml b/Documentation/devicetree/bindings/soc/ti/ti,am654-system-controller.yaml
> index e79803e586ca..a03e13cf2677 100644
> --- a/Documentation/devicetree/bindings/soc/ti/ti,am654-system-controller.yaml
> +++ b/Documentation/devicetree/bindings/soc/ti/ti,am654-system-controller.yaml
> @@ -34,6 +34,31 @@ patternProperties:
>      type: object
>      $ref: /schemas/phy/ti,phy-gmii-sel.yaml#
>  
> +  "^mux-controller$":

That's not a pattern, but fixed string. Move to 'properties'. I thought 
the tools check this. Maybe it didn't apply to rc1 for the bot and you 
didn't test either?

> +    type: object
> +    ref: /schemas/mux/reg-mux.yaml#
> +    description:
> +      This is the SERDES lane control mux.
> +
> +  "^clock@[0-9a-f]+$":
> +    type: object
> +    $ref: /schemas/soc/ti/ti,am654-serdes-ctrl.yaml#
> +
> +  "^dss-oldi-io-ctrl@[0-9a-f]+$":
> +    type: object
> +    $ref: /schemas/mfd/syscon.yaml#
> +    properties:
> +      compatible:
> +        items:
> +          - const: ti,am654-dss-oldi-io-ctrl
> +          - const: syscon
> +
> +  "^clock-controller@[0-9a-f]+$":
> +    type: object
> +    $ref: /schemas/clock/ti,am654-ehrpwm-tbclk.yaml#
> +    description:
> +      Clock provider for TI EHRPWM nodes.
> +
>  required:
>    - compatible
>    - reg
> -- 
> 2.43.0
> 

