Return-Path: <linux-kernel+bounces-218289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2586F90BC24
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 22:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A2B51C20CEF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 20:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8F6191467;
	Mon, 17 Jun 2024 20:27:56 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8B0F9F7;
	Mon, 17 Jun 2024 20:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718656075; cv=none; b=NYu5/l6FJSaCr4pm9dmnNpEBXubVw7KnRXfPaKn48HtyjLAVbPtB6tk+dqxpV5F1lAyGfyR6MMRGxJiNo9+qp2gg98C2kwGaizKBa7oWc95wpB9TgSSQa/SM4pm6R/1EOzMMEs9nxngIb1bJV+td+5HS9l7nb8yE6IFeL0KzfG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718656075; c=relaxed/simple;
	bh=kntQSZpBIhbGGTbtMOzZNAQUp2O2VDHwMPPbzIoQ//E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fl+77N0UdsJvYUOB0XtTOOAv25o83usoSWFa+SctK+0BlqBD8O+P5rRBkCfWwW9XAI497m1axHJRiQ9aLTASPTToKkFfQk3S2yZ7faLr/NwKdYAC20aRer0GyNFQjHa6qFnEDyIse05o0aEp4KDDQOpTiJpDMFnLXdGkRtrci6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e8616c2.versanet.de ([94.134.22.194] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sJIx2-0003YP-4q; Mon, 17 Jun 2024 22:27:40 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 Jacobe Zang <jacobe.zang@wesion.com>
Cc: nick@khadas.com, efectn@protonmail.com, jagan@edgeble.ai,
 dsimic@manjaro.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Jacobe Zang <jacobe.zang@wesion.com>
Subject:
 Re: [PATCH v2 3/5] arm64: dts: rockchip: Add HDMI & VOP2 to Khadas Edge 2
Date: Mon, 17 Jun 2024 22:27:39 +0200
Message-ID: <28646794.czjnFlTdjD@diego>
In-Reply-To: <20240617071112.3133101-4-jacobe.zang@wesion.com>
References:
 <20240617071112.3133101-1-jacobe.zang@wesion.com>
 <20240617071112.3133101-4-jacobe.zang@wesion.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Montag, 17. Juni 2024, 09:11:10 CEST schrieb Jacobe Zang:
> Add the HDMI, VP, VOP nodes which HDMI function needs.
> 
> Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>

The rk3588's hdmi controller was just posted in a v1 and from
comments received it looks like it'll still take a bit of time before
that is ready to land. So this patch would also be for later.


Heiko



