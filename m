Return-Path: <linux-kernel+bounces-201700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 054488FC1F0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 04:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E36E11C22870
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 02:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381A373477;
	Wed,  5 Jun 2024 02:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fh2GcuNn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D1A6A325;
	Wed,  5 Jun 2024 02:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717555232; cv=none; b=SM+HJkb1h7/CBC7hNQ+WFi9nIxDA8djaGAMJJglsuWg07tASeZAz+sWhiII0X5EbhwFvDYoxspXUsc7NQKBvscQdDQqGgp27zk14fXihrv//xAPeWKHBLe0p+76CiPBES4/6p0+TQ5znF2yTcFbN+6OykeyQXlADLMHFjuftD8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717555232; c=relaxed/simple;
	bh=840XKDDyn63oAGMCbkcub5XCfPW/BOMnJw0kEG1uZVM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fRni2jHBX3j8l39AsGWhmUAko1EBYLNhsXZhuVUVSJZi2MNKSzPxrO79yzBhYkkj3mfg+CNl28InHK1vyAHZ5QewRrNtt3riMPaoMCidx8zYo4qUWyr/R08nFPIlpctnFNMgouxkEPVB6YWQ2mwqG28CcJayl/PNXdZNQdoDuWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fh2GcuNn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 92F55C32782;
	Wed,  5 Jun 2024 02:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717555231;
	bh=840XKDDyn63oAGMCbkcub5XCfPW/BOMnJw0kEG1uZVM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fh2GcuNnwY96ZBRB+28SUQk2pRD67NdiY1NSMC4CMTm3EgTzKeQll6zqG14kUOWBI
	 o2jlwkmVbxJD47w7duXqS91BDYZXlJcfsf700CqBjC/XEldc6qesvZB3RcMZ+Sz0Yh
	 iUy3dCx5u9o4BSZajgPxQtYktSqoOkdPa6wDlzFGtw3+nhEnwK0F2Xa2bg+V67+Orb
	 QNKouW2Cmn7OgAIGyV75aU7prbg8G72znvMDw80g0IyDh4xZQhyXYmsVxpeEzNDggc
	 BUH4Jb4NsBrxaZyPuqfoWB/kduc8u24QhjJ4ZyUuZL8rjS0ozgQ5fZP6x7+Af0xL4V
	 SkiLUxBx7gbcw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 83DE0DEFB90;
	Wed,  5 Jun 2024 02:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 2/3] platform/chrome: cros_ec_proto: Upgrade get_next_event to
 v3
From: patchwork-bot+chrome-platform@kernel.org
Message-Id: 
 <171755523153.3149.14093963339315232636.git-patchwork-notify@kernel.org>
Date: Wed, 05 Jun 2024 02:40:31 +0000
References: <20240604230837.2878737-1-dnojiri@chromium.org>
In-Reply-To: <20240604230837.2878737-1-dnojiri@chromium.org>
To: Daisuke Nojiri <dnojiri@chromium.org>
Cc: bleung@chromium.org, tzungbi@kernel.org, groeck@chromium.org,
 swboyd@chromium.org, pmalani@chromium.org, chrome-platform@lists.linux.dev,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to chrome-platform/linux.git (for-kernelci)
by Tzung-Bi Shih <tzungbi@kernel.org>:

On Tue,  4 Jun 2024 16:08:25 -0700 you wrote:
> Upgrade EC_CMD_GET_NEXT_EVENT to version 3.
> 
> The max supported version will be v3. So, we speak v3 even if the EC
> says it supports v4+.
> 
> Signed-off-by: Daisuke Nojiri <dnojiri@chromium.org>
> Change-Id: I3af4912c4f7bfdb24445dbbff5f1c6b7a4453de4
> 
> [...]

Here is the summary with links:
  - [2/3] platform/chrome: cros_ec_proto: Upgrade get_next_event to v3
    https://git.kernel.org/chrome-platform/c/db9b2f0fe681

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



