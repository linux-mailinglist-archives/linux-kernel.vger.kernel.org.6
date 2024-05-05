Return-Path: <linux-kernel+bounces-168964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B95548BC03A
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 13:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A46561C20DE6
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 11:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E94A17BD9;
	Sun,  5 May 2024 11:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JimJYdjz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55642566A;
	Sun,  5 May 2024 11:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714908731; cv=none; b=IVve0SeRm1aP6PzZ8qaxu0x93ma/eflVDuiTLaBbCy7cTgpkb/URqIT7onYYcb0tuMAO/Bj/Ac/eSsOmCuOPQtTySn18HBy40r9+OLUJsvNUhmCgK2G/ygdtMUtnRgaKzvDPBeIsrPl6XVxOci9JQx8BFW6DFd8QX7nTsJnk1iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714908731; c=relaxed/simple;
	bh=zo6MNQZCEBD6b3AWALFdLcV6B6KTtGSpb1td+DtvigY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E/Hde0lqAlZp8aip9/E2hqckhS9lxTP1On+2Pk9mtTHgPPavuIQh+SOUEwYuEvzOyziXY0acsONEWFUVOS+81IDUX5T8HRQZi1BqO6qHaREKrzcq4Ovi7dXKOanApjsOKAFWDcXRW60onilc5xO0EZKJ30E/DuKQt5Hz0jVDzeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JimJYdjz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F356AC113CC;
	Sun,  5 May 2024 11:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714908730;
	bh=zo6MNQZCEBD6b3AWALFdLcV6B6KTtGSpb1td+DtvigY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JimJYdjzvynBymUsAse5opQYcEnpmDDbXTJVjMvtlQTb/XUoJAJDQZ7U/bZkBRerO
	 DCkMG5xFviIHmjnP7eiPa95q9/KEobvzcsT+mL7f9mo7pvvgDJodKDfU2CqEBZtEk/
	 ip/1hZ7wU12o1x3b4fpKzwe4pHGECDV/2osOX0j3iGapcgeSa0N/S/kp+UFb3VEALC
	 seNWeALtUoXxoRyr6ErVRD+zyWyrwXT07pgE3kkCABtzgxzLzR+pwk0EKbo574a0S5
	 5FpIHDjY+p08XkISXyO5FcHaNnHYb5eStSIZbCOAeXVJcNeXtzFwT6RD+FDaZfTgbk
	 ZVvnYhONvv92Q==
Message-ID: <3425732a-390b-4c0f-ba1b-2a7e2219d581@kernel.org>
Date: Sun, 5 May 2024 13:32:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] ASoC: dt-bindings: omap-mcpdm: Convert to DT schema
To: Mithil <bavishimithil@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-sound@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240417134237.23888-1-bavishimithil@gmail.com>
 <2e179356-425d-48cc-84db-0ea3e6203fba@kernel.org>
 <CAGzNGR=pvv67UJtNnkDUMhrpnPjNCCYEGeCaM7e_9=4G+Lcfgw@mail.gmail.com>
 <676ce61c-e850-4046-ad0f-e3382be3fe0c@kernel.org>
 <CAGzNGR=rDrd6LyAC2yB4XUcxn=H1VdY8LQO99NEOBR1sLGGT0Q@mail.gmail.com>
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
In-Reply-To: <CAGzNGR=rDrd6LyAC2yB4XUcxn=H1VdY8LQO99NEOBR1sLGGT0Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/05/2024 11:59, Mithil wrote:
>>>> Missing constraints, so replace it with maxItems: 1
>>> Similar to how clock-names are handled?
>>>
>>>> List the items. I asked to open existing bindings and take a look how it
>>>> is there. Existing bindings would show you how we code this part.
>>>   clock-names:
>>>     items:
>>>       - const: pdmclk
>>>     minItems: 1
>>>     maxItems: 1
>>> Something like this?
>>
>> No. Do you see code like this anywhere? Please only list the items,
>> although without context impossible to judge.
>>
> Quick search on sources gave me
> Documentation/devicetree/bindings/usb/dwc2.yaml

Above code is different - it does not have maxItems, which you want to add.

> which I used as reference for this prop
> clock-names:
>   description: Must be "pdmclk"

Again, no, please list the items.
items:
 - const: foo



> 
> compatible = "ti,omap4-mcpdm";
> reg = <0x40132000 0x7f>, /* MPU private access */
>         <0x49032000 0x7f>; /* L3 Interconnect */
> interrupts = <0 112 0x4>;
> Not really constants as they do change with platforms (omap4 vs 5 for
> example) but

That is not really relevant... This is not pi or other math constant.

> So do i just make up the constants for it then? Those just seem like
> magic numbers.

Hm? Did you look around for other SoC nodes? 0 looks like SPI, 4 like
LEVEL_HIGH, but it depends on number of meaning of the interrupt cells,
so who is parent interrupt controller.

To work with DT bindings it is necessary to have minimum basic knowledge
about DTS. Maybe it would be good to start with some guides/tutorials
about DTS. elinux has quite some tutorial and also resources pointing to
various conference talks.

Best regards,
Krzysztof


