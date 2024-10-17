Return-Path: <linux-kernel+bounces-370316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 007BE9A2B09
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 19:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B979E282BA5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 17:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE56F1DFDA1;
	Thu, 17 Oct 2024 17:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XN8nnuMO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590F51DF98D;
	Thu, 17 Oct 2024 17:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729186444; cv=none; b=OdXbqLJRVnvyjkyFV+KTTYvmGs7SjeaoxKwKTKrJ0AGjNSM+6FYwBBmpBQhL3dAo0CX6cmScHmJaZIRbzdNXwcivNm7dBgJAWbMpPr6F97ye/ziFKNitjF4zIXC36ZuQxnQwWCQmdWj5vH6eF6623hebs/asW0d97Cu/uOgNf+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729186444; c=relaxed/simple;
	bh=jPr/nf1eLLa436lI73XxGXL7DW4MyxgUa4WIJmCnTXE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=DzgzY+SYz1Ep6KQ5CocKfTmTjzP7HiwZQR/tSnmXO1E67ZcHErRwRVnwBbgNjxJuf8wtr+gRj5N9RI3MtNh/VpTm0QLSx4fMU6qZxI59OFZs6/jCX1TDOlXDPEkoNh5dO6R1yqdeQXyY+tv1be2PDvYWzxaMBeoxRDXXd8Mc458=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XN8nnuMO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38941C4CECE;
	Thu, 17 Oct 2024 17:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729186444;
	bh=jPr/nf1eLLa436lI73XxGXL7DW4MyxgUa4WIJmCnTXE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=XN8nnuMOoLkmzFYakW9juYaKgWe/n12pOl0DdZ7/NLOG9sbeYFOusuqJnKvrNazPs
	 93zFRIvDhLOCAukCEKXgNtxl8skshUL4uK1XYqZFa2INKi3GnwmFCNvWXK+wdoB6vC
	 bzhXBLX0NiIcqFFszZHfe1P4QZqUqvX2IyUnnIybf0tmizTkRxj/u28+zS0mHCS7mn
	 SvqarX2+UNYIyHg8/aoU5swiJvIRLXUW6xvJopV84oU9rdgZObrH67k9mEz2qSCqrE
	 UFjXHr9emNFGPhLl5lPGgdvrvVy7w+FE12KY2IFe9kukqiHVCAJVUYKZ8XXtOqPTX2
	 iHgW64aejMSlQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD7B3809A8A;
	Thu, 17 Oct 2024 17:34:10 +0000 (UTC)
Subject: Re: [GIT PULL] soc: fixes for 6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <5547084c-db39-4a92-968b-413f5d843582@app.fastmail.com>
References: <5547084c-db39-4a92-968b-413f5d843582@app.fastmail.com>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <5547084c-db39-4a92-968b-413f5d843582@app.fastmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/arm-fixes-6.12
X-PR-Tracked-Commit-Id: 1b59d6c19c2ca4e705effee5c2f68fd8ab307c90
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c16e5c94c8c2f0c20f5ce594188f84fd00040378
Message-Id: <172918644942.2551340.1036232273596697770.pr-tracker-bot@kernel.org>
Date: Thu, 17 Oct 2024 17:34:09 +0000
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, soc@lists.linux.dev, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 17 Oct 2024 15:43:42 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/arm-fixes-6.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c16e5c94c8c2f0c20f5ce594188f84fd00040378

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

