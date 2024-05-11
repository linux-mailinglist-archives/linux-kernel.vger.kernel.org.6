Return-Path: <linux-kernel+bounces-176345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7F18C2E3A
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 02:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E1A01F21044
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 00:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F4F44C89;
	Sat, 11 May 2024 00:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+SrKoc9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8939312B95
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 00:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715388634; cv=none; b=gY/9lYsl2oVzpXkc9f1NLIg+azng8oCdS9TPkrQqRg1WWgv/VyZRbnqiJ+muG1RDwAlnXr1Fi3/I2WEkREi0sVME5NvcmqwrAm0gzYWVKFrc2x7hL5yI6x7aLEZbU200Atl/uhR3z5YtpPSOqajXOKxopO3W/uXvBEgM3V8esQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715388634; c=relaxed/simple;
	bh=AgAMu+gDLWo3EWA4KTgzUI8GgEKMvy5SiUAFAwQuGwM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JcpTEii7eO6NxfoS6YgPXm0a0Vd1LT4XksnR9t/q6KqpTZn52w9OeqcyoTVDo637ZUNQy1FbVLBcGl8EU4bA7WHqqN6/YL8DKcEGkyDF1COMujW5Tcu7mg6NdPmDf70k5XRfbTUfiFszvrKMYISLogGvy3ZJqm3Jzi0jOOtS1WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+SrKoc9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 482E6C4DDE9;
	Sat, 11 May 2024 00:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715388634;
	bh=AgAMu+gDLWo3EWA4KTgzUI8GgEKMvy5SiUAFAwQuGwM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=L+SrKoc9SGVmN++aJfbvFTqyQWyyE23vY5zFm1SD2R+9b78XXzYe001PSUpSUkOFf
	 CN06CP1/dYC2SkG8L1SlQ6PrffWQmT1V2MiKEO1Zi8RK0PXF2jX6glx+aehE2njMpF
	 h1N+u6lh2FtjI2AtkE/PtOvvq3gpKQs1wShsEx1yzJ51iASqehniyh+EYdFaU3ZdTz
	 uVHNmd3RZ62BmBb+2Kvd52Z9IBuC47+NyqrdBhufQWT+mhmjdk92p5FFbrk6xiwHms
	 OxvJS59nkArUUIGJBIU6Tlo1D9GIrs7zEdvJG2Q0SPqQRrLDu00qd00lc7nBDUkllx
	 T5QHjCfo+cjMw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3C5A0C32759;
	Sat, 11 May 2024 00:50:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH V2] f2fs: fix some ambiguous comments
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <171538863424.11229.12572874171964870634.git-patchwork-notify@kernel.org>
Date: Sat, 11 May 2024 00:50:34 +0000
References: <1714132889-9423-1-git-send-email-zhiguo.niu@unisoc.com>
In-Reply-To: <1714132889-9423-1-git-send-email-zhiguo.niu@unisoc.com>
To: =?utf-8?b?54mb5b+X5Zu9IChaaGlndW8gTml1KSA8emhpZ3VvLm5pdUB1bmlzb2MuY29tPg==?=@codeaurora.org
Cc: jaegeuk@kernel.org, chao@kernel.org, ke.wang@unisoc.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 hongyu.jin@unisoc.com

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Fri, 26 Apr 2024 20:01:29 +0800 you wrote:
> After commit d7e9a9037de2 ("f2fs: Support Block Size == Page Size"),
> Some comments are confused and just correct with block size is 4KB.
> 
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> ---
> v2: add comments "support 64 TB disk size for 16K page size"
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,V2] f2fs: fix some ambiguous comments
    https://git.kernel.org/jaegeuk/f2fs/c/991b6bdf1b00

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



