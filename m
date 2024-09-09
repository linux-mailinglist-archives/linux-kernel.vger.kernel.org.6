Return-Path: <linux-kernel+bounces-320931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE831971232
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 10:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DC3D1F22ACD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 08:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1D71B14E6;
	Mon,  9 Sep 2024 08:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pcq6KMKL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCFE175D25;
	Mon,  9 Sep 2024 08:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725870923; cv=none; b=fN/YhB5HpGcVpU/URsUeXv4SmMs3hqX0Q836mqRbskZCOeaUg0lSBqMjMgoK0d4rmJILQGiRPqpLjTEZt0UE4yEBUA4jYTpjPQHlwYW9LnvJ+yTM/5vrawH8WbM26Ub2ZBCPgyu9KWvTw2C0oDwGEt5a/rN+SgevQuSH4OX6Rk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725870923; c=relaxed/simple;
	bh=iA+YHcOyAEOpIaqYSrEmrjVp8ayS0K19IhlgGFFnhuk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eA91k0jcWZlJSFmXOHtpZwVQM6VQqRmd07YTt419VK1ReUyahUybH+GNPpC9qwub994LeFp/Ybs+4FI+bkPzN4omJ7x5StpVrHGgIcbxqGJDQmO4FNZQri2Y+1CnvvvNy4WVty7IKYFIg113NyZa0A57qml9TTRIc9uqGwdrk+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pcq6KMKL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8F3DC4CEC5;
	Mon,  9 Sep 2024 08:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725870922;
	bh=iA+YHcOyAEOpIaqYSrEmrjVp8ayS0K19IhlgGFFnhuk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pcq6KMKLQK8/otMAhzdrOhAKI+kCLa+bXVauYjHmXaMwaa/qKMnx4Gi2SfQwO0vlY
	 xlSJjm8JqoP1yvu+kVEDXiAUivWb42Z/2JGdfOzomxHL2N8y9ykxLhU/IK/0vWPVtg
	 4nrY0NmXVcK36yx3ZPl7jgs0ArbXsoj7iv1zTTXEf8+k13ITgaxnNj096jmLuDGvS+
	 Y6sgbCWh2ayg1uZrGIMOErqz3tiwxndlDAj1vQjgKY/uTPcqBEyzpKNhqUDi8pnr4t
	 aApU4sorD2mSGJlkAuo/VaqKlE2WJGWW0wYlM5piWV/uW7zdqIlhfEIOKEo1EDINKL
	 MNuOQ3j+oUSyg==
Message-ID: <ee4d4375-873b-4b9c-b694-f0191e5c2c54@kernel.org>
Date: Mon, 9 Sep 2024 10:35:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] dt-bindings: phy: sparx5: document lan969x in sparx5
 dt-bindings
To: Daniel Machon <daniel.machon@microchip.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>, Lars Povlsen <lars.povlsen@microchip.com>,
 Steen Hegelund <Steen.Hegelund@microchip.com>, UNGLinuxDriver@microchip.com,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-phy@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240906-sparx5-lan969x-serdes-driver-v1-0-8d630614c58a@microchip.com>
 <20240906-sparx5-lan969x-serdes-driver-v1-8-8d630614c58a@microchip.com>
 <c0aa5342-a2af-4ac4-bc33-b6dbfff77f63@kernel.org>
 <20240909082241.hvw3a7yig3pujrsk@DEN-DL-M70577>
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
In-Reply-To: <20240909082241.hvw3a7yig3pujrsk@DEN-DL-M70577>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/09/2024 10:22, Daniel Machon wrote:
> Hi Krzysztof,
> 
> Thanks your comments.
> 
>> On 06/09/2024 14:52, Daniel Machon wrote:
>>> Document lan969x in the existing Sparx5 dt-bindings.
>>>
>>
>> Say something useful, not copy of subject.
>>
>>> Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
>>
>> A nit, subject: drop second/last, redundant "dt-bindings". The
>> "dt-bindings" prefix is already stating that these are bindings.
>> See also:
>> https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree/bindings/submitting-patches.rst#L18
> 
> Duly noted.
> 
>>
>>
>>> Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
>>> ---
>>>  .../bindings/phy/microchip,sparx5-serdes.yaml          | 18 ++++++++++++++++--
>>>  1 file changed, 16 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/phy/microchip,sparx5-serdes.yaml b/Documentation/devicetree/bindings/phy/microchip,sparx5-serdes.yaml
>>> index bdbdb3bbddbe..1e07a311e8a5 100644
>>> --- a/Documentation/devicetree/bindings/phy/microchip,sparx5-serdes.yaml
>>> +++ b/Documentation/devicetree/bindings/phy/microchip,sparx5-serdes.yaml
>>> @@ -8,6 +8,7 @@ title: Microchip Sparx5 Serdes controller
>>>
>>>  maintainers:
>>>    - Steen Hegelund <steen.hegelund@microchip.com>
>>> +  - Daniel Machon <daniel.machon@microchip.com>
>>>
>>>  description: |
>>>    The Sparx5 SERDES interfaces share the same basic functionality, but
>>> @@ -62,12 +63,17 @@ description: |
>>>    * 10.3125 Gbps (10GBASE-R/10GBASE-KR/USXGMII)
>>>    * 25.78125 Gbps (25GBASE-KR/25GBASE-CR/25GBASE-SR/25GBASE-LR/25GBASE-ER)
>>>
>>> +  lan969x has ten SERDES10G interfaces that share the same features, operating
>>> +  modes and data rates as the equivalent Sparx5 SERDES10G interfaces.
>>> +
>>>  properties:
>>>    $nodename:
>>>      pattern: "^serdes@[0-9a-f]+$"
>>>
>>>    compatible:
>>> -    const: microchip,sparx5-serdes
>>> +    enum:
>>> +      - microchip,sparx5-serdes
>>> +      - microchip,lan969x-serdes
>>
>> It seems there is no lan969x SoC/chip. Are you sure you are using
>> correct naming, matching what kernel is using? Maybe you just sent
>> whatever you had in downstream (hint: that's never a good idea).
> 
> You are right. There is no upstream support for lan969x SoC yet. The
> upstreaming of the lan969x SoC has just begun, and this series is part
> of that upstreaming effort. The lan969x switch driver (not submitted
> yet) will depend on this SERDES driver, however, their functionality is
> really independent of each other. That is why I am also upstreaming the
> SERDES- and switch driver series independent of each other.

That's not exactly my point. Becayse lan969x appears. I claim you use
incorrect name, so are you sure you do not use wildcards?
Best regards,
Krzysztof


