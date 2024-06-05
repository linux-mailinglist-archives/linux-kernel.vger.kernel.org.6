Return-Path: <linux-kernel+bounces-201699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 953508FC1EF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 04:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51464286836
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 02:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32CC773476;
	Wed,  5 Jun 2024 02:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IbdIbsRC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CC16A008;
	Wed,  5 Jun 2024 02:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717555232; cv=none; b=uQoyY4FNKmOqpUEJi55S0ACvuRLo8S5bnXRo7HpBV522TUK1p/hgMHeZQLN0eJiyFL+2wwTwSMfnLDCNbAafG2EWuSUIDAxferYSRlwG8cubjmIm93tdwZGZJH5b+9G8I33t2ZPevdoHepJswyxuYNZWC0pyp8vvhAVUV9fbvik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717555232; c=relaxed/simple;
	bh=TLe44Hr5WqeQyDO4vxCFTXDPLS7g3Gj+ESzImneXZNg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YfyWjB0Cmp8gk3E1Mx5dItstcP2DHBEl//t9JZl9JprS1My3EkkeMv6Vd72/kfj+FRqGhL9EMn3ow2K1UTR7zhS9JMMHhpOFquu8dqDzCWPdSiJAz60ekG5ncQZjXsz+8aZ630+eRuHytMMkCyg97PbRdoYIJ3CuWGCXOUq+FFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IbdIbsRC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0C9F4C4AF0A;
	Wed,  5 Jun 2024 02:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717555232;
	bh=TLe44Hr5WqeQyDO4vxCFTXDPLS7g3Gj+ESzImneXZNg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IbdIbsRCBE2x3GNfOjPZJJcqpjWdy/b5/lStTwHR4TMauqlBAwDHdlnX8JXAui3gT
	 uKNDEOwtUApPzJZ8DDTcINiQ1gy5DQs+A/xp2DdUZyxiJu2d4kpxU3ajTf52HDUUyS
	 G8pJcYgHUntocdKHK3pPixdL+M5I+D+jVl6scnmROuBaV1zlYSOMHTUMaKBFlwVxZS
	 I5j7poUPXDMcL8/NDJ9nxf4QtnfwApOaZ8lnklz3hwefkcc8F6rveklxs5kRTDq1ih
	 TMJE9NIlwoRF4lZ0ruytWhvQ6KXUlY+R9SuoajUAvvjNnTyEWQkmcHMl6dBG538RcE
	 AQaECZW0cHehw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F4157DEFB90;
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
 <171755523199.3149.3028217991036780038.git-patchwork-notify@kernel.org>
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

This patch was applied to chrome-platform/linux.git (for-next)
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



