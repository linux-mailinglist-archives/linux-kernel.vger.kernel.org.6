Return-Path: <linux-kernel+bounces-258984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB24938F78
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 14:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 098551C21486
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 12:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38C116D4E6;
	Mon, 22 Jul 2024 12:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gs2r/LMZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E227316CD21
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 12:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721653001; cv=none; b=SooqveuLoDqgMnhPiFM+51tU4yBbhYKq+CK1yz6YUsUBidz3XE0DPeszdeubtsel5BzhCT4+fpeTPlGajJN8/ekbTATlyR9EbauctL+6EMM50RIbnH7yflzdQxVnDvuuveyfnuxeQZL7I5yzIVoqrkrFZoiV/AvJ3wTCp7hpUvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721653001; c=relaxed/simple;
	bh=coMvSSabAJCbEDASBOo9nowi+9h9N9iIbee5616pgZU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=dgp9lnQnqjYn5fteS2prTEpKTfs77XumsVMfBotfkdInDLgBpHd9tmA+I2Bi5yx5IrkUiV9zWJj0OKUR4Hrd/azvE70NDm6mddHPc1CYt9tcKk370biz3FBE5qnMUKpng02cL3RyO0UR077v/uKLrFMTi8b69/oj35HjlugnnQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gs2r/LMZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8914C116B1;
	Mon, 22 Jul 2024 12:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721653000;
	bh=coMvSSabAJCbEDASBOo9nowi+9h9N9iIbee5616pgZU=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=gs2r/LMZSEMHq5Xs6M9dqTMhln9aitldMNJPgCd6qDuN9oX1IXSSnbSNJFwmAvprF
	 3xrMV0yBE3r4AJ8zDt+/ZerGt+B73OIQ2ONaajhEFnxI+DMsGm0W0P9zQmdhIin26y
	 Jd8LN+SYSGjdCaa00k6ZqN+IQYExKURP9B7EH5IUIamSqHvESK5ygq1hTk8fjfHRDn
	 PbbT0DH8xL4x+1stn9b9i+5nH+lX1njASy51JAPFatGRlOGerhJapL11M9Qk+pKEiI
	 iB7cGF+qWVR6Co2v2toQLgxIcuxzcgJOrCqm7PfCR3AUZ5PIELGS+SLbbkGZFhI+6G
	 1JJbCv8jeutAw==
Message-ID: <39ec733e-c49f-44c4-b998-19c7cbaf6ad1@kernel.org>
Date: Mon, 22 Jul 2024 14:56:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] HID for 6.11
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
 Benjamin Tissoires <bentiss@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org,
 Konstantin Ryabitsev <konstantin@linuxfoundation.org>
References: <uirri5bsktq5pk2tu4gs2u22qimjcn7hi66ek6gbj65qyczfex@yjy4brkoixfv>
 <c52b7bf6-734b-49fd-96e3-e4cde406f4e0@linaro.org>
 <f94c747c-7ee4-41b9-9851-610cecf2e555@kernel.org>
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
In-Reply-To: <f94c747c-7ee4-41b9-9851-610cecf2e555@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/07/2024 14:51, Krzysztof Kozlowski wrote:
> On 22/07/2024 14:46, Konrad Dybcio wrote:
>>
>>
>> On 16.07.2024 3:34 PM, Benjamin Tissoires wrote:
>>> Linus,
>>>
>>> please pull from
>>>
>>>   git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/for-linus-2024071601
>>>
>>> to receive HID subsystem updates for 6.11 merge window. Highlights:
>>>
>>
>> [...]
>>
>>>       HID: bpf: Add support for the XP-PEN Deco Mini 4
>>>       HID: bpf: Add Huion Dial 2 bpf fixup
>>>       HID: bpf: Thrustmaster TCA Yoke Boeing joystick fix
>>>       HID: fix for amples in for-6.11/bpf
>>
>> Hi,
>>
>> this commit broke b4 for everyone starting next-20240719, as it's
>> an empty cover letter with b4 tracking information
> 
> Uh, reminds me, I guess the same mistake of not seeing differences
> between git pull and git am...
> https://lore.kernel.org/all/311c8b64-be13-4740-a659-3a14cf68774a@kernel.org/
> 
> So just to recap:
> 
> Please *do not merge your own trees* into kernel.org repos. Instead use
> b4 shazam to pick up entire patchset, even if it is yours. b4 allows to
> merge/apply also the cover letter, if this is your intention.

Also, this was not present in next-20240717 and earlier. It was added in
20240719, so few days ago during merge window.

I think features should be in the next for some time before the merge
window starts, not added to next the moment they are sent to upstream.

Best regards,
Krzysztof


