Return-Path: <linux-kernel+bounces-278338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8211494AEE8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 19:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4403A28360F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 17:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7019E13D63E;
	Wed,  7 Aug 2024 17:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=flokli.de header.i=@flokli.de header.b="JlO/hfdU"
Received: from mail.flokli.de (mail.flokli.de [116.203.226.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD8313CFA3;
	Wed,  7 Aug 2024 17:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.226.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723051741; cv=none; b=PwsauKNF2gN6O/KKFDuOgp+mGc8YBcang+HMMw6YEGfAL2qDT5rLJI/TMWhpHYWD7AhzGzypymJ/APQ5PSg56+yHJH7Ct3VU7FE20zeL2gkaJ3pHsyXMwdDL+mDdSXjyUISZzvffhn1smwda9pM4jX2jDMuY/GGt0zYGUk/Mq/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723051741; c=relaxed/simple;
	bh=CdQYQng1XcB/PNUN/RmqM0IWBeKhBQdHhMdIMLbqluM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=alButcV2J9NZWaH9RN9p2PZciLSaBrRZr22KNgmdhQTdc4XxHMFDBwDB4pd2Ldc28thlHeXAvo0116oVMidOwnuFke+W+KLMm1ez6gwuZqtMH8XM/EuT6swjyXhtp6zO1Bfpvbn44Uf2PuM+LeW8YGItPzHgg+6u4YRxAkdzpIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flokli.de; spf=pass smtp.mailfrom=flokli.de; dkim=pass (1024-bit key) header.d=flokli.de header.i=@flokli.de header.b=JlO/hfdU; arc=none smtp.client-ip=116.203.226.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flokli.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flokli.de
Date: Wed, 7 Aug 2024 20:28:54 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flokli.de; s=mail;
	t=1723051735; bh=rHo5vM6cqAZ+OgnVua1TaGhVLFcBFB3aUwuIxSftVwA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JlO/hfdUSeW9lyknaUkJwym9NccGsVaiBIKvyLsM6kaVMI+/EVLvPzQ6J0jqpBBhY
	 JeWpvRhH6sr9P36rVsoiihl51JSy965kQDNQzDL2rU3ZHwMJcmBp+k9HrSAio3mezi
	 Wd0w1Wizq+UQoc85UVzLJElJ55ZFNDBk7eAJ9GPg=
From: Florian Klink <flokli@flokli.de>
To: Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>
Cc: Dragan Simic <dsimic@manjaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sebastian Reichel <sebastian.reichel@collabora.com>, Kever Yang <kever.yang@rock-chips.com>, 
	Muhammed Efe Cetin <efectn@protonmail.com>, FUKAUMI Naoki <naoki@radxa.com>, 
	=?utf-8?B?VGFtw6FzIFN6xbFjcw==?= <tszucs@protonmail.ch>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: rockchip: add rfkill node for M.2 E wifi
 on orangepi-5-plus
Message-ID: <q7db4syvuz3qsssgznjnwujm25gzmxdf7n5dzjhmmwsaxssk5e@5ecftp23wc7p>
References: <20240807162001.1737829-1-flokli@flokli.de>
 <20240807170030.1747381-1-flokli@flokli.de>
 <c1cd51655f783d9ec2f6f068590c2a35@manjaro.org>
 <4364452.rE2NhlSrgm@diego>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4364452.rE2NhlSrgm@diego>

Hey,

On Wed, Aug 07, 2024 at 07:17:49PM GMT, Heiko Stübner wrote:
>Hi Florian,
>
>Am Mittwoch, 7. August 2024, 19:15:03 CEST schrieb Dragan Simic:
>> On 2024-08-07 19:00, Florian Klink wrote:
>> > This follows the same logic as 82d40b141a4c ("arm64: dts: rockchip: add
>> > rfkill node for M.2 Key E WiFi on rock-5b").
>> >
>> > On the orangepi-5-plus, there's also a GPIO pin connecting the WiFi
>> > enable signal inside the M.2 Key E slot.
>> >
>> > The exact GPIO PIN can be validated in the Armbian rk-5.10-rkr4 kernel
>> > rk3588-orangepi-5-plus.dtsi file [1], which contains a `wifi_disable`
>> > node referencing RK_PC4 on &gpio0.
>> >
>> > Signed-off-by: Florian Klink <flokli@flokli.de>
>> > Tested-by: Florian Klink <flokli@flokli.de>
>> > Link:
>> > https://github.com/armbian/linux-rockchip/blob/9fbe23c9da24f236c6009f42d3f02c1ffb84c169/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
>> > [1]
>>
>> Unfortunately, this isn't how the "Link: ..." tag is to be used, or how
>> a reference is to be provided.  Please see the patch submission linked
>> below for a correct example of providing links as references.
>>
>> https://lore.kernel.org/linux-rockchip/4449f7d4eead787308300e2d1d37b88c9d1446b2.1717308862.git.dsimic@manjaro.org/T/#u
>
>please also don't post v2 patches as replies to v1.
>Instead start a new mail thread please.
>
>A lot of tooling cannot really find the correct version in such
>multiversion threads.

sorry for the noise. I sent a v3, addressing the requested changes, as a
new thread.

Somewhat offtopic for this patch, but it'd be great if
process/submitting-patches.html could include:

  - A mention of the kernel quotation style for commit ids and subjects
	 and how to produce them
  - A styleguide for how to link to references
  - An active discouragement from using --in-reply-to for v2 (which
	 differs from what `git send-email` proposes).

Florian

