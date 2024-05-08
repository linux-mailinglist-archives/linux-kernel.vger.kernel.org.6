Return-Path: <linux-kernel+bounces-172969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1D08BF98B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 11:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAF7E283A78
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 09:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29ECF75803;
	Wed,  8 May 2024 09:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="yI4LvrKF"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2A971753;
	Wed,  8 May 2024 09:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715160588; cv=none; b=s7Dw6EcCfG1wHXMt7BthOmO78ISE7yZDz6zvWli6DqJ54fVY5h2Exozx+553MHX7X9jVyrz99aKTSzwGbbXGeTgST9wKEHHEf2BPy1qFABVK3ciKptOuOR0B9YFuYbPPwQ1KD6NFHH9sRuUJ4dxdqcPho3mfkrDgVZoHgIWI5fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715160588; c=relaxed/simple;
	bh=CyUA6ks1HsLglg9cdqivgokq0SYSLKF5yuxVYskxaFY=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=unJMbanPABl4VVNXLwyBwZSFRf2yiGynpdVfl37E6fKHi1l853yiGtDFsrg4OTHJNm6BY+AuG8JUiuJ+nfTvFHt6aL4OtYUndbVumoDhjB4vmnxyrk2S7r+sag6+BStJJFt700q2F6RwVd14v2ZF27Kx8LzWgF/2n4bOAiF1dJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=yI4LvrKF; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1715160582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JL7Cqc7rpixgBgbCXhIQMAAO82vWRkxls15BxMKvRjg=;
	b=yI4LvrKFeze38qylAOEwDE+u0aDLwijFZ11pRQXLtPq+5cRr4L29GioAoB+XHJJDyJS4SF
	dYIhMJAXL01yhOISHYCff80gnsnbRlJjsKG6TCf4LS1ODA4AJ9t67oUGzH4ISIZDALxboo
	gdoTbP5qvSjdWBwukr/zNQnLi6bvSeISFQ6/PHSSCnZ08BywqcGtOG8PJtO84fGlMs1fSD
	snRkHQU1XjAAncDkgSsXaoQVWdgM9rBRrTVmCn+3xTLCgHk1394fEio19jL9iJEsXEUw01
	ts0CTGePsVsnx/F2vIjQY0+BetXaqSm0qvR9tqLxnXB4gwwNq+qMV6QRH7xSvg==
Date: Wed, 08 May 2024 11:29:41 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Alexey Charkov <alchark@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Daniel Lezcano
 <daniel.lezcano@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Chen-Yu
 Tsai <wens@kernel.org>, Diederik de Haas <didi.debian@cknow.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, Kever Yang
 <kever.yang@rock-chips.com>
Subject: Re: [PATCH v4 6/6] arm64: dts: rockchip: Add OPP data for CPU cores
 on RK3588
In-Reply-To: <e220061e-0bb5-4fa4-9a91-aefd81e6636c@cherry.de>
References: <20240506-rk-dts-additions-v4-0-271023ddfd40@gmail.com>
 <20240506-rk-dts-additions-v4-6-271023ddfd40@gmail.com>
 <e220061e-0bb5-4fa4-9a91-aefd81e6636c@cherry.de>
Message-ID: <dd9c76519ee0eee177528488a4946056@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Quentin,

On 2024-05-08 11:12, Quentin Schulz wrote:
> On 5/6/24 11:36 AM, Alexey Charkov wrote:
>> By default the CPUs on RK3588 start up in a conservative performance
>> mode. Add frequency and voltage mappings to the device tree to enable
>> dynamic scaling via cpufreq.
>> 
>> OPP values are adapted from Radxa's downstream kernel for Rock 5B [1],
>> stripping them down to the minimum frequency and voltage combinations
>> as expected by the generic upstream cpufreq-dt driver, and also 
>> dropping
>> those OPPs that don't differ in voltage but only in frequency (keeping
>> the top frequency OPP in each case).
>> 
>> Note that this patch ignores voltage scaling for the CPU memory
>> interface which the downstream kernel does through a custom cpufreq
>> driver, and which is why the downstream version has two sets of 
>> voltage
>> values for each OPP (the second one being meant for the memory
>> interface supply regulator). This is done instead via regulator
>> coupling between CPU and memory interface supplies on affected boards.
> 
> I'm not sure this is everything we need though.
> 
> For the LITTLE cores cluster, all OPPs up to 1.416GHz are using the
> same opp-supported-hw, however the ones above, aren't.
> 
> 1.608GHz, 1.704GHz and 1.8GHz are all using different opp-supported-hw.
> 
> Similarly, for the big cores clusters, all OPPs up to 1.608GHz are
> using the same opp-supported-hw, but not the ones above.
> 
> 1.8GHz and 2.016GHz, 2.208GHz, 2.256GHz, 2.304GHz, 2.352GHz and 2.4GHz
> all have a different opp-supported-hw.
> 
> The values in that array are coming from cpu leakage (different for
> LITTLE, big0 and big1 clusters) and "specification serial number"
> (whatever that means), those are coming from the SoC OTP. In the
> downstream kernel from Rockchip, the former value is called "SoC
> Version" and the latter "Speed Grade".
> 
> I think this may have something to do with "binning" and I would see
> the ones above the "common" OPPs as "overclocking". Not all CPUs would
> support them and some may not run stable at some lower frequency than
> their stable max. Adding Kever from Rockchip in Cc to have some input
> on the need to support those.

Good point.  We should remove the OPPs for both clusters that aren't
supported by all RK3588(s) binnings, to be on the safe side.

I'll hopefully dive into supporting different Rockchip binnings rather
soon.  There's even more about that, and not just with the RK3588(s),
which I think I'll get all covered.

