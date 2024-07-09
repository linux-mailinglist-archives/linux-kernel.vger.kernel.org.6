Return-Path: <linux-kernel+bounces-246467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F07F92C20E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 19:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A04A11C22DAF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 17:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64ECD18B046;
	Tue,  9 Jul 2024 17:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d00pFqlD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B4F639;
	Tue,  9 Jul 2024 17:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720544570; cv=none; b=o7E8mtgXC+ZuzB2B3AU1jOs2Ptbk8K27X26wBYUE2XBi6XLu7s6MN5FeFo1oBuJsNr9pQBr//y96NYuLRSKz3zNwAYKKi930kG8m17s3q6hG+XhVl5x0iXpS0JE1UwA9Y6TVDvlzluwgfbvz9f+q4Zjdc4IRywFXg6pFxlZWqW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720544570; c=relaxed/simple;
	bh=UzBIt+FVpxgii3bYvT/TnaWmQi6iHbmvBKeb61lHb3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WVRA1QQV7krJc7w4DBNMoi3Zy0BMUBvur8cJySKERyzAhEGGXaoDi1fOCebjSo85GRvwEKgE15HtVI4KIM4yHUE64WSIe1jm/dGbQif6Q+M+asDxL1UVo3r6RP773y1NTu8foUosHmR4O87aazhiyXv384a5Q6gKXgchTSvKnRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d00pFqlD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E60E8C3277B;
	Tue,  9 Jul 2024 17:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720544570;
	bh=UzBIt+FVpxgii3bYvT/TnaWmQi6iHbmvBKeb61lHb3k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d00pFqlDVfdTFREfEUkJuxoLP5iXotpydIl8G2UUgF+TKjBxoc4MFjv8iKVgZ3Hj9
	 o8l5blsRE3ApLwbyhrfTraoP3ntoI4lcGb3kZExgvOc7TH09ZdtoXfsPPSXVnjHWEO
	 Fh5uz7qx0SDLAED79e/P/xRLPj/Oym5HtnlcekoqhihDU0uus6e6rzD4U51yqVXm3A
	 De7E/+7ZAXGlQi0b+C1obR3cRkdlnsHXpqah0M4KygMrTOUcuBHykxMZQMXjbexgaI
	 /lpKz8IU+m12M31xGzkEPhxCXL9T4u6kFm6SIIs1ZsIDjLXIbfFm8yW1i5VHJaraSZ
	 Q0S02+Zj8Q9Pg==
Date: Tue, 9 Jul 2024 11:02:48 -0600
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Marek Vasut <marex@denx.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH] dt-bindings: non-dt-devices: document ltr,ltrf216a used
 via ACPI PRP0001
Message-ID: <20240709170248.GA3803124-robh@kernel.org>
References: <20240709084401.21108-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709084401.21108-1-krzysztof.kozlowski@linaro.org>

On Tue, Jul 09, 2024 at 10:44:01AM +0200, Krzysztof Kozlowski wrote:
> There is a device in the wild with non-updatable firmware coming with
> ACPI tables with rejected "ltr,ltrf216a" compatible.  Linux kernel still
> supports this device via ACPI PRP0001, however the compatible was never
> accepted to bindings.  Lack of bindings causes checkpatch.pl warning
> about undocumented compatible.

Why do we care? For checkpatch.pl I really don't. That hack check I 
wrote makes any string in binding docs a documented compatible. I have a 
better check using the schema written, but that would make checkpatch 
dependent on dtschema tools. So maybe just time to drop this check from 
checkpatch as we have other ways to check and track this.

However, I do care about 'make dt_compatible_check'. Besides these ACPI 
cases, there's a bunch of cases that we'll never have schemas for. Like 
everything from Sparc... Old PowerMac stuff... So I would like to 
'document' them just to exclude from dt_compatible_check. So perhaps 
this should be generalized.

> 
> Add a schema for such ACPI PRP0001 devices purely to satisfy
> checkpatch.pl and document consensus: ltr,ltrf216a compatible is allowed
> only via ACPI PRP0001, but not bindings.
> 
> Link: https://lore.kernel.org/all/20240705095047.90558-1-marex@denx.de/
> Link: https://lore.kernel.org/lkml/20220731173446.7400bfa8@jic23-huawei/T/#me55be502302d70424a85368c2645c89f860b7b40
> Cc: Marek Vasut <marex@denx.de>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/non-dt-devices.yaml   | 35 +++++++++++++++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/non-dt-devices.yaml
> 
> diff --git a/Documentation/devicetree/bindings/non-dt-devices.yaml b/Documentation/devicetree/bindings/non-dt-devices.yaml
> new file mode 100644
> index 000000000000..206334693c7b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/non-dt-devices.yaml
> @@ -0,0 +1,35 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/non-dt-devices.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Non-devicetree Devices - Exception List
> +
> +maintainers:
> +  - Rob Herring <robh@kernel.org>
> +
> +description:
> +  Some devices using ACPI with non-updatable firmware/ACPI tables use
> +  incorrect Devicetree compatibles via ACPI PRP0001.  Developers want to
> +  support these devices, thus use such compatibles in Linux drivers, however
> +  usage of these within Devicetree sources was rejected.
> +
> +  Following list of devices is an incomplete schema with a goal to pass Linux
> +  kernel scripts/checkpatch.pl checks about undocumented compatibles but also
> +  reject any DTS file using such un-approved compatible.
> +
> +  Usage of any of following compatibles is not allowed in Devicetree sources,
> +  even if they come from immutable firmware.  New entries can be added
> +  only on the basis of non-updatable ACPI firmware on the device.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ltr,ltrf216a
> +
> +required:
> +  - compatible
> +  - broken-usage-of-incorrect-compatible

That's a neat trick...

> +
> +additionalProperties: false
> -- 
> 2.43.0
> 

