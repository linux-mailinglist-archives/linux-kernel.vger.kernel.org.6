Return-Path: <linux-kernel+bounces-251006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB23892FFAC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 19:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A69A1C2219F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 17:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1893D1EB56;
	Fri, 12 Jul 2024 17:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dPzogAYd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A198176241;
	Fri, 12 Jul 2024 17:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720804929; cv=none; b=p9X9hbPXMyAxoxVGKIrERO25Pg6Ab2L3eTxLCQyPaQjxyjqfodp6UvZDevwkG/Dr24mTNemSoiL7pCuYVqYX+scfmD8YXJPx6omD94YVXzhdSMSHFZXxKx/4B+03DwPIFpbZZjiYPsmiVHjq08Cq+dNVObLVJyeCu9oHKhfq8TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720804929; c=relaxed/simple;
	bh=2Ex1ON+s+j0TUr6WcjiGdR8GVnK+27jup8cEzaO7AuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rn0+6AjMzyDnGuLnI/F9qxrMsZAcGF3voT2Jptr/OBkWOF6pEGoi1hYtQvkduEycgZqNkNbeLNiX+mN94TaGHTx8v8y9IvbfpEMh4g2EcQUfD2HIzzvDC09EKZbnE6urJLGB2SolnVZpJQFf3Uqtp4b2owq57jAaq55LrRCFwNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dPzogAYd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89D8DC32782;
	Fri, 12 Jul 2024 17:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720804929;
	bh=2Ex1ON+s+j0TUr6WcjiGdR8GVnK+27jup8cEzaO7AuA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dPzogAYd1M03xYPWV/tq6Gh8clQyxdEXWEaMuEHj0VR5ZH+c9GjxsGSe0BzmheaCw
	 7tyzrwwny3QeOmTQXqgOPeKlXIJuPa7BGbN127lurYvXfIYRPh1E63lI7CSNBlfbRR
	 Mhl0WhZ7Uf5UHskXYg5ZmHWCR6YoLR/T2ludKwNdOUVSUzIAzkThYz4GhzM/YBs7Tn
	 XQX1X9jwdqOk3iiz2NWd9r1O3eRVHZBPJ/p8RG5xn2zUhVomejKjCfzJXBOj7yLS0L
	 1MHq0CSJCAfkqdGBSrMd36PetRiHGEkF2u3zfEHj91nDPYMwo/ttUOdXfuwvQH1eKp
	 67gV5RhYrEx9A==
Message-ID: <ffa6a941-0e01-4f88-90cd-6673b602a7d3@kernel.org>
Date: Fri, 12 Jul 2024 19:22:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] dt-bindings: i3c: add header for generic I3C flags
To: Frank Li <Frank.Li@nxp.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Miquel Raynal
 <miquel.raynal@bootlin.com>,
 "moderated list:I3C SUBSYSTEM" <linux-i3c@lists.infradead.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Cc: imx@lists.linux.dev
