Return-Path: <linux-kernel+bounces-304642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E2296231C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 11:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 386361F22313
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 09:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480C6161B43;
	Wed, 28 Aug 2024 09:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I+fspJpN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E7E1607AC;
	Wed, 28 Aug 2024 09:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724836305; cv=none; b=KyOlZWU46rOz0YbZyowvFfHdFgzSwdlJRBOO1xfZNRqflw9KTx8IPjW947zlC1yEa24WE78lMx531wZGGsgv1kcG1GjfcRBdHS16nq9LgKhER+MDxavZpNaCgPzdH0HBH2wnD/LTYXtb62QNjYqyqh5apYdEW5/9z0zEF3O5gns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724836305; c=relaxed/simple;
	bh=0h8O7FJ3DgvgGR17BcBk6wfFWrda7TDSqBbyr2M0Ubw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iNLzQ7cpOwZ7shGsSiMJM/4h2Jwgm/GZScaQmiIepJ74lP0m9gT0zWa7HwayJDZ6pfG8PiWcC1uGQU3ABhggZ0PiDDjCTDdyvjOuRQBmZw+Iq6o3HcUCowac5L6qZ2lHL29dqyJHyCigSHV7v1b4KWQbCexGeT722Q5eQ3JXifs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I+fspJpN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A85C5C51EE7;
	Wed, 28 Aug 2024 09:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724836304;
	bh=0h8O7FJ3DgvgGR17BcBk6wfFWrda7TDSqBbyr2M0Ubw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=I+fspJpN+ifmm1D7U6v+HSzkaGPjPPilt3HUwEAU722sfeMSp67NFdNXcJ328RMu0
	 Gnmn14XMc1kBl4uBDrp7yr2Sxo0NUyjeulXLgYK+yWRWwC3+OobBRqULU+kJo19fCR
	 sKlmwH6S2niy9eB4qjMHhtszgWjkrir2/a5UKpnie9YHAhXs6v9RSZKvwr0iZcJrcs
	 uyycCazxcv9GMBurmktEhyW98mbA7XBNn/dlbyUOfNqU9g/d8Z5V/wOkBTyLqfAStG
	 pmWuY/tGOc0UavfTJVDbZjfUlhI7mbQSm95663RfHUt8ssz8hEnR5tN6gL4AdxV8Q1
	 O5+GzqFq1AvxQ==
Message-ID: <0ec92d59-0648-40ed-a522-307152b5c37d@kernel.org>
Date: Wed, 28 Aug 2024 11:11:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] arm64: dts: qcom: add base QCS615 RIDE dts
To: Lijuan Gao <quic_lijuang@quicinc.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, kernel@quicinc.com,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240828-add_initial_support_for_qcs615-v1-0-5599869ea10f@quicinc.com>
 <20240828-add_initial_support_for_qcs615-v1-6-5599869ea10f@quicinc.com>
 <22qkvfravm6sxiq3xfavahg2u6b2pwlyzqbqvd55zym5zef3gi@m4bsqkdvggty>
 <17d0017e-b55d-4b32-9fd3-1a1a84e5ebf9@quicinc.com>
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
In-Reply-To: <17d0017e-b55d-4b32-9fd3-1a1a84e5ebf9@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 28/08/2024 09:54, Lijuan Gao wrote:
> 
> 
> 在 8/28/2024 2:25 PM, Krzysztof Kozlowski 写道:
>> On Wed, Aug 28, 2024 at 10:02:16AM +0800, Lijuan Gao wrote:
>>> Add initial support for Qualcomm QCS615 RIDE board and enable
>>> the QCS615 RIDE board to shell with dcc console.
>>>
>>> Signed-off-by: Lijuan Gao <quic_lijuang@quicinc.com>
>>> ---
>>>   arch/arm64/boot/dts/qcom/Makefile        |  1 +
>>>   arch/arm64/boot/dts/qcom/qcs615-ride.dts | 15 +++++++++++++++
>>>   2 files changed, 16 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
>>> index 197ab325c0b9..c5503f189847 100644
>>> --- a/arch/arm64/boot/dts/qcom/Makefile
>>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>>> @@ -110,6 +110,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= qcm6490-idp.dtb
>>>   dtb-$(CONFIG_ARCH_QCOM)	+= qcm6490-shift-otter.dtb
>>>   dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-1000.dtb
>>>   dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-4000.dtb
>>> +dtb-$(CONFIG_ARCH_QCOM)	+= qcs615-ride.dtb
>>>   dtb-$(CONFIG_ARCH_QCOM)	+= qcs6490-rb3gen2.dtb
>>>   dtb-$(CONFIG_ARCH_QCOM)	+= qcs8550-aim300-aiot.dtb
>>>   dtb-$(CONFIG_ARCH_QCOM)	+= qdu1000-idp.dtb
>>> diff --git a/arch/arm64/boot/dts/qcom/qcs615-ride.dts b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
>>> new file mode 100644
>>> index 000000000000..31d32ad951b5
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
>>> @@ -0,0 +1,15 @@
>>> +// SPDX-License-Identifier: BSD-3-Clause
>>> +/*
>>> + * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
>>> + */
>>> +/dts-v1/;
>>> +
>>> +#include "qcs615.dtsi"
>>> +/ {
>>> +	model = "Qualcomm Technologies, Inc. QCS615 Ride";
>>> +	compatible = "qcom,qcs615-ride", "qcom,qcs615";
>>> +
>>> +	chosen {
>>> +		bootargs = "console=hvc0";
>>
>> Noooo, last time I agreed on this, you told me later it is different.
>>
> In the early stages, enabling HVC is to more easily verify clock and 
> PMIC related functions, as it’s difficult to debug without the console 
> log. After the clock and PMIC are ready, we will enable the UART console.

Working serial is supposed to be part of the early submission.

Best regards,
Krzysztof


