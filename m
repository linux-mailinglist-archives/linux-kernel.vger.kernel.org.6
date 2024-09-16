Return-Path: <linux-kernel+bounces-330467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1BE979EE1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 12:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68B2BB22870
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 10:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD9414B945;
	Mon, 16 Sep 2024 10:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SmCKTdx4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D21517C8D;
	Mon, 16 Sep 2024 10:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726480974; cv=none; b=g1cfv91faWG7R2Dy2AnlyS3LGeUfAWBE1mRtUOKdIcLow4xDbALRbKgbI+HWZQFw87+TEcip3K3joWN8upIAol3WGY5R8r2FmGD/3J+rrOvChWnAbLwsGxDXJoCRwcRV+uXTzh0bRlyabGlIo9ey9B8aQT0OXnUFIPPxzxB+XQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726480974; c=relaxed/simple;
	bh=2JAcUazpILyjWEBfKP9J2vMMoWzkdvtOE73YS/HthaQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TFtXKk6ZvvVQBJs70mkozsFPZNCPlewoZrBONZAxo8Z1P2mchBiB2F8Q7W8ZvmC33BE2PG1UOaATtccWEWIlIdK3Ccv0rEt/hvCKxmAM5Al5pnVJGtZgMjRt7qewUYUaCQQPkREfZE6inGtiZSOPRrF4/oSy9OWLl0xLngk9lL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SmCKTdx4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E07C4CEC7;
	Mon, 16 Sep 2024 10:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726480973;
	bh=2JAcUazpILyjWEBfKP9J2vMMoWzkdvtOE73YS/HthaQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SmCKTdx4BqPrZ9VjlAHhbQRyex+r4GiqztP/6IvBFfAy4strRwH3ZMUzxbr9E+YKz
	 GcnaQ2bgwtWgQRYvgU097TVr3MxD94YrzwCdO/Z/sRyHYKG2KzF+9e71PzqNIS0rMg
	 TzFEOu7KodZ6FAdIVWr3cVmBM7LSenM8qk3LNmHxfWcPETC0cu3h/XtCR9TTxKezLa
	 mK7b32Z/67G46n1xMcRAgMScpVZ5UqTeD8OuZfxULJ/kCwAosbCsk7JrqnYuth8q1W
	 4JgYiGiY0xQorr6MM0KxGjSorKnfznieJcNF9uVxY8kz+onWNrEYZquD0VMGa/4gbE
	 NY/vM+m5dovDw==
Message-ID: <a9a7038c-4478-4366-831a-81dca8fa5afc@kernel.org>
Date: Mon, 16 Sep 2024 12:02:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/13] arm64: dts: mediatek: mt8188: Update VPPSYS node
 name and compatible
To: Fei Shao <fshao@chromium.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Conor Dooley
 <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org
References: <20240909111535.528624-1-fshao@chromium.org>
 <20240909111535.528624-7-fshao@chromium.org>
 <11bc2522-bc10-4dcf-8142-708b57d181cf@kernel.org>
 <CAC=S1nhiJ=7yAucJsaYKUUBrwrxOVBMB2CF=bFwyLa2o-5RmWw@mail.gmail.com>
 <64cc35c8-30df-4882-a933-f42119270f48@kernel.org>
 <CAC=S1ni+pJJZhbjvVqhba5u1JqGv=dZTv8+KH4xburea2AG4Qg@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <CAC=S1ni+pJJZhbjvVqhba5u1JqGv=dZTv8+KH4xburea2AG4Qg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/09/2024 13:06, Fei Shao wrote:
> On Tue, Sep 10, 2024 at 3:19 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>
>> On 10/09/2024 07:12, Fei Shao wrote:
>>> On Mon, Sep 9, 2024 at 7:41 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>>>
>>>> On 09/09/2024 13:14, Fei Shao wrote:
>>>>> Use and add "syscon" in VPPSYS node names and compatible to fix errors
>>>>> from `make CHECK_DTBS=y mediatek/mt8188-evb.dtb`.
>>>>>
>>>>> Signed-off-by: Fei Shao <fshao@chromium.org>
>>>>> ---
>>>>>
>>>>>  arch/arm64/boot/dts/mediatek/mt8188.dtsi | 8 ++++----
>>>>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
>>>>> index 2900d78b7ceb..14e51a11f688 100644
>>>>> --- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
>>>>> +++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
>>>>> @@ -1799,8 +1799,8 @@ mfgcfg: clock-controller@13fbf000 {
>>>>>                       #clock-cells = <1>;
>>>>>               };
>>>>>
>>>>> -             vppsys0: clock-controller@14000000 {
>>>>> -                     compatible = "mediatek,mt8188-vppsys0";
>>>>> +             vppsys0: syscon@14000000 {
>>>>> +                     compatible = "mediatek,mt8188-vppsys0", "syscon";
>>>>
>>>> If this was working before, it looks like this is not a syscon and
>>>> bindings need to be fixed.
>>>
>>> I guess it's because the binding was later updated in commit
>>> 26bcd8a53098 ("dt-bindings: arm: mediatek: mmsys: Add VPPSYS
>>> compatible for MT8188"), and the corresponding DT update was unnoticed
>>> at the time.
>>> If that makes sense then this should be a valid fix.
>>
>> Not necessarily. Why not fixing bindings? Prove that bindings are
>> correct, not DTS, first.
> 
> MediaTek's mmsys doesn't merely control clocks, it also provides
> display pipeline routing control and other misc control registers, so
> it's appropriate to categorize it as a system controller over a clock
> controller.
> As for vdosys and vppsys, they are likely variants or aliases of mmsys
> introduced in their newer SoCs.

Nothing like that was in the commit msg...

> 
> That description was updated in commit 1a680aa888d6 ("dt-bindings:
> mediatek: Update mmsys binding to reflect it is a system controller"),
> so I just assumed it's correct without thinking much...


Best regards,
Krzysztof


