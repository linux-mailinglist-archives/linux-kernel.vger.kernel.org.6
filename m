Return-Path: <linux-kernel+bounces-178028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E87E8C47A2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 21:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D274A1F229F1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 19:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE637F481;
	Mon, 13 May 2024 19:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NY8oKpPw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EF978285;
	Mon, 13 May 2024 19:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715629081; cv=none; b=d9UQPAYg/woWWGGTgBXlK33YBrOfMrbSVhaQ++U03VjndxfK/+BUtmZ6DA2ycG2WrScjnOzeIkyqnvCs16ayou6nxi6DYIgOsKs0MwoFXMKSQnHNScvcFHMAb50i3S3jfdLxtpkIQ0J6QDkyhamiC4OdI2WZHzCY5NUu9E4JTw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715629081; c=relaxed/simple;
	bh=mNULInQ/cr+jTALVBZl3RW6eB3tMeoMw2eNLUmJkGcI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=omIS/Lcrf1jlCTVJD1KdtZI8hc1vx/JDWxB3pTzeQvlf0q74xfjGI8klJrItuyURbQfHIZlxKWAqWEk/BdtPkY1epS/Fn231iNMLQGu2XxYiZfN450f0u1wVihSedjIEn/e7bDADZbgdtDggEkQPlStJjqELosszVBnZMSAWEJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NY8oKpPw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0C27BC4AF09;
	Mon, 13 May 2024 19:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715629081;
	bh=mNULInQ/cr+jTALVBZl3RW6eB3tMeoMw2eNLUmJkGcI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=NY8oKpPwnZNNlTP43Hz0CwcXL/5Dfv0JryWwanZIe8NcmzRkQshZLs0zzTw+hUw18
	 1K7grxcd1+0sHkh/MzKMV29cf73Lx13+q2eKaqcJYCF/oV3eqI6qcStyRM4bPGAjW9
	 5NlSnVOM0tKw3qCnfAGjOyK3s0OOzXtiB/qEoXqzGi1EoTSkXMX7Q4vu9mf2V2qU5e
	 /b6+zvgzHSgCP+VwHJRlYYzun9fJO+C9IFmdEfdOLsh2EPpDj/Z63vwmFnzwIm1af+
	 QaHgBaUEUhYBnYlXS23DZC2Irc8OigAbLZLGaFEgnsyH7fLwKG5jsBpBNlb2B0BFYv
	 G8DOVzfPRpaXg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 02472C433E9;
	Mon, 13 May 2024 19:38:01 +0000 (UTC)
Subject: Re: [GIT PULL] vfs mount
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240510-vfs-mount-ed8db9c38114@brauner>
References: <20240510-vfs-mount-ed8db9c38114@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240510-vfs-mount-ed8db9c38114@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.10.mount
X-PR-Tracked-Commit-Id: 7cd7bfe59328741185ef6db3356489c22919e59b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 103fb219cf57fc3641d92af2f4f438080cea3efc
Message-Id: <171562908100.8710.15987481011013053220.pr-tracker-bot@kernel.org>
Date: Mon, 13 May 2024 19:38:01 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 10 May 2024 13:46:47 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.10.mount

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/103fb219cf57fc3641d92af2f4f438080cea3efc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

