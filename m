Return-Path: <linux-kernel+bounces-383802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3139E9B205B
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 21:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54FFD1C211FE
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 20:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C446A18132A;
	Sun, 27 Oct 2024 20:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rutxLgU/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263E317E8E2;
	Sun, 27 Oct 2024 20:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730061001; cv=none; b=bv5lDFFKltAt83dka+H7AvwhMQpjb+nSVQ8w5h/Ve8ZvFN+hM4yx/DXyjKWCQCPbHIR/nDp80W4lcb/LnPgda+vCoI3R2UvqSkYmB7jFWesW4lxBmuGI/IMTTtA5BUHnFePGXtRzoEUZifDUrM7CiMHWnQJ+6HpwQYKPWmAvvWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730061001; c=relaxed/simple;
	bh=RBDRTpmoR7tK0vxcuHjvBDGbXIBaa+8Lb+u9fte4zhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vu0MuHF8HTR6V9CMLiOdVucl1whzMkKZqL3vvGU4dLDreN6Y7dhbTQtAK+N8LTATvh+epGim0fDRsTYKLEGMAwkue5AVk8tz0RNcQHFkSUn9fdcGvK7Jz+j6XAyZ74dJlWfoo+8MwmxMdWYpmsvn6MhNAT85aiseLaPtNG4Tnfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rutxLgU/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0A76C4CEC3;
	Sun, 27 Oct 2024 20:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730061000;
	bh=RBDRTpmoR7tK0vxcuHjvBDGbXIBaa+8Lb+u9fte4zhE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rutxLgU/wTlndCeDb7HYLHZCODaBvWvV/qEdpaagQBcGr5ZTWtSXjhYHR0H39cFLe
	 qhJIBYhsNZ72/Ig1XyL1If0m5hzHP7Rgdra4LdJ7k90SzTY0DAiu8DPkg9OeuuVr1Q
	 nIexNmmU1PKO0FN0N6qkUmsq1x0LM1rl+TSi3FF0+h97I1nR2O8YuMZ8RvxvqJdZiW
	 ANWISnLvQSb8MIs63cEHtoefcR8j7cizxWPUN25DiKUy0B3/5ifZSiNnzwqplaKpKp
	 J92aiavCOpFCt8ZH7zy/YOuyqP2KYcthjHMjCdbsJpx6OfOhPiS3m4lrQczyNrMetr
	 HmRrcQS93/+4g==
Date: Sun, 27 Oct 2024 21:29:56 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Karan Sanghavi <karansanghvi98@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Shuah Khan <skhan@linuxfoundation.org>, Alexander Aring <alex.aring@gmail.com>, 
	Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH v3] dt-bindings: power: Convert raspberrypi,bcm2835-power
 to Dt schema
Message-ID: <tmxgkiso66gr62dlnnf4zij7oxtbyf3lkgtmbudiwzolbkuuff@y3l7kxr6rwyy>
References: <20241026-raspberrypi-bcm2835-power-v3-1-6621e075d33f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241026-raspberrypi-bcm2835-power-v3-1-6621e075d33f@gmail.com>

On Sat, Oct 26, 2024 at 01:59:13PM +0000, Karan Sanghavi wrote:
> Convert the raspberrypi,bcm2835-power binding to Dt schema
> 
> Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>
> ---
> Changes in v3:
> - Applied changes as per the feedback received for title and description
> - Removed power label and renamed node to power-controller	
> - Moved the file from bindings/soc/bcm to bindings/power
> - Link to v2: https://lore.kernel.org/r/20241022-raspberrypi-bcm2835-power-v2-1-1a4a8a8a5737@gmail.com
> 
> Changes in v2:
> - Added original file maintainers
> - Removed unnecessary headers from example and formating from description 
> - Link to v1: https://lore.kernel.org/r/20241019-raspberrypi-bcm2835-power-v1-1-75e924dc3745@gmail.com
> ---
>  .../bindings/power/raspberrypi,bcm2835-power.yaml  | 44 ++++++++++++++++++++
>  .../bindings/soc/bcm/raspberrypi,bcm2835-power.txt | 47 ----------------------
>  2 files changed, 44 insertions(+), 47 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/power/raspberrypi,bcm2835-power.yaml b/Documentation/devicetree/bindings/power/raspberrypi,bcm2835-power.yaml
> new file mode 100644
> index 000000000000..71b3fa41c495
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/raspberrypi,bcm2835-power.yaml
> @@ -0,0 +1,44 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +

Some random changes... this wasn't in previous version

> +---
> +

Neither this.

> +$id: http://devicetree.org/schemas/power/raspberrypi,bcm2835-power.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Broadcom BCM2835 power domain
> +
> +maintainers:
> +  - Alexander Aring <alex.aring@gmail.com>
> +  - Eric Anholt <eric@anholt.net>
> +
> +description:
> +  The Raspberry Pi power domain manages power for various subsystems
> +  in the Raspberry Pi BCM2835 SoC.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - raspberrypi,bcm2835-power
> +
> +  firmware:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: Reference to the RPi firmware device node
> +
> +  "#power-domain-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - firmware
> +  - "#power-domain-cells"
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    power-controller {
> +      compatible = "raspberrypi,bcm2835-power";
> +      firmware = <&firmware>;
> +      #power-domain-cells = <1>;
> +      };

Nor this misindent.

Your task was to do 'mv', not rewrite the patch. How random differences
could appear here?

Best regards,
Krzysztof


