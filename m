Return-Path: <linux-kernel+bounces-575127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B905EA6EDD3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 11:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77A6A188BA70
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 10:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C95B254846;
	Tue, 25 Mar 2025 10:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u5+ZT9Mf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD3D9479;
	Tue, 25 Mar 2025 10:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742898984; cv=none; b=dW+l5CpTWac/oT9UjbPPyyWk+uAYy7ajdAVVymSYVr1oj6TRiEduQ2Q0fxOgbskyh1aVv1SzPxpPwPL0IOpffeSn/adSWEL18+5c6iRIP2jAPF6fO1vmEFiK05/Kaqcl2GYgf05dKtEqSslXJ3vecb1T0pu3yqOtwx87svQZMcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742898984; c=relaxed/simple;
	bh=ck3O1+mng/bZI1IvB15QbMdH614u9xgl5MjZuaDArWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cUzVOZKJBpChdr0w0OsGOpJ07IoErXhQAUd8YNP/tmIhI51r3cdR1H1Xt8AvC+wWh4eoXZ3RHxiHqjL03QjmQCIZJUmmNMYFd/wxe/pUna1pAl/PlA1y0ReGdJrzJ3JKnYQFT5oDzFh27aqt26GymcYs1DdFbPqAn/NPc+jKuoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u5+ZT9Mf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA69CC4CEE4;
	Tue, 25 Mar 2025 10:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742898983;
	bh=ck3O1+mng/bZI1IvB15QbMdH614u9xgl5MjZuaDArWg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=u5+ZT9MflYR2AK2u73KY4OQ1H1YqYC27iHzf5lFi1MKy40NWH4AU7Zh5HYPfEp3VE
	 wkT99ync4eqrJrBf1tK5FyO61fH6I7X+Pkutl7pBk1H8+smSGGB/M8fbpHATPuMxaQ
	 p0acF+poWCPAo2GlOnxygP6yPUJ3CmdjxqDHUz9WRMmJ5lN+2Zk/Ck09oKzU/EQXBM
	 Y8pry1dfOiE8+yEvsJndbN70mujpR39ejWR/Rt/8eMiCjDxG4pF4JRfK9RnRIyfxL8
	 kVuyT+6nSMiH6UcYZA8IbNcHt84JpgpDyLWuTzf59gjyngCn17HpDibGbSrGhF2Mh1
	 b7m0QQHjH9WPA==
Message-ID: <77f94763-5604-484f-93c8-dc018c166b37@kernel.org>
Date: Tue, 25 Mar 2025 11:36:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: mailbox: add cix,sky1-mbox
To: Guomin Chen <guomin.chen@cixtech.com>,
 Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 cix-kernel-upstream@cixtech.com, Peter Chen <peter.chen@cixtech.com>,
 Lihua Liu <Lihua.Liu@cixtech.com>
References: <20250325101807.2202758-1-guomin.chen@cixtech.com>
 <20250325101807.2202758-2-guomin.chen@cixtech.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20250325101807.2202758-2-guomin.chen@cixtech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/03/2025 11:18, Guomin Chen wrote:
> +
> +description:
> +  The Cixtech mailbox controller, used in the Cixtech Sky1 SoC,
> +  is used for message transmission between multiple processors
> +  within the SoC, such as the AP, PM, audio DSP, SensorHub MCU,
> +  and others
> +
> +  Each Cixtech mailbox controller is unidirectional, so they are
> +  typically used in pairs-one for receiving and one for transmitting.
> +
> +  Each Cixtech mailbox supports 11 channels with different transmission modes
> +    channel 0-7 - Fast channel with 32bit transmit register and IRQ support
> +    channel 8   - Doorbell mode,using the mailbox as an interrupt-generating
> +                   mechanism.
> +    channel 9   - Fifo based channel with 32*32bit depth fifo and IRQ support
> +    channel 10  - Reg based channel with 32*32bit transmit register and
> +                   Doorbell+transmit acknowledgment IRQ support

Maybe you split one device into two and that's why you have
unidirectional mailboxes?

> +
> +properties:
> +  compatible:
> +    const: cix,sky1-mbox
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  "#mbox-cells":
> +    description: Common mailbox binding property to identify the number

Drop

> +        of cells required for the mailbox specifier. Should be 1

Drop

Don't repeat constraints in free form text. Missing const.

You kept here pieces I asked to drop. You dropped pieces I did not
comment under. Please observe where the comments appear.

So again: explain what each cell argument means.


> +> +  cix,mbox-dir:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Direction of the mailbox (0:TX or 1:RX)
> +    enum: [0, 1]

Respond to comments or implement them. Previous discussion was not
resolved - you did not respond. Sending the same with unfinished
discussion is not way to convince maintainer. Opposite: you will get
NAKed because you try to finish discussion and push your patch over the
wall.

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - "#mbox-cells"
> +  - cix,mbox-dir
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        mbox_ap2pm: mailbox@30000000 {
> +            compatible = "cix,sky1-mbox";
> +            reg = <0 0x30000000 0 0x10000>;
> +            interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH 0>;
> +            #mbox-cells = <1>;
> +            cix,mbox-dir = <0>; /* 0:tx; 1:rx */

Drop comment. If you need comment, then this should be string.

> +        };
> +
> +        mbox_pm2ap: mailbox@30010000 {
> +            compatible = "cix,sky1-mbox";
> +            reg = <0 0x30010000 0 0x10000>;
> +            interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH 0>;
> +            #mbox-cells = <1>;
> +            cix,mbox-dir = <1>; /* 0:tx; 1:rx */

Drop second example. Wasn't here and is not needed. Same properties,
difference in one value is not that much.


Best regards,
Krzysztof

