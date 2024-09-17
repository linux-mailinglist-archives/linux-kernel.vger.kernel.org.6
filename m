Return-Path: <linux-kernel+bounces-331970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6025A97B37F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 19:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7A36B2ADC6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 17:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF0218800E;
	Tue, 17 Sep 2024 17:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GG3mX/0j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CA5187FFC;
	Tue, 17 Sep 2024 17:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726593434; cv=none; b=M4Io/3Ez8FBaFZ8sqatidKBv5wvQnXPgv0p7BHdEaQT8kCjvgunR9eRifLcqXPUWUM6aaBLS5OCJhl8N3/XpXCOHroe73+dVovsNmtGH0lHuvlfbfPjvjMitS/rdjV0+f4ziJUCHttoJ6uFOFlvbH7zHuj+N6WiY2kTD68mtmJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726593434; c=relaxed/simple;
	bh=fmDfbRwe9CfPOnof2be3cKpz85D/y4WnwkurNAiLbwE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MaOa4K8cRuqIyX+oeK+RPb+ytTjwU5uzqQ4chBgC1mu4N631apzhdIrUm9rLmPkLXLRi6ZqaikKmEdTt356U/9VkTscUr5KtGF0Ipv7H/Kzl7kmh1EUoM2R8BD4j37PIlGYfK8IZLNco2PrttYYWFwX2VYT/ed0oje555E+P7ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GG3mX/0j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 436E1C4CEC5;
	Tue, 17 Sep 2024 17:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726593433;
	bh=fmDfbRwe9CfPOnof2be3cKpz85D/y4WnwkurNAiLbwE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GG3mX/0jkn+pYcBuZvD35KENr2LMZNwW6DjalirywwLWNWOm/6dmR0O60nEAhyob2
	 IZQO6eZWJa9zerY+EX0jQnlBUcz0tKYU1iBCC4cfT4GcC4INugvtSh9YukbkByOXjM
	 elcgLZh3F71AJptTtzGY82cOkckjoQLEduDS3SGHuZTxCHcqb1zb8Kmlxn8jc2KEAo
	 G+MCGDVaSrtiNK2xAQM/v8Iibcn+gFUEVlaYfjAC6XRrvt+uXPvHZOdCEivmiq66za
	 0oznR3Gp6zb/uIJ95DRjRu6j+JxfUD1V4oYk18E4SiZ+xsrejlu3jrAB+0//BvSDlJ
	 EkFDDs/wWv4xA==
Message-ID: <e0db2f62-b2fd-4b61-932c-cc2caf5dd647@kernel.org>
Date: Tue, 17 Sep 2024 19:17:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] dt-bindings: mtd: spi-nor: add OTP parameters
To: Erez <erezgeva2@gmail.com>
Cc: Erez Geva <erezgeva@nwtime.org>, linux-mtd@lists.infradead.org,
 Tudor Ambarus <tudor.ambarus@linaro.org>,
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>,
 linux-kernel@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Esben Haabendal <esben@geanix.com>
References: <20240917094956.437078-1-erezgeva@nwtime.org>
 <20240917094956.437078-4-erezgeva@nwtime.org>
 <9c273945-5a70-408e-a9da-a0797aa6d935@kernel.org>
 <CANeKEMN+ZUAGKGsqnaToDB3AxX9NN_JeCBWHwd-wwnTWLU3R+g@mail.gmail.com>
 <64ef46b1-7908-4b15-866d-9cabe2e5dc9e@kernel.org>
 <CANeKEMPwgtECfksgz6jXkR+bjVFwCB9DOh1q7t_3WeojReqxbA@mail.gmail.com>
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
In-Reply-To: <CANeKEMPwgtECfksgz6jXkR+bjVFwCB9DOh1q7t_3WeojReqxbA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/09/2024 19:11, Erez wrote:
> On Tue, 17 Sept 2024 at 19:00, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>
>> On 17/09/2024 12:42, Erez wrote:
>>> On Tue, 17 Sept 2024 at 12:36, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>>>
>>>> On 17/09/2024 11:49, Erez Geva wrote:
>>>>> From: Erez Geva <ErezGeva2@gmail.com>
>>>>>
>>>>> Some flash devices need OTP parameters in device tree.
>>>>> As we can not deduce the parameters based on JEDEC ID or SFDP.
>>>>>
>>>>> Signed-off-by: Erez Geva <ErezGeva2@gmail.com>
>>>>> ---
>>>>>  .../bindings/mtd/jedec,spi-nor.yaml           | 37 +++++++++++++++++++
>>>>>  1 file changed, 37 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
>>>>> index 6e3afb42926e..d502b7fab2ce 100644
>>>>> --- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
>>>>> +++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
>>>>> @@ -90,6 +90,43 @@ properties:
>>>>>        the SRWD bit while writing the status register. WP# signal hard strapped to GND
>>>>>        can be a valid use case.
>>>>>
>>>>> +  opt_n_regions:
>>>>
>>>> No underscores, but hyphens.
>>>
>>> I'll fix this.
>>>
>>>>
>>>>> +    type: u32
>>>>
>>>> It does not look like you tested the bindings, at least after quick
>>>> look. Please run `make dt_binding_check` (see
>>>
>>> I run "make dt_binding_check" on kernel 6.6.
>>
>> Yeah, we are no on kernel 6.6. You can run it also on kernel v4.1 -
>> still does not matter.
>>
>> Don't develop on ancient code because then you ask us to review same
>> broken stuff we already fixed.
> 
> I test with Beaglebone black for testing, it is difficult to run the
> last vanille version.
> I did backport the spi-nor driver.
> As for "make dt_binding_check" on last kernel, it need to upgrade the tools,
>  and I did not think it could change that much.
> 

Well, it is possible to build kernel on small embedded board, but that's
quite cumbersone, slow and inefficient, considering that it's just
easier to cross compile. But anyway, binding check does not even need
cross compilation.

Sorry, the code is obviously wrong, there is no such thing as u32, so
you did not test it. I provided link which explains how to test it. You
must do it on latest mainline kernel. Just like you must develop and
generate patches on latest mainline kernel, because this is where we
apply the patches. We do not apply them to v6.6.

Best regards,
Krzysztof


