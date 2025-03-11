Return-Path: <linux-kernel+bounces-556890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C94C9A5CFEC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 20:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B0963AD545
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2F7264A87;
	Tue, 11 Mar 2025 19:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gb2Vb8hs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6932641CA
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 19:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741722605; cv=none; b=QQ1QssqbyfmdCtb4UeqqHL7I9wOeNWOydb9q0vdtXADOj+O/pBLBT7HHfZ7mWybc8TwJNIs1FakjMJ4qvoDP0/gfgh9uCjyejc3qdRH1h4cZ0n2DR24pVuNvDVFzJaYGpPyPz4r8ZoxM9aoVh7ga4Tui6KouuH800saNTOQUG5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741722605; c=relaxed/simple;
	bh=Cwz3YGGG06uS5rTz987s1NY7XkDbZR/rxmyhnN3CR7s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZaqSTgR0eoFdPMYJGL0Ef7TyjHr2OZB6TLk8KBlEVB1zugaekpGOgUD01qaKEH5aXdx3YQn1/Dd/miyRMOPst9XicqzK+pDrpJuS5zaHCfm8Pt5kXbguyssMqAKQ0/DGPbaiTyaRUkvTPb1WaL81l8n91CLVylZkhgnjlCnzTcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gb2Vb8hs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9EBDC4CEE9;
	Tue, 11 Mar 2025 19:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741722605;
	bh=Cwz3YGGG06uS5rTz987s1NY7XkDbZR/rxmyhnN3CR7s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gb2Vb8hssPd5IwW6EJ8PaDZyyTxazXrxg31Wpdch7somRPY9HjRLGKqzMwDXoCao3
	 m9yox02TZoyU2U/mxPB7e1tCbjV5EoUg8mZLhV0dCjAZVNbnYPAhpdGyX4ckZdeBc/
	 0M2ZNoYGXBhCP1PylLV9MORJGhEIEntwwoEiWJ0zhdGPzR+KSHgKX9JXW9Vjk81s0e
	 hvTQqR3GbhavBSj92O/t8Oc3eG8IkPxd+EjsnwN0Rv+AHJBHsy7Tc5QDTthLq/DxQm
	 uURoWJLkauwY4k4itM8NJBcBNsDZTTCMK3SQeQEgYhMdrlCNv81ZSNWKCTywuQz8dG
	 h4l5dCVVBDFxQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33AE5380AC1C;
	Tue, 11 Mar 2025 19:50:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] Revert "f2fs: rebuild nat_bits during umount"
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <174172263998.214029.16633125667702978351.git-patchwork-notify@kernel.org>
Date: Tue, 11 Mar 2025 19:50:39 +0000
References: <20250305110712.2114200-1-chao@kernel.org>
In-Reply-To: <20250305110712.2114200-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed,  5 Mar 2025 19:07:12 +0800 you wrote:
> It reports that there is potential corruption in node footer,
> the most suspious feature is nat_bits, let's revert recovery
> related code.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/checkpoint.c |  21 +++------
>  fs/f2fs/f2fs.h       |  32 +++++++++++++-
>  fs/f2fs/node.c       | 101 ++++++++++---------------------------------
>  3 files changed, 59 insertions(+), 95 deletions(-)

Here is the summary with links:
  - [f2fs-dev] Revert "f2fs: rebuild nat_bits during umount"
    https://git.kernel.org/jaegeuk/f2fs/c/19426c4988aa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



