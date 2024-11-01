Return-Path: <linux-kernel+bounces-392825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 650BB9B988F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 20:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D1C01F23754
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 19:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9AF1D0E15;
	Fri,  1 Nov 2024 19:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uYoiD2kT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044E51D0425;
	Fri,  1 Nov 2024 19:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730489227; cv=none; b=EeZjhNYeTz+vjuQyQCEvk9+EqUj9/5tQgZ3KqzpuEYx4dit9P4zQ8d6MUyWDu8X2WiU46niI7fDgfqLcIA4KNazf56asxuU3BCIsuWlJE+47IhvukoQ2GU7TcCVSkARobpHHLjwy8P94ObyKsAI9q5XRxmo44jGOisDGxl2lXio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730489227; c=relaxed/simple;
	bh=ZgsRFhjZ8jdb9d5nAWftavR5ewJEWTt7qpXCwxTn82Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EsWwp/bPSZDNwM28B+NCoOluVNzIaQL4Ll4ui12qqR4QTdVCUQlhsdDydIXxjkQ1AwX38QAhvB0FG9fNQKtbmCLX7ai0wz2rVro3RrPN8e2GJrkCE6ZgRo1O9NuGEfyeYOSJ6X+orcjKYz/BgFxNAa2B3DX0BGB0BQzemmN7Gbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uYoiD2kT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A114FC4CECD;
	Fri,  1 Nov 2024 19:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730489226;
	bh=ZgsRFhjZ8jdb9d5nAWftavR5ewJEWTt7qpXCwxTn82Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uYoiD2kTeKpYOm2z/uULnpoK0n0Z20N9XF81Is+CU610H7+p5tunUexmxrYd3ywG6
	 5qYLPmQMgBCV4FnfuMCOJuNx19pVO5xj0Xe+8d9w0/Snlx0n/cBROpNlyrp+meb2G/
	 cSF8Iv5eyOSB1INnm25svwU9YZ7Q61nmo4pMJsRCN8Ev5KVbl2Tzkqdlsh4tmG4gCe
	 It0ReBPcJarJ3qgBZKTMQnQGCm6B+NCs3Y1jeLtwPA1xyPl9sAkB39RV5KZ7cICr0q
	 l+et7ux4a94wnKMZaHFMptUILN/ktLRNcL3OyHFjjM12zogQG0osHS79Dpb7p8stoc
	 e7zAdiXO4MX4Q==
Date: Fri, 1 Nov 2024 14:27:05 -0500
From: Rob Herring <robh@kernel.org>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: lee@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	mazziesaccount@gmail.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, sre@kernel.org
Subject: Re: [PATCH] dt-bindings: mfd: bd71828: Use charger resistor in mOhm
 instead of MOhm
Message-ID: <20241101192705.GA4062121-robh@kernel.org>
References: <20241029111112.33386-1-andreas@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029111112.33386-1-andreas@kemnade.info>

On Tue, Oct 29, 2024 at 12:11:12PM +0100, Andreas Kemnade wrote:
> Apparently there was some confusion regarding milliohm vs. megaohm.
> (m/M). Use microohms to be able to properly specify the charger
> resistor like other drivers do. This is not used yet by mainline code
> yet. Specify a current sense resistor in milliohms range rathes then
> megaohms range in the examples.

milliohms?

rathes?

> 
> CC: sre@kernel.org
> Reported-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Closes: https://lore.kernel.org/imx/6dcd724a-a55c-4cba-a45b-21e76b1973b0@gmail.com/T/#mf590875a9f4d3955cd1041d7196ff0c65c0a7e9d
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  .../devicetree/bindings/mfd/rohm,bd71828-pmic.yaml  | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)

Looks like rohm,bd71815-pmic.yaml has the same problem.

> 
> diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml b/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml
> index fa17686a64f7..09e7d68e92bf 100644
> --- a/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml
> +++ b/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml
> @@ -55,14 +55,15 @@ properties:
>      minimum: 0
>      maximum: 1
>  
> -  rohm,charger-sense-resistor-ohms:
> -    minimum: 10000000
> -    maximum: 50000000
> +  rohm,charger-sense-resistor-micro-ohms:
> +    minimum: 10000
> +    maximum: 50000
> +    default: 30000
>      description: |
>        BD71827 and BD71828 have SAR ADC for measuring charging currents.
>        External sense resistor (RSENSE in data sheet) should be used. If some
> -      other but 30MOhm resistor is used the resistance value should be given
> -      here in Ohms.
> +      other but 30mOhm resistor is used the resistance value should be given
> +      here in microohms.
>  
>    regulators:
>      $ref: /schemas/regulator/rohm,bd71828-regulator.yaml
> @@ -114,7 +115,7 @@ examples:
>              #gpio-cells = <2>;
>              gpio-reserved-ranges = <0 1>, <2 1>;
>  
> -            rohm,charger-sense-resistor-ohms = <10000000>;
> +            rohm,charger-sense-resistor-micro-ohms = <10000>;
>  
>              regulators {
>                  buck1: BUCK1 {
> -- 
> 2.39.5
> 

