Return-Path: <linux-kernel+bounces-417207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 777BE9D5097
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 17:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 649FFB243E7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 16:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1181A3034;
	Thu, 21 Nov 2024 16:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LQXPgOPS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6141A0BD7
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 16:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732206023; cv=none; b=r0A8p6VgHNVSuC6UKiSSAsBNGHVduRAbvf5A9LzhRzq7Q5QcYEvcR/C0CJKlOy9j+2RkOAKXn7an0ZacpE21cUAzMIx9ttqfdut98pRzoOgieyBE87ZQAiVVVJW+g48rgTs0YrAvFdcCtG9FqLFiSJZ1r4r121AtZQxExIfbp1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732206023; c=relaxed/simple;
	bh=RGARQvB2BI7CSMbr1w+xiIywJu8/CNafzE06Oc++Uis=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sQ1gW8goDFnZuOIQXmx2PbP8SeCBcLh4e6UFq7JTcml2ub/7Wkz3n3UscLMpQPSkcACekpZ+6dQIWPh057VPBbrQMJPyxHE+FwhP+QmPovbheNYAOYSIrvwy6oJsF4c2epnojXToH4rcQjBwla55M/3iq7ww2i2DP96bYC9tWbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LQXPgOPS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82259C4CECD;
	Thu, 21 Nov 2024 16:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732206023;
	bh=RGARQvB2BI7CSMbr1w+xiIywJu8/CNafzE06Oc++Uis=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LQXPgOPSSJnZlW1PMrEG5sc+WXFNSTb7KD/V6aPfk/HcQMHpWwROh5hQjIsYnBEbW
	 bTRVAZK0W7JI0rABvVEHhjfZTSjmFLUJP9C65zgq1fc4Hrrt8AHZyUNv3uaw2TbRz/
	 DMfhLf/526gWjsnDPjXZyYAh5njkErVi8KtBfWtwVEqKiwArO6iUQRcJ5n9GO0JSyL
	 IvlXMLP1MIlEmkz7PtlVhuQ/g7GGgnhTJnMY82qchY11Q8KmzEoWpHuAV1aLxu+hOr
	 zYjHc4CJaduLMQuARR3i5F/mnZXyrqCZndDq6Xkpk7M/3ovAn2KUL6gGuuEz7RcnM3
	 cXXDrEkqbE4BQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD063809A00;
	Thu, 21 Nov 2024 16:20:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: clean up w/ F2FS_{BLK_TO_BYTES,
 BTYES_TO_BLK}
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <173220603549.1977996.14578612741483518273.git-patchwork-notify@kernel.org>
Date: Thu, 21 Nov 2024 16:20:35 +0000
References: <20241107014602.3638020-1-chao@kernel.org>
In-Reply-To: <20241107014602.3638020-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, zhiguo.niu@unisoc.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu,  7 Nov 2024 09:46:02 +0800 you wrote:
> f2fs doesn't support different blksize in one instance, so
> bytes_to_blks() and blks_to_bytes() are equal to F2FS_BYTES_TO_BLK
> and F2FS_BLK_TO_BYTES, let's use F2FS_BYTES_TO_BLK/F2FS_BLK_TO_BYTES
> instead for cleanup.
> 
> Reported-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> Signed-off-by: Chao Yu <chao@kernel.org>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: clean up w/ F2FS_{BLK_TO_BYTES, BTYES_TO_BLK}
    https://git.kernel.org/jaegeuk/f2fs/c/7461f3709418

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



