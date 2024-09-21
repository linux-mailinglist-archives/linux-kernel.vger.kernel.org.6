Return-Path: <linux-kernel+bounces-334774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 924F697DC01
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 09:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6E971C20FAB
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 07:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55CA014F9F1;
	Sat, 21 Sep 2024 07:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="Atj3S5ZA"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6E755E73
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 07:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726904659; cv=none; b=jGcjwguAa6mEgqoauJqz5UzBDR+THHvMJ8vntD3R+IKwQeDIi87ltwLilXf21PZtuLN0P4e0yET4FFnU674kPNOgd3ZVCHC7PmyPai1NBelL6ixx41zbwLJ6q8L+Oz1ETw33yXUJigYuSoed3txldpQ35ESE+pUw7sfPDwkuJPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726904659; c=relaxed/simple;
	bh=M52KHEvgxb3s8a3iS4DMJ1LIeehWXqsgOc5+rNMaouA=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=VGcWYyhI8cjhB7Ldha3FRfwba3yme8apMDC60ErwMbJV5C9UTdxJB8POE0MCt+fz1Mgjisu8ygbUJ8ZMt0s9dta31LgXevwmViQjAmKjAZzGYhx1TeuggleK4Nw8nPIrLoHi363SXecyWJqGgKZQcwMXp9teHuqgf0f5z/nEzrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=Atj3S5ZA; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1726904648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4cVbtG6UBv+JOdpJncJVPMzEBH9bGJcgKZgxZYkLoBc=;
	b=Atj3S5ZAGPhAitPL064StmMbyBJGP8gUz9EdUuNDhbkh12XY5djHGPC5LChIAFvbPpUMaZ
	w8liL20pF/PSP24YNpl6AIdGd2dM4/pGNlBwPi+IU6zdDLFaoR0yyoEBAGTF7PKoIVNON7
	Mpx+DvSBsMkQGabh7SGMm+TTuImEk2XcD6Jq8TAXIwzXx/Zv6tAPaxN+SwrmbE9GVy9zQf
	Nu58Ki+8gyDt/RFfFgwGks2kiiGoIfzqB93wQBY34zYP8zlpGuGk4SYSViKRuakGTs+2G5
	GijMqjGgmJkiQECHmCZ3W9U4qqr2XYWjDzrUXgx2ylbMlp6GTKid2Sp3MPN33A==
Date: Sat, 21 Sep 2024 09:44:06 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megi@xff.cz>
Subject: Re: [PATCH] arm64: dts: sun50i-a64-pinephone: Add mount matrix for
 accelerometer
In-Reply-To: <b4139fedf81f3a3fc94d361b7f013109@manjaro.org>
References: <20240916204521.2033218-1-andrej.skvortzov@gmail.com>
 <6e5d0e9978bff30559c17f30d1495b59@manjaro.org> <ZunCysUTSfQU1ylg@skv.local>
 <c7664fda936d36e0d916ae09dd554d2e@manjaro.org> <ZuqyuvZ6tdzp5XSW@skv.local>
 <8df5fc79a3e899738aa944a290774c72@manjaro.org> <ZurYndjVz7r0U6dz@skv.local>
 <Zur4rhyT50lwxE_v@skv.local> <b4139fedf81f3a3fc94d361b7f013109@manjaro.org>
Message-ID: <816a0e142e8f4d4ff9368f69adb68ba5@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Andrey,

On 2024-09-19 20:34, Dragan Simic wrote:
> On 2024-09-18 17:58, Andrey Skvortsov wrote:
>> On 24-09-18 13:27, Dragan Simic wrote:
>>> Actually, unless my analysis is proven wrong, perhaps it would
>>> be better if I'd submit this patch in its final form, because it
>>> has diverged a lot from the original patch.  IIUC, Ondrej only
>>> imported the original patch from somewhere, without some kind of
>>> proper attribution. [4]
>>> 
>>> [4] 
>>> https://xff.cz/kernels/6.9/patches/0221-arm64-dts-sun50i-a64-pinephone-Add-mount-matrix-for-.patch>>
>> 
>> please, submit your version of this patch. I'd be glad to review it (I
>> think, I've already did)
> 
> Yes, you basically already did that. :)  Thanks, I'll send my version
> of the patch in the next few hours, with proper attribution included
> for you and Ondrej, of course.

It would be great if you could provide your Reviewed-by tag.

For future reference, i.e. for anyone reading the mailing list
archive at some point in the future, here's the link to my version
of this patch:

https://lore.kernel.org/linux-sunxi/129f0c754d071cca1db5d207d9d4a7bd9831dff7.1726773282.git.dsimic@manjaro.org/

