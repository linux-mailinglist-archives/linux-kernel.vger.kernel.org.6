Return-Path: <linux-kernel+bounces-189980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 586E88CF7FA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 05:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FA8B1F21687
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 03:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D178F8830;
	Mon, 27 May 2024 03:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qgU9NaeB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BF44C96;
	Mon, 27 May 2024 03:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716779431; cv=none; b=DalGTIUuLlQBR1uZKjwRJa0hmCoo0ruywegCZmLS/VTlJUideoyx+zSiJSlc338Zwvd3ag2L6Rxkiiob8iUnvgYOg128kLHlaXkI+OcGBOhuqZTTnFVOinuAeNvaS+g6+yLN+yXV6dvXxE+G55tV9ASBhju3mIYTNCR2CVHxiX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716779431; c=relaxed/simple;
	bh=nQ+yASZZf4ZLThVtkct1L/qj2j0Q16CyRcHYQ4Z86wg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WwHM5QHU4y4aT8HlYXMqMO2zkDF8r9bHRqi0vm65mrk0X8Ys6ODSRh1dGVIc5RcIGbDm6bH27i+Fe4xgvSA9MOSu6pwkzKGw2/hGkDQeyfrSHSJ7/mLs5CLUOXJThMl81T1OMDWS5u0T+YWZ3ZXGOs4p4gPpisvD+8OybHaDXxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qgU9NaeB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 37055C4AF07;
	Mon, 27 May 2024 03:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716779430;
	bh=nQ+yASZZf4ZLThVtkct1L/qj2j0Q16CyRcHYQ4Z86wg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qgU9NaeBAbSdTky8/A6A8K/xPF+zEV6R4u+bb88ssTV8YECw/Lh7ttmQoqOpS78IP
	 Mpx2sJTmqe17Uz/IR4AzGgi7Lq8f95AHDA2ry7p4z9iyoAJHirOUeOWdemKaybgT3I
	 HttHA5h8HmagOLgqZNdEHA+i9iV9mBsldgi697KBnnHUEjuonICRdFhAUblWiglsSh
	 e1VNe4V4vQEdyHr9pMp0K4L3SvK5RjUd9vtdq2Lo1b+V77E8jKyWPbBTKkhGFjTKoN
	 Ry3BWP1sUIXZyyGMqX4xKOJ6dQpD9uUSQu9NsO2j5CGgHCx0wu8SRxbQnkxBc88eoH
	 E4ktahHFwenxQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 28C48CF21F7;
	Mon, 27 May 2024 03:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2] platform/chrome: cros_ec_proto: Trivial kdoc fixes
From: patchwork-bot+chrome-platform@kernel.org
Message-Id: 
 <171677943016.24851.12983091193443152313.git-patchwork-notify@kernel.org>
Date: Mon, 27 May 2024 03:10:30 +0000
References: <20240524-cros_ec-cmd_versions-v1-0-8a148647d051@weissschuh.net>
In-Reply-To: <20240524-cros_ec-cmd_versions-v1-0-8a148647d051@weissschuh.net>
To: =?utf-8?q?Thomas_Wei=C3=9Fschuh_=3Clinux=40weissschuh=2Enet=3E?=@codeaurora.org
Cc: bleung@chromium.org, tzungbi@kernel.org, groeck@chromium.org,
 chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org

Hello:

This series was applied to chrome-platform/linux.git (for-kernelci)
by Tzung-Bi Shih <tzungbi@kernel.org>:

On Fri, 24 May 2024 10:33:32 +0200 you wrote:
> Two tiny fixes for kernel docs.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
> Thomas Weißschuh (2):
>       platform/chrome: cros_ec_proto: Fix cros_ec_get_host_event_wake_mask kdoc
>       platform/chrome: cros_ec_proto: Fix cros_ec_get_host_command_version_mask kdoc
> 
> [...]

Here is the summary with links:
  - [1/2] platform/chrome: cros_ec_proto: Fix cros_ec_get_host_event_wake_mask kdoc
    https://git.kernel.org/chrome-platform/c/d1019a74e0f5
  - [2/2] platform/chrome: cros_ec_proto: Fix cros_ec_get_host_command_version_mask kdoc
    https://git.kernel.org/chrome-platform/c/c48a71a88772

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



