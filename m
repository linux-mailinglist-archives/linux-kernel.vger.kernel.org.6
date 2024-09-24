Return-Path: <linux-kernel+bounces-336629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D939983D3B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 08:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBB101F23E37
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 06:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AEC6823D1;
	Tue, 24 Sep 2024 06:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d6C89Qeg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982D4811EB
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 06:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727160028; cv=none; b=QBTWOW4UUAD1N0dw3IY+MVTqydjbENChpQk4vC//kGPyB+xoD2q+bBL7uJAMrnsaHh0vbhmdsYdHUkSVKsLMIq30S136ujx5XSndIbDsEkLLiiw6AYqL1lNGiGSxl7Xaik9L5Q1jnf/BLHMVG64d/+3Ni9ZIhXIP1InwtQFUYLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727160028; c=relaxed/simple;
	bh=bV09n5RIN0Vhxw7HFNVW3Pyh6JzncIhtJpLcc191YP8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=us768WKVS7FBPOP9te05ZLD69d0LAg4E6Itzhf/giiLK6IufiM+931TgeMp2mnXrl/3/dLG0rgZxY1O76FL0Qh6aJaoxlnxRAb+Vq7gdtdwabQ5FJorvLkfdc7kySr6gp8XGMryZ7xkLGwroEbfyd/9Azy8tIHmeVslVP1W5Ip8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d6C89Qeg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29435C4CEC4;
	Tue, 24 Sep 2024 06:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727160028;
	bh=bV09n5RIN0Vhxw7HFNVW3Pyh6JzncIhtJpLcc191YP8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=d6C89Qegnxut93Sj+lkJmOGzOdLZde3Bl9xuUdvRRaz6L8QGOdO4vTrAQQjSeUB8l
	 SXm305645vt2zHuxBnbfCe1t9V2Jzkl8CoZkvErNzOrg0LH26jt4uOaKPSTl3pJjz8
	 vfYDUeZ/QKg/faIGTjaXIZ7cB9UpQt0jyqP4Rr9CA0uF51g+td/B7LkskIWT6N0fwa
	 ORyB5lNlMGEtyMX40j3s5qmy8VNNNHFwlR+qeyduRn4Vh8FMGLpHJhaJBfBIPPqUk0
	 IK2eGsLzF44ktiA9+G6c8Z3Cl/6PFzgMSGVO856v12wHYheycbWtuT4ryp1iHhQ5sZ
	 3V8kPnVCfRNOQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE8143806655;
	Tue, 24 Sep 2024 06:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ACPI: NUMA: initialize all values of acpi_early_node_map to
 NUMA_NO_NODE
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172716003024.3899939.517065140587976451.git-patchwork-notify@kernel.org>
Date: Tue, 24 Sep 2024 06:40:30 +0000
References: <20240729035958.1957185-1-haibo1.xu@intel.com>
In-Reply-To: <20240729035958.1957185-1-haibo1.xu@intel.com>
To: Xu@codeaurora.org, Haibo1 <haibo1.xu@intel.com>
Cc: linux-riscv@lists.infradead.org, sunilvl@ventanamicro.com,
 xiaobo55x@gmail.com, ajones@ventanamicro.com, catalin.marinas@arm.com,
 will@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, Jonathan.Cameron@huawei.com, gshan@redhat.com,
 rmk+kernel@armlinux.org.uk, james.morse@arm.com, guohanjun@huawei.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Mon, 29 Jul 2024 11:59:55 +0800 you wrote:
> Currently, only acpi_early_node_map[0] was initialized to NUMA_NO_NODE.
> To ensure all the values were properly initialized, switch to initialize
> all of them to NUMA_NO_NODE.
> 
> Suggested-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> 
> [...]

Here is the summary with links:
  - ACPI: NUMA: initialize all values of acpi_early_node_map to NUMA_NO_NODE
    https://git.kernel.org/riscv/c/732b177663e1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



