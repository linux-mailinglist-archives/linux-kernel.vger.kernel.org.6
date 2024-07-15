Return-Path: <linux-kernel+bounces-252073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CAB2930DE6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 08:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D38E1F217AD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 06:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371D613B29F;
	Mon, 15 Jul 2024 06:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cX5HT+C6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717CB5223
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 06:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721024557; cv=none; b=CQloYGRjUjd6wZqzjZlypqSj+gE1mwkLT7BziSPf9+YqaLnS3IoEA0B+JlN9U/8EZfC3wsynw1t9q0wvgz3xFXRp5Ly+f6t4wErPfwEU5+9SY2ckV8wqw9o+SCcXZIiHzkyCYasQdeHKiDEHupV4YcyxVHL4X+AeivbB0MLyXEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721024557; c=relaxed/simple;
	bh=Co1Akgsep+V5e0x3SqKrYkPdSIfOqSklD63YDt8g5Ns=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZolsbDKSKEroJ8OUcySBkE97vrp/mwjX6vXDxyKNr72oXDPUfXuh7WVpdqIVowC1rDpmpphZ/VW+C11TP+i1rXFSvs6fmWA0WFmAmJmMaRnY9ot36AzLQpGeHtn7MlQI0V1O1Ce3r2jEgwh8riWCNJQln7QT2cQBM5Z5xS2KPFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cX5HT+C6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59614C4AF0A;
	Mon, 15 Jul 2024 06:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721024556;
	bh=Co1Akgsep+V5e0x3SqKrYkPdSIfOqSklD63YDt8g5Ns=;
	h=Date:From:To:Cc:Subject:From;
	b=cX5HT+C6feoGfAic3pfRtIP+Ps13HfXKzbul1Heg5+MDHnUMYqVQi8CX6b1xF9Tjd
	 bBnxsFlV9vM3lRe6iC7hIjAdX8MGm4aFhzjorAnCFVQqlpMuymoqX/WS8SMJm66glk
	 ONZ2LFoiNtace049iRGggYA67l74Crb4EeXBAhsRohG9TgnkPShlRf5xYYrxj0fNrn
	 g1sBJ9uqq19dLqP2ghdoTz9tObkR12i6Ght+zFBqLJQp2LTa8G+xIg22rZupWOFlpA
	 HkXLnp7n3aCWh3HQ0z631IEa0SYolhgYdJE6RabHOg8hxaSmVkOmAkh/OcvbTeyRO7
	 mYQk1DX3zXshw==
Date: Mon, 15 Jul 2024 14:22:27 +0800
From: Gao Xiang <xiang@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Hongzhen Luo <hongzhen@linux.alibaba.com>,
	Chao Yu <chao@kernel.org>
Subject: [GIT PULL] erofs updates for 6.11-rc1
Message-ID: <ZpTAI1mLZ1pfTnz8@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Hongzhen Luo <hongzhen@linux.alibaba.com>,
	Chao Yu <chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

Could you consider this pull request for 6.11-rc1?

No outstanding new features have landed for this cycle so far.

There are patches addressing folio conversions for compressed inodes:
While large folio support for compressed data could work now, it remains
disabled since the stress test could hang due to page migration in a few
hours after enabling it.  I need more time to investigate further before
enabling this feature.

Additionally, there are also some patches to clean up stream
decompressors and tracepoints for simplicity.

All commits have been tested and no potential merge conflict is
observed.

Thanks,
Gao Xiang

The following changes since commit 256abd8e550ce977b728be79a74e1729438b4948:

  Linux 6.10-rc7 (2024-07-07 14:23:46 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.11-rc1

for you to fetch changes up to a3c10bed330b7ab401254a0c91098a03b04f1448:

  erofs: silence uninitialized variable warning in z_erofs_scan_folio() (2024-07-13 12:47:34 +0800)

----------------------------------------------------------------
Changes since last update:

 - More folio conversions for compressed inodes;

 - Stream decompressor (LZMA/DEFLATE/ZSTD) cleanups;

 - Minor tracepoint cleanup.

----------------------------------------------------------------
Dan Carpenter (1):
      erofs: silence uninitialized variable warning in z_erofs_scan_folio()

Gao Xiang (8):
      erofs: convert z_erofs_pcluster_readmore() to folios
      erofs: convert z_erofs_read_fragment() to folios
      erofs: teach z_erofs_scan_folios() to handle multi-page folios
      erofs: tidy up `struct z_erofs_bvec`
      erofs: move each decompressor to its own source file
      erofs: refine z_erofs_{init,exit}_subsystem()
      erofs: tidy up stream decompressors
      erofs: avoid refcounting short-lived pages

Hongzhen Luo (1):
      erofs: get rid of z_erofs_map_blocks_iter_* tracepoints

 fs/erofs/compress.h             |  61 ++++---
 fs/erofs/decompressor.c         | 148 ++++++++++++++---
 fs/erofs/decompressor_deflate.c | 149 +++++------------
 fs/erofs/decompressor_lzma.c    | 166 +++++++------------
 fs/erofs/decompressor_zstd.c    | 154 ++++++------------
 fs/erofs/internal.h             |  48 ++----
 fs/erofs/super.c                |  34 +---
 fs/erofs/zdata.c                | 346 ++++++++++++++++++++--------------------
 fs/erofs/zmap.c                 |   4 +-
 include/trace/events/erofs.h    |  32 +---
 10 files changed, 496 insertions(+), 646 deletions(-)

