Return-Path: <linux-kernel+bounces-532435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC275A44DC6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 21:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7EC816652F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 20:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9445B215078;
	Tue, 25 Feb 2025 20:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="DIzpj0s9"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34DD214817;
	Tue, 25 Feb 2025 20:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740515557; cv=none; b=TzxvbbJ0Hto5PCtlh0NLznHUNFxvalGolc/4UJYQJpYS0ACzUoueg8ecMRIeosU4McFWDJl73Uouc7zTNsvBOWVH+wRU2c5LslyW5BgCnCB5yI8/Vd/fy94SPwf8Pr/yXQ0uCsbEyt7pEFR/hQ8RUXMg+jfQgGn8e+/cmYn3Lb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740515557; c=relaxed/simple;
	bh=wckgz3tdenQ9ZtBQpHOi8VCnc+yy0A2dSk2aV0Zjeqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fV3duAC8f+oE2pN+7N17ksMYR48Hl176JmG0OmcBkHpm1DQbKOiCIvGJ/3bhSQOzOKatxwc6r1CDbNi1xePgHK9oj8amdNLK25rnh5RwcapCHYyWqYgMiiYlbp07MBgRKOSGSx5bFpAb92V+jxSk6PFiod5oWlhlOSEPfAlAKRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=DIzpj0s9; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 16745A30;
	Tue, 25 Feb 2025 21:31:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1740515460;
	bh=wckgz3tdenQ9ZtBQpHOi8VCnc+yy0A2dSk2aV0Zjeqw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DIzpj0s9msFhLOz+8bA185w8lDAvF6MScXRRMWToJGq11vaWb1/54GtxQCAOvXrqh
	 RH6/pHRixNuKKM/vbBSymDEELXmkO1a88QHytPB+UlaV4YbeEwZQoZj2FNj2j1mVBb
	 ZPMjQ1V5Q3I6kuMK4oLbVo7miOEkNBd2u6vXcsaE=
Date: Tue, 25 Feb 2025 22:32:08 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Jonathan Corbet <corbet@lwn.net>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	soc@lists.linux.dev, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/2] docs: dt: submitting-patches: Document sending DTS
 patches
Message-ID: <20250225203208.GG18866@pendragon.ideasonboard.com>
References: <20250225184822.213296-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250225184822.213296-1-krzysztof.kozlowski@linaro.org>

Hi Krzysztof,

On Tue, Feb 25, 2025 at 07:48:21PM +0100, Krzysztof Kozlowski wrote:
> Document two rules already widely used and enforced by DT maintainers
> and SoC platform maintainers:
> 
> 1. DTS patches should be placed at the end of driver patchset to
>    indicate no dependencies of driver code on DTS.
> 
> 2. DTS patches should be applied via SoC platform maintainers, because
>    it is a driver-independent hardware description.  However some
>    driver maintainers are reluctant to pick up portions of patchsets and
>    prefer to take entire set at once.  For such cases, the DTS portion
>    should be split into separate patchset, so it will not end up in the
>    driver subsystem integration tree.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

This matches my understanding of the current (and best) practices, so

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  .../bindings/submitting-patches.rst           | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/submitting-patches.rst b/Documentation/devicetree/bindings/submitting-patches.rst
> index a64f21a5f299..f3e23e69a638 100644
> --- a/Documentation/devicetree/bindings/submitting-patches.rst
> +++ b/Documentation/devicetree/bindings/submitting-patches.rst
> @@ -54,11 +54,22 @@ I. For patch submitters
>       followed as of commit bff5da4335256513497cc8c79f9a9d1665e09864
>       ("checkpatch: add DT compatible string documentation checks"). ]
>  
> -  7) If a documented compatible string is not yet matched by the
> +  7) DTS is treated in general as driver-independent hardware description, thus
> +     any DTS patches, regardless whether using existing or new bindings, should
> +     be placed at the end of patchset to indicate no dependency of drivers on
> +     the DTS.  DTS will be anyway applied through separate tree or branch, so
> +     different order would indicate the serie is non-bisectable.
> +
> +     If a driver subsystem maintainer prefers to apply entire set, instead of
> +     their relevant portion of patchset, please split the DTS patches into
> +     separate patchset with a reference in changelog or cover letter to the
> +     bindings submission on the mailing list.
> +
> +  8) If a documented compatible string is not yet matched by the
>       driver, the documentation should also include a compatible
>       string that is matched by the driver.
>  
> -  8) Bindings are actively used by multiple projects other than the Linux
> +  9) Bindings are actively used by multiple projects other than the Linux
>       Kernel, extra care and consideration may need to be taken when making changes
>       to existing bindings.
>  
> @@ -79,6 +90,10 @@ II. For kernel maintainers
>    3) For a series going though multiple trees, the binding patch should be
>       kept with the driver using the binding.
>  
> +  4) The DTS files should however never be applied via driver subsystem tree,
> +     but always via platform SoC trees on dedicated branches (see also
> +     Documentation/process/maintainer-soc.rst).
> +
>  III. Notes
>  ==========
>  
> -- 
> 2.43.0
> 
> 

-- 
Regards,

Laurent Pinchart

