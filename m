Return-Path: <linux-kernel+bounces-205794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1397C900060
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 12:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B86921F22DDC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 10:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A08E15B96C;
	Fri,  7 Jun 2024 10:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WfmZ4eSp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF931581F2;
	Fri,  7 Jun 2024 10:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717755029; cv=none; b=UqPF4ySchasaPxbQkCyAiByUdP4efNl1CACCcaZ7q4U/nlqAh2F5FqLFheT3754XUX8fIHkjoSkm6dd0lJyRmH32OUczPjlhgjBPBtLnC2Mif0cYJfx4cYN84v+dfduGuWMLezo2Yx0KIkb6XK7MtaSQpvlniegdM6eOnB+Mf+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717755029; c=relaxed/simple;
	bh=4ooSt/Ha0HvPAnE/O3wfkAqEhziVkdWk4WocWWI4/Q4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YprWO71TdLX+UPPo25eVql96wRSxEXTDd7iMhTa2NTQ+E/v347Fqyq4UWo4lZhAhpIBiPZo3de3PW0VvXgW20/61fVGDKG5wyp3IZTy4PyOZG59lWJrFymeala3rtJWfE5EJD43AXzZgTe6hm/xiar7kRwF2Yp8mYhNKkkPIWKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WfmZ4eSp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 58D76C32781;
	Fri,  7 Jun 2024 10:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717755029;
	bh=4ooSt/Ha0HvPAnE/O3wfkAqEhziVkdWk4WocWWI4/Q4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WfmZ4eSpkVBKATI1/CkeEMwL6aXfNMa8fSXfQ1QmfxLyjuQZ18cLlhO0uSM6WRQaq
	 xx7cP06n03hzpqODPPwMKWY9PVBd7OOtFkoqLW5P7runIWL0hJcek1WsyP5McA9YeI
	 YBtGgbHQwennJXQT2cNPqtSQS7ENjxmr+S5KeroiJDAXyqD7O6nMKAbooEL1u8GL3w
	 RKe0M7DNVnO1vS9+GSiS+2N3CGG5xzzfnuwrkqZP8Ag9XKx8seBZXFqjOeFOP4OQ+k
	 rFt3KSMM3YL7rBRTVlgJTBfBoH9miAs2bbetxTZWCEyYP4Y/tQtFrbZr2FEUSWH/5a
	 36E9IQ8aYy2Ow==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4B713CF3BA4;
	Fri,  7 Jun 2024 10:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] hwmon: (cros-ec_hwmon) Fix access to restricted __le16
From: patchwork-bot+chrome-platform@kernel.org
Message-Id: 
 <171775502930.9691.14409318862407601058.git-patchwork-notify@kernel.org>
Date: Fri, 07 Jun 2024 10:10:29 +0000
References: <20240606180507.3332237-1-linux@roeck-us.net>
In-Reply-To: <20240606180507.3332237-1-linux@roeck-us.net>
To: Guenter Roeck <linux@roeck-us.net>
Cc: tzungbi@kernel.org, chrome-platform@lists.linux.dev,
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
 bleung@chromium.org, linux@weissschuh.net

Hello:

This patch was applied to chrome-platform/linux.git (for-kernelci)
by Tzung-Bi Shih <tzungbi@kernel.org>:

On Thu,  6 Jun 2024 11:05:07 -0700 you wrote:
> 0-day complains:
> 
> drivers-hwmon-cros_ec_hwmon.c:sparse:sparse:cast-to-restricted-__le16
> 
> Fix by using a __le16 typed variable as parameter to le16_to_cpu().
> 
> Fixes: bc3e45258096 ("hwmon: add ChromeOS EC driver")
> Cc: Thomas Weißschuh <linux@weissschuh.net>
> Cc: Tzung-Bi Shih <tzungbi@kernel.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> 
> [...]

Here is the summary with links:
  - hwmon: (cros-ec_hwmon) Fix access to restricted __le16
    https://git.kernel.org/chrome-platform/c/c8a4bdca928d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



