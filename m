Return-Path: <linux-kernel+bounces-557567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF38A5DAE2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 11:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 593D5188B5C8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 10:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58AA623E35B;
	Wed, 12 Mar 2025 10:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DOWq8CK9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18BE23E34D
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 10:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741776674; cv=none; b=W0IrB0FESpGzlCLAoESSC+voWLBkHwitub2ZP5eG2UwsdxjEdYUTAElV5HZGt2OuGtTumWo13cPmts4fGKUge0b0PxCcQ9XfmyablQ3rn2VrXJ9xVcHkxPaUxIi1hSAAcM17Qnov/4+pS6NFQgtYR6qfDpQ6VZqeHaRkFNT6wSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741776674; c=relaxed/simple;
	bh=ML0IjKPWeKtMJa7Pak5YPzg21kk0tPL2tjJ/pumhwSg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jm40IhPqCXi9k6UWmtLfbSA9+Ylu3mheLE/tx6WNSmmvjoBHz13tqnuu3r16tVfPGrJHHSmEuWQUm1TLvovXuMRPi+khBAQ3ASQjFBzTREvj6u9Iweikwo1UJcm0sOVby/xLmIv6z0uorUCzhao8H1QNg+XJMsxYkK6p1hQ9/iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DOWq8CK9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 964ABC4CEE3;
	Wed, 12 Mar 2025 10:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741776674;
	bh=ML0IjKPWeKtMJa7Pak5YPzg21kk0tPL2tjJ/pumhwSg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DOWq8CK9hTekPGl+XzcOc9+jZc/mLeeq5yEzBALUTkSIdL381EIsI4srTo3YcGyd0
	 rtcnWowDzFPNwdHKR37LIPodXyME4gih0kQOIUY5ULCkAtW5+YsYcgkPDB+KISs3T/
	 U5aF1M5JCbZxiWc4TNVLChZyFU3S/vZucPjH3bS6Pv05TYeOzHx2xrXSrkZnPFDFek
	 Fm4CygytCc/MIZh8YP7TEIbkYrCxBie1cM9BaQ+I8tqL/dzp5v1SCTsDnFt+Pul187
	 AQ3Xq+N4m0YhpNWF19fV/AzaWckvWI1rQwvhCbxZGybxcshRQpon15eCIAnhPBMSJN
	 5+oO7iGi/ASXA==
Message-ID: <37707900-9162-43f2-b89b-3e1fec514daf@kernel.org>
Date: Wed, 12 Mar 2025 11:51:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] dt-bindings: add device tree binding for silex
 multipk
To: Nipun Gupta <nipun.gupta@amd.com>, linux-kernel@vger.kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 derek.kiernan@amd.com, dragan.cvetic@amd.com, arnd@arndb.de,
 gregkh@linuxfoundation.org
Cc: praveen.jain@amd.com, harpreet.anand@amd.com, nikhil.agarwal@amd.com,
 srivatsa@csail.mit.edu, code@tyhicks.com, ptsm@linux.microsoft.com
References: <20250312095421.1839220-1-nipun.gupta@amd.com>
 <20250312095421.1839220-2-nipun.gupta@amd.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20250312095421.1839220-2-nipun.gupta@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/03/2025 10:54, Nipun Gupta wrote:
> Add binding documentation for Silex multipk device node with compatible
> string as 'silex,mutlipk'.

Please use subject prefixes matching the subsystem. You can get them for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching. For bindings, the preferred subjects are
explained here:
https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters

A nit, subject: drop second/last, redundant "bindings". The
"dt-bindings" prefix is already stating that these are bindings.
See also:
https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree/bindings/submitting-patches.rst#L18

> 
> Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
> ---
>  .../bindings/misc/silex,multipk.yaml          | 50 +++++++++++++++++++

Bindings are before users.

>  MAINTAINERS                                   |  1 +
>  2 files changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/silex,multipk.yaml
> 
> diff --git a/Documentation/devicetree/bindings/misc/silex,multipk.yaml b/Documentation/devicetree/bindings/misc/silex,multipk.yaml
> new file mode 100644
> index 000000000000..6951886734ca
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/silex,multipk.yaml
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/misc/silex,multipk.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Silex MultiPK driver

Drop "driver" and describe hardware.

> +
> +maintainers:
> +  - Nipun Gupta <nipun.gupta@amd.com>
> +  - Praveen Jain <praveen.jain@amd.com>
> +
> +description: |
> +  Silex Multipk device handles the Asymmetric crypto operations. The
> +  driver provides interface to user-space to directly interact with the
> +  Silex MultiPK device.

Why this isn't in crypto?

> +
> +properties:
> +  compatible:
> +    const: silex,mutlipk

Unknown vendor prefix

Device name part is weirdly generic. How is this device exactly called?
Where is it used? Where is datasheet?

> +
> +  interrupts:
> +    maxItems: 1
> +
> +  reg:
> +    items:
> +      - description: PKI Queues memory region
> +      - description: PKI TRNG memory region
> +      - description: PKI reset memory region

reset? Like reset controller? Why is this here instead of using existing
reset framework?

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - iommus

You did not test your patches.

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    multipk@20400000000 {
> +      compatible = "silex,multipk";
> +      interrupts = <0x00000000 0x0000009b IRQ_TYPE_LEVEL_HIGH>;

This is nowhere DTS coding style. See how other bindings do it.

> +      reg = <0x00000204 0x00000000 0x00000000 0x00010000>,
> +            <0x00000204 0x00020000 0x00000000 0x00000050>,
> +            <0x00000000 0xEC200340 0x00000000 0x00000004>;

lowercase hex, drop the padings of r0.

> +      iommus = <&smmu 0x25B>;

Lowercase hex

> +    };
Why is this patch a RFC? What is incomplete here?

RFC means patch is not ready so you will not get full review. Full
review will come once you send proper patch (and remember about
changelog and versioning - this is v1).

Best regards,
Krzysztof

