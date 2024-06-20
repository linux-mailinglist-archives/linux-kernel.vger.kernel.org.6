Return-Path: <linux-kernel+bounces-223335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E540691114C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 20:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C54E6B2BCA5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 18:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631411BB6A3;
	Thu, 20 Jun 2024 18:39:54 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D811B9AB0;
	Thu, 20 Jun 2024 18:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718908793; cv=none; b=Hpimxcz5IUeUoe3IgYNw9+F0XcNTelcpRKOWN0tgJftTD3n4qKDmS/pxRIkyGBqFjXHUreNwEtcnlAyjtqnOC3BIc1/qkpk/NbH0c1/I22SimY/w2vWgrAz6cpjzae/hAH6b7PshB4BkDrbPi5tbQfsOti31WGGaBpQnHP/yZzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718908793; c=relaxed/simple;
	bh=ect3o+WXx/8Mtj30Y52UBbKc1pPxHH6COoSG4HKXAqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AT6BeatEXw3Qa9kyOGvUayYwLB25LDBLra6diB2ScXfY1WUIKzC/jEIK8z0XkVV4j6uu1pEuzlJ1WPd9QoZcVdX+5obXysB0NubNTKsVMfGQHOIDEvOrQFMp9yUVf76HXVJ5tfkyQvue7fc0KvHHtKXq2El5epw2O7MXTbc6pRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e860cc8.versanet.de ([94.134.12.200] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sKMhF-0000W2-Ed; Thu, 20 Jun 2024 20:39:45 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Sebastian Kropatsch <seb-dev@mail.de>
Cc: linux-rockchip@lists.infradead.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] arm64: dts: rockchip: Fix regulators,
 gmac and naming on NanoPi R6C/R6S
Date: Thu, 20 Jun 2024 20:39:44 +0200
Message-ID: <2396550.3c9HiEOlIg@diego>
In-Reply-To: <20240612205056.397204-3-seb-dev@mail.de>
References:
 <20240612205056.397204-1-seb-dev@mail.de>
 <20240612205056.397204-3-seb-dev@mail.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Mittwoch, 12. Juni 2024, 22:48:11 CEST schrieb Sebastian Kropatsch:
> Fix the alphabetical ordering in some nodes and rename some regulators
> and pins to match the schematics [1][2] as well as to adhere to
> preferred naming schemes.

General rule of thumb, when you need an "and" in your subject or a list
like the above - you definitly want to split the change into multiple
commits.

> In addition to that:
> * vcc_3v3_sd_s0: Fix voltage to be 3.3V
> * vcc3v3_pcie:
>     - Move to NanoPi R6C, this power switch is not available on R6S
>     - Fix vin-supply (is vcc_5v0 per schematics)
>     - Add gpios/pincrtl to enable power

this defnitly needs its own patch

> * vcc5v0_usb: Remove this regulator since according to the schematics,

this too

> * vcc5v0_host_20 and vcc5v0_usb_otg0 are directly powered by vcc_5v0

this could be grouped together with the 3.3v change

> * gmac1: Add rx_delay of 0 (no delay since phy-mode = "rgmii-rxid")

with rxid mode, why is the rx_delay needed at all?
Shouldn't this just work without the property?

> * rgmii_phy1: Add phy-supply as seen in schematics

separate patch

> * pcie2*:
>     - Add pinctrl reset pins
>     - Update vpcie3v3-supply to match the schematics

separate patch

> * sdhci: Add vmmc-supply and vqmmc-supply

separate patch


Heiko



