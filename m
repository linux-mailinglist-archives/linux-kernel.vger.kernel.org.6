Return-Path: <linux-kernel+bounces-189975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7444B8CF7F2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 05:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E86828158E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 03:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F08DF78;
	Mon, 27 May 2024 03:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZCIa6hWK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E0379EA;
	Mon, 27 May 2024 03:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716779226; cv=none; b=hyGA+8G+drV+Lwk6fokcwP9dfdywC0C9/QFcr1unT/BCY3ebdrPzuxZtftC86qs/VE2XrGhFBUcCEnHn6md8aDbgT5R+ZRTJ125XSI1c+OoKtELDxvYayI5lZM9IBlhpU7G3tMBPKW/SdTxg+DEZYeULuw1V7RsC1xhlltj5X+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716779226; c=relaxed/simple;
	bh=y45Na4LBDYUvhYaEwJT8HcEr8Rv3sz8j5bWUCZh9Kxs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ErXWTO2lefwvBJm0N8i0byE/H/BD9eJl9+BiX6IQ3sIevs/0jEd/W7ipSHveE98PAB2MmA4lIc16VNJ0d7QwyEF5IqWbUqNiNoxcEtYjVG1cUiGyCwRWb73uYlKr/D1juXh0tToWjUjoaaMEo5LnDj3gxVq6OEgmmL7xnF1To2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZCIa6hWK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E51ACC32789;
	Mon, 27 May 2024 03:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716779225;
	bh=y45Na4LBDYUvhYaEwJT8HcEr8Rv3sz8j5bWUCZh9Kxs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZCIa6hWKHlrUOMkDZUoL86dcwTXJuJo6U4UMmZFcEazw9DJsu/yFrojUodbOYo4Py
	 0q1PnEeztBzpF1UhOMDouOCEqLXBRghTWsKivBxXSI/vybmf4daxJF3uH2djQ4/gpo
	 wMtnXMxUmGowH49nuFSk48/jN7Re5/37uZZUxUWumvXiTYJAQ8TdnmbgpkR6h6xXBK
	 JctDEewhwK7Az399IMHqaDowlAxE7DQNd4tVYRZVNqLKwgzaGHCL0CJGozirWpOpZb
	 zVRh3qJ4av1GnixImMisPqVZoF/5Ai3Jz2Xjr5mAvZRbpiGWRD8lQ1GEKUQlqkyTsd
	 9qzSozbwye/Cw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D52EBCF21F9;
	Mon, 27 May 2024 03:07:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2] firmware: coreboot: store owner from modules with
 coreboot_driver_register()
From: patchwork-bot+chrome-platform@kernel.org
Message-Id: 
 <171677922587.1901.3423676427961660678.git-patchwork-notify@kernel.org>
Date: Mon, 27 May 2024 03:07:05 +0000
References: <20240330-module-owner-coreboot-v1-0-ddba098b6dcf@linaro.org>
In-Reply-To: <20240330-module-owner-coreboot-v1-0-ddba098b6dcf@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: tzungbi@kernel.org, briannorris@chromium.org, jwerner@chromium.org,
 chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org

Hello:

This series was applied to chrome-platform/linux.git (for-next)
by Tzung-Bi Shih <tzungbi@kernel.org>:

On Sat, 30 Mar 2024 20:49:46 +0100 you wrote:
> Moving the .owner setting code to the core this effectively fixes
> missing .owner in framebuffer-coreboot, memconsole-coreboot and vpd
> drivers.
> 
> Best regards,
> Krzysztof
> 
> [...]

Here is the summary with links:
  - [1/2] firmware: coreboot: store owner from modules with coreboot_driver_register()
    https://git.kernel.org/chrome-platform/c/46c6685e7e88
  - [2/2] firmware: google: cbmem: drop driver owner initialization
    https://git.kernel.org/chrome-platform/c/7f20f21c22aa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



