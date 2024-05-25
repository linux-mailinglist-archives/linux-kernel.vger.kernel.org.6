Return-Path: <linux-kernel+bounces-189538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B81E8CF163
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 23:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F7DEB20DC0
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 21:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC01129A9C;
	Sat, 25 May 2024 21:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lJ1mQ8WA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A98F2F2F
	for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 21:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716671307; cv=none; b=pSslfjcg+jFbWyz8TWyCimyVIOMD7OzhZiig50L+3IKD5uPUqWNP/0IYYxxuzki/IeLGPcW9TkYFfPwW9SAs6t9aOadS6jbGDw8xnHgwYRAn4CHh6Xt5pxGu8poDNjvq0RTOt9RCPES+bpuJ0Dhaw3kg63uLMh1OiuD7jNzMRJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716671307; c=relaxed/simple;
	bh=RAZPcuVaUgluuMJrmJ8VJE4uzWC0bD7VIThHXQfwhRE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=b81b7UH9aXU22QFRooxcQmQPUXbOh5nz96KmcrdGkTGxBplCMHI/H13y81EPwPXm4wuBP8IcYY18IlntaI0bAN3S86OUYnmUsOHJ2sa0ZlpHPZvr5i8m8havmjzKOn4uG93sz6WxgZFF8fRtFPISNdJPvqP89XXvj0NkVkpP9Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lJ1mQ8WA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DF231C2BD11;
	Sat, 25 May 2024 21:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716671306;
	bh=RAZPcuVaUgluuMJrmJ8VJE4uzWC0bD7VIThHXQfwhRE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=lJ1mQ8WA0DAF3DuFpb2oHlsbaYYxchU75tvIyBN0MKWRe61VQZ8AjoBAlb6uUXC2u
	 AR1yOuuSmW3TfCqsqDyxyBpDqRl+UF3tGzed6MuX9hwuh6AH5C0IiuS3+CbWuYOYf7
	 wmKeqUczmz+Nzg/beKOpLGdkJqipVE1ByS4W0u0trCcJJTP90aDAFP0veyfUkgRAc0
	 zPpzeb1eb9i/zg3u4N2zaSSTqG2cm8581r3sJOqDa5r6KtUywWJ0mMaPF3rwP5/Kp7
	 09GViwCFWJeZDdCKvYJ51eVO8ZxUa9pXyU8tHWacbBOiVuNxauuPbUo0dx5EeEFqyi
	 VJa3LcQrk5/cg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D7526C43617;
	Sat, 25 May 2024 21:08:26 +0000 (UTC)
Subject: Re: [GIT PULL] UML changes for v6.10-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <291644210.144818.1716585972644.JavaMail.zimbra@nod.at>
References: <291644210.144818.1716585972644.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: <linux-um.lists.infradead.org>
X-PR-Tracked-Message-Id: <291644210.144818.1716585972644.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-linus-6.10-rc1
X-PR-Tracked-Commit-Id: 919e3ece7f5aaf7b5f3c54538d5303b6eeeb053b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2313022ec5942e3ddd2e4e57002ed71926887f87
Message-Id: <171667130687.10959.410466621483892256.pr-tracker-bot@kernel.org>
Date: Sat, 25 May 2024 21:08:26 +0000
To: Richard Weinberger <richard@nod.at>
Cc: torvalds <torvalds@linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-um <linux-um@lists.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 24 May 2024 23:26:12 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-linus-6.10-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2313022ec5942e3ddd2e4e57002ed71926887f87

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

