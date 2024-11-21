Return-Path: <linux-kernel+bounces-417308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24DB19D524E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 19:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE5AB283924
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 18:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E4413A250;
	Thu, 21 Nov 2024 18:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V7lxX7Jz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813D814D6EF
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 18:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732212308; cv=none; b=CTTXHHfZLvzR8z9eHkQCsClE8UR9Kp+HtjKN/jMnJxFuDhnabLBJF7fui1uyg5EuauVMkxxv5P4tFzKTt453bn9fLrm+HjxQORBebuH/NZl4TO4fDrwfVWWvC/jXQx9y/Z5d6T/2kTzOs/sVQPEfMnbQnUqjrBv7zvOmXPwTTAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732212308; c=relaxed/simple;
	bh=wF8Ad6kilhgNHogcqaHFl2gIdzn8xpZQqvWZscLTqco=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=HfMxM2bsUuzctmVTrawol+ys5dvBu2fi7KTeBVtBvSHreCjY47KdJqejfE4inoMTCKRzx4XA2un4Vn0m0wRX2cFBRSulTrLnTJf6wLuIyrIj+fJBQYOD+mOQY27mOafCeLZfS8k6M52I+ZuCbLl4u14OMgztRrnyDwjsA1VobrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V7lxX7Jz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B768C4CECC;
	Thu, 21 Nov 2024 18:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732212308;
	bh=wF8Ad6kilhgNHogcqaHFl2gIdzn8xpZQqvWZscLTqco=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=V7lxX7Jz6c4FkzVD3vQCS3bD9I50bkA03AsgjqT9kBkXTCkLLmUnxgKgFqa5uMxs2
	 uCT4JrcH27pPrVAvW8dFzjaQWNSbOX/0/wd4w3gW6EO284z5FY3GCywIIJh1xHlLwy
	 q8FOHw0x0VKegzGt4TBHJwmJM1w+V7JTMLFUlUNYVdFQXZIshYseosdGOTVWLnP8pl
	 BOR1M76jDfDFhJPEyCgaVx8vvRGdVn+DQAbYxuPQIoF/qzYSVz/tIw8Gm/Ss+gRImC
	 nxeYUSs898BapCGvgdbSjIzqX7NYX6uJX2lkv1gR9E8QHIuTvHX7oGX4EIVne4lPz8
	 3qlktmNGRnpvQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E753809A00;
	Thu, 21 Nov 2024 18:05:21 +0000 (UTC)
Subject: Re: [GIT PULL] erofs updates for 6.13-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZzynU2PQOgkWy6BM@debian>
References: <ZzynU2PQOgkWy6BM@debian>
X-PR-Tracked-List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <ZzynU2PQOgkWy6BM@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.13-rc1
X-PR-Tracked-Commit-Id: 0bc8061ffc733a0a246b8689b2d32a3e9204f43c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 90a19b744de3a4fb51aee2edd8f2b9a4b14c9878
Message-Id: <173221231982.2032550.9499251371642487333.pr-tracker-bot@kernel.org>
Date: Thu, 21 Nov 2024 18:05:19 +0000
To: Gao Xiang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-erofs@lists.ozlabs.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 19 Nov 2024 22:57:23 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.13-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/90a19b744de3a4fb51aee2edd8f2b9a4b14c9878

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

