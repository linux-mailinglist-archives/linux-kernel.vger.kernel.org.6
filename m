Return-Path: <linux-kernel+bounces-562112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 704ACA61C46
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 21:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7A8D4602B4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 20:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BD320A5D6;
	Fri, 14 Mar 2025 20:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BOQbUew+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7018209F53
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 20:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741983209; cv=none; b=RtQTQk4Am+zZ7viAC0BBkrhQa755qu2IdTHA9dw1TfgDg0ncJqABZmf/NWhpglY9K1EI+iL+6lE7VB0679d2ruEmi6/h/wrHPG3GWa6Jq9kzVGZ7saLBy6yWaedUo/SFN8+zPb7ddFdehhtat+B0UAO/sB5W9kFTh+gJzxPqsFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741983209; c=relaxed/simple;
	bh=LL1yJzzp6EWZX7AJe+yY32kcTMRCKtpCdn+IdMKtU78=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=UDZiZIs5EblNIqynH7QW838XToH92S7t8cAa4uXNeVir8lmUjMPHsHxXHOc+aa7wcXNXyOoS6FnA855dgxVtdezTHEMQoLEshl2IaSYztbjIkMlYSLvLuXZYK2rzt6W0Z/B5HJXLkQgqEuzoELpsKCoKf82gbiptz/z2belMCM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BOQbUew+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6C63C4CEE3;
	Fri, 14 Mar 2025 20:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741983209;
	bh=LL1yJzzp6EWZX7AJe+yY32kcTMRCKtpCdn+IdMKtU78=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=BOQbUew+M7navHJQ1RwtqqPjo79OD1p00fAszWDXr8jFeuWJ4HDioAqq6829IzRqo
	 Ti6jAlA/clgKKcHFCI9lxyEet6kmpxh+ifc3Lgg3M/TVToea0+ET5C5s4FIZqqxi4r
	 +puRBUV3JOHjRZ1ApYAJ9+SR/YSBZH62bEJIDDUMuKOl4cUuoTMz0R6B+TJW7/fI0J
	 1tnxjKdzbiHZGUGcVQ27jUAUmw9XeOiVkbkBZ4GOA8dFVM4/TSJf26ARgtFDqcNsDs
	 3twPS4e5gozG7qEqkSP3bZeLuMsjMTj/+5Knm8fdb53l2ULtatK0Yxm4KsCsFwJO+X
	 yGac5ZU/nLj3Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF52380CEE2;
	Fri, 14 Mar 2025 20:14:05 +0000 (UTC)
Subject: Re: [GIT PULL] x86 fix
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z9PzZnXjnMnWFym9@gmail.com>
References: <Z9PzZnXjnMnWFym9@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z9PzZnXjnMnWFym9@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2025-03-14
X-PR-Tracked-Commit-Id: a2ab25529bbcea51b5e01dded79f45aeb94f644a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2eaca8a09e55a30e8f2df8d13d4071f8f856b716
Message-Id: <174198324421.2369576.16407837220528009556.pr-tracker-bot@kernel.org>
Date: Fri, 14 Mar 2025 20:14:04 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 14 Mar 2025 10:14:14 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2025-03-14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2eaca8a09e55a30e8f2df8d13d4071f8f856b716

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

