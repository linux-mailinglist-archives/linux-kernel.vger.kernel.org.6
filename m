Return-Path: <linux-kernel+bounces-385512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FF89B3812
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 18:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C85EB22B41
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 17:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920011DF72C;
	Mon, 28 Oct 2024 17:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S/yDcMRv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35C7200C8A
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 17:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730137242; cv=none; b=AQGpsS5G0S9WXytN6v5EYa7dbMMOcRX2QF2pHhOF7E23jyF6DD7Mpfor02U756xLnSchBl069UOjFluIzQFUyFICioxS8JEkOXcq0m+o8kqvykPJPgiBcO8ErFLFSi1DxW1A/bS3yexmIfx04iLq8rejKXtLDQ1YkYrn/8o10ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730137242; c=relaxed/simple;
	bh=1g4pCRYlPLwvCXSAUfYAAQ/mLLeUYd7xuLPtmql3+Mc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OLGmFO4hFSrK4kAnm8KoOqhNOMePSDk05B1oEiuaoKbzfcVSf6HsyI5lVBdzuZOlrFOrUhAy1ZA/uh/MeGkwWWszY5Ee6IQg27oQ51/p8AezsT2Pz4w7we5SzMlcpBB2t/XrPQFcW8dYS0raeLosLRURlQLGNQk5x159QwXTHbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S/yDcMRv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC8EBC4CEC7;
	Mon, 28 Oct 2024 17:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730137241;
	bh=1g4pCRYlPLwvCXSAUfYAAQ/mLLeUYd7xuLPtmql3+Mc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=S/yDcMRvmCeuNpiePf7+edKVD+PEJv5/MZFqvK0P1Jd+poUYqwHNgoX6qc0yXiJF7
	 CnpoOHOw8WCwxnYM5YKTjt0HH0qGIApBuw2pMBzc2pBqTwevoAzietwEdTpT9/7I2i
	 O+8eE6vwcAUoAcqhhtoGRhKaqnjT89b/cuxSPvCaqiTpWMMpj8Ye0X6gc588zvB+q4
	 r2dSMFAXe5NROTu/A7STzpU9st/3Y3NJHLRK02JML1imBKV1kC0zJK1X3zuwmG/NUd
	 6EaZyxB137GZ7Q+xAMCUup7N24Dk9kTPOaSVvHaairtXtnfuaYQlp7cUrVwkw+lLN6
	 HgDeLt6tuWZZA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 716E2380AC1C;
	Mon, 28 Oct 2024 17:40:50 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v3 0/2] f2fs: modify the calculation method of
 mtime
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <173013724899.126843.18304853477430411378.git-patchwork-notify@kernel.org>
Date: Mon, 28 Oct 2024 17:40:48 +0000
References: <1726653980-590956-1-git-send-email-liuderong@oppo.com>
In-Reply-To: <1726653980-590956-1-git-send-email-liuderong@oppo.com>
To: patchwork-bot+f2fs--- via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Cc: jaegeuk@kernel.org, chao@kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed, 18 Sep 2024 18:06:18 +0800 you wrote:
> From: liuderong <liuderong@oppo.com>
> 
> In cost-benefit GC algorithm, mtime will affect
> the selection of victim segment.For a large section,
> mtime should be the mean value of valid blocks,
> in order to select correct victim segment,
> it needs to modify the calculation method of mtime.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v3,1/2] f2fs: remove unused parameters
    (no matching commit)
  - [f2fs-dev,v3,2/2] f2fs: introduce f2fs_get_section_mtime
    https://git.kernel.org/jaegeuk/f2fs/c/b19ee7272208

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



