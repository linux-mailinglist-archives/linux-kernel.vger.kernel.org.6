Return-Path: <linux-kernel+bounces-383827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B879B209D
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 21:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AB441C20AAF
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 20:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43152185B58;
	Sun, 27 Oct 2024 20:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VyjXCTvU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802BB1DFE8;
	Sun, 27 Oct 2024 20:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730062525; cv=none; b=DzuTUnFh7mi7+5pGFv4SCHverOPuaNnVNVtrlyKZpXySDBIU1ELzyppTxOVKbrAWcmvMDWV+uAJMJwA10Zw59PE77VCx0HLSqIoYKRApNt3zhKfxpWEmMVVZP/pbPSyvoiqOMZzDwPpEkfhfOWFHWKEVBMNCWtaxzok/KoH2oRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730062525; c=relaxed/simple;
	bh=cVqokvOyxFvU1xMd1wGqWXrbr+e3s3HH0AKtdgNqiiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nK2IoYPYBTVDpq7CGxuDEN59RkkaViISzRcj/LzTTpn9OmVhhModu4S1eFijIbRIRsJSHUYgPurg+6tkKn8btO30gi+/h4m1nfuowx4c93NxrNEdLsklz79+rgmceguxlup4xVCp1O4JP4KiT1rYnTvMsgPpe+gwX/jk/T2uILU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VyjXCTvU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59098C4CEC3;
	Sun, 27 Oct 2024 20:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730062525;
	bh=cVqokvOyxFvU1xMd1wGqWXrbr+e3s3HH0AKtdgNqiiA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VyjXCTvU1oXMlb+st0YsSdXjD+OAvuNHRtZhLui6BBcKjb2jwya04HqCkRvX9JhG/
	 XGSEPzebYCbYZLG49uM3qhWIcH1JjF7bnwECwmYq8a1+GSr1M/DMF6bTIlJhkHFxmk
	 llPxKQG2R5AWIaK+4yNOMMAXz7m/qGgjBysI5BnTEG7jMM66mdkUv4YQG/uzGgJ/kK
	 ZWHkm7kE3Ec50sWDsDzOJOrt9+wIpg1KZhB1AlYyWwPctju0k/XfxhHrVJ6fb105ar
	 Ygrfcbp+BogMZehryJ9Qk3d43EJ6f18oQonPxup7z2hxIf7enhWVVzXbVtY9q+hk6m
	 DYYbBduU3Urmg==
Date: Sun, 27 Oct 2024 21:55:21 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Fei Shao <fshao@chromium.org>
Cc: Mark Brown <broonie@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Rob Herring <robh@kernel.org>, Steve Lee <steves.lee@maximintegrated.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH 3/4] ASoC: dt-bindings: maxim,max98390: Refernce common
 DAI properties
Message-ID: <i6eljb2nzhwr4bd55dbudsra3sni2hhk2eqgu3gttatwvnolt4@w4uhrklbyop3>
References: <20241025104548.1220076-1-fshao@chromium.org>
 <20241025104548.1220076-4-fshao@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241025104548.1220076-4-fshao@chromium.org>

On Fri, Oct 25, 2024 at 06:44:43PM +0800, Fei Shao wrote:
> Reference dai-common.yaml schema to support '#sound-dai-cells' and
> 'sound-name-prefix' properties.

Why? Is this a DAI?

> 
> Signed-off-by: Fei Shao <fshao@chromium.org>
> ---
> 
>  Documentation/devicetree/bindings/sound/maxim,max98390.yaml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/maxim,max98390.yaml b/Documentation/devicetree/bindings/sound/maxim,max98390.yaml
> index deaa6886c42f..5bd235cf15e6 100644
> --- a/Documentation/devicetree/bindings/sound/maxim,max98390.yaml
> +++ b/Documentation/devicetree/bindings/sound/maxim,max98390.yaml
> @@ -9,6 +9,9 @@ title: Maxim Integrated MAX98390 Speaker Amplifier with Integrated Dynamic Speak
>  maintainers:
>    - Steve Lee <steves.lee@maximintegrated.com>
>  
> +allOf:
> +  - $ref: dai-common.yaml#
> +
>  properties:
>    compatible:
>      const: maxim,max98390

Missing dai cells - how many DAIs are there?

Best regards,
Krzysztof


