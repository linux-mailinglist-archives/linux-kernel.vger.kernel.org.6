Return-Path: <linux-kernel+bounces-543406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E003A4D52B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A21243ADA78
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 07:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FF21F8BCB;
	Tue,  4 Mar 2025 07:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZ4NE5jt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C3D1F6679;
	Tue,  4 Mar 2025 07:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741074115; cv=none; b=RLmQv0VDtexzs1hOvUEilXwT5QEVHCIcvz7uAol5ZxBaIvWfM++beo9lWWQf/q5cGcyd47rAyJWQvwVw9Y5IofNuj+LjRuuBKhlWzIhFbhuimWH4d0QfjreDKCQoFjTlts+/NmzfHzAQg1rI9iGNCcHrMDNPiQDWbBWa81J/rQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741074115; c=relaxed/simple;
	bh=e+d7LzNEHgC04AOhwlIbC1h4HJEdskxbs6owwHoZla4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kaRLwgUfiKE1a1n09AkyeEBZ9+BxsI7ceJOvulgegbiVvi7uNtJXuqc+TVHcqTgNP8kApLqUUrPfe+yeCNHjr+sF/IjfsfYlQbjTEcjwxw5gnhVvlmqGaCz7+ya+0CxbrCpn0l5P/22dO5xfl6O22lwOd7oedgFIVXpLRKKZspg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KZ4NE5jt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EBE8C4CEE5;
	Tue,  4 Mar 2025 07:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741074114;
	bh=e+d7LzNEHgC04AOhwlIbC1h4HJEdskxbs6owwHoZla4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KZ4NE5jtbqkGmnE1o5QhOxcQmPZL4HeBaOIUFgUKIaIm91aSY4ZlgSAOeaCQZBeaq
	 UQi/LW5hamW9Ak+aFTeW/NY3A3/xMza2AObFRsU4SWpVS8OuCJXsi8imcFnr1M6G3Z
	 qwLUjx4aUi+S/d0A0VunusCOf4h5schrPtqedVMTbTnpBhtfZkt3XGQtIhRQxNb2/g
	 UM1JwHtOuR7EhrjuUsLdGWkduk32YQcLqEkdDNuEXPStpidMXge/YSHelLs/63RT0K
	 EVvZppM5sGFyjyCTPQkJUypK9T5ZbQfndVl1yZLDX6NoGIlE7CZAbrXNHHWqo9Wia3
	 WbUyvXQ+3wYnQ==
Message-ID: <2985a7d1-2d57-473a-b953-7a2c0ecb7195@kernel.org>
Date: Tue, 4 Mar 2025 08:41:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/4] dt-bindings: clock: thead: Add TH1520 VO clock
 controller
To: Michal Wilczynski <m.wilczynski@samsung.com>, mturquette@baylibre.com,
 sboyd@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 drew@pdp7.com, guoren@kernel.org, wefu@redhat.com, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 jszhang@kernel.org, p.zabel@pengutronix.de, m.szyprowski@samsung.com
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20250303143629.400583-1-m.wilczynski@samsung.com>
 <CGME20250303143635eucas1p1dbcd26d4906b962e07cbde7f5ef704bf@eucas1p1.samsung.com>
 <20250303143629.400583-2-m.wilczynski@samsung.com>
 <cf6aa8bf-d424-49f4-b6a6-b6b10fd8092f@kernel.org>
 <ac4f8b31-2a9b-4860-a72e-379806ee9f77@kernel.org>
 <1cd2f07d-14a1-4a25-8a81-b815f405018e@samsung.com>
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
In-Reply-To: <1cd2f07d-14a1-4a25-8a81-b815f405018e@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/03/2025 08:39, Michal Wilczynski wrote:
> 
> 
> On 3/3/25 18:46, Krzysztof Kozlowski wrote:
>> On 03/03/2025 18:41, Krzysztof Kozlowski wrote:
>>> On 03/03/2025 15:36, Michal Wilczynski wrote:
>>>> Add device tree bindings for the TH1520 Video Output (VO) subsystem
>>>> clock controller. The VO sub-system manages clock gates for multimedia
>>>> components including HDMI, MIPI, and GPU.
>>>>
>>>> Document the VIDEO_PLL requirements for the VO clock controller, which
>>>> receives its input from the AP clock controller. The VIDEO_PLL is a
>>>> Silicon Creations Sigma-Delta (integer) PLL typically running at 792 MHz
>>>> with maximum FOUTVCO of 2376 MHz.
>>>>
>>>> Add a mandatory reset property for the TH1520 VO clock controller that
>>>> handles the GPU clocks. This reset line controls the GPU CLKGEN reset,
>>>> which is required for proper GPU clock operation.
>>>>
>>>> The reset property is only required for the "thead,th1520-clk-vo"
>>>> compatible, as it specifically handles the GPU-related clocks.
>>>>
>>>> This binding complements the existing AP sub-system clock controller
>>>> which manages CPU, DPU, GMAC and TEE PLLs.
>>>>
>>>> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
>>>> ---
>>>>  .../bindings/clock/thead,th1520-clk-ap.yaml   | 33 ++++++++++++++++--
>>>>  .../dt-bindings/clock/thead,th1520-clk-ap.h   | 34 +++++++++++++++++++
>>>>  2 files changed, 64 insertions(+), 3 deletions(-)
>>>
>>>
>>> Where is the changelog? Why is this v1? There was extensive discussion
>>> for many versions, so does it mean all of it was ignored?
>>
>>
>> Plus this was reviewed so it is even more confusing. Where is the review
>> tag? If tag was dropped, you must explain this - see submitting patches,
>> which asks for that.
> 
> There was a tag, but later in v5 I've added another part to this
> dt-binding - reset, which I wasn't sure whether you would approve of, so
> I've removed the Reviewed-by.

Dropping tag needs explicit explanation and the entire versioning plus
changelog are gone from here.

Best regards,
Krzysztof

