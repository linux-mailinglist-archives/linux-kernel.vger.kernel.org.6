Return-Path: <linux-kernel+bounces-201701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 850048FC1F1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 04:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FD47283420
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 02:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09D513A86E;
	Wed,  5 Jun 2024 02:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tyATZj08"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0326BFCF;
	Wed,  5 Jun 2024 02:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717555232; cv=none; b=WtxlsfDOamD297vPK4E9EN0zc7x0f5NXBc15gO6E/YEBe3lTU4ejZR1xZRM2bVS8rhOHIYGcpKpHJ4yRg8JlBDKKSI39ViUGldzX6sDY4FDPG/W77tVGzVkSAqpj/tvZclBJEefwxN3lbocb/gpVQ1VIP5bWinEW8SNYqEpMdCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717555232; c=relaxed/simple;
	bh=OZZbXtWuB7HSTbw6nFg1ZdzwGRv340zijtO73LmGVis=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jdxG83yf1A0MEfH1AbTGJ7y5xPqov+tJeXK6m6gdRQ9it1IfbUVpoJk0cEMJQ3rRm/c1ngPF0r4JadQBextifocWOuDnusnAcgK6AvuqovDYfAfUvD+5zeHfoNFM62LShwqTAEcjpSEUnjEn09vwhksQGFl3PTD8E88TrrElOwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tyATZj08; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1BA07C4AF08;
	Wed,  5 Jun 2024 02:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717555232;
	bh=OZZbXtWuB7HSTbw6nFg1ZdzwGRv340zijtO73LmGVis=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tyATZj08xeehNSulGIClzREzev8FuJzQGLhlKRA3SPfncjRJwdghnBqq8AsWsp/C9
	 KR9OiEpI0QImhPIsdxBV/hXWpv8jxf5i3DvOq/grxlaIP8DAHvdeX63d2QbpmsYCZG
	 EUjGkxJi2fcJpC1WOsiOW2dFJwZMNzt9OVF7Zw5LGq2sbYwC0DC0InZZjqB4EW8H8Y
	 04J6CIjsjccAMLREBVl7Hem/j+H+xSyhaxsUl2vzAyQEjSu7I/hsPYadQrC1T+OI3E
	 UNHWyGT+1F7tgC+FMlZVOJFKjK4jljQV29vFxhElWOLb/Fe5iVuRJMCHbCdCEaWL+Q
	 Pp6az5mLuXFZQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 12BE5C43617;
	Wed,  5 Jun 2024 02:40:32 +0000 (UTC)
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
 <171755523207.3149.14022797000797834471.git-patchwork-notify@kernel.org>
Date: Wed, 05 Jun 2024 02:40:32 +0000
References: <20240604230837.2878737-1-dnojiri@chromium.org>
In-Reply-To: <20240604230837.2878737-1-dnojiri@chromium.org>
To: Daisuke Nojiri <dnojiri@chromium.org>
Cc: bleung@chromium.org, tzungbi@kernel.org, groeck@chromium.org,
 swboyd@chromium.org, pmalani@chromium.org, chrome-platform@lists.linux.dev,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to chrome-platform/linux.git (for-next)
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



