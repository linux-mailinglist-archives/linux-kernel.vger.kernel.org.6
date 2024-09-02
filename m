Return-Path: <linux-kernel+bounces-310840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A31D9681E1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7CA01F22D2D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 08:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949BE1862AE;
	Mon,  2 Sep 2024 08:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b="olDWk6XD"
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FF4757EA
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 08:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.135.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725265832; cv=none; b=bKDpRy3aIHO+og9TZrDjjxf/s1BYQLsW5m6qjUAMzNT5wuat14N/SQ1gPMVgkDeuChO0/uUiMnlYyK45qZJiVkvNImjHJISmJEWB6cY4oeA8UIiRXsxYMJBT4HkSmTrHOE96HSMk05+nh+GcVqaHgM69g3BFbQQaoOmprYOHHVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725265832; c=relaxed/simple;
	bh=AmPwK5ZGINCwCW9zw47gu4D74GSKi6tzyzwBVS11kis=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z9SBjyf6lOkBy2GgWj7vNOSB2I7hPoHqg3onCHkOScsXWmII4DMcyqKVWJbbPqdIPW1Cidt7ZKIwy6NNs+n75350WABHDox1r5JRPLOqW1vQ1Ej+Q2fmV9rGRyrALFJhcFD1tp4ZCUDh727Q9z5WVWSPtV1jWXDmSClnPBAisAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; spf=pass smtp.mailfrom=tlmp.cc; dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b=olDWk6XD; arc=none smtp.client-ip=148.135.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tlmp.cc
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8A3E269799;
	Mon,  2 Sep 2024 04:30:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1725265829; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=qrCNvicodlSdNtI3m0rhOX/zs3Y0RyZj7feiE8HzeJE=;
	b=olDWk6XDyTNXfPWufG3Oj3xdoICOCgnTNEpWGXoGNj9lvYiyMUG4Vy/w3dUrbOr0DJb626
	dknvMR9yVlLpHk0w0lHrTySRjvjgfglsw60sA6Uko8Az2wvmKpKnOdMWGsBOqn+YpziFSX
	vkb1Pq3SaUpasfuzmDxblGOTq9lpVute9aHjlA6TM4eO64wHt6H7oYlkVFWXfYwDrQN8Oi
	kehSPDV+dXIKckWkQi4sMsmIx07RBlVndUP8gC+9GkZHJSP6dlTgcB23yW6M8qXrVNmIVe
	sqqxlJ3jUgiqaOzubNJpl15CGA+GHo1thg04qeqHDp9UHgq00UjQUdw+101ZVg==
From: Yiyang Wu <toolmanp@tlmp.cc>
To: hsiangkao@linux.alibaba.com
Cc: linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: 
Date: Mon,  2 Sep 2024 16:30:22 +0800
Message-ID: <20240902083024.448367-1-toolmanp@tlmp.cc>
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


