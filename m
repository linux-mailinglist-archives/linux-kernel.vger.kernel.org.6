Return-Path: <linux-kernel+bounces-420984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D899D8520
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 13:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0754E28C112
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 12:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A927619CC0A;
	Mon, 25 Nov 2024 12:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="CWAwjF4r"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D432500BA;
	Mon, 25 Nov 2024 12:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732536688; cv=none; b=GJe4tB4wWIfs7NjybMHQXIAysaHNlMyUBC84Ek4DmY0toxk3sppMW4A5il0smiVzi2YRWAwzxjd9D+Mn5Kc/JVZREIZ42Cch2cixzQDCk0+q5s7E9FlVgLzya811vqs4IrzZcnvsfiNyMTcuhgtUQJqMFaSkyG5l+1nqT+LehMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732536688; c=relaxed/simple;
	bh=14XUCo8yVNfFziyLYmVQUN09e32BPAHXjH641vRkQ6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QJXsSB2i/+aEIzxP53K5bJqHFwbxSRwLroDeQnJoPNwKJAPuOPU382vEriCYeb3zWprMhK0dzA/rxanfRFVELGaiLKgyjSBTI0rsspnne2iL7EY5OWNSG+0EUpHnFda5wecuF6DK8iN8KUGrnYVcdpXxt294+c1zA7B+DfG2TYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=CWAwjF4r; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1732536684;
	bh=14XUCo8yVNfFziyLYmVQUN09e32BPAHXjH641vRkQ6w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CWAwjF4rrDLAt6KfZcgs4+jZTB5EkTcBBHfq9gfAdTk9lJ+J2+zkaLe9v7zit0ZQ1
	 Fel+156ukvkGFJw1SJb/zjW58c9AwaBdPq5bPKzsdRtnkiZYO0ZrJ88qIbY1FY4pUQ
	 9vLA+c78feNhWDrQ7dGM0+llXYT/HSv2G+9frITmKadmpfQ4nle5fsaSu22Og2ItRT
	 4ZuBRMicwewcCAMfWMY8UdiWCK7YBmm+A54qMPzHYSgNQ/58UGixfr/fZ677vhjRoV
	 jZZnBh4bWiiFRzWokkFCmQFh7daOJXicNv4h1Q0fCabyPkKEih3dL1QaQQXEFiZfUH
	 dGvjUEaLP5gVg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0A6EA17E3625;
	Mon, 25 Nov 2024 13:11:24 +0100 (CET)
Message-ID: <bd424582-c537-4a22-afd6-d53cb3fd5814@collabora.com>
Date: Mon, 25 Nov 2024 13:11:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] Devicetree updates for v6.13
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Chen-Yu Tsai <wenst@chromium.org>
Cc: Sasha Levin <sashal@kernel.org>, Rob Herring <robh@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Saravana Kannan <saravanak@google.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>
References: <20241118210730.GA3331421-robh@kernel.org>
 <Z0NUdoG17EwuCigT@sashalap> <c25e6a80-f6dc-4ef9-a90d-0fa09cbbc217@linaro.org>
 <Z0NbeyTwxo-M4Lgi@sashalap>
 <936bf452-3d1f-4940-9a91-69efcdc6985e@collabora.com>
 <CAGXv+5FLkZbZVHNkfRWuT+OioZ0TG=u2WfaFCx-jZFi73QHnVg@mail.gmail.com>
 <19ba4910-f909-41b4-ba62-c904bc37d41d@linaro.org>
 <e77669ea-9edd-4321-8d17-4da40161b59d@linaro.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <e77669ea-9edd-4321-8d17-4da40161b59d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 25/11/24 12:33, Krzysztof Kozlowski ha scritto:
> On 25/11/2024 12:00, Krzysztof Kozlowski wrote:
>> On 25/11/2024 11:34, Chen-Yu Tsai wrote:
>>> On Mon, Nov 25, 2024 at 5:48 PM AngeloGioacchino Del Regno
>>> <angelogioacchino.delregno@collabora.com> wrote:
>>>>
>>>> Il 24/11/24 17:59, Sasha Levin ha scritto:
>>>>> On Sun, Nov 24, 2024 at 05:47:33PM +0100, Krzysztof Kozlowski wrote:
>>>>>> On 24/11/2024 17:29, Sasha Levin wrote:
>>>>>>> Hi Rob,
>>>>>>>
>>>>>>> On Mon, Nov 18, 2024 at 03:07:30PM -0600, Rob Herring wrote:
>>>>>>>>       of: WARN on deprecated #address-cells/#size-cells handling
>>>>>>>
>>>>>>> With the commit above, I've started seeing boot warnings on a few
>>>>>>
>>>>>> And same boards do not report problems on the next?
>>>>>
>>>>> Looks like they do. I haven't checked it previously, but I see that we
>>>>> have similar warnings on a few boards that KernelCI is testing -next on.
>>>>>
>>>>
>>>> That's... horrendous.
>>>>
>>>> I hope that we can get a proper fix with a bootloader update on these (now very
>>>> old) devices... Adding a Google engineer to the loop so that he can follow up
>>>> internally.
>>>
>>> AFAIK that's unlikely going to happen given the resources needed from
>>> the ODMs for a firmware re-qualification. Or we would have fixed the GIC
>>> bug in ATF and had pseudo-NMI.
>>>
>>> Some of the firmware code involved is 10 years old, so even the RK3399
>>> Chromebooks, which no longer have support, could suffer from this as
>>> well.
>>>
>>>> The alternative would be to hack-in a firmware node to mt8183-kukui.dtsi, but....
>>>> ...ugh. That'd be indeed a hack for the sole purpose of fixing a bootloader that
>>>> is acting in a broken way, and I don't like that at all (...and I'm sure I'm not
>>>> alone!).
>>>
>>
>> Then we should add it to the exception list. Let me take a look at this.
> https://lore.kernel.org/linux-devicetree/20241125113151.107812-1-krzysztof.kozlowski@linaro.org/T/#u
> 
> I sent a fix for this platform only. You did not paste links to other
> failing platforms (and sorry but kernelci web interface was absolutely
> unmanageable and unusable, so I am not going to even try to look for
> them) so not sure who should be added to list of exceptions.
> 

Are you aware of the new dashboard, or are you referring to the old one?

https://dashboard.kernelci.org/tree

P.S.: If you do have any feedback on how to make it better, please feel free to
give it out: the KCI team will surely be happy to read it.

Cheers,
Angelo

