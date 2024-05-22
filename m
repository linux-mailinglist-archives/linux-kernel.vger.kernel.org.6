Return-Path: <linux-kernel+bounces-186822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED058CC9B0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 01:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D425B2117E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 23:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56C614E2D6;
	Wed, 22 May 2024 23:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sHwzCwRN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222B914C5B5;
	Wed, 22 May 2024 23:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716420744; cv=none; b=U+RBwtyP+h1nYUM+7gg7AXfC7e1WAGM80RXa/xg5mMeYBRAWf1r4kF6QdBbN1QWjkYJWPRFpJOwWxfVLICrM0Gv7M9HOR7nVGx6He25cUcoUo/G0pYDfKN46Uun536m5ZCoYbN/dtsaVscAxHoYqRQaer3QunIb/CDAT4GULIBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716420744; c=relaxed/simple;
	bh=kpKPeLWBCjE5fgd+5cOKsD21nksUdXEMnnTmcz5+9NM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UlFo5NDmpfI8vOZ7Ta2yCICLKvTrMg6Q/78jPrIjXq3EHSuFTeuPjuoRNHBmOC5f7q7XjEo4t85cZswNIHdgX4uZDswomoJPCrQiGIx69m5EocDDv5L9DeQoQHe7RHCsTvEOrhP4tC6onddCxiAKhXUf4NZDd5rIwxOVt5tt+bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sHwzCwRN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A5D32C4AF08;
	Wed, 22 May 2024 23:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716420743;
	bh=kpKPeLWBCjE5fgd+5cOKsD21nksUdXEMnnTmcz5+9NM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sHwzCwRNVkYZxwlprVtZrnp3/dsj9O9SfyPmCrFUvdoemahb42MxmJbr4Q62RVlU/
	 DXRYmKoTLfgyAdBv5rM/uENXk0rr/jzybEPmP/d+92DkkvhI1zQdbf8eAgAW7fF2ae
	 njUMhdcDMAs6I+aqvk0SCNCZvkmzo84aTLIzbGIEbqr/F54VXk6wQiHo34C2OIMKft
	 biV8uX8Xcon8i+loWX6K5f5ogbMgp+gEAg7y16IU+YYtx56CpxTCW7C/1AZ/O07Db1
	 EWxCcu1m+fpCU/zZG7bnJGkDlbFoVRWiCf+tjAX0OCrrR58w09KPPTvPg2IKrKtthz
	 edzoNxZUaSQXQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 99E31C54BA0;
	Wed, 22 May 2024 23:32:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] of: property: Add fw_devlink support for interrupt-map
 property
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171642074362.9409.8597055988913469203.git-patchwork-notify@kernel.org>
Date: Wed, 22 May 2024 23:32:23 +0000
References: <20240509120820.1430587-1-apatel@ventanamicro.com>
In-Reply-To: <20240509120820.1430587-1-apatel@ventanamicro.com>
To: Anup Patel <apatel@ventanamicro.com>
Cc: linux-riscv@lists.infradead.org, robh@kernel.org, saravanak@google.com,
 devicetree@vger.kernel.org, anup@brainfault.org, paul.walmsley@sifive.com,
 linux-kernel@vger.kernel.org, palmer@dabbelt.com, atishp@atishpatra.org,
 ajones@ventanamicro.com

Hello:

This patch was applied to riscv/linux.git (fixes)
by Rob Herring (Arm) <robh@kernel.org>:

On Thu,  9 May 2024 17:38:20 +0530 you wrote:
> Some of the PCI host controllers (such as generic PCI host controller)
> use "interrupt-map" DT property to describe the mapping between PCI
> endpoints and PCI interrupt pins. This is the only case where the
> interrupts are not described in DT.
> 
> Currently, there is no fw_devlink created based on "interrupt-map"
> DT property so interrupt controller is not guaranteed to be probed
> before the PCI host controller. This affects every platform where
> both PCI host controller and interrupt controllers are probed as
> regular platform devices.
> 
> [...]

Here is the summary with links:
  - [v4] of: property: Add fw_devlink support for interrupt-map property
    https://git.kernel.org/riscv/c/d976c6f4b32c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



