Return-Path: <linux-kernel+bounces-431435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 887CC9E3D53
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 15:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 618C316102B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 14:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7A320ADF5;
	Wed,  4 Dec 2024 14:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fb/f6iea"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE79E20A5E7;
	Wed,  4 Dec 2024 14:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733323958; cv=none; b=T0BnPaKvKTOs13uQ9laVlMPQa7OPk9EIjS8IRHiMw5S2X8Rw97JHhcLO8ir1HzXx5/CFvkddFyn0utdKgmUbs3hewyHSclBXJ+NUwvpk8KGehLYfClCGB5RRyDwyii94180m8wynWTVFs18SbF0n3IVl348gMLenVzpmQdbme4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733323958; c=relaxed/simple;
	bh=q1EI/ZvprzWeZhl8skF4PiVduPC/wxv9wUqtG/H4t0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C8NUKUneP6Gn5R9aXc1CqtvWTnGCYM0L3ffq7+M1Ti3I0bgRbr1YvLgECtm6UVLyXxVwPzi5YSvdKbjiFCvx/6R7WTgsQGhh9t4tMBtAbX6YNU/d2M+zBJoEwAUvsqQTMu+DSCCbSqiTCPzY83b/nNvVoIDt0Fd4DUZxwxKsD1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fb/f6iea; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 233CDC4CECD;
	Wed,  4 Dec 2024 14:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733323958;
	bh=q1EI/ZvprzWeZhl8skF4PiVduPC/wxv9wUqtG/H4t0A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fb/f6ieaBtCN8GEiop0yP175EUVy7Pn3gw34bWjj9fQuqnYC49cUEfsV8iGyiAghi
	 KVWPFvAEp/hKopU+K5jgI9gffGx8mifzIK5eQJIa4NQKvDx8YUDkJgFzIquR94ylYr
	 DJjGW/wFTDCzU/ivgUpcRShAsap5DCtpdybeflUAOt/Ruwa4IVPLbsKU8Bf3WyX3wh
	 8Xp5NuczD6FpmRyZx8a//ssvoTRHiBIJtaVaDYTyTLGGYO5aCvvBHRLW1EkpxxvAaV
	 ejzhGvSC1zxljUXjXYxwskNLGQu2YPu8wJxfZRdAtpEM8IcKIn//sRWCFcEABviwqP
	 UzKkrqejgQQyw==
Date: Wed, 4 Dec 2024 08:52:36 -0600
From: Rob Herring <robh@kernel.org>
To: Valentina Fernandez <valentina.fernandezalanis@microchip.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com,
	conor.dooley@microchip.com, conor+dt@kernel.org,
	jassisinghbrar@gmail.com, krzk+dt@kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v5 3/4] dt-bindings: mailbox: add binding for Microchip
 IPC mailbox controller
Message-ID: <20241204145236.GA202257-robh@kernel.org>
References: <20241202141107.193809-1-valentina.fernandezalanis@microchip.com>
 <20241202141107.193809-4-valentina.fernandezalanis@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241202141107.193809-4-valentina.fernandezalanis@microchip.com>

On Mon, Dec 02, 2024 at 02:11:06PM +0000, Valentina Fernandez wrote:
> Add a dt-binding for the Microchip Inter-Processor Communication (IPC)
> mailbox controller.
> 
> Signed-off-by: Valentina Fernandez <valentina.fernandezalanis@microchip.com>
> ---
>  .../bindings/mailbox/microchip,sbi-ipc.yaml   | 117 ++++++++++++++++++
>  1 file changed, 117 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/microchip,sbi-ipc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/microchip,sbi-ipc.yaml b/Documentation/devicetree/bindings/mailbox/microchip,sbi-ipc.yaml
> new file mode 100644
> index 000000000000..e104573d45c1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/microchip,sbi-ipc.yaml
> @@ -0,0 +1,117 @@
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
> +  The Microchip Inter-processor Communication (IPC) facilitates
> +  message passing between processors using an interrupt signaling
> +  mechanism.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - description:
> +          Intended for use by software running in supervisor privileged
> +          mode (s-mode). This SBI interface is compatible with the Mi-V
> +          Inter-hart Communication (IHC) IP.
> +        const: microchip,sbi-ipc
> +
> +      - description:
> +          Intended for use by the SBI implementation in machine mode
> +          (m-mode), this compatible string is for the MIV_IHC Soft-IP.
> +        const: microchip,miv-ihc-rtl-v2
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
> +      enum:
> +        - hart-0
> +        - hart-1
> +        - hart-2
> +        - hart-3
> +        - hart-4
> +        - hart-5

I don't know why Krzysztof said to list them, when all you needed to do 
was drop the '+':

pattern: "^hart-[0-5]$"

> +
> +  "#mbox-cells":
> +    description: >
> +      For "microchip,sbi-ipc", the cell represents the global "logical"
> +      channel IDs. The meaning of channel IDs are platform firmware dependent.
> +
> +      For "microchip,miv-ihc-rtl-v2", the cell represents the physical
> +      channel and does not vary based on the platform firmware.
> +    const: 1
> +
> +  microchip,ihc-chan-disabled-mask:
> +    description: >
> +      Represents the enable/disable state of the bi-directional IHC
> +      channels within the MIV-IHC IP configuration.
> +
> +      A bit set to '1' indicates that the corresponding channel is disabled,
> +      and any read or write operations to that channel will return zero.
> +
> +      A bit set to '0' indicates that the corresponding channel is enabled
> +      and will be accessible through its dedicated address range registers.
> +
> +      The actual enable/disable state of each channel is determined by the
> +      IP block’s configuration.
> +    $ref: /schemas/types.yaml#/definitions/uint16
> +    maximum: 0x7fff
> +    default: 0
> +
> +required:
> +  - compatible
> +  - interrupts
> +  - interrupt-names
> +  - "#mbox-cells"
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

How do you address the question about this? Add an explanation in the 
schema. No one is going to remember an answer in a review thread. IOW, 
assume that we don't remember the answer and will just ask the same 
questions again.

You can do something like:

reg:
  not:
    description: ...

or

reg:
  not: {}
  description: ...


Rob

