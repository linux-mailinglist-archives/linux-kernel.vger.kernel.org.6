Return-Path: <linux-kernel+bounces-386954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4AE9B4A1D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 13:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 848BCB24676
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB54B206050;
	Tue, 29 Oct 2024 12:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rLgP5GTa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A482040BE;
	Tue, 29 Oct 2024 12:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730206114; cv=none; b=JBKxoGTtqB4CxBRnariZAhEbYE4VSeLHp9N611AGGajrl/L2HEIFFLpbiX6WVQzZnD5CMHH5FdOdyk3vlFmhiLzzul7EsFg1zqi+V2hRZhx8KD/9666iBfyTVyt9dcQSSxFqGONUT0J5gFbg2HE7wKMU0i9SspHuTLl6mHyBFgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730206114; c=relaxed/simple;
	bh=UTYJuniDxeN2MquHNcNm2p29m+sxmXuRSOHwBy60akQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UpmRV+nGuFifN+1y6E+UsJvSmTgexXimrUMXFh2yBLN+PB5bOiBnU4BX3NeXba3933KcQcBYdfso4Ly5itVOTItHcIs203gUhR0IqCbPFo/h5kmTG0UweRvtLNrxLU+so8alMveXFYADt9z4gMsAmMpDK8YznQIVwoVnYftJZC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rLgP5GTa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 922A6C4CECD;
	Tue, 29 Oct 2024 12:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730206113;
	bh=UTYJuniDxeN2MquHNcNm2p29m+sxmXuRSOHwBy60akQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rLgP5GTaHjHlzmdyf5sPunEsAifIOShZ9j9WU5qJk2FlcMmh6KuUEuviQOQDN96m8
	 TwwVo1BLNXfKWe7PWQKRIlHTqGvsJ6tX2I/zf1ATrVYaMNQm0jPq/BPYcX22Nd8vHt
	 +l+WWqT4Q/xY2SXTFBt95U+OlqUqirlilwL2QZcIGqLA+DUWifDiVDQZkxcgytVNWp
	 4qlYk00BKQltSvgKSPmLyabUROI7aAF7uMMEnwdfkdqCqEmvkTf2reg8yg3rwJsZhR
	 5OtiuJJRBSsTEDJms3Xz8JiF6vCID8rMzti+EDIWftyQ/sJPS6Kd6NAlP/y+6sa9Hv
	 v2RBknLeEGLwg==
Date: Tue, 29 Oct 2024 07:48:32 -0500
From: Rob Herring <robh@kernel.org>
To: Valentina Fernandez <valentina.fernandezalanis@microchip.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	peterlin@andestech.com, conor.dooley@microchip.com,
	conor+dt@kernel.org, ycliang@andestech.com, dminus@andestech.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com, jassisinghbrar@gmail.com,
	krzk+dt@kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: mailbox: add binding for Microchip
 IPC mailbox controller
Message-ID: <20241029124832.GA1314513-robh@kernel.org>
References: <20241025125110.1347757-1-valentina.fernandezalanis@microchip.com>
 <20241025125110.1347757-3-valentina.fernandezalanis@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241025125110.1347757-3-valentina.fernandezalanis@microchip.com>

On Fri, Oct 25, 2024 at 01:51:09PM +0100, Valentina Fernandez wrote:
> Add a dt-binding for the Microchip Inter-Processor Communication (IPC)
> mailbox controller.
> 
> Signed-off-by: Valentina Fernandez <valentina.fernandezalanis@microchip.com>
> ---
>  .../bindings/mailbox/microchip,sbi-ipc.yaml   | 108 ++++++++++++++++++
>  1 file changed, 108 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/microchip,sbi-ipc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/microchip,sbi-ipc.yaml b/Documentation/devicetree/bindings/mailbox/microchip,sbi-ipc.yaml
> new file mode 100644
> index 000000000000..90a7932118b5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/microchip,sbi-ipc.yaml
> @@ -0,0 +1,108 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mailbox/microchip,sbi-ipc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip Inter-processor communication (IPC) mailbox controller
> +
> +maintainers:
> +  - Valentina Fernandez <valentina.fernandezalanis@microchip.com>
> +
> +description:

