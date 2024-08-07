Return-Path: <linux-kernel+bounces-278326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 624C794AEC2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 19:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 290DFB28CF2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 17:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DFB313C9A7;
	Wed,  7 Aug 2024 17:18:18 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5440612C475;
	Wed,  7 Aug 2024 17:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723051097; cv=none; b=uvfdyPV94JQx3a23yfL/e7YxGq2ifwHAAZV94u/8zJav3qVn8Bmpjr6c6GoTev1Ku4dOsRUkg1zYwuKKDDgqW98LBfzRrDCGa1viI/br6oYztd/p1fBShr7dQ5EazOg1BbTRJ00EdcFYABG+wnbUlxswoDF2bk9C/U9Vouix8V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723051097; c=relaxed/simple;
	bh=99br1nIhd5bGZFA8uHRJ7NLi3hg7mbOfKCb2HfREdZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XJlpwQc0VdC6PuffQJe9S/yajSDtDvCfAE+uFjtNsPl41KQwQaphN/FZO1sbUfmYOEgwO2HSNdHsZ97Q9VQRrn3htlYLvy+VWeKODhL/Rc7JKXnqZqYJeOr0Eck7G3j4/dKSMirsNk5avGvRNng1tII/qxMHI0pGlBWqxiPRwuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875a9f.versanet.de ([83.135.90.159] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sbkII-0002MU-H9; Wed, 07 Aug 2024 19:17:50 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Florian Klink <flokli@flokli.de>, Dragan Simic <dsimic@manjaro.org>
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
Date: Wed, 07 Aug 2024 19:17:49 +0200
Message-ID: <4364452.rE2NhlSrgm@diego>
In-Reply-To: <c1cd51655f783d9ec2f6f068590c2a35@manjaro.org>
References:
 <20240807162001.1737829-1-flokli@flokli.de>
 <20240807170030.1747381-1-flokli@flokli.de>
 <c1cd51655f783d9ec2f6f068590c2a35@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Florian,

Am Mittwoch, 7. August 2024, 19:15:03 CEST schrieb Dragan Simic:
> On 2024-08-07 19:00, Florian Klink wrote:
> > This follows the same logic as 82d40b141a4c ("arm64: dts: rockchip: add
> > rfkill node for M.2 Key E WiFi on rock-5b").
> > 
> > On the orangepi-5-plus, there's also a GPIO pin connecting the WiFi
> > enable signal inside the M.2 Key E slot.
> > 
> > The exact GPIO PIN can be validated in the Armbian rk-5.10-rkr4 kernel
> > rk3588-orangepi-5-plus.dtsi file [1], which contains a `wifi_disable`
> > node referencing RK_PC4 on &gpio0.
> > 
> > Signed-off-by: Florian Klink <flokli@flokli.de>
> > Tested-by: Florian Klink <flokli@flokli.de>
> > Link:
> > https://github.com/armbian/linux-rockchip/blob/9fbe23c9da24f236c6009f42d3f02c1ffb84c169/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
> > [1]
> 
> Unfortunately, this isn't how the "Link: ..." tag is to be used, or how
> a reference is to be provided.  Please see the patch submission linked
> below for a correct example of providing links as references.
> 
> https://lore.kernel.org/linux-rockchip/4449f7d4eead787308300e2d1d37b88c9d1446b2.1717308862.git.dsimic@manjaro.org/T/#u

please also don't post v2 patches as replies to v1.
Instead start a new mail thread please.

A lot of tooling cannot really find the correct version in such
multiversion threads.

Heiko



