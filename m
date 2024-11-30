Return-Path: <linux-kernel+bounces-426408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2169DF2A3
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 19:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04EA2B21A6B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 18:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27D91AAE18;
	Sat, 30 Nov 2024 18:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NjhWBm6e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4B71AA7AF;
	Sat, 30 Nov 2024 18:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732991978; cv=none; b=OZ5n0HD9T/d+m1bVo/76uIiA08dUTqFAw1n5y96cZrcBymlQH4cvUOGJH/HHmD+GXrDb8uDgm7ClIW/Ndx4uSnlzY5N6KpD92pyZvAR1YmHPMsF/utq9vpTj+sH2vJqT/mpHAH2q6oVUjSE+HK9DiXG8/xHnfJkSN3jakXcTOmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732991978; c=relaxed/simple;
	bh=BsHYzJ643Cv6bjvVY6CWZwVCOk/ZdpyN/K87JbPk+n4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=mKY0AKv8ekokgjUXL7U4CkyL/QZhq4scwdIKs7SLDtnMyOCFPuUZmuwoPwI0lFgp3WI8mI6nvNqo0siRZHkyFwmfWbIAqj/qBOjCPV2QpbXFWCPsMAREysuGAdWJElfDTVQVZCZjc2fct43pcEmB4+wJElgrUCDODJiWPv9rOQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NjhWBm6e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C09D2C4CED7;
	Sat, 30 Nov 2024 18:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732991977;
	bh=BsHYzJ643Cv6bjvVY6CWZwVCOk/ZdpyN/K87JbPk+n4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=NjhWBm6eOBEvkZSa8gnMZSeSY8qCaFroTborMutlWbsu0Dn3VYZv3XSY33xib3dMe
	 eYfPl8QFL5o0c6UAMP1MfRbgmxyqoO95d617Js2hcs/JSJhmlIHIyi8v6yaWO397JZ
	 UBslzh10l/7PgzX7BgRu1WkGO9SdVAlI1i/u5YfgV7e9Njc6UYVzvsOL8BLcrz2XDs
	 S7jC3UfCnIJg66IksYI6GfF6oszuVcFLuh6NEvy0aIA/vROEG1cjX/I3nb1rOaaf6m
	 4GtQvuN5gyMtJJPIQaRVP46jQwfcanDV0S9bcU6Nh0O/ofhfJnSwFgZpuRagFDA69J
	 PPM99TgBms3Pg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AF249380A944;
	Sat, 30 Nov 2024 18:39:52 +0000 (UTC)
Subject: Re: [GIT PULL] smb3 client fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mtEPAZ4XVpvWszL3=Vah7hxTJYoZbGNzh-fLT_-ayquxg@mail.gmail.com>
References: <CAH2r5mtEPAZ4XVpvWszL3=Vah7hxTJYoZbGNzh-fLT_-ayquxg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mtEPAZ4XVpvWszL3=Vah7hxTJYoZbGNzh-fLT_-ayquxg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/6.13-rc-part2-smb3-client-fixes
X-PR-Tracked-Commit-Id: 8d7690b3c146f8ae3089918226697bf4e3943032
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0235da0faeeec1c1ce2265fc627f5d5d9cae7ce8
Message-Id: <173299199136.2451487.808904071243250778.pr-tracker-bot@kernel.org>
Date: Sat, 30 Nov 2024 18:39:51 +0000
To: Steve French <smfrench@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, CIFS <linux-cifs@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 29 Nov 2024 19:00:17 -0600:

> git://git.samba.org/sfrench/cifs-2.6.git tags/6.13-rc-part2-smb3-client-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0235da0faeeec1c1ce2265fc627f5d5d9cae7ce8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

