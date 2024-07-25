Return-Path: <linux-kernel+bounces-262230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DE193C2D1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 15:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B2FA1F21DC3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 13:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2398419B587;
	Thu, 25 Jul 2024 13:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6DUOhBp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558BA19AD8E;
	Thu, 25 Jul 2024 13:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721913639; cv=none; b=o8am78CT76Ba9hCyPVSvogaNcu6gLwgtxp10AYd657j6NDWFPw2j7Q87GXp/4uRZjvgOk/qdCHYgSWreh+YYlacbWm21E5l0MkTVPFP7QKWXbk/sjM7fRjtdxd2L3YvxcAtjKNEXJYI3dqVJRFhPmq/n24D+x7yDi8wuRra9GTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721913639; c=relaxed/simple;
	bh=WAxeB6xNpDOJhk2GtvF3lDer+9cUbsR1XhVgScJOEaQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=i2C5TUkQfMg00HnP4u8+xGqNDgYWNL/LJIi5S3t2SrAjDYA0bltGRyY5Q3pNvgRHeORNbQNVkiAR2NVySCVlsmS7SZA2h7thr6rF98/efG9EJ5o3XaG0W87bxlGJyNl8/QgDw7IZlhJ2RNn6J1imazKbDtd6vc+8smwCbocGlzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T6DUOhBp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2DCD2C4AF0C;
	Thu, 25 Jul 2024 13:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721913639;
	bh=WAxeB6xNpDOJhk2GtvF3lDer+9cUbsR1XhVgScJOEaQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=T6DUOhBpOSV58MvhGNSkQh/NCeOp04CvO3vLRRO5e39aRRvPY+YWBmEK2NbHkLbLU
	 PgbDAS3On4M2FcbHAfeOqsstMgmCJ56Vr+ae+niaumiO0955+dt38qDUxI6k6f7acE
	 ItmwZG/XsMrgordwf1jNxvEh5DABQMfiydai3flYhJDiQKL5949MS9Tf/3GMNjd54h
	 3QpbRkQBvuxGMZz8cSTE8eZYjCRvd66wmkW8QxPKgutIwXY+pRxna0ieC6Vni7mv3y
	 goQfyh9OtKfo7ZJv9bzSLpNOrBFjlKYjGv/wYVhjrAvIWzyTCudBsryXj6EiOjCU07
	 iNRqP5eB4eb7Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1ADD1C4333D;
	Thu, 25 Jul 2024 13:20:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] RISC-V: Provide the frequency of time CSR via hwprobe
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172191363910.6240.3368503310574547091.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jul 2024 13:20:39 +0000
References: <20240702033731.71955-2-cuiyunhui@bytedance.com>
In-Reply-To: <20240702033731.71955-2-cuiyunhui@bytedance.com>
To: Yunhui Cui <cuiyunhui@bytedance.com>
Cc: linux-riscv@lists.infradead.org, punit.agrawal@bytedance.com,
 sunilvl@ventanamicro.com, jesse@rivosinc.com, jrtc27@jrtc27.com,
 corbet@lwn.net, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, cleger@rivosinc.com, evan@rivosinc.com,
 conor.dooley@microchip.com, costa.shul@redhat.com, andy.chiu@sifive.com,
 samitolvanen@google.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, palmer@rivosinc.com, anup@brainfault.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Tue,  2 Jul 2024 11:37:31 +0800 you wrote:
> From: Palmer Dabbelt <palmer@rivosinc.com>
> 
> The RISC-V architecture makes a real time counter CSR (via RDTIME
> instruction) available for applications in U-mode but there is no
> architected mechanism for an application to discover the frequency
> the counter is running at. Some applications (e.g., DPDK) use the
> time counter for basic performance analysis as well as fine grained
> time-keeping.
> 
> [...]

Here is the summary with links:
  - [v4] RISC-V: Provide the frequency of time CSR via hwprobe
    https://git.kernel.org/riscv/c/2709e400c2e0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



