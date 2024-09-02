Return-Path: <linux-kernel+bounces-310841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7793B9681E4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A85C31C21B1B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 08:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549F6186611;
	Mon,  2 Sep 2024 08:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b="Eu6kKwjW"
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0A8153820
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 08:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.135.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725265860; cv=none; b=mFeH49JLMXrKfBaCXdnhmFiCZfYkYCRt/wNUz0JM2b5xLOM1tIgxfKSQWBpah5vsIN6K/ZOPq7f2k8k8zkRJaW+9lvUwhBRsyfKwqLgDbd/pcBfyQL/rUE8xhCH1GAJxQD0CpyO7RoTC8yrBJV5f6+qO+qvZ46ZG3v+NJCNGb9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725265860; c=relaxed/simple;
	bh=AmPwK5ZGINCwCW9zw47gu4D74GSKi6tzyzwBVS11kis=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r8i9O7JDTcyYTopou6m/WWaEcCPOs0POU8MyCHATBDEBnxqJPBVFtd+AGbUuO0x0NjtR+C1iNKO/FrwNbYHLzDspAXgZPswM4bm3r8TapLKx4MZI4DGfpBix//nR8nFtsewGdQJXrdt7tuDAnwO3smRusvoqb1Lv98IkZ0hFIyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; spf=pass smtp.mailfrom=tlmp.cc; dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b=Eu6kKwjW; arc=none smtp.client-ip=148.135.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tlmp.cc
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 79E9B697C9;
	Mon,  2 Sep 2024 04:30:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1725265858; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=qrCNvicodlSdNtI3m0rhOX/zs3Y0RyZj7feiE8HzeJE=;
	b=Eu6kKwjWqrn6qrInDLoHeQ6b0YMOM16lo47VTtUbvsAVV4IckYhjhISlNcQZtW4sIwJ5K5
	L49l6MkdzVlkuDi2nOz0jv0yV1QMh1CYMbdTGUjyeZJIDWf6P5DSo51v9VVFpqARXqZ+P3
	+HFzRymOzaGhsqgm8K4zAqLXhHIfhsa9rt7Dejv+IL3ETib6kesPuwWBxJ7OMtMb/OK8VQ
	lxDYyqNztloYYltAQmJDv023ddNTiWWgdGKhlMzLNqzfG+2jtIeV+a/RW4qYiw+Yijxjun
	ajZVMVn+OH8faFSL1zKMFuVabqqq+QV/MlxxEt5yg90ZhJQQoz96GV4Aa9pALQ==
From: Yiyang Wu <toolmanp@tlmp.cc>
To: hsiangkao@linux.alibaba.com
Cc: linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: 
Date: Mon,  2 Sep 2024 16:30:53 +0800
Message-ID: <20240902083055.448965-1-toolmanp@tlmp.cc>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Subject: [PATCH V4 0/2] erofs: refactor fast_symlink and read_inode

This patchset is response to the original suggestions posted here[1].
Since my later work is somehow related to this issue, i think it's
better to deal with it first.

Changes in V2:
  1. Lift the erofs_fill_symlink patch to 1/2
  2. Fix code styles problems in read_inode patch.
  3. Fix the formatting problems caused by clang-format.

Changes in V3:
  1. Remove some redundant variables and statements in both patches.

Changes in V4:
  1. Remove out_unlock in erofs_fill_inode and use early returns.
  2. Fix missing initializer for erofs_buf in erofs_read_inode.

[1]: https://lore.kernel.org/all/20240425222847.GN2118490@ZenIV/

Yiyang Wu (2):
  erofs: use kmemdup_nul in erofs_fill_symlink
  erofs: refactor read_inode calling convention

 fs/erofs/inode.c | 133 ++++++++++++++++++++++-------------------------
 1 file changed, 61 insertions(+), 72 deletions(-)

-- 
2.46.0


