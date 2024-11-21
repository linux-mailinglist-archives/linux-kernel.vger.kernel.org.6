Return-Path: <linux-kernel+bounces-417206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D8E9D5093
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 17:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8C90282AD4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 16:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD5819F410;
	Thu, 21 Nov 2024 16:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="btZWjhMW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C72519E7D1
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 16:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732206021; cv=none; b=sGQt36FZMv0H2wgcY9WfK9LjOLJ942swJon0Ber6k7DGluMhEOrFg1Wi85vJ0H0uQ930IONY2VVFmPbatGncTfvre6RIWeljZSn/Jmtkv8td0718L4nsN6CuIgiFgyZfoAl5MfXnKGgAV0kYAnOdGVtmAcJUCju6QoG3ZvHtS6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732206021; c=relaxed/simple;
	bh=Pj6ucO4HVe7kpROZ5FlO+LChi3TwCRI5plILCfoqOk4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=t+Xc1O96fke0DES6v2USN9JwHS4fyfVT8FH3YQiCUoNA3f5mRWf7gde6nOY/YnJXMgF1dp5Eeuyx0rXFcQ7PrPUHmnoSnDK1yVsDUA2LjWNagbbytzR/eY7cFp09FVqbVHVmsYI/a9xcC8myGs1JZWEvspNlOghwbmxM0N12sGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=btZWjhMW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1351AC4CECC;
	Thu, 21 Nov 2024 16:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732206021;
	bh=Pj6ucO4HVe7kpROZ5FlO+LChi3TwCRI5plILCfoqOk4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=btZWjhMWcQ3vOpyF/wL6XsXPB29yqL44PlgjuIDyWQSslkkT462c1ZMGHk3ARbN/n
	 GeHHbC+v1BtF1xTah9eXhupEjD82/jVIpQUSmrgOnr/JKdmul9pU/snWdOnTSjhB5q
	 IJomuCXHQ4yUkCHHEPp4/wzzoOJ/RAbarxweATJBVf6FQNmFJqY6MYuZFh0Va9FKQW
	 IDPMACCGfLESl5AAWo5BM1+V964/4LxNT+TiZt0EmAj61KRlB+en972CHqQ0RMmJy0
	 8+IrYyL6sj1THpnCpR+jKbZbYH/fqJnTQtJH1XAWKSi1o7Q6FwDEpm1idU0Q9UnZ7Q
	 ewhrAxuRKWJtw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 36EF43809A00;
	Thu, 21 Nov 2024 16:20:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: replace deprecated strcpy with strscpy
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <173220603268.1977996.10380394142241465930.git-patchwork-notify@kernel.org>
Date: Thu, 21 Nov 2024 16:20:32 +0000
References: <20241118070141.3474-1-danielyangkang@gmail.com>
In-Reply-To: <20241118070141.3474-1-danielyangkang@gmail.com>
To: Daniel Yang <danielyangkang@gmail.com>
Cc: jaegeuk@kernel.org, chao@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Sun, 17 Nov 2024 23:01:40 -0800 you wrote:
> strcpy is deprecated. Kernel docs recommend replacing strcpy with
> strscpy. The function strcpy() return value isn't used so there
> shouldn't be an issue replacing with the safer alternative strscpy.
> 
> Signed-off-by: Daniel Yang <danielyangkang@gmail.com>
> ---
> v2 -> v3: store strscpy result in ret and return ret if error
> v1 -> v2: handle strscpy errors, changed prefix to f2fs
>  fs/f2fs/super.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [f2fs-dev,v3] f2fs: replace deprecated strcpy with strscpy
    https://git.kernel.org/jaegeuk/f2fs/c/789ca0eb47f7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



