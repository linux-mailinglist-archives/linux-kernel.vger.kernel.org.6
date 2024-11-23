Return-Path: <linux-kernel+bounces-419124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E32BB9D69B9
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 16:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3F5C1616F0
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 15:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2888336AF5;
	Sat, 23 Nov 2024 15:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJtuPd2X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACEA18C0C
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 15:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732377028; cv=none; b=ahB8dENEaiAp7YwUpw1DjXK7TPmEUVmjkRAh6DPRXa7UNoHsCDevyVE9YB5f92FGxx1OaQi9TTGEJK7tSgAklNot0S/TDlh+AHpWBF5p/awiGKr8kuq7fX1hbZCipvR52aVQp+GwIGiiu+yLbgZa4UsnRkSUcPxcDL9nyMifpAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732377028; c=relaxed/simple;
	bh=XT9zzKOdfdchStJsLUSyFcrd594yylJRHhSHXGI1VVg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jN+z/DdhjMfkx6pAkvwVn7lfDnfAJ8S+kYfEJcCzSxCOF65fTXf8b2yx3NE0M/705bOMYn+WIIO3pueh+37lmNfZzGzuG39JtODv1wO4lUtQNmwBskpLPb8uvayTokA+pJpobolzDGB1gdZo+yG0K8Pn3L+jnR0pR1jp3/eZ5D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DJtuPd2X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05068C4CECD;
	Sat, 23 Nov 2024 15:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732377026;
	bh=XT9zzKOdfdchStJsLUSyFcrd594yylJRHhSHXGI1VVg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DJtuPd2XOJby+FWLFQPznGujNiyucTulN0lI/PId/oFQUcpwQUxO8TPIOIXKytxZa
	 FVT3PoTyQDrEMd4erPHGGoQCjKJEleuBtA1Y1l7t9EVaz8JyYjzYf2DQlcV9QHu8J9
	 X6grHaYlc2CcnZdLX2dSPk0DM7bsIp4qqswy3WsjnQZUdx+2CMnz3RLmP5x2NvpG22
	 wSF5vWXRu5WN4x6XEjJqmC/nrIPUghsp3855/O7Umqarzy8IQXQU3ARTh1GFjpiBIz
	 38BaZn0Q5UpF8sjNkDLfy7XIfBOLiJSTUc6QxxPVAkdkhtRUdgaPQDY8Z2R4TJRyUo
	 yZz3+3IMx/Uww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71BCC3809A06;
	Sat, 23 Nov 2024 15:50:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: print message if fscorrupted was found in
 f2fs_new_node_page()
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <173237703828.3018181.12274971002493220671.git-patchwork-notify@kernel.org>
Date: Sat, 23 Nov 2024 15:50:38 +0000
References: <20241120065850.1345670-1-chao@kernel.org>
In-Reply-To: <20241120065850.1345670-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed, 20 Nov 2024 14:58:50 +0800 you wrote:
> If fs corruption occurs in f2fs_new_node_page(), let's print
> more information about corrupted metadata into kernel log.
> 
> Meanwhile, it updates to record ERROR_INCONSISTENT_NAT instead
> of ERROR_INVALID_BLKADDR if blkaddr in nat entry is not
> NULL_ADDR which means nat bitmap and nat entry is inconsistent.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: print message if fscorrupted was found in f2fs_new_node_page()
    https://git.kernel.org/jaegeuk/f2fs/c/81520c684ca6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



