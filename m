Return-Path: <linux-kernel+bounces-377520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BFD9ABFF2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 09:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF9982811B0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 07:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7CF14F115;
	Wed, 23 Oct 2024 07:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JR7riPcE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BBE487BE;
	Wed, 23 Oct 2024 07:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729667756; cv=none; b=eO20j6il/H5geBIOewAGuU1iMc2uif8yEATESM4FmCT7LuPmmaddiVS9bOOiWALv2QR+ofosnWtzHmv5etTuIJw8zlDN9xsqutrTJYaEFYJnSMeroA3Hd96bACtuhwkta2VgwccLXZ7Qd7wqkj/4KGTLlC2ULMIOi/M6cDDSRlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729667756; c=relaxed/simple;
	bh=4W+Tw8lSJUPRVKdVVjJ3ewzvg0TBWDpx8vwJiowNTbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gAShptKnyjuXO/+O8lxpXbSMWppgwohoLbjIN572cAJSUT+caQrA6ezk+1j38b/YjjApAcz5V2fuvuiuoWU/p4c3+aZYnWwvPXXUo8lBDdzKe2u4LwiSN+Ww3y2L4JSPXSyDIo1GxhEPQmIiworkGUtAje4DVsjufJOj5S4PmGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JR7riPcE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28ECCC4CEC6;
	Wed, 23 Oct 2024 07:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729667755;
	bh=4W+Tw8lSJUPRVKdVVjJ3ewzvg0TBWDpx8vwJiowNTbA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JR7riPcEnITY8aJKahja89zILrPz505v3WdTnDpFRm/kvLtIZRaOFaLW1Cdqh8Fkj
	 B7OxBb+iMGLvj3Ks0iLpR2LEVZ4foWPrsAnpcizoigUgiXk+4p62a86bKd21EZFmkq
	 6dnyHed9AVMs2993e67wuoTIrUbNQ7pKW3pfNJMGVpSJVgGL8xeFQfoqBkQQ90Swua
	 VjwXEGjQAPwQmjhoq1UluYCHELsZYDwf1h/zs20k6HNGJfRhvrZ6ijs5sJ7xvzm2Di
	 QT2PRajmIsH2bQ7ZN8632rcmC0XtYhPg+NwAdiqk7i9JAisGjCaQGyIVgh3Op3ljIy
	 Ym/KgWFr+h9Ng==
Date: Wed, 23 Oct 2024 09:15:52 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jakob Hauser <jahau@rocketmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v2 1/5] dt-bindings: display: panel: Move flip properties
 to panel-common
Message-ID: <yq7usspbou5lj4zz5giw472icd655als7pdik4ito2ziaidkwv@7yrkrgqs462o>
References: <cover.1729630039.git.jahau@rocketmail.com>
 <18a0d8787b5714633a574f2e15f0cec1addddcfc.1729630039.git.jahau@rocketmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <18a0d8787b5714633a574f2e15f0cec1addddcfc.1729630039.git.jahau@rocketmail.com>

On Tue, Oct 22, 2024 at 11:33:35PM +0200, Jakob Hauser wrote:
> The flip properties were used by "samsung,s6e8aa0.yaml" only so far. By
> introducing "samsung,s6e88a0-ams427ap24.yaml" they become more common.
> 
> Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
> ---
> Patch is based on current branch drm-misc-next.
> ---
>  .../bindings/display/panel/panel-common.yaml           |  8 ++++++++
>  .../bindings/display/panel/samsung,s6e8aa0.yaml        | 10 ++--------
>  2 files changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/panel-common.yaml b/Documentation/devicetree/bindings/display/panel/panel-common.yaml
> index 0a57a31f4f3d..087415753d60 100644
> --- a/Documentation/devicetree/bindings/display/panel/panel-common.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/panel-common.yaml
> @@ -51,6 +51,14 @@ properties:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      enum: [0, 90, 180, 270]
>  
> +  flip-horizontal:
> +    description: boolean to flip image horizontally
> +    type: boolean
> +
> +  flip-vertical:
> +    description: boolean to flip image vertically
> +    type: boolean
> +

I actually wonder how or why would you need to flip the images. I
understand rotation, but this is mirror flip, right? Is it for some
transparent displays?

The change is fine, I just really wonder about hardware.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


