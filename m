Return-Path: <linux-kernel+bounces-414946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFE49D2F8D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 21:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04672283BB3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 20:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666501D5155;
	Tue, 19 Nov 2024 20:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KONacks7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56F61D460E
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 20:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732048526; cv=none; b=ZsfDLL5+Akt20CPjjWF0voxDzA1A/TWLMCDS+CoPIA72tk3/zdYYKADqrlud79/S55UDPsmt76sNdH/GU37BFtFs8jgsM+t+fBlgDi/P4fEYY1xzEgVYfDHGe6UvXrNdHL4AoZLgUUH5nWZAJPGDQXasMgCmIe7raNYRSdw6CHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732048526; c=relaxed/simple;
	bh=RoEr9UmBVLM9VRpD+ZDgkiNfTiWwCbqypANvHbiYXOM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=jrUQoeyQzloOeyU/nof9hZxrb6s0ywhJvcXkx1ZuQH+2ekK+S0pjD3ioWcGrgCy23ChV6zkZaQkZK+Y217aBhj7hqJIg95DAStJXOaysmy6LVeIKZslInP7q1y3+Y9BAjZKS+7nXPq8oP8hmAyAziJnXdoYsL8z/5J7JmWodm5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KONacks7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A706AC4AF0B;
	Tue, 19 Nov 2024 20:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732048526;
	bh=RoEr9UmBVLM9VRpD+ZDgkiNfTiWwCbqypANvHbiYXOM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=KONacks7p2WGVNmYile7SL8NYkxFhUxaZvF1Bkth+U4zUbWUE2TAQYnh2ZznjyoLP
	 uNcG3ojsF+4takfGP8njRojFElP5B9cMLvYK64FAqQd61NQvJdYRHMNzugokQ7Xpka
	 MZIF6jr7RkkZbJn7zt9+xHnxZ/ids52KoqcpDozglyIPSdjHzXcOZ27ASILYR4rBNe
	 IejabIAIEZpc9u7eqN+eoD62j4jSh0v8kz7qeIRkL357Na9bINPnDOim8ueIDSGsqt
	 7qAXkubALYISjKKEuwaURM17xmJ849hoqwGSOy5/uKILmHBKN2EhMxl6ylUVtF7yAO
	 9WbCzVFoXihZQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7184B3809A80;
	Tue, 19 Nov 2024 20:35:39 +0000 (UTC)
Subject: Re: [GIT PULL] x86/microcode for v6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241118150327.GAZztXP3hswdK38kJK@fat_crate.local>
References: <20241118150327.GAZztXP3hswdK38kJK@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241118150327.GAZztXP3hswdK38kJK@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip x86_microcode_for_v6.13
X-PR-Tracked-Commit-Id: 9a819753b0209c6edebdea447a1aa53e8c697653
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ab713e709938ec4045b4cddcd850a0135ae343b4
Message-Id: <173204853794.680579.1800398092278901822.pr-tracker-bot@kernel.org>
Date: Tue, 19 Nov 2024 20:35:37 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 18 Nov 2024 16:03:27 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip x86_microcode_for_v6.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ab713e709938ec4045b4cddcd850a0135ae343b4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

