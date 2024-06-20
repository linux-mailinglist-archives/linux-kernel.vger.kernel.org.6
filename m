Return-Path: <linux-kernel+bounces-223134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42641910E4C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 19:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C18F9B2662E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 17:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A051B3F06;
	Thu, 20 Jun 2024 17:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="soEHDweD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBEC1B3758;
	Thu, 20 Jun 2024 17:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718903881; cv=none; b=l1y8Klvvboi918ALXf3R9NdOlNtv5tblM1JpNdF7g4mJQiVYu9zRvKjButaDijmDtRwc+b0tPEuRNmab/ZW4r4m6j10AcJXFflUemqikFX5hky3y9xkqz96n8hYc8ZMJ9vSIdmk1GcXZbcCWKXxzqdQZ7FZ6ev26WwqBbcBP/EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718903881; c=relaxed/simple;
	bh=t1APqyOX6OlFWYI/LA0CSPLKegiYEgglDrIX/FUPggU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LYe4+eOYkZ68qn1Je8WNcYeagiVQGdB3OAM8BknqnPOHCQ+IMRosFrU0j52CBpjqUVaJSPsYCBSWWMYx83Y/mH+EzYSSJs2jwdRJ6ESLBhSalmcRWiHLGOC/kmSAZeOwAn5ctjhAsWWcDuL2oWTvjV5kEUk2mhmP4Ojyf9XbE9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=soEHDweD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B562C2BD10;
	Thu, 20 Jun 2024 17:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718903880;
	bh=t1APqyOX6OlFWYI/LA0CSPLKegiYEgglDrIX/FUPggU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=soEHDweDY18VLbVdmjclCdP/6tTXKiADN6UYpjFp/tpqYhJhiohZ2Hb/UhnbDTUQ1
	 ilSBbevD3Mx2P30LQDKAnT8HkS7r8qSv6HVAhXH0EpR6PhDQrqFOm052cjt+5jJR2G
	 t54EbAeifXUsFTZ4x3jB4pyh12ef5iLe6lDCgFtCy/Q30hHyV3p6sbkY6ZKV4/agxb
	 ce4vwBmlssyah/TS0HJEg3dtZC0CLNuF/cfZjS3TvERLiagWrkAAeCyAwkBoJFsMP3
	 pMlmtRVTW60/UNhKZcJWw03EgnrLrg+74+gc6ArBD3Ij2W97B3KT8twmTUl6qMVwjM
	 ed6ch5ea6FMfw==
Date: Thu, 20 Jun 2024 18:17:56 +0100
From: Lee Jones <lee@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mfd: Explain lack of child dependency in
 simple-mfd
Message-ID: <20240620171756.GY3029315@google.com>
References: <20240616080659.8777-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240616080659.8777-1-krzysztof.kozlowski@linaro.org>

On Sun, 16 Jun 2024, Krzysztof Kozlowski wrote:

> Common mistake of usage of 'simple-mfd' compatible is a dependency of
> children on resources acquired and managed by the parent, e.g. clocks.
> Extend the simple-mfd documentation to cover this case.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/mfd/mfd.txt | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/mfd.txt b/Documentation/devicetree/bindings/mfd/mfd.txt
> index 336c0495c8a3..98b4340b65f3 100644
> --- a/Documentation/devicetree/bindings/mfd/mfd.txt
> +++ b/Documentation/devicetree/bindings/mfd/mfd.txt
> @@ -18,12 +18,13 @@ A typical MFD can be:
>  Optional properties:
>  
>  - compatible : "simple-mfd" - this signifies that the operating system should
> -  consider all subnodes of the MFD device as separate devices akin to how
> -  "simple-bus" indicates when to see subnodes as children for a simple
> -  memory-mapped bus. For more complex devices, when the nexus driver has to
> -  probe registers to figure out what child devices exist etc, this should not
> -  be used. In the latter case the child devices will be determined by the
> -  operating system.
> +  consider all subnodes of the MFD device as separate and independent devices
> +  akin to how "simple-bus" indicates when to see subnodes as children for a
> +  simple memory-mapped bus. "Independent devices" means that children do not

I'm not against the change, but I think it can be phased better.

Quoting the new part and going on to explain what you mean by it doesn't
flow very well.  Are you able to massage it so it reads a little more
nicely please?

> +  need any resources to be provided by the parent device.
> +  For more complex devices, when the nexus driver has to probe registers to
> +  figure out what child devices exist etc, this should not be used. In the
> +  latter case the child devices will be determined by the operating system.
>  
>  - ranges: Describes the address mapping relationship to the parent. Should set
>    the child's base address to 0, the physical address within parent's address
> -- 
> 2.43.0
> 

-- 
Lee Jones [李琼斯]

