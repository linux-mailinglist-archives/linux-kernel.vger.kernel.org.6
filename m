Return-Path: <linux-kernel+bounces-342476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EBC4988F7D
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 15:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 817941C20E4B
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 13:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13BE1885B7;
	Sat, 28 Sep 2024 13:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jjugqKHr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDAF125DE;
	Sat, 28 Sep 2024 13:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727531155; cv=none; b=usgvp8GRR0g4v6TMCa9AOiFI9dFU/qUfCx+enMAHazZUmhijVu4mTpCw6GpZdviaO0sFJV6zc6xrhgLvemO1hJc2esriwygjwOfYpBnZtUPW1FD/ea46R7MhlgkslMLOieQOBfzebJHu2hQ3E+3AYghQnjJLV5V3YPuJRJAhWNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727531155; c=relaxed/simple;
	bh=Em0L9ku5aG9RNOTHFg9WI2703n/XMa40ZjERGqjIMys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=my4qyR9cDMNTypiIK5K63nUjAtvzVJl8/r73R+ElJGXmfbD3nLGbLCjvHJ4L3aEwbb2tzkbQwo8JvG4VVM6Z4+XSBAvhP40vGXPiJ1AQZ5SQVg93E7EotUWtgnoHyTCSQIsvUhBJCH0+NL76jtN7v3xtYmq6HQldR66bpn56szA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jjugqKHr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9470FC4CEC3;
	Sat, 28 Sep 2024 13:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727531154;
	bh=Em0L9ku5aG9RNOTHFg9WI2703n/XMa40ZjERGqjIMys=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jjugqKHrIv3vNaDuhfHJ1jxkwavZfKlmJCtAseRoK1162VHFQERDhTi0E37QmTb+J
	 gzjDRq6hT4HUMXvV+MUE5JUw+Mi2i+eFGPvl2h822iTkbkRe42cYejCSYvMidto82G
	 OtchMtSO7HMIBa6b+2bMLKo4byvZ5SwsI92V2UvZY2U4jsNU9UfDwfkfHClMPLXzKH
	 QtMd8kf/i+aGbLBXhbo/NkY24Bt/Bn4TfqBD7YDN788jxsNPZKqgsT/WJGzoePAu8g
	 chZgKbr6FwcZ07ExusgJ3+TUPwQ3xg+/fSiW5/Pp4pPPgayJgmoCQlgLyPzOrt1X+Y
	 uyCVg43JL+3Qg==
Message-ID: <18e9d774-813b-427e-9938-53853d695e18@kernel.org>
Date: Sat, 28 Sep 2024 15:45:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/2] dt-bindings: mtd: ubi-volume: add
 'volume-is-critical' property
To: Daniel Golle <daniel@makrotopia.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Zhihao Cheng <chengzhihao1@huawei.com>,
 John Crispin <john@phrozen.org>, linux-mtd@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <e0936674dd1d6c98322e35831b8f0538a5cfa7a3.1727527457.git.daniel@makrotopia.org>
 <7a2e8819-ac70-4070-a731-53994c72cd79@kernel.org>
 <Zvf_84xxhxwpPgee@makrotopia.org>
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
In-Reply-To: <Zvf_84xxhxwpPgee@makrotopia.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/09/2024 15:09, Daniel Golle wrote:
> On Sat, Sep 28, 2024 at 03:02:47PM +0200, Krzysztof Kozlowski wrote:
>> On 28/09/2024 14:47, Daniel Golle wrote:
>>> Add the 'volume-is-critical' boolean property which marks a UBI volume
>>> as critical for the device to boot. If set it prevents the user from
>>> all kinds of write access to the volume as well as from renaming it or
>>> detaching the UBI device it is located on.
>>>
>>> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
>>> ---
>>>  .../devicetree/bindings/mtd/partitions/ubi-volume.yaml   | 9 +++++++++
>>>  1 file changed, 9 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/mtd/partitions/ubi-volume.yaml b/Documentation/devicetree/bindings/mtd/partitions/ubi-volume.yaml
>>> index 19736b26056b..2bd751bb7f9e 100644
>>> --- a/Documentation/devicetree/bindings/mtd/partitions/ubi-volume.yaml
>>> +++ b/Documentation/devicetree/bindings/mtd/partitions/ubi-volume.yaml
>>> @@ -29,6 +29,15 @@ properties:
>>>      description:
>>>        This container may reference an NVMEM layout parser.
>>>  
>>> +  volume-is-critical:
>>> +    description: This parameter, if present, indicates that the UBI volume
>>> +      contains early-boot firmware images or data which should not be clobbered.
>>> +      If set, it prevents the user from renaming the volume, writing to it or
>>> +      making any changes affecting it, as well as detaching the UBI device it is
>>> +      located on, so direct access to the underlying MTD device is prevented as
>>> +      well.
>>> +    type: boolean
>>
>> UBI volumes are mapping to partitions 1-to-1, right? So rather I would
>> propose to use partition.yaml - we already have read-only there with
>> very similar description.
> 
> No, that's not the case.
> 
> An MTD partition can be used as UBI device. A UBI device (and hence MTD
> partition) can host *several* UBI volumes.
> 
> Marking the MTD partition as 'read-only' won't work, as UBI needs
> read-write access to perform bad block relocation, scrubbing, ...

OK, so not partition but read-only volume.

> 
> Also, typically not all UBI volumes on a UBI device are
> read-only/critical but only a subset of them.
> 
> But you are right that the description is inspired by the description
> of the 'read-only' property in partition.yaml ;)
> 
> I initially thought to also name the property 'read-only', just like
> for MTD partitions. However, as the desired effect goes beyond
> preventing write access to the volume itself, I thought it'd be
> better to use a new name.

Yeah, maybe... critical indeed covers multiple cases but is also
subjective. For some bootloader is critical, for other bootloader still
might be fully A/B updateable thus could be modifiable. For others, they
want to use fw_setenv from user-space so not critical at all.

I am in general not so happy in describing flash layout in DT, because
it sounds way too policy or one-use-case specific.

UBI volume is purely SW construct. One OS can partition MTD in multiple
ways, so maybe I just do not understand why we have in the first place.

Best regards,
Krzysztof


