Return-Path: <linux-kernel+bounces-243873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2C0929C05
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 08:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1163B2121B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 06:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4048114287;
	Mon,  8 Jul 2024 06:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EznK2/Nd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA583C0C;
	Mon,  8 Jul 2024 06:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720419381; cv=none; b=PKMXydOEdpVmzNaleCU+jkRu0W6ckW14icQqA303/qR8inz/0OCGkDxukEwYmRCTSnKl805miaiLPhs+1nPQFZ3shgE0Sl87drExdltmdZyNPeIt7tdKzwwmZVvjHJxLR5DlFAI6kKiYLwdCIBd0/fr4h50r73wmIxr2n4Uxcug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720419381; c=relaxed/simple;
	bh=nDJE18CH1b2XqBPQyCOcOyZPkrflQJKDXEmzhbVH/d0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PVPpjL1ianNI4V7cNRKQ1Tnm1zO1ExKyNjKsqQTPCpjfOkaZDeZ8Qu6RVNbAuILNpW98f63b0RpOofFcdwKRmJTRkj6n3kEDNx/+s2o6xrKlD98tr9/QKVFJMH5FN+oTRNEyaaWNPS4PN4sJir2eHov/EYvdoBHcI1aSBITtzDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EznK2/Nd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DBBFC116B1;
	Mon,  8 Jul 2024 06:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720419380;
	bh=nDJE18CH1b2XqBPQyCOcOyZPkrflQJKDXEmzhbVH/d0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EznK2/Nd6OwMmaJ6awGlqGtUBD1CFQ4THI0QacinMh1DrN0C4KAP651dhbIFtaeMV
	 yP2Ek2X8MszbHtltYQA9p+KKBr9W/+zDm4HzPVYHdpSPkZemT0AGmX1lRF8ra4iJ06
	 eve73KWFK8hqxxsb661+fH542zTFyOMkIjjWDkRZibDM6/QERJm6DnlMhfzqmj0zLF
	 iuKc8rXpA32NniMgS01CUpkUb44kEN3addek9++e1jEvkJbsufETRBsCZTfUF6Ke8d
	 A0IjbUtBGKn9y+VJ8GJBg9NMHlEa0MKi1gXPCB6MN2K767L90+6+OKDGLFQqCnbeMI
	 gbELR/8G+2aBg==
Message-ID: <c7688fba-0570-4dc6-80c4-23cd75ed29aa@kernel.org>
Date: Mon, 8 Jul 2024 08:16:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXT] Re: [PATCH v4 2/5] dt-bindings: arm: fsl: add imx-se-fw
 binding doc
To: Pankaj Gupta <pankaj.gupta@nxp.com>, Jonathan Corbet <corbet@lwn.net>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "imx@lists.linux.dev" <imx@lists.linux.dev>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
References: <20240705-imx-se-if-v4-0-52d000e18a1d@nxp.com>
 <20240705-imx-se-if-v4-2-52d000e18a1d@nxp.com>
 <450d1575-c9b3-413b-bfa9-8dc4352fa263@kernel.org>
 <AM9PR04MB8604B9A9F3D22C35679AD1D195DA2@AM9PR04MB8604.eurprd04.prod.outlook.com>
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
In-Reply-To: <AM9PR04MB8604B9A9F3D22C35679AD1D195DA2@AM9PR04MB8604.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/07/2024 07:50, Pankaj Gupta wrote:
>> Drop redundant/obvious parts.
> Will replace above two description line with the below two.
>       - description: mailbox phandle to send message to se firmware
>       - description: mailbox phandle to receive message from se firmware
> 
>>
>> So two mailboxes?
> Two handles of the same mailbox.
> 
>>
>>> +
>>> +  mbox-names:
>>> +    items:
>>> +      - const: tx
>>> +      - const: rx
>>> +      - const: txdb
>>> +      - const: rxdb
>>
>> 4 mailboxes? This cannot be different.
> mbox-names can have any of the above mentioned 4 values.
> And  two values are minimum, required.

No, I said it cannot be different. If two are minimum, then you can have
here 4, right? But earlier you said you can have only 2. It does not
make any sense.

> 
>>
>>> +    minItems: 2
>>> +
>>> +  memory-region:
>>> +    description: contains the phandle to reserved external memory.
>>
>> Drop
> Will remove the line " description: contains the phandle to reserved external memory."
> 
>>
>>> +    items:
>>> +      - description: It is used by secure-enclave firmware. It is an optional
>>> +          property based on compatible and identifier to communication
>> interface.
>>> +          (see bindings/reserved-memory/reserved-memory.txt)
>>> +
>>> +  sram:
>>> +    description: contains the phandle to sram.
>>
>> Drop
> Will remove " description: contains the phandle to sram."
> 
>>
>>> +    items:
>>> +      - description: Phandle to the device SRAM. It is an optional property
>>> +          based on compatible and identifier to communication interface.
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +  - mboxes
>>> +  - mbox-names
>>> +
>>> +additionalProperties: false
>>
>> Keep it after allOf block
> 
> In V2, it is after allOf block.
> In previous comments, it was commented to place allOf block, after required.
> I am little confused.

So why did you implement it entirely different? Read the comment from
Conor and from me again. I am sorry, but repeating the same three times
(once by Conor, twice by me) is quite a waste of time.

Open example-schema. How is it done there?

Best regards,
Krzysztof