References: <20240712170640.3635096-1-Frank.Li@nxp.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzSVLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+wsGVBBMBCgA/AhsDBgsJCAcDAgYVCAIJCgsE
 FgIDAQIeAQIXgBYhBJvQfg4MUfjVlne3VBuTQ307QWKbBQJgPO8PBQkUX63hAAoJEBuTQ307
 QWKbBn8P+QFxwl7pDsAKR1InemMAmuykCHl+XgC0LDqrsWhAH5TYeTVXGSyDsuZjHvj+FRP+
 gZaEIYSw2Yf0e91U9HXo3RYhEwSmxUQ4Fjhc9qAwGKVPQf6YuQ5yy6pzI8brcKmHHOGrB3tP
 /MODPt81M1zpograAC2WTDzkICfHKj8LpXp45PylD99J9q0Y+gb04CG5/wXs+1hJy/dz0tYy
 iua4nCuSRbxnSHKBS5vvjosWWjWQXsRKd+zzXp6kfRHHpzJkhRwF6ArXi4XnQ+REnoTfM5Fk
 VmVmSQ3yFKKePEzoIriT1b2sXO0g5QXOAvFqB65LZjXG9jGJoVG6ZJrUV1MVK8vamKoVbUEe
 0NlLl/tX96HLowHHoKhxEsbFzGzKiFLh7hyboTpy2whdonkDxpnv/H8wE9M3VW/fPgnL2nPe
 xaBLqyHxy9hA9JrZvxg3IQ61x7rtBWBUQPmEaK0azW+l3ysiNpBhISkZrsW3ZUdknWu87nh6
 eTB7mR7xBcVxnomxWwJI4B0wuMwCPdgbV6YDUKCuSgRMUEiVry10xd9KLypR9Vfyn1AhROrq
 AubRPVeJBf9zR5UW1trJNfwVt3XmbHX50HCcHdEdCKiT9O+FiEcahIaWh9lihvO0ci0TtVGZ
 MCEtaCE80Q3Ma9RdHYB3uVF930jwquplFLNF+IBCn5JRzsFNBFVDXDQBEADNkrQYSREUL4D3
 Gws46JEoZ9HEQOKtkrwjrzlw/tCmqVzERRPvz2Xg8n7+HRCrgqnodIYoUh5WsU84N03KlLue
 MNsWLJBvBaubYN4JuJIdRr4dS4oyF1/fQAQPHh8Thpiz0SAZFx6iWKB7Qrz3OrGCjTPcW6ei
 OMheesVS5hxietSmlin+SilmIAPZHx7n242u6kdHOh+/SyLImKn/dh9RzatVpUKbv34eP1wA
 GldWsRxbf3WP9pFNObSzI/Bo3kA89Xx2rO2roC+Gq4LeHvo7ptzcLcrqaHUAcZ3CgFG88CnA
 6z6lBZn0WyewEcPOPdcUB2Q7D/NiUY+HDiV99rAYPJztjeTrBSTnHeSBPb+qn5ZZGQwIdUW9
 YegxWKvXXHTwB5eMzo/RB6vffwqcnHDoe0q7VgzRRZJwpi6aMIXLfeWZ5Wrwaw2zldFuO4Dt
 91pFzBSOIpeMtfgb/Pfe/a1WJ/GgaIRIBE+NUqckM+3zJHGmVPqJP/h2Iwv6nw8U+7Yyl6gU
 BLHFTg2hYnLFJI4Xjg+AX1hHFVKmvl3VBHIsBv0oDcsQWXqY+NaFahT0lRPjYtrTa1v3tem/
 JoFzZ4B0p27K+qQCF2R96hVvuEyjzBmdq2esyE6zIqftdo4MOJho8uctOiWbwNNq2U9pPWmu
 4vXVFBYIGmpyNPYzRm0QPwARAQABwsF8BBgBCgAmAhsMFiEEm9B+DgxR+NWWd7dUG5NDfTtB
 YpsFAmA872oFCRRflLYACgkQG5NDfTtBYpvScw/9GrqBrVLuJoJ52qBBKUBDo4E+5fU1bjt0
 Gv0nh/hNJuecuRY6aemU6HOPNc2t8QHMSvwbSF+Vp9ZkOvrM36yUOufctoqON+wXrliEY0J4
 ksR89ZILRRAold9Mh0YDqEJc1HmuxYLJ7lnbLYH1oui8bLbMBM8S2Uo9RKqV2GROLi44enVt
 vdrDvo+CxKj2K+d4cleCNiz5qbTxPUW/cgkwG0lJc4I4sso7l4XMDKn95c7JtNsuzqKvhEVS
 oic5by3fbUnuI0cemeizF4QdtX2uQxrP7RwHFBd+YUia7zCcz0//rv6FZmAxWZGy5arNl6Vm
 lQqNo7/Poh8WWfRS+xegBxc6hBXahpyUKphAKYkah+m+I0QToCfnGKnPqyYIMDEHCS/RfqA5
 t8F+O56+oyLBAeWX7XcmyM6TGeVfb+OZVMJnZzK0s2VYAuI0Rl87FBFYgULdgqKV7R7WHzwD
 uZwJCLykjad45hsWcOGk3OcaAGQS6NDlfhM6O9aYNwGL6tGt/6BkRikNOs7VDEa4/HlbaSJo
 7FgndGw1kWmkeL6oQh7wBvYll2buKod4qYntmNKEicoHGU+x91Gcan8mCoqhJkbqrL7+nXG2
 5Q/GS5M9RFWS+nYyJh+c3OcfKqVcZQNANItt7+ULzdNJuhvTRRdC3g9hmCEuNSr+CLMdnRBY fv0=
