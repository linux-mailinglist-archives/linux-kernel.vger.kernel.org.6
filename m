Return-Path: <linux-kernel+bounces-418809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE95D9D65CE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 23:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 735D7282B51
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 22:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8D61C2337;
	Fri, 22 Nov 2024 22:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q2xnh7Ai"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2311BC06C
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 22:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732314747; cv=none; b=amU4csojjNKJv5WAPcvfVdGrdjmEHxntmUzgZI607Nv9ZTchEWbD8oMGAWlbWnfy6EU7pUTcVqb48yJta1b8m7J2tAol2d9Lfux7/YQP2EDmKCUGUmhLTZkbGe9AdAqhpd9RJP8AdJXUAAAKuYzwT5JP5F/87vNK3D+OQYdn+U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732314747; c=relaxed/simple;
	bh=YJL7FJAJ2iI4FVHQGL9MXQvVCV2RzIblmkLUlrUrW18=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=su1ectgQwOZ40ztiOq3pDDQCPmPrigWC7m2SHAqx0ZDwuWC1EZHufcqsKdsW9hO0/lyTk+sGYS0sRv2EBnnUiumvwifzGspK+2D/1qma2YGvvI3hCfwOmyZQUxg3qhIwRu8Y4WcjkgwPnhKDOoYGK2CULNAD5whlAWKswOe+RUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q2xnh7Ai; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B1E5C4CECE;
	Fri, 22 Nov 2024 22:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732314747;
	bh=YJL7FJAJ2iI4FVHQGL9MXQvVCV2RzIblmkLUlrUrW18=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=q2xnh7AiWj2shUASVw3BptuCJDHVpEA3VPL0HM+U1nAKlk/hz2MJALlIT0jsx6Oq6
	 QVUTqBXem8WpTFb+qhxvU76dwJ1GVE4k9Gbn/KyzkfrtlpNFg8gF42gxIxkyxtVAtP
	 gTFfNLKpYIYgZxAhMX44f60LUijeRvbrC7IbKbL2k1vhkifSIy6Lt5Sr8Bzr4OpnZ6
	 nSWOKLbEfiM7ry4J411Th9jXXRgSQR0bZdKJsMvHgd4HCxJQ3gZk7yCZTIeY4TKaDq
	 OfmJumSL60ZDyIbV35e325OeEKlsIQSNMieIiwISshfnOPhe91u5i/VTW+NV+g+IRX
	 u58MCTF8pA+hw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADBE53809A00;
	Fri, 22 Nov 2024 22:32:40 +0000 (UTC)
Subject: Re: [GIT PULL] x86/tdx for 6.13-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241120013243.831531-1-dave.hansen@linux.intel.com>
References: <20241120013243.831531-1-dave.hansen@linux.intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241120013243.831531-1-dave.hansen@linux.intel.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_tdx_for_6.13-rc1
X-PR-Tracked-Commit-Id: 7ae15e2f69bad06527668b478dff7c099ad2e6ae
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: be4202228e685d580d75ac7597c0e7e50a63dd6c
Message-Id: <173231475938.2827182.11330495516248255403.pr-tracker-bot@kernel.org>
Date: Fri, 22 Nov 2024 22:32:39 +0000
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: torvalds@linux-foundation.org, x86@kernel.org, linux-kernel@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 19 Nov 2024 17:32:43 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_tdx_for_6.13-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/be4202228e685d580d75ac7597c0e7e50a63dd6c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

