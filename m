Return-Path: <linux-kernel+bounces-552065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82557A574E8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 23:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 693451896D6E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 22:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE80A257450;
	Fri,  7 Mar 2025 22:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZXRfWbBv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F5F257AD7
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 22:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741386588; cv=none; b=fsWBvpLoI9VdJ+XB744aPPzaQ8S9OCD2f7xmsRFMwobCeY7RS4JRy5KFzNPbxWcCrFJ6zplnhenWMSgEav01SR4k8bPyR+WCRbVKE4wqRPo7cbMxOOoO8AjrZSmog9a7djh9xHjIZaQ+iZJmU6WuZLpCcqPYVqBneJ7Nj6JK2X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741386588; c=relaxed/simple;
	bh=Sxw0SFl7pvdkERis/7dzevXzwpuxXKikixnhKWKFVzc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=p9+5LTy+Fj+TtFtqz/R3wpKF0wrXjDOC1UZx+AlZ3SsgDi7iDnuKzx5V53XRw7y3jfHcRrx0FRbQcfZiqN28DvNtMZlmhzPESmTqtDBqy/dELWQoflnqKkc1H0DbPkpMjsGrpf9om29MvEGpq3WrT3H8/LAHKN5EWjprSLUn9wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZXRfWbBv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A71DEC4CED1;
	Fri,  7 Mar 2025 22:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741386587;
	bh=Sxw0SFl7pvdkERis/7dzevXzwpuxXKikixnhKWKFVzc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ZXRfWbBvFZzkG0rifJ18xFIx3udsyytXQmCs5yrRnROqkyqAS0gP9IfRnxrz+J+9/
	 RGteooNLwcLBLEnc4GxUuVgHfVvJZ6wv9nLyPx9KtLe/80+OyanX2z9BigeclbQE9m
	 VVDKbjaViRa0CEHgbcJo9tql4HDdRr6I02JSfAqX/oiHkerr2J1AfnpH/MPXCMoUcH
	 KO6lktt6whMG0b5gdImtvxnShVgEsYE1t7XMRayCO+b+f1BWbm0Juj6s0P7W/otXFM
	 l4ou3XSzgwLntwEvhbKTikfS3k06x7ztum7LFjlpmvd088O3qqqlu7GOC/wJnhxGfU
	 tZcdruwqTcDKQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 712CF380CFD7;
	Fri,  7 Mar 2025 22:30:22 +0000 (UTC)
Subject: Re: [GIT PULL] execve fix for v6.14-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <202503071218.21B5CA1@keescook>
References: <202503071218.21B5CA1@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202503071218.21B5CA1@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/execve-v6.14-rc6
X-PR-Tracked-Commit-Id: 39ec9eaaa165d297d008d1fa385748430bd18e4d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dd047efbe0e086f6ea82774cb239ec4c64a86d76
Message-Id: <174138662155.2506268.14815435804929424817.pr-tracker-bot@kernel.org>
Date: Fri, 07 Mar 2025 22:30:21 +0000
To: Kees Cook <kees@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>, Michael Stapelberg <michael@stapelberg.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 7 Mar 2025 12:18:31 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/execve-v6.14-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dd047efbe0e086f6ea82774cb239ec4c64a86d76

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

