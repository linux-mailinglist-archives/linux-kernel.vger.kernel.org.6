Return-Path: <linux-kernel+bounces-436513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2E69E86EF
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 18:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D55B1881B01
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 17:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F1D18A6AC;
	Sun,  8 Dec 2024 17:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="spyhw8Or"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584C818A6A7;
	Sun,  8 Dec 2024 17:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733677423; cv=none; b=jIIRWtHjfQE4Ydpdf8dilh0p3FryuJ5zt+jofsX+no726WQTi6wVCa8BYfHaOTlC9OEYWLJq0bwc9USorqAFYfc9+zCTMeHOjG0cezEB7d0XM/GvdjSTZFOk8+eHoeIIY0Z9Sk5DXIpQEoIAlLhY06UmiT3G4KHJyEXeaEZ45w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733677423; c=relaxed/simple;
	bh=OzDARD49R+n5VdNnBGtctFOhHbckqO7CziSzfIPOS0M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iGBpnzFKf4NqtX83jNxbyRDsTzedN6ZrKQuvkvUiH0ztFLaVj/zovnNRoBpLxRdzQtqaKnD8Sv8c10Rpx3teSqwSJRjFYL8LVxBP22q8eIepuLV7rdqn/VnI2Yc34BWrFKqlXI9r/5dv6Ak8jLI+DPYQ3pOFSzkfjIOIUS3UOTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=spyhw8Or; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7E68C4CEDD;
	Sun,  8 Dec 2024 17:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733677421;
	bh=OzDARD49R+n5VdNnBGtctFOhHbckqO7CziSzfIPOS0M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=spyhw8Or7dDJtUGMI4hnzo/Cwi7FcY87M/3qsTGI0YPZzRmcGqps8JdoHSqycKF2n
	 f/94VbKItY+duEpzZYT7XPnL+IMuw7GDVMDuZUpK62qQe+2+xsgPOvgUXS04U1399m
	 pOlnX8BMz19MIvkAbBKk2z8DubpaD3nyQT6lnDuJcn/+RyMLoB5M0+4+ZZTPKrreoZ
	 y46FhLv40PSbTmV8tKG5SKbBrRGUv4a/RSuIk0NVW96JADf7g2wDwagSzaqdk9GM3G
	 7uEaMDMzoZxXZGbQvQR/Eux1eK9CW+DXoc2AN1GDBInaF6/wuQQMga/jxcRo5LtzEb
	 wmZFSr2EY/6lw==
From: Vinod Koul <vkoul@kernel.org>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>, 
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>
In-Reply-To: <20241031104631.2454581-1-andriy.shevchenko@linux.intel.com>
References: <20241031104631.2454581-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] phy: sun4i-usb: Remove unused of_gpio.h
Message-Id: <173367741843.1042266.6194820698713604064.b4-ty@kernel.org>
Date: Sun, 08 Dec 2024 22:33:38 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 31 Oct 2024 12:46:31 +0200, Andy Shevchenko wrote:
> of_gpio.h is deprecated and subject to remove. The drivers in question
> don't use it, simply remove the unused header.
> 
> 

Applied, thanks!

[1/1] phy: sun4i-usb: Remove unused of_gpio.h
      commit: b6096751a652a7e7526d4b3d59971a40c3287ef7

Best regards,
-- 
~Vinod



