Return-Path: <linux-kernel+bounces-393777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D5A9BA51E
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 11:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B16091C21012
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 10:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E76166308;
	Sun,  3 Nov 2024 10:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uYrG7dsU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B3C4430;
	Sun,  3 Nov 2024 10:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730629818; cv=none; b=l+YKS/HywETdVBSldk0ox7qJXWDW3omrPUzUm6cHVDdM+00O9WRyRHxWCnIuBXj+Ed14O3l9Bc92YDWNtI+dnMaWBV6U5hpO5Bl1ymoQMFE0gOsXQMdhtb4k6MCggs/PsP4S7kYlLVcV3zIjwOwQpJRFZH9IsHC28c16Ac7KikA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730629818; c=relaxed/simple;
	bh=tscA56UlqwWIvbmdpnNpVS0E2UY2+aox3QClc4hpzWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tdQ/gYxOyE8y0N41iiQsp6vakoGeMCWKRrFB9AhrYn3Oa/UGcw91n6F1tHH787ouj4BzkEFCXATUSOjDHg4+plHMw9oU9QlichFyHVYr+R+kCqsGnOJc7ltP+Zu2YVoZAdLhsK71Wkbyxe8PQWgLXXloerPpKQ3W3tz84CUfA6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uYrG7dsU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 818E9C4CECD;
	Sun,  3 Nov 2024 10:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730629817;
	bh=tscA56UlqwWIvbmdpnNpVS0E2UY2+aox3QClc4hpzWk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uYrG7dsU3f16urLDFyFN2knOnKYxoG1B1TjIc/+p9ULnvYt76lJEI9DZzVXMAeeIT
	 etg9bbtXsG7hw70bu+1s3DSbJ8Qlz9nNyhMMDoCayYTxGM0xFhFaQTVvaYAD7LXqV5
	 6ohatHZBtS/r8h10oPoxqa2gUr+n84t+ZmYR3HPfu1jCBDPfD6pt5Y/OTAa6hamsK0
	 1R6WcOsuvopVH0cxSzY/BjXkkuvQlKiMzm21EyyLPCG2ISAZGnKd1wimSASPqSKaW+
	 5bPdLCbbteiA+Xa32sPuVEQfkbuu6nlGjwV/FDa1nPGIH33LJosVQNhSWhhjeDfK95
	 ugbP6sr0A2L1A==
Date: Sun, 3 Nov 2024 11:30:14 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	linux-actions@lists.infradead.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] dt-bindings: timer: actions,owl-timer: convert to YAML
Message-ID: <mfwotmnedq744aesguvjmroawarvkhpwalgm3wm5onsuffs245@iqorlvndja27>
References: <20241102221354.2856900-1-ivo.ivanov.ivanov1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241102221354.2856900-1-ivo.ivanov.ivanov1@gmail.com>

On Sun, Nov 03, 2024 at 12:13:04AM +0200, Ivaylo Ivanov wrote:
> Convert the Actions Semi Owl timer bindings to DT schema.
>=20
> Changes during conversion:
>  - Rename file to match compatible

I do not see any rename happening, anyway, this is not a change to the
binding, skip mentioning in changelog.

>  - Add a description
>  - Make "clocks" a required property, since the driver searches for it

Clocks were not in original binding, so you add clocks in the first
place.

>  - Correct the given example according to owl-s500.dtsi
>=20
> Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
> ---
>  .../bindings/timer/actions,owl-timer.txt      | 21 ------
>  .../bindings/timer/actions,owl-timer.yaml     | 71 +++++++++++++++++++
>  MAINTAINERS                                   |  2 +-
>  3 files changed, 72 insertions(+), 22 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/timer/actions,owl-t=
imer.txt
>  create mode 100644 Documentation/devicetree/bindings/timer/actions,owl-t=
imer.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/timer/actions,owl-timer.tx=
t b/Documentation/devicetree/bindings/timer/actions,owl-timer.txt
> deleted file mode 100644
> index 977054f87..000000000
> --- a/Documentation/devicetree/bindings/timer/actions,owl-timer.txt
> +++ /dev/null
> @@ -1,21 +0,0 @@
> -Actions Semi Owl Timer
> -
> -Required properties:
> -- compatible      :  "actions,s500-timer" for S500
> -                     "actions,s700-timer" for S700
> -                     "actions,s900-timer" for S900
> -- reg             :  Offset and length of the register set for the devic=
e.
> -- interrupts      :  Should contain the interrupts.
> -- interrupt-names :  Valid names are: "2hz0", "2hz1",
> -                                      "timer0", "timer1", "timer2", "tim=
er3"
> -                     See ../resource-names.txt
> -
> -Example:
> -
> -		timer@b0168000 {
> -			compatible =3D "actions,s500-timer";
> -			reg =3D <0xb0168000 0x100>;
> -			interrupts =3D <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
> -			             <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
> -			interrupt-names =3D "timer0", "timer1";
> -		};
> diff --git a/Documentation/devicetree/bindings/timer/actions,owl-timer.ya=
ml b/Documentation/devicetree/bindings/timer/actions,owl-timer.yaml
> new file mode 100644
> index 000000000..ed50b4753
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/actions,owl-timer.yaml
> @@ -0,0 +1,71 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/timer/actions,owl-timer.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Actions Semi Owl timer
> +
> +maintainers:
> +  - Andreas F=C3=A4rber <afaerber@suse.de>
> +
> +description: |

Do not need '|' unless you need to preserve formatting.

> +  Actions Semi Owl SoCs provide 32bit and 2Hz timers.
> +  The 32bit timers support dynamic irq, as well as one-shot mode.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - actions,s500-timer
> +      - actions,s700-timer
> +      - actions,s900-timer
> +
> +  clocks:
> +    maxItems: 1
> +
> +  interrupts:
> +    minItems: 1
> +    maxItems: 6
> +
> +  interrupt-names:
> +    minItems: 1
> +    maxItems: 6
> +    items:
> +      enum:
> +        - 2hz0
> +        - 2hz1
> +        - timer0
> +        - timer1
> +        - timer2
> +        - timer3

timer1 is a required property. Above is fine but you need allOf:if:then:
block customizing/constraining it per variant.

> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - clocks
> +  - interrupts
> +  - interrupt-names
> +  - reg
> +
> +additionalProperties: false

Blank line

Best regards,
Krzysztof


