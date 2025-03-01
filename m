Return-Path: <linux-kernel+bounces-539963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6118FA4AB5A
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 14:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 459DE1897AAD
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 13:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295FB1DED5A;
	Sat,  1 Mar 2025 13:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uqwv1xUJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678932FC23;
	Sat,  1 Mar 2025 13:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740836955; cv=none; b=RlEYVWSJaJYWS6+sMhzKDQzVkm+lLPfXG0FZdOme4/T47744Mu4XJbPYwLmMOnwpQs3PBAPhj3Ey5F/op/FiC7BlO6YGAPLrjBhICfCqVr6nnEFLB2Fl4FtjGX8mI2Dga9ZZ0F+/+hG/1/JcnFnhZW9bOibfqL45e2vlYtMSlBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740836955; c=relaxed/simple;
	bh=+7BkRCaAMc58KXpPqobpivf31lnIl3j+4Emd+l300nk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=olm0/NcixasupP1Qw1ONg6efD2JUGjjpTIkRCvDxX/7npc2f0PPyjwxAnw3QH3NqVrUwHQZacfCMOg7H9ipVx4326keKiK2301uOwj/IdAPYh0m0OmfL+vvIyfyAf2DQZdk0G+8iqi4l95EgwehR+eqSOX0YBzwHP3/LvYcGPuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uqwv1xUJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D19BC4CEDD;
	Sat,  1 Mar 2025 13:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740836954;
	bh=+7BkRCaAMc58KXpPqobpivf31lnIl3j+4Emd+l300nk=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=uqwv1xUJNLzBJ1t/hU5t0tEi03hedao4PSnQpep+U31PEUwmomlVrYQDhxMiQ2IX3
	 aSGYQTc5/kwE874DucxsVcSDX9vnvIa0xsqP7fmhGg1RW6VTSu53LR9OTBOhb763s9
	 xR6dNiFs2skx2Xw+1F9GkAFheG2IwlFr8Y/i9Eya4FO+WbTzsei1/HBEy0LKUGwAOr
	 Js874oreIerHFSk74MTLDXu1I+8l9E4mih8Zyer+MTaJE0mlKSAlCg09H3Oy9xsHr3
	 lrUNxsnZgjUsO+Wq5CpnCoYtLrgZ0wMG+YAdeRUnQk+COyF5aMCBFCQSzl6PDjMpC4
	 FurCXC3Wf+d7w==
Message-ID: <20946ee0-4973-4831-bc77-4d9942f1a348@kernel.org>
Date: Sat, 1 Mar 2025 14:49:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH v3 3/3] arm64: dts: marvell: cp11x: Add
 reset controller node
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wilson Ding <dingwei@marvell.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: "andrew@lunn.ch" <andrew@lunn.ch>,
 "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
 "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
 "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
 <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 Sanghoon Lee <salee@marvell.com>, Geethasowjanya Akula <gakula@marvell.com>
References: <20250227192536.2426490-1-dingwei@marvell.com>
 <20250227192536.2426490-4-dingwei@marvell.com>
 <d085c34a-fdbf-4950-a2e3-b3d25a1c0145@kernel.org>
 <BY3PR18MB46730C150D4CB9619B3B05FBA7CC2@BY3PR18MB4673.namprd18.prod.outlook.com>
 <050ae833-10b5-4d80-9856-8bc2f434a74f@kernel.org>
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
In-Reply-To: <050ae833-10b5-4d80-9856-8bc2f434a74f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/03/2025 14:46, Krzysztof Kozlowski wrote:
>>>> Signed-off-by: Wilson Ding <dingwei@marvell.com>
>>>> ---
>>>>  arch/arm64/boot/dts/marvell/armada-cp11x.dtsi | 8 ++++++++
>>>>  1 file changed, 8 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
>>> b/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
>>>> index 161beec0b6b0..c27058d1534e 100644
>>>> --- a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
>>>> +++ b/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
>>>> @@ -226,6 +226,8 @@ CP11X_LABEL(rtc): rtc@284000 {
>>>>  		CP11X_LABEL(syscon0): system-controller@440000 {
>>>>  			compatible = "syscon", "simple-mfd";
>>>>  			reg = <0x440000 0x2000>;
>>>> +			#address-cells = <1>;
>>>> +			#size-cells = <1>;
>>>>
>>>>  			CP11X_LABEL(clk): clock {
>>>
>>> Wait, no unit address here.
>>
>> This subnode came from the existing code. I didn't touch this subnode
>> in my patch. As you can see, the system-controller has a wide address
>> range, which includes clock, GPIO registers as well as the unit-softreset
>> register.
>>
>>>
>>>>  				compatible = "marvell,cp110-clock";
>>>> @@ -273,6 +275,12 @@ CP11X_LABEL(gpio2): gpio@140 {
>>>>  					 <&CP11X_LABEL(clk) 1 17>;
>>>>  				status = "disabled";
>>>>  			};
>>>> +
>>>> +			CP11X_LABEL(swrst): reset-controller@268 {
>>>
>>>
>>> So why here it appeared? This is wrong and not even necessary. Entire
>>> child should be folded into parent, so finally you will fix the
>>> incomplete parent compatible.
>>
>> We do need the reset-controller as a subnode under system-controller node
>> for the following reasons:
>>
>> - We need to have 'reg' property in this subnode so that we can get the offset
>>   to system-controller register base defined in parent node. This is suggested
>>   by Rob in V2 comments. 
>>   And we need to know the register size to calculate the number of reset lines.
>>   This is suggested by Philipp in V1 comments.
> 
> You do not need and you received that comment as well. It is implied by
> compatible.
> 
>>
>> - We also need to define the 'reset-cells' in this subnode. And the consumer of
>>   the reset controller uses the label of this subnode for the phandle and reset
>>   specifier pair. 
> 
> reset-cells will be in the parent once you fold it.
> 
>>
>> As I mentioned in my reply to the first comment, the reset-controller is not the
>> only device within the system-controller register spaces. Do you still think I
> 
> You provided very little hardware description of the device. So based on
> hardware description you provided: yes.

and to clarify - by device I mean the parent node, the system controller.

Your commit even mentions driver, not the hardware:
"Add device-tree binding documentation for the Armada8K reset driver..."
not hardware, so you will get the review as good as you describe things.

Bindings are about hardware so if you disagree with the review here,
please provide arguments in terms of hardware.

> 
>> should fold it into the parent node. And what I proposed is exactly same as
>> that the armada_thermal driver did (See below). I wonder why what was accepted
>> in the past become not accepted now. 
> 
> We did not discuss here drivers, but if you insist talking about
> "marvell,armada-cp110-thermal" then point me to review or ack from DT
> people. You claim it was accepted so how did we accept it?
> 
> It was 2013 so that's another answer: many things done 12 years ago were
> done not according to best practices. Also best practices evolved.



Best regards,
Krzysztof

