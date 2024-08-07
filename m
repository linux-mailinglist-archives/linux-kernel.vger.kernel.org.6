Return-Path: <linux-kernel+bounces-278341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FFD94AEEE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 19:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 338F61F226DC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 17:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BB113D258;
	Wed,  7 Aug 2024 17:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="AeSpDEIt"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63D313AA2B;
	Wed,  7 Aug 2024 17:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723051932; cv=none; b=AM4tVE4ZyxRVNIVqEwuUIjmsc4gcg0aNp2yFjmgC5bkkF9mBO/HA/JFqd9DSuP1xRCds2kKgmA7+B7qGouhj2idARWNtu85C9eMcPfQf9bA1mSDfsfJAwLkx6OacyF2xpXtOFQXuE3DeQL908/tCmmfQ/G5utmsXbqD0aA+3AZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723051932; c=relaxed/simple;
	bh=Kyzhtcp8YwehVXY2zuLqVHb9oj/LCAB3wKlRbx6FMtI=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=tkHf9/AsMtOHQGd6TBj8PQg6QRqpL/setdrlqDPL9UlLWN0CbMhNFpL4FLkT1aIkEpuSiD4YBFsE3kWsqQC4C/pkC3eHOgfxCucDeu+waTnacX3P49iZCjuo/wzlGZsfMQ0fSJqMSRugVYBTmMuETj2CMsBEnXsU6jnCOAXhcXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=AeSpDEIt; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1723051927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MUNN0AugEZ1zPnIu0ewnWkrGOsYCX84PMrFL5jeb/Zc=;
	b=AeSpDEItCSMqhZdwouuVi3u6JOcbGyrpEG0X8dpagAL5NtxFRX/x6W636AyRv56IWhlECN
	s48UEFjA+FONFfb7Q/3BoUorCOOGsT3AnV0A+AXNe2WdHx/TQiACct0E60jAGzc8hwOTMA
	J8icx/RkkH0Wj+kFsdvm3Xy/zQwJ7mkAXSRZHx8ZR0kumDyYlhyUx73skUGI5xmOSr7KNu
	QVOTkPKbClTwgJBXYnjWyAZVqwcuRsdlsZbdRs81B1ryfX83HcIZCjbX4oZ6hdBj99TwZv
	CZaDgUUGzgMKmDtYgfIsCpLcJsDzHQ2NPEJVeoxGC4NflXbUvwS16l5c0eT0EQ==
Date: Wed, 07 Aug 2024 19:32:07 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Florian Klink <flokli@flokli.de>
Cc: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Sebastian Reichel <sebastian.reichel@collabora.com>,
 Kever Yang <kever.yang@rock-chips.com>, Muhammed Efe Cetin
 <efectn@protonmail.com>, FUKAUMI Naoki <naoki@radxa.com>, =?UTF-8?Q?Ta?=
 =?UTF-8?Q?m=C3=A1s_Sz=C5=B1cs?= <tszucs@protonmail.ch>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: rockchip: add rfkill node for M.2 E wifi
 on orangepi-5-plus
In-Reply-To: <q7db4syvuz3qsssgznjnwujm25gzmxdf7n5dzjhmmwsaxssk5e@5ecftp23wc7p>
References: <20240807162001.1737829-1-flokli@flokli.de>
 <20240807170030.1747381-1-flokli@flokli.de>
 <c1cd51655f783d9ec2f6f068590c2a35@manjaro.org> <4364452.rE2NhlSrgm@diego>
 <q7db4syvuz3qsssgznjnwujm25gzmxdf7n5dzjhmmwsaxssk5e@5ecftp23wc7p>
Message-ID: <c54832e02d1dbf7597a2c2d57e665e1a@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-08-07 19:28, Florian Klink wrote:
> On Wed, Aug 07, 2024 at 07:17:49PM GMT, Heiko Stübner wrote:
>> Am Mittwoch, 7. August 2024, 19:15:03 CEST schrieb Dragan Simic:
>>> On 2024-08-07 19:00, Florian Klink wrote:
>>> > This follows the same logic as 82d40b141a4c ("arm64: dts: rockchip: add
>>> > rfkill node for M.2 Key E WiFi on rock-5b").
>>> >
>>> > On the orangepi-5-plus, there's also a GPIO pin connecting the WiFi
>>> > enable signal inside the M.2 Key E slot.
>>> >
>>> > The exact GPIO PIN can be validated in the Armbian rk-5.10-rkr4 kernel
>>> > rk3588-orangepi-5-plus.dtsi file [1], which contains a `wifi_disable`
>>> > node referencing RK_PC4 on &gpio0.
>>> >
>>> > Signed-off-by: Florian Klink <flokli@flokli.de>
>>> > Tested-by: Florian Klink <flokli@flokli.de>
>>> > Link:
>>> > https://github.com/armbian/linux-rockchip/blob/9fbe23c9da24f236c6009f42d3f02c1ffb84c169/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
>>> > [1]
>>> 
>>> Unfortunately, this isn't how the "Link: ..." tag is to be used, or 
>>> how
>>> a reference is to be provided.  Please see the patch submission 
>>> linked
>>> below for a correct example of providing links as references.
>>> 
>>> https://lore.kernel.org/linux-rockchip/4449f7d4eead787308300e2d1d37b88c9d1446b2.1717308862.git.dsimic@manjaro.org/T/#u
>> 
>> please also don't post v2 patches as replies to v1.
>> Instead start a new mail thread please.
>> 
>> A lot of tooling cannot really find the correct version in such
>> multiversion threads.
> 
> sorry for the noise. I sent a v3, addressing the requested changes, as 
> a
> new thread.
> 
> Somewhat offtopic for this patch, but it'd be great if
> process/submitting-patches.html could include:
> 
>  - A mention of the kernel quotation style for commit ids and subjects
> 	 and how to produce them
>  - A styleguide for how to link to references
>  - An active discouragement from using --in-reply-to for v2 (which
> 	 differs from what `git send-email` proposes).

I'd suggest that you go ahead and whip up a new patch that adds those
specific instructions to the documentation.

