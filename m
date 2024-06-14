Return-Path: <linux-kernel+bounces-214273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E3D90820E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 04:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE9B71F239F2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 02:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A88186297;
	Fri, 14 Jun 2024 02:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LcLe3MJw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF3E1850A7;
	Fri, 14 Jun 2024 02:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718333431; cv=none; b=sIJHuUQbLfB7rWGSiEdSc3WjkGbZMF4A/kYXrrqf2tEVxUcxO97vAjBWbN8FNJQadgwoS5m2WnSApzEmGajWNfEZB6JV4w43+WeS97VkXGSb80Q1h7vYF+BQfeG65LlNb2ZMjCEO4Bwkqd5iSYNXsY3A1Mv43hF3wg9hNzHJ0oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718333431; c=relaxed/simple;
	bh=H5RnwBHKARD3OGe+nAiKyTn52y22Y54pRLlkrk71XeE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=u192+T2nPhTcaKAFZRCtm0gmMXgjBAIUhz5R/qw5p177i6C0I6qvL2MtHs9UtIDVEVuY0OFird2uO3KUqJYRc5c90FtJxci1MHdAP8uQyJbdZUwcCDCGJNSfj65dVzpiUtdfof+bQjW+sT7oSVq7KIYA5ACU6P5KvXdt0K1+mvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LcLe3MJw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 56002C4AF49;
	Fri, 14 Jun 2024 02:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718333430;
	bh=H5RnwBHKARD3OGe+nAiKyTn52y22Y54pRLlkrk71XeE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LcLe3MJwOego2EPFukvKcOeGV5x/zAyH9WsS06QI9EWt4EU//vZ3575k2mXphODDh
	 1hc3xZTfBgpR+3v0sis/uFIpZYxVBEQ75+3pmBtUyZYRpLNtQqelDE9qbaU7UvzGKG
	 qdWbjQXlNpLnpGe/HUMod4eTMsaLTD8/MGJU5dUIr7pmpEy0pnszx2yaHLVs2cHFyG
	 FYtIcjn3jskyYxl4BDmx7SvN8RzCX99WjSRIqVAEW/dYe1V78KE34+Io4ZKmhXiV+k
	 mnaqLyHgsJzBQvfg68AadW0aS9xgLOAn10dwYZji3iIu5llhsaP8NqALz4imtjaVdo
	 AZxwi73IJ4lvg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4A672C43612;
	Fri, 14 Jun 2024 02:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] platform/chrome: cros_ec_lpc: Handle zero length read/write
From: patchwork-bot+chrome-platform@kernel.org
Message-Id: 
 <171833343030.26166.18265568049906773511.git-patchwork-notify@kernel.org>
Date: Fri, 14 Jun 2024 02:50:30 +0000
References: <20240613212542.403-1-ben@jubnut.com>
In-Reply-To: <20240613212542.403-1-ben@jubnut.com>
To: Ben Walsh <ben@jubnut.com>
Cc: dan.carpenter@linaro.org, bleung@chromium.org, tzungbi@kernel.org,
 groeck@chromium.org, chrome-platform@lists.linux.dev,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

Hello:

This patch was applied to chrome-platform/linux.git (for-next)
by Tzung-Bi Shih <tzungbi@kernel.org>:

On Thu, 13 Jun 2024 22:25:42 +0100 you wrote:
> cros_ec_lpc_mec_read_bytes and cros_ec_lpc_mec_write_bytes call
> cros_ec_lpc_mec_in_range, which checks if addresses are in the MEC
> address range, and returns -EINVAL if the range given is not sensible.
> 
> However cros_ec_lpc_mec_in_range was also returning -EINVAL for a zero
> length range.
> 
> [...]

Here is the summary with links:
  - platform/chrome: cros_ec_lpc: Handle zero length read/write
    https://git.kernel.org/chrome-platform/c/b57cd5703a16

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