In-Reply-To: <20240712170640.3635096-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/07/2024 19:06, Frank Li wrote:
> From: Carlos Song <carlos.song@nxp.com>
> 
> Add header file for generic I3C flags to avoid hard code in dts file.
> 
> Signed-off-by: Carlos Song <carlos.song@nxp.com>
> Reviewed-by: Frank Li <frank.li@nxp.com>
> Acked-by: Jason Liu <jason.hui.liu@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  Documentation/devicetree/bindings/i3c/i3c.yaml |  5 ++++-
>  MAINTAINERS                                    |  1 +
>  include/dt-bindings/i3c/i3c.h                  | 16 ++++++++++++++++
>  3 files changed, 21 insertions(+), 1 deletion(-)
>  create mode 100644 include/dt-bindings/i3c/i3c.h
> 
> diff --git a/Documentation/devicetree/bindings/i3c/i3c.yaml b/Documentation/devicetree/bindings/i3c/i3c.yaml
> index 113957ebe9f1d..90f3610725185 100644
> --- a/Documentation/devicetree/bindings/i3c/i3c.yaml
> +++ b/Documentation/devicetree/bindings/i3c/i3c.yaml
> @@ -91,6 +91,7 @@ patternProperties:
>                - const: 0
>                - description: |
>                    Shall encode the I3C LVR (Legacy Virtual Register):
> +                  See dt-bindings/i3c/i3c.h

Use full paths.

>                      bit[31:8]: unused/ignored
>                      bit[7:5]: I2C device index. Possible values:
>                        * 0: I2C device has a 50 ns spike filter
> @@ -153,6 +154,8 @@ additionalProperties: true
>  
>  examples:
>    - |
> +    #include <dt-bindings/i3c/i3c.h>
> +
>      i3c@d040000 {
>          compatible = "cdns,i3c-master";
>          clocks = <&coreclock>, <&i3csysclock>;
> @@ -166,7 +169,7 @@ examples:
>          /* I2C device. */
>          eeprom@57 {
>              compatible = "atmel,24c01";
> -            reg = <0x57 0x0 0x10>;
> +            reg = <0x57 0x0 (I2C_FM | I2C_FILTER)>;
>              pagesize = <0x8>;
>          };
>  
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3c4fdf74a3f9d..f0ce22e04d467 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10479,6 +10479,7 @@ F:	Documentation/ABI/testing/sysfs-bus-i3c
>  F:	Documentation/devicetree/bindings/i3c/
>  F:	Documentation/driver-api/i3c
>  F:	drivers/i3c/
> +F:	include/dt-bindings/i3c/
>  F:	include/linux/i3c/
>  
>  IBM Operation Panel Input Driver
> diff --git a/include/dt-bindings/i3c/i3c.h b/include/dt-bindings/i3c/i3c.h
> new file mode 100644
> index 0000000000000..2513947e70cd2
> --- /dev/null
> +++ b/include/dt-bindings/i3c/i3c.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0-only OR MIT */

Do not introduce new license, even if it is compatible.
s/MIT/BSD-2-Clause/ - see binding and checkpatch.


Best regards,
Krzysztof


