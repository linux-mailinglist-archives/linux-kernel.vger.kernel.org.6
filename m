Return-Path: <linux-kernel+bounces-444504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E9C9F07F6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 10:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2460F188A1E6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 09:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B071B21BC;
	Fri, 13 Dec 2024 09:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TCP5FlPP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF66C364D6;
	Fri, 13 Dec 2024 09:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734082468; cv=none; b=ZHTwiFrbUbCyCsQDc2+plDkdyhWhBhTB7DBNQfZovgsbU+z5XmX6qMSHUCEZ3mgcv9IgCAdeu0kyKkOUXNL1/1Xxe9WjCDKnkT4FYIzG2LFmA/9rSDWAVlLCQN+2Gvt8Tt/zd7V0t7S6ddLc0FNmuKzZSzrHOLGxCOIqnm7F9+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734082468; c=relaxed/simple;
	bh=shAFm4xEcVgvQ08saw8ULWVwBdClSzYyPXaWFqnQ1mM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ywg2W+tTJeoVt/NCz2m+/xYUaxa8eu4OuGQfhxx3Dp19/4uxUumoZcIJhJLBbeRituQnSFgSg+2j0oVigFDKHUzELrTRzXzpjCyi4sxTrdK/jf6mawH+qfrwe05sqxp3jZ2wvfKXjvUzo0/oPH76PpX5r88Ku8T9qGKKs5hrgI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TCP5FlPP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C01FFC4CED0;
	Fri, 13 Dec 2024 09:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734082465;
	bh=shAFm4xEcVgvQ08saw8ULWVwBdClSzYyPXaWFqnQ1mM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TCP5FlPPGIRhcEfltKPzaQHKp6ODDUSOjfSjaYLX8rTfDbBX1Re+DPx+xvFlS4bCy
	 ioboxr1O7HeS+Nt7wsbVxIa8TrFNx3bTP6qlb/kR6pMxwAegXKpWKtj5WOViMW6tTi
	 HKWKo/hb4rI+KeecHGmUUA1dNWmQbzI2SruDOewOJW/4gZV/Edo2Sq7yt8D+dXmaJ0
	 vqe+rn4nsEcM5ARLhWyb+a+ed2BsipJ3UFIFM8+KPEGIIAxR3pTQ+ZqtnvzFsbMOl8
	 fo11zjQaCtwmg6UjlfIQCgHZVJXewJCPR3u1SQ5aVEpCEfp/KlfF91SeI7pAILjQzL
	 9Ue17bRd1vWSA==
Date: Fri, 13 Dec 2024 10:34:22 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Robert Foss <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>, 
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Barnabas Czeman <barnabas.czeman@mainlining.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>, Caleb Connolly <caleb.connolly@linaro.org>, 
	David Heidelberg <david@ixit.cz>, ~postmarketos/upstreaming@lists.sr.ht, 
	phone-devel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] media: dt-bindings: media: camss: Restrict bus-type
 property
Message-ID: <nqggstwkytqxpxy3iuhkl6tup5elf45lqi3qlgyv6eaizvnfdr@2uy57umdzqfa>
References: <20241209-camss-dphy-v1-0-5f1b6f25ed92@fairphone.com>
 <20241209-camss-dphy-v1-1-5f1b6f25ed92@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241209-camss-dphy-v1-1-5f1b6f25ed92@fairphone.com>

On Mon, Dec 09, 2024 at 01:01:05PM +0100, Luca Weiss wrote:
> The CSIPHY of Qualcomm SoCs support both D-PHY and C-PHY standards for
> CSI-2, but not any others so restrict the bus-type property describing
> this to the supported values.
> 
> The only exception here is MSM8916 which only supports D-PHY. C-PHY was
> introduced with newer SoCs.
> 
> Do note, that currently the Linux driver only supports D-PHY.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  .../bindings/media/qcom,msm8916-camss.yaml         |  8 ++++++
>  .../bindings/media/qcom,msm8953-camss.yaml         | 15 +++++++++++
>  .../bindings/media/qcom,msm8996-camss.yaml         | 20 +++++++++++++++
>  .../bindings/media/qcom,sc8280xp-camss.yaml        | 20 +++++++++++++++
>  .../bindings/media/qcom,sdm660-camss.yaml          | 20 +++++++++++++++
>  .../bindings/media/qcom,sdm845-camss.yaml          | 20 +++++++++++++++
>  .../bindings/media/qcom,sm8250-camss.yaml          | 30 ++++++++++++++++++++++
>  7 files changed, 133 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/media/qcom,msm8916-camss.yaml b/Documentation/devicetree/bindings/media/qcom,msm8916-camss.yaml
> index 9cc0a968a401836814560c1af3ee84d946500b4f..3de2a3d2b5b761106975aab65ff614b2ef579ef5 100644
> --- a/Documentation/devicetree/bindings/media/qcom,msm8916-camss.yaml
> +++ b/Documentation/devicetree/bindings/media/qcom,msm8916-camss.yaml
> @@ -94,6 +94,10 @@ properties:
>                  minItems: 1
>                  maxItems: 4
>  
> +              bus-type:
> +                enum:
> +                  - 4 # MEDIA_BUS_TYPE_CSI2_DPHY
> +
>              required:
>                - data-lanes
>  
> @@ -113,6 +117,10 @@ properties:
>                  minItems: 1
>                  maxItems: 4
>  
> +              bus-type:
> +                enum:
> +                  - 4 # MEDIA_BUS_TYPE_CSI2_DPHY
> +
>              required:
>                - data-lanes
>  
> diff --git a/Documentation/devicetree/bindings/media/qcom,msm8953-camss.yaml b/Documentation/devicetree/bindings/media/qcom,msm8953-camss.yaml
> index 8856fba385b1123d748199b46c5009c97700ad9b..6d776b0ca71140c0816b246dbaf41ef376205bba 100644
> --- a/Documentation/devicetree/bindings/media/qcom,msm8953-camss.yaml
> +++ b/Documentation/devicetree/bindings/media/qcom,msm8953-camss.yaml
> @@ -112,6 +112,11 @@ properties:
>                  minItems: 1
>                  maxItems: 4
>  
> +              bus-type:
> +                enum:
> +                  - 1 # MEDIA_BUS_TYPE_CSI2_CPHY

Just 1

> +                  - 4 # MEDIA_BUS_TYPE_CSI2_DPHY

Just 4

The type and meaning is already stated by video-interfaces and the
binding headers.

Anyway:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


