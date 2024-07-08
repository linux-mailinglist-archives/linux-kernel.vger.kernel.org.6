Return-Path: <linux-kernel+bounces-244470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DDD392A4A6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 16:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFBDC1C21B6A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 14:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395EC13DDCA;
	Mon,  8 Jul 2024 14:28:35 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0E613D888;
	Mon,  8 Jul 2024 14:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720448914; cv=none; b=BJyxvkzhquU6dSqPys0ZNSPRT12JY7MhtRhTExlu6QMRU8KsgFfsCB5l7JDbsSwRxVhg/zn4LecLeAK/d9byZZWoG45OZERUCZQEA1F9kTYMPdDMSFNbQP4H50WZy4NcB1YvBrDkXmx9faHWuwYhfO8SO/IoHtJB62ULpCzHBbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720448914; c=relaxed/simple;
	bh=6a7s4o5kpI/Ev6hXF1zdH5fABTZxkhFg7rNLsJx3upY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EyfXpNlSwjUMbtJwdJVHyJgbbRa5TEtwZBHFrhmmXIYdsR45lyFh4klxuHjNZJERnL7Sxi+y2pTrrRa8PqZqXecdeOa+QRu2ukPEnYCZzdWZAmPAi2jG8WUlx+g6cGhHwR5fn78FWGwj4g2864zpW2u5XthjsyfK5OKD8C/lUho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e8616d7.versanet.de ([94.134.22.215] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sQpLa-0001Jx-3f; Mon, 08 Jul 2024 16:28:06 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Diederik de Haas <didi.debian@cknow.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-rockchip@lists.infradead.org,
	Dragan Simic <dsimic@manjaro.org>,
	Alex Bee <knaerzche@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Add avdd supplies to hdmi on rock64
Date: Mon,  8 Jul 2024 16:28:02 +0200
Message-Id: <172044883544.1350787.9222264263996653684.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240704191919.38856-1-didi.debian@cknow.org>
References: <20240704191919.38856-1-didi.debian@cknow.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 4 Jul 2024 21:18:33 +0200, Diederik de Haas wrote:
> Pine64's Rock64 was missing the avdd supply properties on the hdmi node,
> causing the following warnings:
> 
>   dwhdmi-rockchip ff3c0000.hdmi: supply avdd-0v9 not found, using dummy regulator
>   dwhdmi-rockchip ff3c0000.hdmi: supply avdd-1v8 not found, using dummy regulator
> 
> In the Rock64 Schematic document version 2.0 those supplies are marked
> as DVIDEO_AVDD_1V0 and DVIDEO_AVDD_1V8 respectively, but in version 3.0
> those are named HDMI_AVDD_1V0 and HDMI_AVDD_1V8, which is a bit clearer.
> In both versions those are connected to LDO3 and LDO1 respectively.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: Add avdd supplies to hdmi on rock64
      commit: dbdadc14b94e1c0326a430c1f84592a9b5c6b6d2

Added the Reviewed-by tag, but not the 2nd.


Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

