Return-Path: <linux-kernel+bounces-349067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A3E98F057
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 15:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C41A5282904
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 13:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F0719B3EC;
	Thu,  3 Oct 2024 13:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RNQ1Ex1N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCF8145B1F;
	Thu,  3 Oct 2024 13:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727962001; cv=none; b=FAHxL+eWg7OlCF27qQ/8Gf/p8FCBLhQbYgDYczIHlahr53Mc6DCPZiUsNVY7NaV0Pg5IVzlNK7nRfgpw4TUCR9lV3SXPJFMoV0mfgqoSoPVYd3OJVf9pwrN74fg0oqVooGM5NNR03JMfTLlZDs3l1QdjUpv/z4RfUGTfdBby+4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727962001; c=relaxed/simple;
	bh=4teILCpG7nVKauGfczDrS3CuU7P1Mr3FJftqso6wKZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fRUlxj48JsdaFaaWGIA3V3Ub0PvVRsPWSadeBy5jrAOJdNGK4lgnGDyvy/Nrrjc4me+1VqMJBHQ0F1wJ9eo82vOpWaGQWFL88mSL33Skhu4yf3AjSBxqGXc0aGhNB5MNiMJd8sexPkNADg71pxYpLu1NHhoShj2yYQmwctTReMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RNQ1Ex1N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C4B9C4CEC5;
	Thu,  3 Oct 2024 13:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727962000;
	bh=4teILCpG7nVKauGfczDrS3CuU7P1Mr3FJftqso6wKZ8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RNQ1Ex1NthJJkR0uKRzC360vI7m29LF5rzT1fbDMbceYF1BcaU1clgeUkwlWCmFZA
	 KEOZWRRXjYdsY1fnuJBbj9Ts7qeKFiVOgWvvX4j6y+3M33GoWaD+AMPDLH7LD7X+15
	 QZHjm99J+q3LwuEDu0l6QtuH80mQTLy1gQKsj/XhwYp0/rkxRz5H5sRJ054fnKymZ0
	 R0YbSdR4OMpLaHz6IzphVxjb3FEKRiQqkDWApG24oWoudG1iMuO8kyW8Icg6gtDu2O
	 RAzTheRVRB4bBITaggv/a9NNAwF6RJMpLYOhS1CFZAov7rHZhvtQnZZXnnnTYu+1Il
	 t86BfUPt4Akrg==
Message-ID: <ca913f6a-c028-456d-9f9f-0c3183d8a921@kernel.org>
Date: Thu, 3 Oct 2024 15:26:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dt-bindings: display: bridge: sil,sii9022: Add
 data-lines
To: Wadim Egorov <w.egorov@phytec.de>, andrzej.hajda@intel.com,
 neil.armstrong@linaro.org, rfoss@kernel.org
Cc: Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, bbrezillon@kernel.org, conor+dt@kernel.org,
 krzk+dt@kernel.org, robh@kernel.org, upstream@lists.phytec.de
References: <20241003082006.2728617-1-w.egorov@phytec.de>
 <20241003082006.2728617-2-w.egorov@phytec.de>
 <fbb7d268-76f9-4d2e-9168-c927ccfdac50@kernel.org>
 <d28be8e9-b235-43e0-aaed-dd65a87c5797@phytec.de>
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
In-Reply-To: <d28be8e9-b235-43e0-aaed-dd65a87c5797@phytec.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/10/2024 13:56, Wadim Egorov wrote:
> 
> 
> Am 03.10.24 um 12:03 schrieb Krzysztof Kozlowski:
>> On 03/10/2024 10:20, Wadim Egorov wrote:
>>> The SI9022 HDMI transmitter can be configured with 16, 18, or 24 input
>>> data lines. This commit introduces the data-lines property to the input
>>
>> lines? lanes? What are lines? like pins?
> 
> Yes, "lines" in this context refers to the number of pins used for the 
> input pixel data bus, which can support 16, 18, or 24-bit wide data 
> buses. These are parallel data lines (or pins) that carry uncompressed 
> digital video to the HDMI transmitter.
> 
>>
>>> endpoint, specifying the number of parallel RGB input pins connected
>>> to the transmitter.
>>>
>>> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
>>> ---
>>>   .../bindings/display/bridge/sil,sii9022.yaml        | 13 ++++++++++++-
>>>   1 file changed, 12 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/display/bridge/sil,sii9022.yaml b/Documentation/devicetree/bindings/display/bridge/sil,sii9022.yaml
>>> index 5a69547ad3d7..24306f8eb107 100644
>>> --- a/Documentation/devicetree/bindings/display/bridge/sil,sii9022.yaml
>>> +++ b/Documentation/devicetree/bindings/display/bridge/sil,sii9022.yaml
>>> @@ -81,9 +81,20 @@ properties:
>>>   
>>>       properties:
>>>         port@0:
>>> -        $ref: /schemas/graph.yaml#/properties/port
>>> +        unevaluatedProperties: false
>>> +        $ref: /schemas/graph.yaml#/$defs/port-base
>>>           description: Parallel RGB input port
>>>   
>>> +        properties:
>>> +          endpoint:
>>> +            $ref: /schemas/graph.yaml#/$defs/endpoint-base
>>> +            unevaluatedProperties: false
>>> +
>>> +            properties:
>>> +              data-lines:
>>
>> No, this will confuse everyone. Considering lack of description how
>> anyone would figure out what this means?
> 
> I guess from working with the hardware/reference manual and using this chip?
> 
> I don't think it is overly confusing, especially since the port is 
> already described as the "Parallel RGB input port" which clearly implies 
> the use of pins for data transmission.


I am surprised you do not find data-lanes and data-lines confusing. For
non-native English speakers this even might sound the same.

You used earlier pins and bits, so maybe it's the same as bus-width,
which is already used all over the bindings, including one of the bridges.

Anyway a generic property should go to video-interfaces.

> 
> I am open to other suggestions if you believe a different name would 
> improve clarity.
> 
> Btw, bridge/toshiba,tc358768.yaml, which performs a similar function, 
> also uses the term data-lines.

Then this has to go to common schema.

Oh, wait, video-interfaces already have it!

Best regards,
Krzysztof


