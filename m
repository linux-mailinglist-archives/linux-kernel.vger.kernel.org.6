Return-Path: <linux-kernel+bounces-316971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5258496D7B5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 13:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7CFE1F21677
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 11:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E8219A2A2;
	Thu,  5 Sep 2024 11:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="d6cDH/VF"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F273194C65;
	Thu,  5 Sep 2024 11:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725537322; cv=none; b=q6pSmvHd8LyqJyvH5yhLIf5PGbl44mMIKiFZfiIs+8Fqeka2sHg47/xvYeHpfUEzjOsT0w/YxsDydgt8HRGBmjGUri5gAnrTurWht1lQFUhIJh6J7Pk15+YxIDCP5Pog3yzVTCHpC4CT4aHM3bTj9LrLVH28UsX2C3huIORTwzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725537322; c=relaxed/simple;
	bh=jSetfquzpmF62muhBT/L3l/qbjSvIT+AerCCCMOuNQ4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=k+MoqaLzYi/I61Hv6oh1WIwpZ99X2HidXigcWTqsXWkLd6TSjj1v5Ka3N9ia78JHQ/xJR30ifM59Ulms34uQcxGavZkDU1+gDlnjmHVxf78f7pM1dTPIOsbpSBxcLy17WIkfo+tXSDwFI/BASPVZ1iednaChtd5J9yHBgQjNuU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=d6cDH/VF; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1725537318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7lrJXO1W4YN3/zquz/ykgMmTRr2bRbz5txPQeyarbwQ=;
	b=d6cDH/VFE0XpvelPCCctGpR1Id/Tm9O/1zoppYApE8HNE0MplV0/rqsvTKtUeOW8V6ifuY
	8WQ5GYyIdQzlHL/A+rOGeSZ8m2GsHaSNszHvndNPRiceSfuRCVMFWTrkcgbweGGgzqrpLq
	xvJGuk2omZC7HYsxuxD54TxNclRTfW5/aJ4KoSncyw8VU9Y1ocwlmPGp2UmN5eEzdF2EMB
	mGeD4CMA8a99v2qp+IfYaL//3L0gPOSl+ZRf+9jOT8nC1KXqAuwrCKHzjF/vFpA7XIUxBu
	EuLj0G55GGxt8dtVjBQr+nbrZ7q2DGk7fEVjRoPu2lMRL0MYR6vLVAa4Liqvsg==
Date: Thu, 05 Sep 2024 13:55:18 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-rockchip@lists.infradead.org, heiko@sntech.de,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-kernel@vger.kernel.org, Diederik de Haas <didi.debian@cknow.org>
Subject: Re: [PATCH] arm64: dts: rockchip: Add a few aliases to the PineTab2
 dtsi
In-Reply-To: <6b51f810-438c-42fe-92c2-87966906b534@kernel.org>
References: <987e68d1c5e9a0cc56d730aec87246aa5ab8ea14.1725535770.git.dsimic@manjaro.org>
 <c820085c-a4f4-4d03-9df8-733a79e911c0@kernel.org>
 <946b8248f5b282a8532c8532a3eda98e@manjaro.org>
 <6b51f810-438c-42fe-92c2-87966906b534@kernel.org>
Message-ID: <48e02d2d4d50892e8ea32975b2017195@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-09-05 13:48, Krzysztof Kozlowski wrote:
> On 05/09/2024 13:43, Dragan Simic wrote:
>> Hello Krzysztof,
>> 
>> On 2024-09-05 13:39, Krzysztof Kozlowski wrote:
>>> On 05/09/2024 13:32, Dragan Simic wrote:
>>>> Sprinkle a few commonly used aliases onto the PineTab2 dtsi file, to
>>>> improve
>>>> its readability a bit, to make it easier to refer to the actual 
>>>> nodes
>>>> later,
>>>> if needed, and to add a bit more detail to some of the labels.
>>>> 
>>>> No functional changes are introduced, which was validated by
>>>> decompiling and
>>>> comparing all affected board dtb files before and after these 
>>>> changes.
>>>>  When
>>>> compared with the decompiled original dtb files, some of the 
>>>> phandles
>>>> in the
>>>> updated dtb files have different values, and the updated dtb files
>>>> contain
>>>> some additional phandles and additional symbols that come from the
>>>> introduced
>>>> aliases, but they still effectively remain the same as the 
>>>> originals.
>>>> 
>>>> Suggested-by: Diederik de Haas <didi.debian@cknow.org>
>>>> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
>>>> ---
>>> 
>>> Unused aliases do not improve readability, so for me this change is
>>> making code worse without valid reason.
>> 
>> Then why do we already have, for example, unused "rk817_charger:
>> charger"
>> aliases in quite a few board dts(i) files?  If those are actually seen
> 
> Ask contributors...

That would be a lot of work for next to nothing.  Actually, I believe
those aliases were simply copied and pasted, at least when it comes to
the "rk817_*" aliases that are unused without doubt.

>> as
>> redundant, we should remove all of them.
> 
> They are already there, so dropping them is close to unnecessary churn.
> And quite a lot of work to investigate the reason behind EACH label.

Hmm, it's true that a lot of work would be needed.  On the other hand,
how about adding these aliases to the PineTab2 dtsi for the sake of
consistency with the other similar board dts(i) files?  For example,
grepping for "rk817_charger", which is used as an alias in all other
dts(i) files for boards that use RK817, currently omits the PineTab2
dtsi.  I see that as a downside that this patch attempts to improve.

