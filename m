Return-Path: <linux-kernel+bounces-222151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 833A890FD69
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 09:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B6202859FA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 07:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB44343AD2;
	Thu, 20 Jun 2024 07:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ID24uu3q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7881639;
	Thu, 20 Jun 2024 07:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718867949; cv=none; b=AHUZldNX1ZTErJF1GsjOB1FQF7t1wyOHrlQX21Yr00Qbnt2CXydO0TxNh2FR+YHuHosMuZLSAPe4Bb2rLeHniyBQEWQcXxcQ2otsVC0s/Iy6BvuIS1MjLA1xbTklZM8xgObf/pSavn0fH+/ja079rpP2eg/KAMkk/0i+hlgC1v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718867949; c=relaxed/simple;
	bh=Zwu60kBBc3ZVuAZKiAWikwgP+Uy2vTXXOt9t/l7FvGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f/3pFjIeUZ/uoUk3lyAzy+P1bv/LOjPkWeMLkmLTyJbwtmEeY4WTmCmcN9k4KYp1TeNC6ZM3CEpNOEpXMzo4IYS/LTXK0ScgzMd6l7IW5DseS1EAqIQIRlFS5TzIOhyXH5FAL3R25qNSbuf5mjuNNL4bYvToOQnfs/KdbHynoqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ID24uu3q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3157BC2BD10;
	Thu, 20 Jun 2024 07:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718867948;
	bh=Zwu60kBBc3ZVuAZKiAWikwgP+Uy2vTXXOt9t/l7FvGs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ID24uu3qUODA/yfK5aAYCBQ0vrbKIrLvvPzXXq8REq/W5F6My6Y+FBd2QbmgwVIzw
	 PYcgG20Uu0R3WWD0mzGNzI+twz15DzSPf+kCLWUqIaTu9i4AQ+aRlOZf+bwpFY/oX8
	 n+ol4CK5osyTsyi89GUvG4wGFy4GS040Oz4/Ko46fT590DxZdcqN1/QR/inc67kSPZ
	 pP/n6POG3Li58uoOEY9f3NejMwQX01UeqxHVhxOB16w+hoiYz/Vqj+neH0yaSuXc1X
	 TlsSUOUm6Kooim16KSQkduLUpx4jD51I+s0cNxDe/zdGAZpEnxjZZtevON/cWUiK6X
	 2O9w9HOMVNbZQ==
Message-ID: <23a3c09d-1cd7-4da4-8d94-6fb3bacc65b7@kernel.org>
Date: Thu, 20 Jun 2024 09:19:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/4] dt-bindings: arm: amlogic:
 amlogic,meson-gx-ao-secure: add secure-monitor property
