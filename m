Return-Path: <linux-kernel+bounces-435586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 035BF9E79C9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 21:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0B2A1887637
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 20:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C8E20458D;
	Fri,  6 Dec 2024 20:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uWTyoFgW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78648204571
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 20:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733515514; cv=none; b=TjT+6Z7CxzHA1aoAnJhTGqDXdR+vxYkHqL81Umbjouq5AIy/qonNSyhKvM5ckvfAoaFrHBsFpc94e45FNbjIcJlL9NWbvFa2YDpaV3UjH2z78Lmb/UuyeQd8SC5sToD7T0jw7FnmyA6j2ZDdOMhJ6qrGT4GqFhMhCySC3HyLz4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733515514; c=relaxed/simple;
	bh=kTsabmL9ug57nRZrunj5mDfYoHK7D/zJkvyl2s/RuNs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ZwnN6o5wvBotX0UKTJsOWHf46pFI1otdW0lkmks6WESpK50Cajaw96W0UyS/vhcnCX2RBxlBuMua1Mb0PM9gBak1OesYCOmIonnYHeVmlyriSefX6g+R9miQjgunyqOFShVxLOlkgoaXvHjlCcj+uYfPF1ouDiHlJeeZAtdv/Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uWTyoFgW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A7A2C4CED1;
	Fri,  6 Dec 2024 20:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733515514;
	bh=kTsabmL9ug57nRZrunj5mDfYoHK7D/zJkvyl2s/RuNs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=uWTyoFgWcWZoJJmKRtWqiyA1Dz5Bpk/zxUPJOWzbHhJA2uqbLSTFykNYi7eiAraUp
	 NU0F5AfkYmPhSA5YY81apOIaKvmHoccV4zDqr3OMUulnm5kTq11R39UNnhuLN0oU1D
	 x9HTfSFul5msz1jipPlJNHUWDtMoz3/dlR3mqL5Xm+TL/21KinT2Jx3gGh2uhFKqUz
	 AQGOw/ZA4/VHbO6DyK0JnFjKsFrwJsN7MIl5UpdOFr1Y7rgY0ihXxg1bgQVOOdhKEs
	 14O2taq5gzvci4UQAvjwamg7ttt/1sxUr93vSDayGOydVxWg6qa4rW1sc6om65Tf0W
	 4aBjyB4bwzETw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B77380A95C;
	Fri,  6 Dec 2024 20:05:30 +0000 (UTC)
Subject: Re: [GIT PULL] regmap fixes for v6.13-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <93ea3817b0aa8bf9e95e9270537af268.broonie@kernel.org>
References: <93ea3817b0aa8bf9e95e9270537af268.broonie@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <93ea3817b0aa8bf9e95e9270537af268.broonie@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-fix-v6.13-rc1
X-PR-Tracked-Commit-Id: 3061e170381af96d1e66799d34264e6414d428a7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d9e15b25161e0783def5f852179db38d817c957c
Message-Id: <173351552877.2778953.2100547260654136493.pr-tracker-bot@kernel.org>
Date: Fri, 06 Dec 2024 20:05:28 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 06 Dec 2024 15:39:00 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-fix-v6.13-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d9e15b25161e0783def5f852179db38d817c957c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

