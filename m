Return-Path: <linux-kernel+bounces-559599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B19A5F5F2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 14:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E11D17A37CF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 13:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA14267B00;
	Thu, 13 Mar 2025 13:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JB0Fw2dn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82752641FD
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 13:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741872524; cv=none; b=u5BbCV8Gan1vRMRpDGloOTf3yx4s+JV5tm5oTzLCDyoYtIhcmvUkfw5fZMml4VJrVSr5D5Ct2a2R1X43hTF7+I+aCKeW0ZnW7FCE3Uz2h4iL6EcIGzwMB24g5vNy8bxcUGgg/q7vFW6DTEHSVDp1hEu40r9CfHeKbX7xGtx3Nxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741872524; c=relaxed/simple;
	bh=iqxmpqxwezW/E0wQ2/ag0wQd5oigAqsm5H9ZXnRt95Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IcMLeVNhlgXstz1WgXP2wDrQqoI8noPUh9HW94AOodAuF4MpsRcd2vBkE5DJqiT7HuYEdjQaI8sA2sMSYbfxMOgXi5MGkZ7GBOjvP8/uvrj3QWBpmnCOIH1yXTTngdMOAMkxlp4z7zTu09N8YDf0TW7URz3Ehjwlp84NgNgr2bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JB0Fw2dn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C56EC4CEEE;
	Thu, 13 Mar 2025 13:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741872523;
	bh=iqxmpqxwezW/E0wQ2/ag0wQd5oigAqsm5H9ZXnRt95Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JB0Fw2dnKEi8allw1f9x9jy6Rklb2BEA5hll8CoHT4vJeaooCf11PN0qFIytQpemr
	 WPH85qa4jn6kTjVQ+DmDVCiddEGsJEkt/7s3ZgSMQl5wbl48zC9knG0Raw4/Yb/QHn
	 Gjy82N3arJDKlQOH1eftxrDNTJq8DieQKgAR3WKDckWww6jSmPTVwwkOGM/jNCV6J/
	 6bmVORSGSZfEXyEpP/4HgPNPHT8t4rTISecLCP0g2hCrrfVEG6go/2up2M/wCyEXRA
	 7O6gLnXzXSSKaZ/Ygfxg7523qo+5M4VMVE09vC+h4K9qb5Q4XwE+44GvC2GlRXpoU5
	 wiSTyhJyDMWZw==
Message-ID: <27cf6dab-da29-458a-b376-4013c05434ab@kernel.org>
Date: Thu, 13 Mar 2025 14:28:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: mailbox: cix: add device tree binding
 documentation.
To: Guomin Chen <guomin.chen@cixtech.com>,
 Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, cix-kernel-upstream@cixtech.com,
 Peter Chen <peter.chen@cixtech.com>, Lihua Liu <Lihua.Liu@cixtech.com>
References: <20250313132405.742360-1-guomin.chen@cixtech.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20250313132405.742360-1-guomin.chen@cixtech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/03/2025 14:24, Guomin Chen wrote:
> From: Guomin Chen <Guomin.Chen@cixtech.com>
> 
> This patch adds device tree binding for mailbox from Cixtech.

Please do not use "This commit/patch/change", but imperative mood. See
longer explanation here:
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

A nit, subject: drop second/last, redundant "device tree binding
documentation.". The "dt-bindings" prefix is already stating that these
are bindings.
See also:
https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree/bindings/submitting-patches.rst#L18

Also, no full stop in the subject.

> 
> Reviewed-by: Peter Chen <peter.chen@cixtech.com>
> Signed-off-by: Lihua Liu <Lihua.Liu@cixtech.com>
> Signed-off-by: Guomin Chen <Guomin.Chen@cixtech.com>
> ---
>  .../bindings/mailbox/cix-mailbox.yaml         | 74 +++++++++++++++++++

Filename matching compatible.

>  1 file changed, 74 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/cix-mailbox.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/cix-mailbox.yaml b/Documentation/devicetree/bindings/mailbox/cix-mailbox.yaml
> new file mode 100644
> index 000000000000..85cb54ae2e79
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/cix-mailbox.yaml
> @@ -0,0 +1,74 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mailbox/cix-mailbox.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cix mailbox controller
> +
> +maintainers:
> +  - Lihua Liu <Lihua.Liu@cixtech.com>
> +
> +description:
> +  CIX mailbox controller is used to exchange message within
> +  multiple processors, such as AP, AUDIO DSP, SensorHub MCU,
> +  etc. It supports 10 mailbox channels with different operating
> +  mode and every channel is unidirectional.

uni but configurable or each channel has specific direction?

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
> +    description: |
> +      <&phandle channel>
> +      phandle   : Label name of controller
> +      channel   : Channel number

Drop above and explain what the cell argument is.

> +
> +      This controller supports three types of unidirectional channels, they are
> +      1 register based channel, 1 fifo based channel and 8 fast channels.
> +      A total of 10 channels for each controller. Following types are
> +      supported:
> +      channel 0_7 - Fast channel with 32bit transmit register and IRQ support.
> +      channel 8   - Reg based channel with 32*32bit transsmit register and
> +                    Doorbell+transmit acknowledgment IRQ support
> +      channel 9   - Fifo based channel with 32*32bit depth fifo and IRQ support.
> +    const: 1
> +
> +  cix,mbox-dir:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Direction of the mailbox (0:TX or 1:RX)
> +    enum: [0, 1]

I don't understand why do you need it. By not sending us driver patch,
you are not making it easier. Why would provider care how consumers use
the mbox channel? Maybe consumer should choose the direction?

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
> +        mbox0: mailbox@30000000 {
> +            compatible = "cix,sky1-mbox";
> +            reg = <0 0x30000000 0 0x10000>;
> +            interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH 0>;
> +            #mbox-cells = <1>;
> +            cix,mbox-dir = <0>;
> +            status = "okay";

Drop

> +        };
> +    };


Best regards,
Krzysztof

