Return-Path: <linux-kernel+bounces-551112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4005AA56855
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 13:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61A461889A13
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 12:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E38219A72;
	Fri,  7 Mar 2025 12:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="WMMJhBhR"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AEE184E;
	Fri,  7 Mar 2025 12:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741352091; cv=none; b=QAsSukeKXYnOmZF2g0op6omO9K2/4EiNQMqN8KyMtWkKZfBNXpR7yGl0itmC00KljWbKcv/eu1iN5qX/PCgNTppiKShwPD3LME5EAgzcsj86ehdhnyluZe2YFLqkhuB/nIk4hI11RM5yX6E29FEkvJpPTjT6j07FVleJftWCI+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741352091; c=relaxed/simple;
	bh=t98L1cJyPlqfqZqXYXCrH5GnatMIVTQhNMPpuL4im/E=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Ecgdq1mAZEJ9ebIAbrF3CpkWeC/FhZAtyk2sGswfruqDMSh/HzEKX1GLmXg289gG878aarvQzhBcS2Y9sP8BDWJc1R9/as5HMj91Ys6F/TpZEy5y4mWsGiMXrA2QE1BlD58r1Gah1lEJp7PZIA7RNkxyr6gijpqtXhS6wz++dOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=WMMJhBhR; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1741352085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U1IBEXO1K0l5EuPKHFBzRStL3WgZjK6CIvw+VolQFd4=;
	b=WMMJhBhRudn8CU78xN2jLApEoIVy9rZlY2pmDnhr2zeXZBVlzcEU83m0I/zzoJSHS3d62F
	c5urEaK+q7wOlW8MGfT+FDW49jLTGYxbXKZ7kMP5/XKSeWzcz030m0IUu2S2X0lLOYpeV4
	MLi9r5gzwPwWB0f9zz0BnHOS8TPEdMUHXVF3NEGVYvXmF4GPiZK7whf2iMgVyby45R5mR1
	LDp4gPWKA4YRH7hCyp6fBmAkfeEyUWxw3oBAHlVtWegLnb8l4/jrrRbTZU4VGNgBSleLwJ
	PxLF44RtB23hX5Buh4Quo/YLk2TgDZlmljoElh9oUikWqCPIJJkhv5iG+Ak1aQ==
Date: Fri, 07 Mar 2025 13:54:45 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 heiko@sntech.de, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] docs: dt-bindings: Specify ordering for properties
 within groups
In-Reply-To: <f9779027-63cf-4cb7-8399-1f3f1843c900@kernel.org>
References: <7276139ea1f4a5f4db48c77f536a3638492e6c2f.1741321984.git.dsimic@manjaro.org>
 <20250307-logical-nimble-okapi-3ba081@krzk-bin>
 <0df01d9863f72df3bebff1868f010954@manjaro.org>
 <f9779027-63cf-4cb7-8399-1f3f1843c900@kernel.org>
Message-ID: <02600009a6b478c43822239d6957dff8@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2025-03-07 13:41, Krzysztof Kozlowski wrote:
> On 07/03/2025 10:50, Dragan Simic wrote:
>>>> Applying strict alpha-numerical ordering can result in property 
>>>> lists
>>>> that
>>>> are suboptimal from the usability standpoint.  For the provided
>>>> example,
>>>> which stems from a real-world DT, [2][3][4] applying strict
>>>> alpha-numerical
>>>> ordering produces the following undesirable result:
>>> 
>>> BTW, your entire commit msg still has incorrect wrapping. Please use
>>> standard editors which understand Git commit msg style (which I 
>>> believe
>>> is equal to Linux submitting patches).
>> 
>> Sorry, but what makes the wrapping wrong?  I wrap patch descriptions
>> at or well before 78 columns, which I belive is the desired way to do
>> so.  The longest line in this patch description is 77 characters long,
>> which is still below 78 characters.
> 
> Because it is not correct. Read submitting patches. Run checkpatch.

Here's what scripts/checkpatch.pl returns:

WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit 
description?)
#10:
the property names can result in more logical and more usable property 
lists,

total: 0 errors, 1 warnings, 26 lines checked

So, it's just a warning, and if I wrap that single line before
column 77, checkpatch.pl stops complaining.  Thus, your earlier
broad statement that "your entire commit msg still has incorrect
wrapping" is simply wrong.

>> Also, please note that I don't "just use" some random editor, but I 
>> use
>> a highly customized Vim setup, in which I over time wrote about 46 KB
>> of Vimscript code in my ~/.vimrc, all by hand.  I've even contributed
>> smaller patches to Vim.
> 
> OK, so not random, but incorrectly configured. Different tools, same 
> result.

Could you, please let me know your thoughts about the actual
contents of the patch, regarding the settlement that I proposed
in my previous response?

