Return-Path: <linux-kernel+bounces-189979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 379F38CF7F9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 05:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB25A1F21A4A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 03:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7448579E1;
	Mon, 27 May 2024 03:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PkAsgTx4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B906D23D7;
	Mon, 27 May 2024 03:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716779430; cv=none; b=mNKXasUgviP5a5KHqZTA+7AlZjKbmdwl9aQARnaLSSCI7fTG/50GvDbOt3kBUfNlK/UvN6RAszlamXxnYlMG09SCzKU305L5NVO/C+YJzhcsRuEllDT6widYZKA4UOmdUbvbDztSa9XzgLRBeIkv67uuxGE9meYpCPLw7vDxLAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716779430; c=relaxed/simple;
	bh=H9f98sf9KBY7q0f3ExFOE5UpF03Q4X6HE5DY4K8Pv8Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KnjlMdmsns06GN6PR3LklgC5E4L3EWFJXww9orNNtwJqo141r2xLkaYPuBvlFJmWLwJcD/C17Xgin9J66EzB82m7atgPaxib+pz+tThAb3Pk1PnsCdWu66j+U4otV8IsbTLMQShNTUN1Pb/xqlgTjO8jhD2C56KWDSxt3EI3kvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PkAsgTx4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 96227C4AF0C;
	Mon, 27 May 2024 03:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716779430;
	bh=H9f98sf9KBY7q0f3ExFOE5UpF03Q4X6HE5DY4K8Pv8Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PkAsgTx4VwGk+piZoKNks4CeST2HutgtgoBoqFoFMGNNSWU86ifJpzKi10zBCMY8n
	 IWf0YUXB3r2i1jaWnlxQSFNPIM9H+ibNHcQmIqmXPFvt54+ydwYy1+qY9lMz2C3IkC
	 Wh7qyLbTiogBXg3p8BzECUjjZms5DO+MebmLxQO4TWibB/0J/B/1HMez13gAc1ho85
	 WqumxzQk9OgBIy5bJE/gTiRUomXHb1bT0fG3tSj8KYB7pPSZNRiMETh0bkBgkqnkIp
	 Ehy3QQlN5s4VPSJiCNepBYeCeB1T1Nf97xLS3jwoTnIzQ4A0rrYQoEmEvdELGEaS82
	 y+S78D8yilNtA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8A199CF21F7;
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
 <171677943055.24851.13069392043315072746.git-patchwork-notify@kernel.org>
Date: Mon, 27 May 2024 03:10:30 +0000
References: <20240524-cros_ec-cmd_versions-v1-0-8a148647d051@weissschuh.net>
In-Reply-To: <20240524-cros_ec-cmd_versions-v1-0-8a148647d051@weissschuh.net>
To: =?utf-8?q?Thomas_Wei=C3=9Fschuh_=3Clinux=40weissschuh=2Enet=3E?=@codeaurora.org
Cc: bleung@chromium.org, tzungbi@kernel.org, groeck@chromium.org,
 chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org

Hello:

This series was applied to chrome-platform/linux.git (for-next)
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



