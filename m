Return-Path: <linux-kernel+bounces-295458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 402EA959B27
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 14:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3C0A283B00
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 12:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B6017E00D;
	Wed, 21 Aug 2024 12:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I/XSPwKy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54061531F7;
	Wed, 21 Aug 2024 12:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724241633; cv=none; b=sIR6elHH0Bv/6vr03QKC6A7IrnOffc1L093+M5n0/ubmMtJXqNxdi8gFKWeAt1JmqRE9LYCz89tqoYLd4J6YjzdbzhjVvC1cRWQH+qigWsZqYvyvfyrFqHR+4NJiqdOpqkeboGwPgCohae0oIEsDUlaP0nE56w3nYMohBWcTC8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724241633; c=relaxed/simple;
	bh=IPSEdjvoIX5rdMbRTM7WwdPlptvwR8o4WpwCojpwIFw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IqKt5HubdMI9PQ45yaWui6FXywDqe67PDJsxMf8Beq0utxtB2wese794cklKRHdijP74QO5IzwVC6EDIDOs6OEnvRAs0pnA+L7hmZ+GLYY9NTxszivAOqjqvhfMXR2+H3lKABEMzYQFt4GXYdFF66JO6XehDebV6tzz/iVZfZGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I/XSPwKy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30C38C32782;
	Wed, 21 Aug 2024 12:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724241633;
	bh=IPSEdjvoIX5rdMbRTM7WwdPlptvwR8o4WpwCojpwIFw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=I/XSPwKyIdIrIO4d2LVXa70dwyybys8EijgLbXMhyICZ3jBluQBBREVk04froteb+
	 DDXXvmrSNMO7NUKUzp0p2PgAO9ZfJ8P/LQiuDZ2KLfTAVZmCOiqhRy2kmO9whiXKy7
	 lD5+O32w0ITA8EJpqkMtn8Few9R7SVFvyeGCQgBqAW+029PK09SNFqEg1yiy3fGEZK
	 dddATFPS16Qsy44EgVaXHvk8EejoE16ykqlyt21C70ZXHcyIpIWQrtlduV1J+mTyon
	 tfuk4+buy1N/3zQuHCOkPVSG/B9x/snO6zCrv8FuUSaq5dLPpuLUtrbJEKJpB2DJQb
	 PdSeCCCGDsoHg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB5E03809ABF;
	Wed, 21 Aug 2024 12:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next v3] net: wwan: t7xx: PCIe reset rescan
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172424163277.1699659.13229153782791615531.git-patchwork-notify@kernel.org>
Date: Wed, 21 Aug 2024 12:00:32 +0000
References: <20240817083355.29811-1-jinjian.song@fibocom.com>
In-Reply-To: <20240817083355.29811-1-jinjian.song@fibocom.com>
To: Jinjian Song <jinjian.song@fibocom.com>
Cc: chandrashekar.devegowda@intel.com, chiranjeevi.rapolu@linux.intel.com,
 haijun.liu@mediatek.com, m.chetan.kumar@linux.intel.com,
 ricardo.martinez@linux.intel.com, loic.poulain@linaro.org,
 ryazanov.s.a@gmail.com, johannes@sipsolutions.net, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, angelogioacchino.delregno@collabora.com,
 linux-arm-kernel@lists.infradead.org, matthias.bgg@gmail.com, corbet@lwn.net,
 linux-mediatek@lists.infradead.org, helgaas@kernel.org,
 danielwinkler@google.com, korneld@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Sat, 17 Aug 2024 16:33:55 +0800 you wrote:
> WWAN device is programmed to boot in normal mode or fastboot mode,
> when triggering a device reset through ACPI call or fastboot switch
> command. Maintain state machine synchronization and reprobe logic
> after a device reset.
> 
> The PCIe device reset triggered by several ways.
> E.g.:
>  - fastboot: echo "fastboot_switching" > /sys/bus/pci/devices/${bdf}/t7xx_mode.
>  - reset: echo "reset" > /sys/bus/pci/devices/${bdf}/t7xx_mode.
>  - IRQ: PCIe device request driver to reset itself by an interrupt request.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] net: wwan: t7xx: PCIe reset rescan
    https://git.kernel.org/netdev/net-next/c/d785ed945de6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



