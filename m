Return-Path: <linux-kernel+bounces-194256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F858D3902
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 16:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7633DB22E24
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 14:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19471156C7F;
	Wed, 29 May 2024 14:20:58 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A61C156C72;
	Wed, 29 May 2024 14:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716992457; cv=none; b=oS+wnpj1iohpBmjpHuFIoHaHI3RvK7GVilHjMR7rmaUnXzVebS3X9qEGahS6xw+PEn8QaSyAEG6Mh1PTcMQsQIN3fRAJTQ2Si0vhz9/YeI9FfdA83oVGSfmvBUGC820fJAegzDdyAW7nKcM0Y1nHY9JNTgIDvaqS3h7rL+Nh688=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716992457; c=relaxed/simple;
	bh=gEZgJfnpDKcVX7a8rQNX8w/y5okGLoeiey+wtjf7wZw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DK/bTSl//riwhGQVzhWZHU7Gnzut0Cu5QU0Lz5BNrYBZMxLQhNoY+ntMYnGjKkxgFN84c2Ln2VNnIDsVy/ZbSTmSRncuXTEbEWZwV0ClcXedxoXAuGogUUuabfqYra8tZryCxnNFEpJEAoC9iaAEVKh2kdO2H9LL8f1m8R14PJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F32B9C113CC;
	Wed, 29 May 2024 14:20:56 +0000 (UTC)
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id E57CD5FA0C;
	Wed, 29 May 2024 22:20:54 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: linux-sunxi@lists.linux.dev, Dragan Simic <dsimic@manjaro.org>
Cc: jernej.skrabec@gmail.com, samuel@sholland.org, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 robh+dt@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 linux-kernel@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <e4b9cc3e3d366a571e552c31dafa5de847bc1c12.1716914537.git.dsimic@manjaro.org>
References: <e4b9cc3e3d366a571e552c31dafa5de847bc1c12.1716914537.git.dsimic@manjaro.org>
Subject: Re: [PATCH v2] arm64: dts: allwinner: Add cache information to the
 SoC dtsi for H616
Message-Id: <171699245491.691617.1726179876185446565.b4-ty@csie.org>
Date: Wed, 29 May 2024 22:20:54 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Tue, 28 May 2024 18:45:16 +0200, Dragan Simic wrote:
> Add missing cache information to the Allwinner H616 SoC dtsi, to allow
> the userspace, which includes lscpu(1) that uses the virtual files provided
> by the kernel under the /sys/devices/system/cpu directory, to display the
> proper H616 cache information.
> 
> Adding the cache information to the H616 SoC dtsi also makes the following
> warning message in the kernel log go away:
> 
> [...]

Applied to sunxi/dt-for-6.11 in sunxi/linux.git, thanks!

[1/1] arm64: dts: allwinner: Add cache information to the SoC dtsi for H616
      https://git.kernel.org/sunxi/linux/c/d4ec229eaeb8

Best regards,
-- 
Chen-Yu Tsai <wens@csie.org>


