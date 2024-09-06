Return-Path: <linux-kernel+bounces-319257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 340C596F9C1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 19:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D24891F2562D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 17:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58241D4607;
	Fri,  6 Sep 2024 17:08:36 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD321D45F9
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 17:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725642516; cv=none; b=mLEHCQu48jbp+VEPEfpTFebM4ylsqZ1YoWFyXHRZ1Nt7cH6Wh8d1aAgObRLtheB/XRw9g8VzKJ7l9bz2rYpOpFpXr6s+L6NhqJ8sRfJhu4my9/BV7WE9NoLQNXxSs+0xj+0gIRcov1riHC59bXcfOi0fXBkDrdEck9TClsvdMvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725642516; c=relaxed/simple;
	bh=CuUvTAIM1xwbtfJ2xJo/RWMjCH9YZ5Z4n5RiO2zK7MQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KSTqXOQasHMpXdFy9sFQ6+cb6uvaqktI2U0NH+VRzyvYqd8zpwFZN0Vh9ZVXlK1CwLAbakbP3gyY0ziDh71Ok7SZAOWgvti17evr3l7naUjV4HKoAAB2vukWwCWQA81Z0PRTaAB3DB0kKsE8L2PxipWNOf1D4xZ/ynx0FqX529k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 200CFC4CEC4;
	Fri,  6 Sep 2024 17:08:34 +0000 (UTC)
Date: Fri, 6 Sep 2024 18:08:32 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 fixes for 6.11-rc7
Message-ID: <Zts3ECHu-7nucQHp@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull the arm64 fix below. Thanks.

The following changes since commit 75c8f387dd16066a90c0928d00851edad0c8c519:

  Merge tag 'kvmarm-fixes-6.11-2' of git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm into for-next/fixes (2024-08-23 09:47:39 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to c060f93253cad63ea9d41b5b1186a1da32541dec:

  arm64: stacktrace: fix the usage of ftrace_graph_ret_addr() (2024-09-05 15:03:35 +0100)

----------------------------------------------------------------
Fix the arm64 usage of ftrace_graph_ret_addr() to pass the
&state->graph_idx pointer instead of NULL, otherwise this function
just returns early.

----------------------------------------------------------------
Puranjay Mohan (1):
      arm64: stacktrace: fix the usage of ftrace_graph_ret_addr()

 arch/arm64/kernel/stacktrace.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
Catalin

