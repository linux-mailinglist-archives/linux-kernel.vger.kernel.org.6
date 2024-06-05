Return-Path: <linux-kernel+bounces-201696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 854608FC1ED
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 04:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC5401C22B75
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 02:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC986E613;
	Wed,  5 Jun 2024 02:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ib31cJpN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CBB61FE5;
	Wed,  5 Jun 2024 02:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717555232; cv=none; b=MAHDmvQT6lO3bgZydbyy8gZizmOD/axMNAPq8I0FO9eFft5FUSwvLJPFaCiTpvUoCzFPl6ETRg46IQD5K1E72zrQzSDBItvpbTv95LfutzYharNEAKYgplqNy1z8iMbwQxKE03qFnS0MYoETo/x/5VoGiTbRYbNsjV+EXuQuESc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717555232; c=relaxed/simple;
	bh=KD7nS9/Rz4ZB8xlfcPKQUV9jmEgBvYrpHKcnr8+TJKI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=N9+1AsyWaJjxnif1oOuZTNw3VHrYMbsSgeCIzuC04CEyjNz6xC1g/vUawaykep+xPiJ05DwQop8mCpRalAyRvgCptImFhmAnM9DRPdOkBOTiBo+1SCb0mWf5PR0eCO9OhSaaxsS6znHVE1RsWWgvLEIvJOTbgB8JnkloQ3zi14g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ib31cJpN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 82A9EC4AF07;
	Wed,  5 Jun 2024 02:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717555231;
	bh=KD7nS9/Rz4ZB8xlfcPKQUV9jmEgBvYrpHKcnr8+TJKI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ib31cJpNTWWLBPTiaz+qtvNNG2RQan7i3ym8W82wVzS6SzeLvT/ccjUD4CEX+1PW8
	 MxDD3jFrgSNeqU/Nx0psC39tDGwDv9ipzrqkwRQqFzYKvD9O2YwIFNJ+w1W4lC2UdB
	 LTrNdfUEKFVRLOU6JDfcgu2hWnWCpvXW1bHrpNcge79Qg/DUAggxEk9RljcHPBrZPr
	 v8da+FziAolGZA4SIKuvVNEmzy7WgJV1HbN4r7RaqTC3l8UzZD72Vg6bNc2KfoNO2S
	 09fFpMTIHLVfOakXr/ldO+ssZ2LLHLw1LULaqR0zEQDyAbYgWLdpKPeDXKMMt4Ykzk
	 qQvpbmRHgLiag==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 71917C43617;
	Wed,  5 Jun 2024 02:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/3] platform/chrome: Add struct ec_response_get_next_event_v3
From: patchwork-bot+chrome-platform@kernel.org
Message-Id: 
 <171755523146.3149.8031207498337240552.git-patchwork-notify@kernel.org>
Date: Wed, 05 Jun 2024 02:40:31 +0000
References: <20240604170552.2517189-1-dnojiri@chromium.org>
In-Reply-To: <20240604170552.2517189-1-dnojiri@chromium.org>
To: Daisuke Nojiri <dnojiri@chromium.org>
Cc: bleung@chromium.org, groeck@chromium.org, hverkuil-cisco@xs4all.nl,
 rekanorman@chromium.org, tzungbi@chromium.org, abhishekpandit@google.com,
 gwendal@chromium.org, pholla@chromium.org, chingkang@chromium.org,
 lma@chromium.org, chrome-platform@lists.linux.dev,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to chrome-platform/linux.git (for-kernelci)
by Tzung-Bi Shih <tzungbi@kernel.org>:

On Tue,  4 Jun 2024 10:01:48 -0700 you wrote:
> Add struct ec_response_get_next_event_v3 to upgrade
> EC_CMD_GET_NEXT_EVENT to version 3.
> 
> Signed-off-by: Daisuke Nojiri <dnojiri@chromium.org>
> ---
>  .../linux/platform_data/cros_ec_commands.h    | 34 +++++++++++++++++++
>  1 file changed, 34 insertions(+)

Here is the summary with links:
  - [1/3] platform/chrome: Add struct ec_response_get_next_event_v3
    https://git.kernel.org/chrome-platform/c/ba098ed9829c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



