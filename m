Return-Path: <linux-kernel+bounces-246373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B00492C146
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 18:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 420FAB2958E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 16:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB2618FA3C;
	Tue,  9 Jul 2024 16:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iHUIDBE4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8B118FA22;
	Tue,  9 Jul 2024 16:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542343; cv=none; b=Sm2QiOio7opCXkbAdlsxVRyEFXNfbEWheoNQq1mmIcT+6rzd84yTI0Fp2JyuKK0NX4XUyl//3XwiNtz3LL+NrYA1CgTTPjWbfCHbvaaMqna/vZ8ver2pj46ARXCKFPfyLe5syH5yhJrIg1PatloNSVfnh8h6vpK7Me2dFVKp2mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542343; c=relaxed/simple;
	bh=HNZERyax7YfeQp01st75pcXuzHJEbSApRID1V7p3OuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xs4C5RQl702yJqqx7vZsGDgqKtoh8Jy8vL80tGXYm21VMZIoDYLsuHj0pm3lE29VXDr4dBBmFqhLGodm6xLQGKvVsZ+qtbPL67Or4hdQTp/fsNiQFl9oCuXyYJMgmejlVxlMTky6ebtdCyvNe4AAtlNfi4VdO0+DZjSH5f3dy8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iHUIDBE4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 051B3C4AF0A;
	Tue,  9 Jul 2024 16:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720542343;
	bh=HNZERyax7YfeQp01st75pcXuzHJEbSApRID1V7p3OuE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iHUIDBE4GwDL2TuhKWi3TEIqXmzbP/vCD/CeAe6EkVKb3NC3tMP1dYiGFzXlNqoxh
	 BjBnQU3sGIt9PcajkS1QI8Ufz4/VCk1QNGm3Bd8hdCstWib+384X2BIMDknG6Y8BK2
	 kcsaTJBMSJFfi8XQ9R0gyIaMsrXHCHGyR6mXSTUn6E0Z4m4hXk90PeQ12cOwEx/0CZ
	 xp3vliteT2PpbjprrlX75KtrY7aLPxLCWhiRIpNrd+6cRdQmg6Rx06hXOpKyTmMrWU
	 zUWWx3FM2x38dHdKoVuzF8qIj8t+GYlNkWyiuTDhd+Fvh0uPWIoTRbXJATS/vujvzi
	 k8lfXH8F9Hg0w==
Date: Tue, 9 Jul 2024 10:25:41 -0600
From: Rob Herring <robh@kernel.org>
To: George Liu <liuxiwei1013@gmail.com>
Cc: linux-aspeed@lists.ozlabs.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Subject: Re: [PATCH v2] dt-bindings: arm: aspeed: add IEIT x86 platform BMC
 boards
Message-ID: <20240709162541.GA3680692-robh@kernel.org>
References: <20240708034848.100930-1-liuxiwei@ieisystem.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240708034848.100930-1-liuxiwei@ieisystem.com>

On Mon, Jul 08, 2024 at 11:48:48AM +0800, George Liu wrote:
> Document the new compatibles used on the ieisystems
> 
> Signed-off-by: George Liu <liuxiwei@ieisystem.com>

Still confused with the 3 names: ieisystems, ieisystem, and ieit

The preference for vendor prefixes is domain names, but if ieit is a 
better identifier please explain why (in the commit msg).

> ---
>  Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> index e386d0ebfb14..818fbe9c45fc 100644
> --- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> +++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> @@ -92,6 +92,7 @@ properties:
>                - ibm,rainier-bmc
>                - ibm,system1-bmc
>                - ibm,tacoma-bmc
> +              - ieit,nf5280m7-bmc
>                - inventec,starscream-bmc
>                - inventec,transformer-bmc
>                - jabil,rbp-bmc
> -- 
> 2.34.1
> 

