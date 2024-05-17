Return-Path: <linux-kernel+bounces-182523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E888C8C52
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 20:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B0E21F2313B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 18:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A8E13E02B;
	Fri, 17 May 2024 18:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VBg5Yt1F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67F8DDD2;
	Fri, 17 May 2024 18:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715971436; cv=none; b=P71xOugPGZmIr/yZ9MhKh146LCqT7RXBk7Pp0O8S2xg3gNFaNhWYkC+771xIFke7skBR2HvQjXQxEPc2iXKRpSpeyllwVfzsX4I6vD0hOFT7LTNOXgnAtb/N33eGkls+Jkyc89DxKV19huchLtQnIfFbIb0Qtpi/ejZMDZXTLLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715971436; c=relaxed/simple;
	bh=rXPQJygbC0DMISP7QXzLWaPWajAHo71QuVi0X8fQ/pA=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=o5JLPUiYGQUpDFSwY0df2RGFTjbX+BlzfEWfhOud6mOUUYMsClCMyH8tTUW+dyUBxtkIU6Hd+ldbkX//7uH69veBNjg5vOvVnm5/y+M9ap7bsM9HZZZTppYyA8dXAzmY02HpNnBlug3v8xS+sfADq7y8nSnMkIuu7yztBYlFEOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VBg5Yt1F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F235C2BD10;
	Fri, 17 May 2024 18:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715971434;
	bh=rXPQJygbC0DMISP7QXzLWaPWajAHo71QuVi0X8fQ/pA=;
	h=Date:From:To:Subject:From;
	b=VBg5Yt1FpfyOZusa/16xesupKHDQUs11gDGAIja2miCvaBHrkZJrc/7VYKJrIr59/
	 sRqvnVuaXaxtJqVZohHtX5vC5fKr25WOH+c4VZ+m4Y/qmioB4Wny0CTOTAVZMWYMjo
	 UtuXMj9tJiayNM2DgA5FCEM1qgvdguaP0VJFfyQgEpKRwCyJk0ldllxcKOHD3f3C2G
	 K1nIgYI0H8anWrguwfcKwfEaBTdGi7ZA4mX9GxZOE5LiZghLUEqo8Oz2Jaa1Ls+1Yb
	 be4kVto5HhMchNbUR3F1qYjN7HMbGICG3s74oCVNNfKL9pPMAhUseZapDjHyOXNWnD
	 B8F+j/1DS2VBQ==
Date: Fri, 17 May 2024 20:43:50 +0200
From: Helge Deller <deller@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	John David Anglin <dave.anglin@bell.net>
Subject: [GIT PULL] parisc architecture fixes for v6.10-rc1
Message-ID: <ZkelZteEp_Cgqwo1@p100>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull a few small fixes & updates for the parisc architecture for 6.10-rc1.

Fix sigset_t in uapi headers and silence one compiler warning in hugetlb code.

Thanks!
Helge

----------------------------------------------------------------
The following changes since commit e67572cd2204894179d89bd7b984072f19313b03:

  Linux 6.9-rc6 (2024-04-28 13:47:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.10-1

for you to fetch changes up to d4a599910193b85f76c100e30d8551c8794f8c2a:

  parisc: Define HAVE_ARCH_HUGETLB_UNMAPPED_AREA (2024-05-15 17:14:26 +0200)

----------------------------------------------------------------
parisc architecture fixes and updates for kernel v6.10-rc1:

- Define sigset_t in parisc uapi header to fix build of util-linux
- Define HAVE_ARCH_HUGETLB_UNMAPPED_AREA to avoid compiler warning
- Drop unused 'exc_reg' struct in math-emu code

----------------------------------------------------------------
Dr. David Alan Gilbert (1):
      parisc/math-emu: Remove unused struct 'exc_reg'

Helge Deller (2):
      parisc: Define sigset_t in parisc uapi header
      parisc: Define HAVE_ARCH_HUGETLB_UNMAPPED_AREA

 arch/parisc/include/asm/page.h        |  1 +
 arch/parisc/include/asm/signal.h      | 12 ------------
 arch/parisc/include/uapi/asm/signal.h | 10 ++++++++++
 arch/parisc/math-emu/driver.c         |  6 ------
 4 files changed, 11 insertions(+), 18 deletions(-)

