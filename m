Return-Path: <linux-kernel+bounces-574618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9846CA6E7B3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 01:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DBF31753E6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 00:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5B715381A;
	Tue, 25 Mar 2025 00:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RT69SuMF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FBA14D433
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 00:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742863500; cv=none; b=S/NiVzT8GJZRupLNuC91QXc7piG50rrtwE7XM6dgKA3fVk+XStH9Bvxko/gdetv5WJUisRt6wAcBbpCCfZ6pSscmFF4oB6ZyCOgJv/hp+EykwOkCnVA9SogsxNZXM8BqxDdeavGibTz6H+9x8YBAJzn6nqIxjc/+9J9CGUUB/Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742863500; c=relaxed/simple;
	bh=L+af8V7o/8Kq/T2917AvyJeLfeLJR6nlxNsrlXHRGRo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=DiyMYzZkI2sciKLl7uc5FyfwwymThez1Duya+9r5+rrj12yGv0cK+BxY+Y+bq0ISh3DWTUyO7AK/YT5OJz2deOju+FuW2Dve9nqeIT7LThi+YpiJ1En+xjtv2vAP5ZoE1CTE5rktbWOEY9xW4MwCeLb8rn+EFcpmQrXas3fEkNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RT69SuMF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36B69C4CEEF;
	Tue, 25 Mar 2025 00:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742863500;
	bh=L+af8V7o/8Kq/T2917AvyJeLfeLJR6nlxNsrlXHRGRo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=RT69SuMFiAwSt4nhrtehmWzIFs8A/kROaC6uBqtliqMU7k78qKgsPVqZoWS/9SK8b
	 0NsKQexw6UXtiEHKY9lnHrOagIpcUJLKYpmf1xQk12fUi3vftS00I1OIQFWbNiVnNO
	 jdIrtcT1dAjfWXTcoSKfEfA0nDVCDGlaZsyBlEAtI2i+Us6SvJAriTSXCI0kC71W5a
	 IHpx9dmhxA5DfOvSo0Fe2s++rSuXCWaj2jJldduxbEDVj1uiZqisl6uiiMFJv5+XmQ
	 1jNOAEHke8RqlhnHELHni1AmRwjV/B7l3KFlnvo6vT+7NYyPuCtj+sNDXEZlwZ4Txc
	 I+k3J9xHeEtQA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE167380664F;
	Tue, 25 Mar 2025 00:45:37 +0000 (UTC)
Subject: Re: [GIT PULL] pstore update for v6.15-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <202503170906.A32F95E32@keescook>
References: <202503170906.A32F95E32@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202503170906.A32F95E32@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v6.15-rc1
X-PR-Tracked-Commit-Id: 5674609535bafa834ab014d90d9bbe8e89223a0b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 95c61e1a9c924481c0828fbd7b9e0432741b7472
Message-Id: <174286353630.36585.16019950181302857870.pr-tracker-bot@kernel.org>
Date: Tue, 25 Mar 2025 00:45:36 +0000
To: Kees Cook <kees@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 17 Mar 2025 09:06:35 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v6.15-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/95c61e1a9c924481c0828fbd7b9e0432741b7472

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

