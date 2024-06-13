Return-Path: <linux-kernel+bounces-213526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 796C190766F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 17:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 116C42816DA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6DCC149C52;
	Thu, 13 Jun 2024 15:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dgFyyKCP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3C0143759;
	Thu, 13 Jun 2024 15:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718292030; cv=none; b=SG82+jTuFZ1jTSwTE89GfHdcp3O2xoAqwg3D2+lUlejrmu9KvHBCfQds9VNXn1LwkVVHdXxEJJKo1amGFTU1O4TMqaVY4cC2h7p9w2e1JdLh8KovskwJqlRcOaB1KRpt4My8BYybe4MdV0e6VoWbLG1sQa5+XmUMn3nuLrasSho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718292030; c=relaxed/simple;
	bh=Gh4uOL7q5FWJwHSZwLXH0gmGi2mBbI+MxDTZqV4SHus=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bZICnqI2yDViA4kJFoDRVq9PbtFPqk+G3SxSTtcL5oqvTSfsudjWmgaG5wYCjdF2sFv/nV7EUXNkmV1W3T/OygnIr4swa0TfRcSXADqlhmAh7ZBkQs4GlxLt3i7WNatNkWcO43FefBX3mcruNtQTz+hYJHBF1qgMONMMWqu5s/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dgFyyKCP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9BD45C4AF1D;
	Thu, 13 Jun 2024 15:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718292029;
	bh=Gh4uOL7q5FWJwHSZwLXH0gmGi2mBbI+MxDTZqV4SHus=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dgFyyKCPkQ2AWAucyYxvXgGGEdjAmEahdwAzJL0hmiGVf/xOBsRTpUnuLnKerkT5K
	 /z71z8nGBj9bc3d3yjm2p+BeM4V5FArE/p8ASSKwaq1uKKuh2cVrlqRqZlCFayKPu0
	 HB5cGAm3W9OAXnEZAiAJVf8x3cAecwxSPU87SD8yHfvC5qRV3r2xTQswANMpFUlPf/
	 s2T1CVFeHwgun1q09AAbkLNVppvwueqNGY0qzLO0qmUnnCJZK3buIcOTG8sGskUztV
	 TKcCxtZoRmrKWv84iJta1HO4OntuTXWr3Z2PzFfuOOw71LEadSICaU9PNkzfY/Zyzp
	 mfeZ1dKAEHUpA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8F9C0C43612;
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
 <171829202958.32437.16739284609802669464.git-patchwork-notify@kernel.org>
Date: Thu, 13 Jun 2024 15:20:29 +0000
References: <e0b43fb5-ecc8-4fb4-9b76-c06dea8cc4c4@moroto.mountain>
In-Reply-To: <e0b43fb5-ecc8-4fb4-9b76-c06dea8cc4c4@moroto.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: ben@jubnut.com, bleung@chromium.org, tzungbi@kernel.org,
 groeck@chromium.org, chrome-platform@lists.linux.dev,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

Hello:

This patch was applied to chrome-platform/linux.git (for-next)
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