You need '>' and blank line in between each paragraph if you want the 
paragraphs maintained.

Elsewhere too.

> +  The Microchip Inter-processor Communication (IPC) facilitates
> +  message passing between processors using an interrupt signaling
> +  mechanism.
> +  This SBI interface is compatible with the Mi-V Inter-hart
> +  Communication (IHC) IP.
> +  The microchip,sbi-ipc compatible string is inteded for use by software
> +  running in supervisor privileged mode (s-mode). The SoC-specific
> +  compatibles are inteded for use by the SBI implementation in machine

intended

> +  mode (m-mode).

This per compatible information should be with the compatibles.

> +
> +properties:
> +  compatible:
> +    enum:
> +      - microchip,sbi-ipc
> +      - microchip,miv-ihc-rtl-v2

To add per compatible descriptions, you can do:

oneOf:
  - const:
    description: ...
  - const:
    description: ...



> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    minItems: 1
> +    maxItems: 5
> +
> +  interrupt-names:
> +    minItems: 1
> +    maxItems: 5
> +    items:
> +      pattern: "^hart-[0-5]+$"

Is the numbering always contiguous (e.g. not "hart-0, hart-3")? If so, 
drop the names. A name matching the index of the entry is not useful.

> +
> +  "#mbox-cells":
> +    description:
> +      For the SBI "device", the cell represents the global "logical" channel IDs.
> +      The meaning of channel IDs are platform firmware dependent. The
> +      SoC-specific compatibles are intended for use by the SBI implementation,
> +      rather than s-mode software. There the cell would represent the physical
> +      channel and do not vary depending on platform firmware.
> +    const: 1
> +
> +  microchip,ihc-chan-disabled-mask:
> +    description:
> +      Represents the enable/disable state of the bi-directional IHC channels
> +      within the MIV-IHC IP configuration. The mask is a 16-bit value, but only
> +      the first 15 bits are utilized.Each of the bits corresponds to
> +      one of the 15 IHC channels.
> +      A bit set to '1' indicates that the corresponding channel is disabled,
> +      and any read or write operations to that channel will return zero.
> +      A bit set to '0' indicates that the corresponding channel is enabled
> +      and will be accessible through its dedicated address range registers.
> +      The remaining bit of the 16-bit mask is reserved and should be ignored.
> +      The actual enable/disable state of each channel is determined by the
> +      IP block’s configuration.
> +    $ref: /schemas/types.yaml#/definitions/uint16
> +    default: 0
> +
> +required:
> +  - compatible
> +  - interrupts
> +  - interrupt-names
> +  - "#mbox-cells"
> +
> +additionalProperties: false
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: microchip,sbi-ipc
> +    then:
> +      properties:
> +        reg: false
> +        microchip,ihc-chan-disabled-mask: false
> +    else:
> +      required:
> +        - reg
> +        - microchip,ihc-chan-disabled-mask
> +
> +examples:
> +  - |
> +    mailbox {
> +      compatible = "microchip,sbi-ipc";
> +      interrupt-parent = <&plic>;
> +      interrupts = <180>, <179>, <178>;
> +      interrupt-names = "hart-1", "hart-2", "hart-3";
> +      #mbox-cells = <1>;
> +    };
> +  - |
> +    mailbox@50000000 {
> +      compatible = "microchip,miv-ihc-rtl-v2";
> +      microchip,ihc-chan-disabled-mask=  /bits/ 16 <0>;

Incorrect formatting around the '='.

> +      reg = <0x50000000 0x1C000>;
> +      interrupt-parent = <&plic>;
> +      interrupts = <180>, <179>, <178>;
> +      interrupt-names = "hart-1", "hart-2", "hart-3";
> +      #mbox-cells = <1>;
> +    };
> -- 
> 2.34.1
> 

