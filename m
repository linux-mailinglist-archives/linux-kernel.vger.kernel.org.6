Return-Path: <linux-kernel+bounces-227571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E32F915356
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 18:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F9561C2012A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 16:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03EC819DF7B;
	Mon, 24 Jun 2024 16:20:30 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8263019D063
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 16:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719246029; cv=none; b=HE8FGKWs9apjE2Dw7U+GD5LeRo4zCrH+JeaZ8GpSlwzr9Alh9grSfFwMVDbePOhwjZSpkwhvTUkoMKEnTbNCIY3G6f8EuCfd1GUuY9jQiq2GWtj+lK8faXIRCJuHSEihcsVwj1LWkWk1oxVPTregzTwfSUmW3iUNk/A1PXNrOFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719246029; c=relaxed/simple;
	bh=Y8pWBcQyem82eKSXGISRLYFcUQpDIajsb11ofVNNahI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tfXKZKe4AdaOFEeaAnG0uFHYSlNyBazjNDULI3ltTzKIZN53bI/tZwwnvaD17bHZkxGbk9QPhDqRH8XnpNqH0UWy74xDZtSwJdoMfr45TMd+QbPlyB3sizC3LFTRz6jYJ5x/3EmxxQz3gZ4yxdA5uziTffuthnvu8nWjfl0A93M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875b6a.versanet.de ([83.135.91.106] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sLmQa-0001wn-5h; Mon, 24 Jun 2024 18:20:24 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: dri-devel@lists.freedesktop.org,
	Jonas Karlman <jonas@kwiboo.se>
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Subject: Re: (subset) [PATCH 00/13] rockchip: Enable 4K@60Hz mode on RK3228, RK3328, RK3399 and RK356x
Date: Mon, 24 Jun 2024 18:20:15 +0200
Message-Id: <171924573800.612064.11395186343493727609.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240615170417.3134517-1-jonas@kwiboo.se>
References: <20240615170417.3134517-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sat, 15 Jun 2024 17:03:51 +0000, Jonas Karlman wrote:
> This prepares and enable use of HDMI2.0 modes, e.g. 4K@60Hz, on RK3228,
> RK3328, RK3399 and RK356x.
> 
> Patch 1-3 fixes some issues to help support use of high-resolution modes.
> 
> Patch 4 fixes reading of EDID on RK3328 when using a forced mode.
> 
> [...]

Applied, thanks!

[01/13] arm64: dts: rockchip: Increase VOP clk rate on RK3328
        commit: 0f2ddb128fa20f8441d903285632f2c69e90fae1

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

