Return-Path: <linux-kernel+bounces-211836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 870429057B9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 17:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11354283DF3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 15:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E9D1836DF;
	Wed, 12 Jun 2024 15:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jFdjzOKq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC570181321
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 15:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718207757; cv=none; b=ncRC6b1siTkN2yALoC7iSXgg3PRf+T/Yxf2EmrAgkzSKI8wLU1YfViB8f5UdJdJDnVrRszSQrH3K8KO1g3EQgU82fQ4nPySy4+5dxAWh36hWJpISSVlMNE1UobSdsJAj9qZGB48NnoJWhdT5NcE1zu2eKCVQSO9qhPxhHLk5PYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718207757; c=relaxed/simple;
	bh=c3FMlagO4HhbTzrgPecz6RKU3l5fy3h1uoMfDBquvuY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JNw0AWSivvSWi+ba0Lmzvg9TS7fuDuhj5mvwYmidt5ZyRBPPdVIU0XqesKCU/G6cC04bvhMVjANJajyqjV6Wa1ZVPg7KnWIV86p79LyGwn/hW1stByOZdT9/lb9SDiV2upRjieELTNthcO5Zi3DxZmWvxW0XMxLw6M2y1BAWe3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jFdjzOKq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 89176C4AF1C;
	Wed, 12 Jun 2024 15:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718207757;
	bh=c3FMlagO4HhbTzrgPecz6RKU3l5fy3h1uoMfDBquvuY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jFdjzOKq0QfNuyRJKUIX53p1TWUF4Jqt6Gn1h14i6f2nUpw/qk5WT1ga4WLCFUW8/
	 7iJ/PpmlgabK5a7jKfsUCrCDerHtBd3mOAWaivowbOC26qO7P4S48VOkBIHsoTmURr
	 7cww1VUd/TrH49B+4KA9xFccuXq2WV948S3pDJWMLmnPLdtQQxIseE/HEdwD77Y33x
	 5wppROmrDmcelhhA5Dvk3a0FG/Kb/FkYackp25y+7utUos45hC/eF3Qy5xFYdPIJfm
	 6W2Jc9IZpSUAa8AnPyxHlmKOd0rv88SjxVgBaeMwqkzd3XByG1ebu9VzAY4/s/pLEs
	 /nxB16kMzaJ9g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7ED9FC4361A;
	Wed, 12 Jun 2024 15:55:57 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: add support for FS_IOC_GETFSSYSFSPATH
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <171820775751.32393.2721044204636659523.git-patchwork-notify@kernel.org>
Date: Wed, 12 Jun 2024 15:55:57 +0000
References: <20240515081233.2463848-1-chao@kernel.org>
In-Reply-To: <20240515081233.2463848-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed, 15 May 2024 16:12:33 +0800 you wrote:
> FS_IOC_GETFSSYSFSPATH ioctl expects sysfs sub-path of a filesystem, the
> format can be "$FSTYP/$SYSFS_IDENTIFIER" under /sys/fs, it can helps to
> standardizes exporting sysfs datas across filesystems.
> 
> This patch wires up FS_IOC_GETFSSYSFSPATH for f2fs, it will output
> "f2fs/<dev>".
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: add support for FS_IOC_GETFSSYSFSPATH
    https://git.kernel.org/jaegeuk/f2fs/c/cc260b66c4cd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



