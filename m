Return-Path: <linux-kernel+bounces-234499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3285991C764
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 22:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA438286240
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 20:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F8480C09;
	Fri, 28 Jun 2024 20:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ilrtl5To"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDBE80027;
	Fri, 28 Jun 2024 20:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719606897; cv=none; b=GnTyLr0G09WtCALg5HoP10ZMrOmhG3fY1X0WOHY43KupcPKnEn4X9bzxnBikbYYmzM9oTiRX9jDj/Wed+tRLrkWLNpJR/ivW4y1Ydee3pjlO7lr6xZmJL3TO2mY8lJx6o4w+kEn/5W8oQceHYDR2Kocf2eddqrTc2BEbmRgYNnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719606897; c=relaxed/simple;
	bh=lCcqJYgRiAEz9pBVyJBmMruRcOqpwTBPSELYvb2bHYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uhu/rguelwrk+sgE8Yq36WhPiDQRwlGzVRnL2KaJMt+HqD9BhQGdNyo8c1Y4BG0h7BzMWhafb011NqYmEf7Gf3G3UxWBbDqEcrs+ZnY0Zw2e230W02V2ZOmKmqN7K7Mc9rzvPHL532KY6e7JzMHefj2xTDHAxQ7A55Orq5RNXnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ilrtl5To; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0963EC4AF0F;
	Fri, 28 Jun 2024 20:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719606897;
	bh=lCcqJYgRiAEz9pBVyJBmMruRcOqpwTBPSELYvb2bHYM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ilrtl5Topbc4d0nUYU4CJJo5kqy6IyMLkg9hhTP2dqWmRsltug7FuK6i85Kfkcm4N
	 +BNlrxipKIk5pqOJR4PAEll9RUeBQkeJ4sKyZ66toYOZZkZLp+91sleKQez+0CwV6W
	 7yxemmydR3NdiVLXm5As+nS8j1NuSZgbQX9ukMCNJidQ40caqWUTcI/EIovctRRyez
	 XelkDj4JIPTq+XONkTRyAyRpQ3bATSbdECQUh7vtCqHnQDzn1qTFtQ7roAhW96oedY
	 R4jnJym98Qh2fl9ZwS/ze0P0pCPh1jtxKtWssJDywWTN0HhgiM0Hs6lDR4jKUcXgAZ
	 hmUljZnr3jKiQ==
Date: Fri, 28 Jun 2024 14:34:56 -0600
From: Rob Herring <robh@kernel.org>
To: Animesh Agarwal <animeshagarwal28@gmail.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: dt-bindings: realtek,rt5645: Convert to dtschema
Message-ID: <20240628203456.GA170991-robh@kernel.org>
References: <20240621154034.489037-1-animeshagarwal28@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621154034.489037-1-animeshagarwal28@gmail.com>

On Fri, Jun 21, 2024 at 09:10:27PM +0530, Animesh Agarwal wrote:
> Convert the RT5650/RT5645 audio CODEC bindings to DT schema.
> 
> Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>
> Cc: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>  .../bindings/sound/realtek,rt5645.yaml        | 129 ++++++++++++++++++
>  .../devicetree/bindings/sound/rt5645.txt      |  82 -----------
>  2 files changed, 129 insertions(+), 82 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/realtek,rt5645.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/rt5645.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/realtek,rt5645.yaml b/Documentation/devicetree/bindings/sound/realtek,rt5645.yaml
> new file mode 100644
> index 000000000000..d2d97d2bca2e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/realtek,rt5645.yaml
> @@ -0,0 +1,129 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/realtek,rt5645.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: RT5650/RT5645 audio CODEC
> +
> +maintainers:
> +  - Animesh Agarwal <animeshagarwal28@gmail.com>
> +
> +description: |
> +  This device supports I2C only.
> +
> +  Pins on the device (for linking into audio routes) for RT5645/RT5650:
> +    * DMIC L1
> +    * DMIC R1
> +    * DMIC L2
> +    * DMIC R2
> +    * IN1P
> +    * IN1N
> +    * IN2P
> +    * IN2N
> +    * Haptic Generator
> +    * HPOL
> +    * HPOR
> +    * LOUTL
> +    * LOUTR
> +    * PDM1L
> +    * PDM1R
> +    * SPOL
> +    * SPOR
> +
> +allOf:
> +  - $ref: dai-common.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - realtek,rt5645
> +      - realtek,rt5650
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +    description: The CODEC's interrupt output.
> +
> +  avdd-supply:
> +    description: Power supply for AVDD, providing 1.8V.
> +
> +  cpvdd-supply:
> +    description: Power supply for CPVDD, providing 3.5V.
> +
> +  hp-detect-gpios:
> +    description: 
> +      A GPIO spec for the external headphone detect pin. If jd-mode = 0, we
> +      will get the JD status by getting the value of hp-detect-gpios.

       maxItems: 1

> +
> +  cbj-sleeve-gpios:
> +    description:
> +      A GPIO spec to control the external combo jack circuit to tie the
> +      sleeve/ring2 contacts to the ground or floating. It could avoid some
> +      electric noise from the active speaker jacks.

       maxItems: 1

With that,

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

