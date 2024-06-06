Return-Path: <linux-kernel+bounces-203923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC4C8FE208
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B96EB28F4F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F74714F10F;
	Thu,  6 Jun 2024 09:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="B+gYOMfo"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419EE14EC71;
	Thu,  6 Jun 2024 09:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717664481; cv=none; b=F+U+aTWEtqB0p2Q8CmgzdGmO8oBP7ogFcjwKiWIaWFq+RJbaoWOZSPTmyTBG2JKiRBtY6q/LDeu4987lEEm6gocg8/kWRNblhIk29wiUiYCWyFXjmoNgY+BHHqdW500U7Le++ybLejp9k43fdg7wmOM60mm9qeEDyoPu1wNuX0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717664481; c=relaxed/simple;
	bh=RGDQk9fEPK8TgeW16JgNCDUsvYQVkjgaqUjy4gYx4Tg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NNX64AvMxw2BcMSqCwusYUjpRAis4OzpIF9Lid49OqbHZRKQzOQl/igraZg/9Tm3XxL+OK2uPRTYNZh5T5cSHaGzkieO8/z8jDrMbGlxlyU8UJO7rtMD0htN8R2UicpYGsMeY2ZbxmB9SecA7zfsRPtX6zLeqB/UQLCkiv4UoCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=B+gYOMfo; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B9AB01BF20E;
	Thu,  6 Jun 2024 09:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1717664472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P6nHOSRQUTf8lskncbcfrnOE9UYbIGtkvvS9zsNteIA=;
	b=B+gYOMfoQgw4FyCl7kj7mLnNlrqSsM7ytiJnzZz8Q+UEsu9yEbM0jF6r7MZ6XbJ5Rff/C/
	vMWapylmnzqLdpbZXMWTMMoeG0wnWNOhd5q/G8AlcxneKdkkH08Z7wLDmDYk7aFLM6kwfZ
	BTmZi3nz/kET4STOEYSgG/C52WmwE+TKOfkyl2u4CckHlIzim2M7XHnp8zHqcQJFBBbKFa
	/PsVRVDQ5aWSS7uLf23fHfBKuNCXV2kDl5HhHWvapM6h7OwKDC1kWngXRQmaxQVGRruvbM
	XDI6/HzXUaEvUdATk7M7pxvn62d9/uUbbm1Fg47T2P1Rks/5iAbhBcRA6b+RfA==
Message-ID: <0ae387c1-31b2-4e87-aa7d-f98e3c90e985@arinc9.com>
Date: Thu, 6 Jun 2024 12:01:03 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: mt7622: fix switch probe on bananapi-r64
To: Thorsten Leemhuis <regressions@leemhuis.info>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 Frank Wunderlich <linux@fw-web.de>, Paolo Abeni <pabeni@redhat.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Daniel Golle <daniel@makrotopia.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 frank-w@public-files.de, Rob Herring <robh@kernel.org>
References: <20240516204847.171029-1-linux@fw-web.de>
 <a29dd7d1-40a8-4c88-99aa-651a3305b640@arinc9.com>
 <5AEE5668-0C8E-4EE4-A398-66CB99DF5650@public-files.de>
 <43aacd9d-b851-4100-8ccc-878ac6ae10f8@leemhuis.info>
 <698cf562-1ca9-4aa3-be7e-a1474b612c5b@leemhuis.info>
 <0cba095c-3d55-416a-a7ad-b359129731cf@arinc9.com>
 <714da201-654b-4183-8e5e-8ff0b64fe621@leemhuis.info>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <714da201-654b-4183-8e5e-8ff0b64fe621@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 06/06/2024 11.26, Thorsten Leemhuis wrote:
> On 31.05.24 08:10, Arınç ÜNAL wrote:
>> I had already submitted a patch series that would've prevented this
>> issue back in 14 March 2024 [1]. I've asked numerous times for the patch
>> series to be applied [2][3][4][5].
>>> Eventually Daniel asked for some changes [6]. But I won't have time to do
>> that anytime soon and I think the patch series is good enough to be applied
>> as is.
> 
> Then I guess we need some other way to resolve this in mainline to unfix

I don't believe we need another way to resolve it. I've already told that
the patch series is good enough to be applied as is and I don't see any
responses with reasons against this here.

> Frank's device. The two obvious options are afaics:
> 
> * revert the culprit (868ff5f4944aa9 ("net: dsa: mt7530-mdio: read PHY
> address of switch from device tree")) and reapply it in a later cycle

Sorry, no. There's nothing wrong with that patch. The actual cause of this
issue is the patch that introduced this device tree source file with the
wrong PHY address.

> * apply Frank's patch (or an improved one) in this thread (and if needed
> revert it when some better changes emerge.
> 
> Arınç ÜNAL, could you please comment on that and ideally handle the
> necessary tasks, as it's your patch that causes the regression.

I don't see any necessary tasks for me to handle. AngeloGioacchino Del
Regno whom is the only person I know that maintains these device tree
source files can simply apply the patch series that I have already
submitted and we can all move on. I haven't heard from them whilst the
patch had been waiting since March. So I'm not sure who's going to apply
this patch, and to which tree.

Arınç

