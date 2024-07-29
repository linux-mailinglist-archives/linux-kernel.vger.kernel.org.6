Return-Path: <linux-kernel+bounces-266326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B76C93FE2E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 21:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B5A31C222D7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 19:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09809187343;
	Mon, 29 Jul 2024 19:22:15 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313D784D34;
	Mon, 29 Jul 2024 19:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722280934; cv=none; b=u+MZaVZMq2rM5glUsvAlKwQLrAxVoIX9Ox273nvEcF/kkPN3VCWDaZWr5GJSx+2gkpQ+5U0F7iXCp7lDuyb+gEWvW7l7u8UXF/pISjPAHNPW3tye9Gc/i+sdGWWLeQl/9yDyqII3xMahAxpfGzDb7o/rhQXlzSpNBiqy4EcqDFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722280934; c=relaxed/simple;
	bh=mOfRS1Nw8ey6+muwNAxOfEuNvzUEh2WXLYGHHq8WeYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oYjYHQu+HHkR3F396eUnyydcQXS2gpQV0gVvLX6NCzAE1bPYq1FALAsAcXnamMyAJHei4KTUReQtmEiZzR5kiUUnnEOITLKfiuiGin5cWHTzPQfM2aapzmxPKOmJYwC7Kzut50JhUPgtO6OpSYyBRr8iJLHZ8pkSsiXGc3EP0/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e86192c.versanet.de ([94.134.25.44] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sYVwc-0007DX-3G; Mon, 29 Jul 2024 21:22:06 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Michael Riesch <michael.riesch@wolfvision.net>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject:
 Re: [PATCH] arm64: dts: rockchip: add wolfvision pf5 visualizer display
Date: Mon, 29 Jul 2024 21:22:05 +0200
Message-ID: <1941803.VZ3vTMCxA0@diego>
In-Reply-To: <171338906385.2268267.11350398666302673626.b4-ty@sntech.de>
References:
 <20240412-feature-wolfvision-pf5-display-v1-1-f032f32dba1a@wolfvision.net>
 <171338906385.2268267.11350398666302673626.b4-ty@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Mittwoch, 17. April 2024, 23:24:34 CEST schrieb Heiko Stuebner:
> On Fri, 12 Apr 2024 14:54:09 +0200, Michael Riesch wrote:
> > Add device tree overlay for the WolfVision PF5 Visualizer display.
> > Since there shall be additional variants of the WolfVision PF5 display in
> > future, move common definitions to a device tree include file.
> > 
> > 
> 
> Applied, thanks!
> 
> [1/1] arm64: dts: rockchip: add wolfvision pf5 visualizer display
>       commit: ecca3b96aa849bf7a6e704567c5f71bff912cec0

I have kept that patch around for a while, hoping the DTC patch would
get merged soon'ish, but it looks like this will still take a bit.

Keeping this patch on top of the pile makes everything hard, so sadly
I've dropped it for now.


Heiko



