Return-Path: <linux-kernel+bounces-563081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D5EA636C3
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 18:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD908188FAEE
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 17:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1E41DFE12;
	Sun, 16 Mar 2025 17:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jz/bwj84"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97711DEFDB;
	Sun, 16 Mar 2025 17:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742145599; cv=none; b=aX8omuEnaaGBaUtmCuWpoJo7zWBTnsIYUYuKhC42dXa9YameKEKsv8+daBJyqAveiN4zSPINHG5K71zetxBJprW0QLrajpYBVlLCI+D0ryKVqGzb7OOafMhiK1ScffajVDfTxglMkKms3q/TPkd71PsFo9pJc0NwDMfBMXL7xh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742145599; c=relaxed/simple;
	bh=eWdR67b6ix179Rxy3aXvjo2umckSWRuMZDSIyOoE/8g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TPVxmxJdL0ftW2OLxQ6Aqk22YJ3xQ3ck8G/3vzY2rjBxRdvN5t8eTFeA762YHgh1QbkJJs1cO+N4iHAHtIY1vTgBIE7AYb7uWSd5Qa7DlS0wd6PFAVR3Q15/vhzHC3FO21R8Dz6TOJbp86EMtE+4MkYByZ29JQuvaGC/fNsd58M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jz/bwj84; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E155AC4CEEA;
	Sun, 16 Mar 2025 17:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742145599;
	bh=eWdR67b6ix179Rxy3aXvjo2umckSWRuMZDSIyOoE/8g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Jz/bwj84Ai7VdAGrIP0RsEvCTEDnpDlbIPEzXbk3l9G6eWrFUT2VNqLj8bkwyuKrl
	 CPTOoy2nilVn4904n9ech4E6c+cgPCL4fcJqlb4VsNzOJNF/9Zc5H3vQTpjX/Td8zY
	 pccAdyEOOnd/hgyABAyjJOw27sWAxxlghLS2113sHupjxnBxuFaf/XXqmt/CB/+kr8
	 dUyaaYkQReYDGlvlwrRuGt5viiSE4ig25Kiz9D4ClpkreNFgr7X7ZzjjlTCBxw4/or
	 Tm3GC+lRDhcZKPUm75BW9ekDhNKlmnf4mSUzK4XKYqBLD8ar2E/9M8wL8/1wv7VIIg
	 Nojj3jQInFlqQ==
From: Vinod Koul <vkoul@kernel.org>
To: kishon@kernel.org, Heiko Stuebner <heiko@sntech.de>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 quentin.schulz@cherry.de, sebastian.reichel@collabora.com, 
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, dse@thaumatec.com
In-Reply-To: <20250313134035.278133-1-heiko@sntech.de>
References: <20250313134035.278133-1-heiko@sntech.de>
Subject: Re: [PATCH v8 0/2] MIPI DSI phy for rk3588
Message-Id: <174214559552.644495.17738101369641908083.b4-ty@kernel.org>
Date: Sun, 16 Mar 2025 22:49:55 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 13 Mar 2025 14:40:30 +0100, Heiko Stuebner wrote:
> This adds the phy driver need for DSI output on rk3588.
> 
> The phy itself is used for both DSI output and CSI input, though the
> CSI part for the whole chain needs a lot more work, so is left out for
> now and only the DSI part implemented.
> 
> This allows the rk3588 with its current VOP support to drive a DSI display
> using the DSI2 controller driver I'll submit in a next step.
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: phy: Add Rockchip MIPI C-/D-PHY schema
      commit: 301587cf4e771aca8c5ee05a6ba8d7d8f548e478
[2/2] phy: rockchip: Add Samsung MIPI D-/C-PHY driver
      commit: b2a1a2ae7818c9d8da12bf7b1983c8b9f5fb712b

Best regards,
-- 
~Vinod



