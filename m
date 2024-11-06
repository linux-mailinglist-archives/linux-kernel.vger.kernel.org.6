Return-Path: <linux-kernel+bounces-398033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B20B9BE48B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 11:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1129C28359D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 10:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23741DE2C1;
	Wed,  6 Nov 2024 10:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="xsyXRFSj"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE901D2F42;
	Wed,  6 Nov 2024 10:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730889911; cv=none; b=jVUy1Zavc5Zb2emq84GOsNc60JKWuX40Nhgp6qOK+34WomV8DCNpKZqqfPIADn2tt1mUHjIRmM6hNV8yV83hBKv7rFh3uLq2G6YPomF51jpjEKfOS6RTAcshSsHXyZivT31tdbgFZXGuaAV4/JisE7XQwUiPQP73KXab0SZs+K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730889911; c=relaxed/simple;
	bh=VYbrb9NXcVzqwFStRd289eGd3x0lBWwnfDGWq7prPCQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=G9gJhzV4t1Uh2pRyWg99GNkERm76NxkpMxk/NaqiI3QfDe8vieZxKKfcabbWHQd4NP4p76yH/571/9e2+uGx1DjdnTqAinR13jruYYhKH2238RwqV7lfPQM1DvMIS1c7nwlmDBkN5Ul6zclGtUnNeozYedLU4X+08Uy4AC+HHjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=xsyXRFSj; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1730889906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X8FgUJIVPnDpXU0UCJKNG07n1qA7azNbt7tpYPJJ9xQ=;
	b=xsyXRFSjJuvIbSEjNJMRsLDbna6IqWYVKDqByUClVhHGywFD1sM/9Xjpu9MNIU80TEZukh
	7HdK2aHO5PoYyj7SA04iVGh6LkXj2OK7QGdKwrJE31puGhujKR0ut9nCaJDQEqimpS1609
	Qkhasy/4DzuL8PPbL3kUiZy23y6ZzmNlz61pTuYSYaF3G45ORvEvJ+aCquHi284ZpCN0d3
	YQXZneHi7OP0ShfNFZfhCCuoYAMkz57Tl9eceq21x1HX4rduuCp6GVy2qHGBZZkmkb82xd
	FqhoUyAJFDTD2Wez0IsXX6uWOceKqSHbqV0m/sktblx46vPe/+4AGGBNKnh6qw==
Date: Wed, 06 Nov 2024 11:45:06 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc: linux-rockchip@lists.infradead.org, Quentin Schulz
 <quentin.schulz@cherry.de>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, alchark@gmail.com
Subject: Re: [PATCH v2] arm64: dts: rockchip: Add OPP voltage ranges to RK3399
 OP1 SoC dtsi
In-Reply-To: <3252308.5fSG56mABF@diego>
References: <dbee35c002bda99e44f8533623d94f202a60da95.1730881777.git.dsimic@manjaro.org>
 <f6bb3387-4396-45d4-9cb4-594d58095510@cherry.de> <3252308.5fSG56mABF@diego>
Message-ID: <77bc2898bbbd2633d6713b4935bd5ee3@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Heiko,

On 2024-11-06 10:41, Heiko Stübner wrote:
> Am Mittwoch, 6. November 2024, 10:32:06 CET schrieb Quentin Schulz:
>> On 11/6/24 9:33 AM, Dragan Simic wrote:
>> > Add support for voltage ranges to the CPU, GPU and DMC OPPs defined in the
>> > SoC dtsi for Rockchip OP1, as a variant of the Rockchip RK3399.  This may be
>> > useful if there are any OP1-based boards whose associated voltage regulators
>> > are unable to deliver the exact voltages; otherwise, it causes no functional
>> > changes to the resulting OPP voltages at runtime.
>> >
>> > These changes cannot cause stability issues or any kind of damage, because
>> > it's perfectly safe to use the highest voltage from an OPP group for each OPP
>> > in the same group.  The only possible negative effect of using higher voltages
>> > is wasted energy in form of some additionally generated heat.
>> >
>> > Reported-by: Quentin Schulz <quentin.schulz@cherry.de>
>> 
>> Well, I merely highlighted that the voltage was different on OP1
>> compared to RK3399 for the 600MHz OPP :)
>> 
>> So... If there's ONE SoC I'm pretty sure is working as expected it's 
>> the
>> OP1 fitted on the Gru Chromebooks with the ChromiumOS kernel fork
>> (though yes, I believe all Gru CB are EoL since August 2023). In the 
>> 6.1
>> kernel fork, there's also no range:
>> https://chromium.googlesource.com/chromiumos/third_party/kernel/+/refs/heads/chromeos-6.1/arch/arm64/boot/dts/rockchip/rk3399-op1-opp.dtsi
> 
> yeah, this somehow goes quite a bit into the "stuff that doesn't need 
> to
> change" area. On the one hand it does make "some" sense to unify things
> if we're using ranges everywhere else.

I agree that it might be unneeded, but there's no possible harm, and
unifying the things may be seen as beneficial.

> On the other hand, as Quentin noted below, all existing OP1 devices 
> seem
> to run just fine, and there won't be any more entering the kernel.

Hmm, why can't we add more OP1-based devices?  As I mentioned in my
earlier response to Quentin, my plan is to implement the board dts
for OP1-based TinkerBoard 2S, so I'd like to know is there something
that might prevent that board dts from becoming merged?

> So what do we realisitically gain here, except hiding existing 
> git-history
> under another layer?

Sorry, I'm not sure what would become hidden by this patch?

>> So not sure we need to handle theoretical cases here. Will let
>> maintainers decide on that one. FWIW, there are two other OP1 devices,
>> the RockPi4A+ and RockPi4B+ which do not change the OPP either.

