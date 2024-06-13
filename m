Return-Path: <linux-kernel+bounces-213527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC83390766E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 17:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A2A428157D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7017149C57;
	Thu, 13 Jun 2024 15:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LrCgFSlb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF400144312;
	Thu, 13 Jun 2024 15:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718292030; cv=none; b=pWXXJjjVLbB+SAxtPlBMJV5ieZVAlL2V3TdqBLGHjWDXnitW5iMvzFr6NSDFU7bxiMkeeLjFIj1/R3DD/85c314j0KQ+rwpR3Zy20/BrtmdMiI2jU0dwv9TmE42M2opQd/aqrZOX+LxEq/mq4EuUXCppjQldRCGRjiQF2uZ+W3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718292030; c=relaxed/simple;
	bh=1XT4r0mKPz5fePD/fYIIGKxk2aGH3p0jZ4pSt9Z/9ok=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=R492JdaWiDpbr2YIyIdHyRRTVPVwvR0nwvDhUP9MfeF3hTw6Qr++AUvvgBzkAz8rBLDsHHqmzAz/ORGyJdzSFj3KXIfVvtlkVkKc9uaoncLZhZ9GDpqVo7BkcElw7A6cPfrRfi3ybEZRUaAK4uIppPt8GLsAYZXMh04PSnypymY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LrCgFSlb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6ED86C32789;
	Thu, 13 Jun 2024 15:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718292029;
	bh=1XT4r0mKPz5fePD/fYIIGKxk2aGH3p0jZ4pSt9Z/9ok=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LrCgFSlbDeqzNUG/i5nO/v1VKeH23uZ4yNItjtZQsX+tkIJN8wP7AuQjHAjx3TO0x
	 hhkApAGwmCiQduL5+4tghi6BRppb5ov4Fa3ZPfETx4KDTZRc4/CEYzxKbR8+0PjJ7Y
	 Fdh1PkMSRNqp9VIglTjM0KA1naO+z1w7WvrZae/WxWcU4o2ZSNr69aVbfb5+PEBmJ8
	 5CMGBYQCmE3rvP4+HgVoYJMKoy8veGRrsYR6ZgttdvFjTvIg6+It4SH1nekTEGLuiG
	 1+tTuJcU+cDZ1jWJLQpNg9/gKaFTi+lEVJ6VEOPLspc+Alcfb5ctRe50W9uRl2MoM0
	 uHfVDm4e/PNHw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5D83EC43619;
	Thu, 13 Jun 2024 15:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] platform/chrome: cros_ec_lpc: Fix error code in
 cros_ec_lpc_mec_read_bytes()
From: patchwork-bot+chrome-platform@kernel.org
Message-Id: 
 <171829202937.32437.8819458024238678415.git-patchwork-notify@kernel.org>
Date: Thu, 13 Jun 2024 15:20:29 +0000
References: <e0b43fb5-ecc8-4fb4-9b76-c06dea8cc4c4@moroto.mountain>
In-Reply-To: <e0b43fb5-ecc8-4fb4-9b76-c06dea8cc4c4@moroto.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: ben@jubnut.com, bleung@chromium.org, tzungbi@kernel.org,
 groeck@chromium.org, chrome-platform@lists.linux.dev,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

Hello:

This patch was applied to chrome-platform/linux.git (for-kernelci)
by Tzung-Bi Shih <tzungbi@kernel.org>:

On Thu, 13 Jun 2024 16:55:14 +0300 you wrote:
> We changed these functions to returning negative error codes, but this
> first error path was accidentally overlooked.  It leads to a Smatch
> warning:
> 
>     drivers/platform/chrome/cros_ec_lpc.c:181 ec_response_timed_out()
>     error: uninitialized symbol 'data'.
> 
> [...]

Here is the summary with links:
  - platform/chrome: cros_ec_lpc: Fix error code in cros_ec_lpc_mec_read_bytes()
    https://git.kernel.org/chrome-platform/c/77a714325d09

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



