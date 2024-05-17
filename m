Return-Path: <linux-kernel+bounces-181908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FFD78C8329
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 11:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 582D4281599
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 09:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745C520313;
	Fri, 17 May 2024 09:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aWVriPPJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1661DDDB;
	Fri, 17 May 2024 09:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715937465; cv=none; b=FFNCQ3fUz2FeThHRFhwzvKxYnavoBsUzYW48TiQPq91hsY21stP32EFI1DZ9Bv9z5nP9zoFCkdGbqZfZv0uiegOE/ec5xxO1u9FTQGdw/vcwkZNk10kIkqJR/A+V7Rd9KS6FRSJiSAcpXr5I69/6mO+f1hRAzQ4v4l9Txr6P4iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715937465; c=relaxed/simple;
	bh=PH0+m7B2XUeSInY+T38VdjzfDLnpX53dQVeTatGhnRg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o2IXKfr4gmHi6WaXl48UCmIhlVZte6rLjeOoXhVg1eU3VCjeMBaIYRjHRN5J0Wc5guOK/EUG5SD/VRW84REpnscXRpMBwXDA/YIGn31bKZKhOSKWYkkPfr+1LI46p4/l1tGrLnX4gGs8A+FLTMbcs20kCSxcViswzc2yWD+iTLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aWVriPPJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B1A6C2BD10;
	Fri, 17 May 2024 09:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715937465;
	bh=PH0+m7B2XUeSInY+T38VdjzfDLnpX53dQVeTatGhnRg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aWVriPPJ57nLu5vE4RIQhh8UV+H+XWuOocJwj/lLqfmnuAhMHVuf7jDFyNrRA/SFS
	 kXm20A9srgZJPNJQ7hfxyawegGrmGHP+GxDOclm0ATHguTlqwEg5e52B+ttEzdKmns
	 1t8PTDc6zgzDw/lQB+F3CgVdDf0YwnUSNCfEVyfSkQtCY5gU4LhvoijivFL7xYemtP
	 Gbfh4o9jT+zg8qUCCFLOuU01ZFm4zsZ1lB73rc8ftvZf1HS0oOzZOBR5pkg0h6thmz
	 1InAjQg4onWLAoKDqKzka+XjwDPLGZn2OoaWsZVstd4P9RY7ypsS4Td4lepmQsfXqF
	 yTjYFtH2voiGA==
Message-ID: <d570bf46-f3a3-4a01-b554-1c1c76b55e16@kernel.org>
Date: Fri, 17 May 2024 11:17:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/9] dt-bindings: fsi: Document the FSI controller
 common properties
To: Eddie James <eajames@linux.ibm.com>, linux-fsi@lists.ozlabs.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, robh@kernel.org, joel@jms.id.au,
 andrew@codeconstruct.com.au
References: <20240514195435.155372-1-eajames@linux.ibm.com>
 <20240514195435.155372-6-eajames@linux.ibm.com>
 <9200e46a-3cb5-4363-a560-ee3d88e05ced@kernel.org>
 <a219f01e-a856-46cb-83c4-4fde99b8addd@linux.ibm.com>
 <eb6e2b5b-f341-404b-9215-6e80f21a6842@kernel.org>
 <80713a00-9574-4ae0-8af7-3fe12affcfc1@linux.ibm.com>
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
In-Reply-To: <80713a00-9574-4ae0-8af7-3fe12affcfc1@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/05/2024 17:02, Eddie James wrote:
> 
> On 5/15/24 09:35, Krzysztof Kozlowski wrote:
>> On 15/05/2024 16:28, Eddie James wrote:
>>> On 5/15/24 09:18, Krzysztof Kozlowski wrote:
>>>> On 14/05/2024 21:54, Eddie James wrote:
>>>>> Since there are multiple FSI controllers documented, the common
>>>>> properties should be documented separately and then referenced
>>>>> from the specific controller documentation.
>>>>>
>>>>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
>>>>> ---
>>>>> Changes since v4:
>>>>>    - Add interrupt controller properties
>>>>>    - Add clock-frequency property to FSI controller and CFAM
>>>>>    - Add detail to chip-id property description
>>>>>
>>>>>    .../bindings/fsi/fsi-controller.yaml          | 66 +++++++++++++++++++
>>>>>    1 file changed, 66 insertions(+)
>>>>>    create mode 100644 Documentation/devicetree/bindings/fsi/fsi-controller.yaml
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/fsi/fsi-controller.yaml b/Documentation/devicetree/bindings/fsi/fsi-controller.yaml
>>>>> new file mode 100644
>>>>> index 0000000000000..8620e4da6de77
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/fsi/fsi-controller.yaml
>>>>> @@ -0,0 +1,66 @@
>>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>>> +%YAML 1.2
>>>>> +---
>>>>> +$id: http://devicetree.org/schemas/fsi/fsi-controller.yaml#
>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>> +
>>>>> +title: FSI Controller Common Properties
>>>>> +
>>>>> +maintainers:
>>>>> +  - Eddie James <eajames@linux.ibm.com>
>>>>> +
>>>>> +description:
>>>>> +  FSI (FRU (Field Replaceable Unit) Service Interface) is a two wire bus. The
>>>>> +  FSI bus is connected to a CFAM (Common FRU Access Macro) which contains
>>>>> +  various engines such as I2C controllers, SPI controllers, etc.
>>>>> +
>>>>> +properties:
>>>>> +  "#address-cells":
>>>>> +    const: 2
>>>>> +
>>>>> +  "#size-cells":
>>>>> +    const: 0
>>>>> +
>>>>> +  '#interrupt-cells':
>>>>> +    const: 1
>>>>> +
>>>>> +  clock-frequency:
>>>>> +    minimum: 1
>>>>> +    maximum: 200000000
>>>> This is a deprecated property in general. Why did it appear? It does not
>>>> exist in current bindings and nothing in commit msg suggests changes in
>>>> the bindings themselves.
>>>
>>> OK, is there some document that describes what properties are
>>> deprecated? Because it's used all over the place in the bindings. Anyway
>> dtschema: dtschema/schemas/clock/clock.yaml
>>
>> buses anyway should use bus-frequency but it is also legacy one.
>>
>>> I need this property, I can rename it if you like. I can also update the
>> Why do you need it? Why clocks cannot be chosen by drivers and initial
>> state selected by assigned-clock-rates?
> 
> 
> Well, I could use assigned-clock-rates, though it seems like I'd then 
> have to implement the clock provider framework for both the FSI 
> controller driver and the CFAM driver, which is a lot of extra work. FSI 
> controller isn't really a clock provider, it's a bus like i2c (which 
> uses clock-frequency), so it doesn't quite fit in my opinion...

OK, it's fine in such case.

Best regards,
Krzysztof


