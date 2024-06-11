Return-Path: <linux-kernel+bounces-209198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A17902E99
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 04:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9575E1C2289D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 02:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B379216F8FA;
	Tue, 11 Jun 2024 02:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FFdABJRs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B401581E2;
	Tue, 11 Jun 2024 02:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718074357; cv=none; b=S1oAXWmwTwUbuIIi84ZK4pTvTf8WYg4YePTxoddW+CVdV7xmwfp8AA52j312vdyeEanjfh15JweGfaJMdCTNS5oIXYTiz+lpgYlHx52XMu1eWU953EAOLJVmQ1vW/Csqun6/LjAzryNWu5pIrCSpS5HXmFORIGRubw+zEgIB+IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718074357; c=relaxed/simple;
	bh=5fSoCzmjHuhe5eCMweOM54coVCvd2vNpXRWVUl6Bm1c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=m2MGRIksOLI+EGQIIVYeTe16ZaAUwZhIJLXJo5oyncucaCZMYVsl603EDiyJWrk72oF8+gEqRw9CavWzGL0evBVoOvLwkvBt+r5M3yE9YQwS2WbByzVlxhDpGiAAiTh9CqLa4rSJRAVln5piOFWsVZQFM7XUQqQNUrRPfDlxR7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FFdABJRs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 961B6C4AF50;
	Tue, 11 Jun 2024 02:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718074356;
	bh=5fSoCzmjHuhe5eCMweOM54coVCvd2vNpXRWVUl6Bm1c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FFdABJRs2KK7Axq9QiBH2vxIV5P+hv4hJVI+hkuNxCSx2/iXioKAZ4r3sCbmN05pN
	 9Zb+c/GIbh6Q+9blvdLswur98FOAIwdgkpYwxdIErDnc3a0OhnsZoSWP/IvPuf99d8
	 wzkKA7Wf3g41qdCbNzCJEd9wOPYU0e0TAOvr9M17L3WB/X4anuAecRqS/zl3Bw/XeP
	 diNVHVf6gloxtdcjKEhb9kBiTSkLnFk+KRq3XdGsUPsNQ/77b+kNR7grvsH3/uXhjD
	 NjMhzucoka0ti8zpYd6QWTdtpOhIIhvuXHOEt7x65C+8boRTiLwXxOzr/nQleXw3Xq
	 ara1UePoBEtjg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 883FCE7C770;
	Tue, 11 Jun 2024 02:52:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] platform/chrome: cros_ec_proto: add missing
 MODULE_DESCRIPTION() macro
From: patchwork-bot+chrome-platform@kernel.org
Message-Id: 
 <171807435655.18125.5100585135586179160.git-patchwork-notify@kernel.org>
Date: Tue, 11 Jun 2024 02:52:36 +0000
References: <20240610-md-drivers-platform-chrome-v1-1-f9c75adcc1ca@quicinc.com>
In-Reply-To: <20240610-md-drivers-platform-chrome-v1-1-f9c75adcc1ca@quicinc.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: bleung@chromium.org, tzungbi@kernel.org, groeck@chromium.org,
 chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org

Hello:

This patch was applied to chrome-platform/linux.git (for-next)
by Tzung-Bi Shih <tzungbi@kernel.org>:

On Mon, 10 Jun 2024 14:50:37 -0700 you wrote:
> make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/platform/chrome/cros_kunit_proto_test.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> 
> [...]

Here is the summary with links:
  - platform/chrome: cros_ec_proto: add missing MODULE_DESCRIPTION() macro
    https://git.kernel.org/chrome-platform/c/d11c00292a31

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