To: Viacheslav <adeep@lexina.in>, Conor Dooley <conor@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
References: <20240610084032.3096614-1-adeep@lexina.in>
 <20240610084032.3096614-4-adeep@lexina.in>
 <20240610-dropout-compress-6d6a9b749524@spud>
 <4866f6d4-2e3c-40c7-a8cb-ba4e422ffef6@lexina.in>
 <20240611-undying-earthy-00236ac251aa@spud>
 <20240613164244.GA1999034-robh@kernel.org>
 <c0d18fef-be65-461e-948f-c25e757199a5@lexina.in>
 <20240617-sulfate-posture-1619f1cdf090@spud>
 <3e939ec0-f38b-468b-a897-80be207c1bdd@lexina.in>
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
In-Reply-To: <3e939ec0-f38b-468b-a897-80be207c1bdd@lexina.in>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 20/06/2024 09:14, Viacheslav wrote:
> 
> 
> 17/06/2024 19.57, Conor Dooley пишет:
>> On Mon, Jun 17, 2024 at 11:21:30AM +0300, Viacheslav wrote:
>>> Thanks for review.
>>>
>>> 13/06/2024 19.42, Rob Herring wrote:
>>>> On Tue, Jun 11, 2024 at 07:07:28PM +0100, Conor Dooley wrote:
>>>>> On Tue, Jun 11, 2024 at 01:25:11PM +0300, Viacheslav wrote:
>>>>>> Hi!
>>>>>>
>>>>>> 10/06/2024 19.08, Conor Dooley wrote:
>>>>>>> On Mon, Jun 10, 2024 at 11:39:49AM +0300, Viacheslav Bocharov wrote:
>>>>>>>> Add secure-monitor property to schema for meson-gx-socinfo-sm driver.
>>>>>>>
>>>>>>> "bindings are for hardware, not drivers". Why purpose does the "secure
>>>>>>> monitor" serve that the secure firmware needs a reference to it?
>>>>>>
>>>>>> This driver is an extension to the meson-gx-socinfo driver: it supplements
>>>>>> information obtained from the register with information from the
>>>>>> SM_GET_CHIP_ID secure monitor call. Due to the specifics of the module
>>>>>> loading order, we cannot do away with meson-gx-socinfo, as it is used for
>>>>>> platform identification in some drivers. Therefore, the extended information
>>>>>> is formatted as a separate driver, which is loaded after the secure-monitor
>>>>>> driver.
>>>>>
>>>>> Please stop talking about drivers, this is a binding which is about
>>>>> hardware. Please provide, in your next version, a commit message that
>>>>> justifies adding this property without talking about driver probing
>>>>> order etc, and instead focuses on what service the "secure monitor"
>>>>> provides etc.
>>>>
>>>> To put it another way, how many secure monitors does 1 system have?
>>>
>>> One per system in current device tree.
>>
>> One per system, or one is currently described per system, but more might
>> be added later?
> 
> it turns out to be one per system. It's either there or it's not.
> 
>>
>>>> What do you do if the property is not present? You didn't make it
>>>> required which is good because that would be an ABI break.
>>>
>>> We need an indication of the ability to use the secure-monitor to obtain
>>> additional information within the soc driver. It seemed to me that using an
>>> explicit reference to the secure-monitor is the best choice.
>>>
>>>>
>>>> You only need a link in DT if there are different possible providers or
>>>> some per consumer information to describe (e.g. an interrupt number or
>>>> clock ID). You don't have the latter and likely there is only 1 possible
>>>> provider.
>>>
>>> Would replacing the reference to sm with an option, for example,
>>> use-secure-monitor = <1>; look more appropriate in this case?
>>
>> Perhaps a silly question, but (provided there's only one per system, why
>> can't the secure-monitor driver expose a function that you can call to get
>> a reference to the system-monitor? I did something similar before with
>> a call to in mpfs_sys_controller_get() mpfs_rng_probe(). Granted,
>> mpfs-rng is probed from software so it's slightly different to your
>> case, but the principle is the same and it's not unheard of for code in
>> drivers/soc to expose interfaces to other drivers like this. You can
>> just call a function like that, and know whether there's a secure
>> monitor, without having to retrofit a DT property.
> 
> That could be an option. But again, nothing prevents me from searching 
> for the secure-monitor node throughout the entire DT array.
> 
> The question is more about something else, let me try to explain from 
> the beginning:
> 
> We currently have a soc driver that uses only the register to get basic 
> information and it must be loaded early because other modules' behavior 
> depends on its information.

Please provide name/link to the upstream source code (downstream does
not matter).

> There is an option to supplement the register information with 
> information from the secure-monitor.
> For this, we had to write a new driver that uses the same register 
> information as a fallback but can wait for the secure-monitor driver to 
> load and add its information to soc.
> It seemed logical to me to keep the DT structure the same and just add a 
> reference to the secure-monitor (or as a second option, create a 
> variable indicating support) for those SoCs that have been tested and 
> can provide this information.
> Not all Amlogic SoCs support this call, in some (mostly newer 
> generations of SoCs), this call returns incorrect information and we and 
> colleagues are still figuring out what has changed. But most established 
> platforms support this.
> We could add this information retrieval to the secure-monitor itself, 
> but that would be a completely different story and would not constitute 
> a soc driver.
> 
> In the end, we need information about the support of the secure-monitor 
> call for obtaining information for the soc driver. In my opinion, this 
> can only be done by specifying it in the DT in specific files for 
> Amlogic platforms: either by referencing the SM or by an option that 
> allows checking the SM.

That's not the only option. This is SoC specific so can be deduced from
the compatible as well. And this is kind of obvious from this patchset
(actually patch 4): you add it per SoC.

Best regards,
Krzysztof


