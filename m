Return-Path: <linux-kernel+bounces-531307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5CEA43EC9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 462943AF5B1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 12:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E868267F67;
	Tue, 25 Feb 2025 12:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fLPNIKyQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D43267738;
	Tue, 25 Feb 2025 12:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740485211; cv=none; b=g5O0AAPpMGIbIvCbpsFS00ePwyM1Nj5z2kcvvti2C25krlI4mdBzNnkU3JHah2OCA/emuM4EehbP5K//58fakUoA6kMQEZM4p41JGIm54Aa3FnZ6BZu4j6LOY1ohP8Xaq4bObD+LuDsT2Le+FXI6LT6u7l+NU4jdj2dz/gySses=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740485211; c=relaxed/simple;
	bh=M9uKEUq8wn1OiK4A1Sr0SpwlETpU2D5rT6iicUMUS1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZTDyY65Fwfh+ZjbU4l1EqhqjEjuAaGy0uqZvVA/0aaq4LLWesRmNwYHwtAPZT9LKCEPkUH5mF8T4BxwdPHFXzvK8TA2ncXHjsmdPvK8zFja3eOrvvV1ML+k7tiWWNgsg5ctQPa99kVjtqzX8uA9zO1ElsPMlYwWHChmfScUk5Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fLPNIKyQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE59DC4CEDD;
	Tue, 25 Feb 2025 12:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740485211;
	bh=M9uKEUq8wn1OiK4A1Sr0SpwlETpU2D5rT6iicUMUS1Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fLPNIKyQnCzj28tki4yV9v+CUMXKJW+LhrPH/IGrA85Bn5ky46l80LYAIM6m1d/rM
	 a8uYmQQSd5gLKQYy0dp9r6cuOr01gxQrF9R3a2bh6yEgoli8ajXK4c29euyGaLVCey
	 Lw1NX7ADGj35VLWeLs2kY10+9vO+w0StzGefOnQP7D3Y7JhAGfxVe/CvpTXPmpyvfa
	 +FmAozCrOXoLeUApjCkOGjX8dBLBLFRWA4gIyCp9mj4EBxz4fLnDaYljDasJNu5JMl
	 GCVe9ZrTyj+cmPbxEfcmFfWYGeTjRmGrAIx4akqRIImn3Gtgpy2RyJAX8Sp2jpqK1G
	 lhswYgpdvf4Kg==
Date: Tue, 25 Feb 2025 13:06:48 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Leonardo Felipe Takao Hirata <leo.fthirata@gmail.com>
Cc: tglx@linutronix.de, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, vz@mleia.com, 
	Leonardo Felipe Takao Hirata <leofthirata@gmail.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] dt-bindings: interrupt-controller: Convert
 nxp,lpc3220-mic.txt to yaml format
Message-ID: <20250225-lean-bronze-millipede-03edd9@krzk-bin>
References: <20250224210432.94851-1-leofthirata@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250224210432.94851-1-leofthirata@gmail.com>

On Mon, Feb 24, 2025 at 06:04:30PM -0300, Leonardo Felipe Takao Hirata wrote:
> Convert NXP LPC3220-MIC to DT schema.
> 
> Signed-off-by: Leonardo Felipe Takao Hirata <leofthirata@gmail.com>

SoB mismatch.

Run checkpatch.

> ---
>  .../interrupt-controller/nxp,lpc3220-mic.txt  | 58 -------------
>  .../interrupt-controller/nxp,lpc3220-mic.yaml | 86 +++++++++++++++++++
>  2 files changed, 86 insertions(+), 58 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/nxp,lpc3220-mic.txt
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/nxp,lpc3220-mic.yaml

...

> +title: NXP LPC32xx MIC, SIC1 and SIC2 Interrupt Controllers
> +
> +maintainers:
> +  - Vladimir Zapolskiy <vz@mleia.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - nxp,lpc3220-mic
> +      - nxp,lpc3220-sic
> +
> +  reg:
> +    description:
> +      Should contain IC registers location and length.

Drop description

> +    maxItems: 1
> +
> +  interrupt-controller: true
> +
> +  '#interrupt-cells':
> +    const: 2
> +    description:
> +      The number of cells to define an interrupt, should be 2.

Don't repeat constraints in free form text. Drop.

> +      The first cell is the IRQ number, the second cell is used to specify
> +      one of the supported IRQ types.
> +          IRQ_TYPE_EDGE_RISING = low-to-high edge triggered,
> +          IRQ_TYPE_EDGE_FALLING = high-to-low edge triggered,
> +          IRQ_TYPE_LEVEL_HIGH = active high level-sensitive,
> +          IRQ_TYPE_LEVEL_LOW = active low level-sensitive.
> +      Reset value is IRQ_TYPE_LEVEL_LOW.
> +
> +  interrupts:

Need to list and describe the items.

> +    description:
> +      Empty for MIC interrupt controller, cascaded MIC hardware interrupts for
> +      SIC1 and SIC2

And then allOf:if:then restricting it per variant (interrupts: false).

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupt-controller
> +  - '#interrupt-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    mic: interrupt-controller@40008000 {
> +      compatible = "nxp,lpc3220-mic";
> +      reg = <0x40008000 0x4000>;
> +      interrupt-controller;
> +      #interrupt-cells = <2>;
> +    };
> +
> +    sic1: interrupt-controller@4000c000 {
> +      compatible = "nxp,lpc3220-sic";
> +      reg = <0x4000c000 0x4000>;
> +      interrupt-controller;
> +      #interrupt-cells = <2>;
> +      interrupt-parent = <&mic>;
> +      interrupts = <0 IRQ_TYPE_LEVEL_LOW>,
> +                  <30 IRQ_TYPE_LEVEL_LOW>;
> +    };
> +
> +    sic2: interrupt-controller@40010000 {

Drop, two examples are enough.

> +      compatible = "nxp,lpc3220-sic";
> +      reg = <0x40010000 0x4000>;
> +      interrupt-controller;
> +      #interrupt-cells = <2>;
> +      interrupt-parent = <&mic>;
> +      interrupts = <1 IRQ_TYPE_LEVEL_LOW>,
> +                  <31 IRQ_TYPE_LEVEL_LOW>;
> +    };
> +
> +    adc@40048000 {
> +      compatible = "nxp,lpc3220-adc";

Drop, not relevant.

Best regards,
Krzysztof


