Return-Path: <linux-kernel+bounces-203387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 262558FDA2C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 01:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C35851F24F42
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 23:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22D116193B;
	Wed,  5 Jun 2024 23:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nk+k7pUO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AFB160884;
	Wed,  5 Jun 2024 23:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717629027; cv=none; b=oopEz8tFai0RQHMWK/sNr5TpYgaHRehUD/NYyjLBOWO1RVMCH3ZD5uNE9RwbuPUr9w4Zy9vSMwh/MdvQJSzJcPkBqY1zfsb4HmVc95SN9hGkGQGAiNNBeJqVl+wqmD7A+5LHKAEhMen1YycL/ZC5fegKhSKJx/58A/MQjlyOF4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717629027; c=relaxed/simple;
	bh=DqNzbfeYdzlgSZnvwqVVM1/hr0wbxWQ46hLlfil+Yv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qp7OraF+hww9Mx3IL+mwMktetkNr6lFMbsE4pQUn/Sxdu/GQRuag4Y6cdB94ny6XjMksmdm1Wb3lInWygY9CLnqUrOLhmOPfPtO8k5uoo2yzRG6ESFw6tlTtS7HwoYvYXhk5xJSfY91JnsjEyskrLVfir9+kmfYWazYqTIWOvfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nk+k7pUO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB4BAC2BD11;
	Wed,  5 Jun 2024 23:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717629026;
	bh=DqNzbfeYdzlgSZnvwqVVM1/hr0wbxWQ46hLlfil+Yv4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nk+k7pUOpZhqOLLY/euYavqSWDJBhAe1zQjOIZzw0Dwgp7Y34Wn7PuOjJWL/CmYPa
	 h77OhkIhraRywOjrk5QBl9DiKeamh5Xy8ZOnNZLVvBl3cvdG4sOZf60nSt32hG1UCe
	 C0A9eGPGnDyMwDqc73fxz+/OS8m8vEfXwDlf5y+3aolHWtTsRE+IwGOClzK8Ltacqp
	 oiW0/ZOHQkqX4JPUbZ90SsZO7kQEcT/rDYT0DDw+L7x1db2Xtu0XKLSFUoPXbwC3Gv
	 B38JBpGrciQiAzfWppMYx9Ygklps4r/b9yjpLor7fj1vCUkfsHH9xmrC+MB3KziKeM
	 5d5y37IT1fsyQ==
Date: Wed, 5 Jun 2024 17:10:21 -0600
From: Rob Herring <robh@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: dt-binding: convert spdif-receiver.txt to dt-schema
Message-ID: <20240605231021.GA3302324-robh@kernel.org>
References: <20240605-topic-amlogic-upstream-bindings-convert-spdif-receiver-v1-1-262465adbac2@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605-topic-amlogic-upstream-bindings-convert-spdif-receiver-v1-1-262465adbac2@linaro.org>

On Wed, Jun 05, 2024 at 06:20:50PM +0200, Neil Armstrong wrote:
> Convert text bindings to dt-schema format for the Dummy SPDIF receiver

Couldn't this be shared with the transmitter. The only diff is the 
compatible.

> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../devicetree/bindings/sound/linux,spdif-dir.yaml | 37 ++++++++++++++++++++++
>  .../devicetree/bindings/sound/spdif-receiver.txt   | 10 ------
>  2 files changed, 37 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/linux,spdif-dir.yaml b/Documentation/devicetree/bindings/sound/linux,spdif-dir.yaml
> new file mode 100644
> index 000000000000..ec8990c236f7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/linux,spdif-dir.yaml
> @@ -0,0 +1,37 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/linux,spdif-dir.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Dummy SPDIF Receiver
> +
> +maintainers:
> +  - Mark Brown <broonie@kernel.org>
> +
> +allOf:
> +  - $ref: dai-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: linux,spdif-dir
> +
> +  "#sound-dai-cells":
> +    const: 0
> +
> +  sound-name-prefix: true
> +
> +required:
> +  - "#sound-dai-cells"
> +  - compatible
> +
> +addirionalProperties: false
> +
> +examples:
> +  - |
> +    spdif-in {
> +        #sound-dai-cells = <0>;
> +        compatible = "linux,spdif-dir";
> +    };
> +
> +...
> diff --git a/Documentation/devicetree/bindings/sound/spdif-receiver.txt b/Documentation/devicetree/bindings/sound/spdif-receiver.txt
> deleted file mode 100644
> index 80f807bf8a1d..000000000000
> --- a/Documentation/devicetree/bindings/sound/spdif-receiver.txt
> +++ /dev/null
> @@ -1,10 +0,0 @@
> -Device-Tree bindings for dummy spdif receiver
> -
> -Required properties:
> -	- compatible: should be "linux,spdif-dir".
> -
> -Example node:
> -
> -	codec: spdif-receiver {
> -		compatible = "linux,spdif-dir";
> -	};
> 
> ---
> base-commit: c3f38fa61af77b49866b006939479069cd451173
> change-id: 20240605-topic-amlogic-upstream-bindings-convert-spdif-receiver-c8d2fdb688cb
> 
> Best regards,
> -- 
> Neil Armstrong <neil.armstrong@linaro.org>
> 

