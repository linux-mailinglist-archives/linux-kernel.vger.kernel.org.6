Return-Path: <linux-kernel+bounces-278393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADF794AFA2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 20:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BD54B262AC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 18:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E87D13E028;
	Wed,  7 Aug 2024 18:25:13 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D372C6BB;
	Wed,  7 Aug 2024 18:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723055112; cv=none; b=hDPOx9j/e9srveqI73i7aO5So2nZfJUxkXdwIXmO4CoIhIMDRT4zXCqlGDcyRKVPoFqzWLRMq3zPywI0O0FrW4Dl5Mdoq/7Br2v5VCZYh0bk3jAVk2EwwoQqn014h7JePd0JF+scz/TJE1qYZFVC4j/NQNWmHHhoaKJG1hcqJo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723055112; c=relaxed/simple;
	bh=KKUu24oD2Wy0fXUYtZnkfFiLYDp69U/4eCTYHvVNweE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JJqF+PyQQ1Z8i1mQoVi69wZrCTAJOwBY+tp+gUaNV832AeAnZ25h/nx4JmoOJkomcI7p6//Dhe1QXqRtWYlwLuaX3flH3jDh8OX9ojDQ7EfJvbBgi2kSpvrrq3VMxE+4HE+vhBLUYdn+hhaNmwHWlyuqGl8EV3vOA+hFnINV6rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875a9f.versanet.de ([83.135.90.159] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sblL6-0002jz-NF; Wed, 07 Aug 2024 20:24:48 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Dragan Simic <dsimic@manjaro.org>, Florian Klink <flokli@flokli.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Muhammed Efe Cetin <efectn@protonmail.com>, FUKAUMI Naoki <naoki@radxa.com>,
 =?utf-8?B?VGFtw6FzIFN6xbFjcw==?= <tszucs@protonmail.ch>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v2] arm64: dts: rockchip: add rfkill node for M.2 E wifi on
 orangepi-5-plus
Date: Wed, 07 Aug 2024 20:24:47 +0200
Message-ID: <4124439.ReJHH8Nr61@diego>
In-Reply-To: <krvprzy3iz5b7n37eo2mb6sol6pcjkxsjdbdi6sxeebwveqtnr@e52cvrlkdjsa>
References:
 <20240807162001.1737829-1-flokli@flokli.de>
 <a10e70e2d67b9d63f2296b36b4cb3719@manjaro.org>
 <krvprzy3iz5b7n37eo2mb6sol6pcjkxsjdbdi6sxeebwveqtnr@e52cvrlkdjsa>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Mittwoch, 7. August 2024, 20:14:24 CEST schrieb Florian Klink:
> On Wed, Aug 07, 2024 at 07:24:27PM GMT, Dragan Simic wrote:
> >On 2024-08-07 19:00, Florian Klink wrote:
> >>This follows the same logic as 82d40b141a4c ("arm64: dts: rockchip: add
> >>rfkill node for M.2 Key E WiFi on rock-5b").
> >>
> >>On the orangepi-5-plus, there's also a GPIO pin connecting the WiFi
> >>enable signal inside the M.2 Key E slot.
> >>
> >>The exact GPIO PIN can be validated in the Armbian rk-5.10-rkr4 kernel
> >>rk3588-orangepi-5-plus.dtsi file [1], which contains a `wifi_disable`
> >>node referencing RK_PC4 on &gpio0.
> >>
> >>Signed-off-by: Florian Klink <flokli@flokli.de>
> >>Tested-by: Florian Klink <flokli@flokli.de>
> >
> >I forgot to mention that providing a Tested-by tag is redundant when
> >there's already a Signed-off-by tag, because the latter already implies
> >the former.
> 
> This came after I sent the v3. Generally I wish people would test things
> - though too often it's not. I explicitly tested this to work (with a
> wifi module added to that slot being unblock-able afterwards), and
> wanted to point that out, thus adding the Tested-by.
> 
> DCO 1.1 doesn't say anything about Tested-by, it's mostly legalese about
> being allowed to send out the patch, and understanding the consequences
> regarding licensing. It doesn't require the person adding their
> Signed-Off-By to have tested it.

While the DCO may not say it, everyone else will simply require it though ;-) .

Aka no maintainer will apply a patch without the submitter having tested
their change. This is just implicitly expected.

Like if it comes to light later that the change was not tested before
submission that creates quite a trust-issue between submitter and
maintainer on future submissions.


Heiko



