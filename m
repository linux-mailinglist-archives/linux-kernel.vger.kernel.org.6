Return-Path: <linux-kernel+bounces-298104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7386B95C27E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 02:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81D631C22416
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 00:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C71BE47;
	Fri, 23 Aug 2024 00:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="iPyIMDlN"
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE191C36
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 00:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724373329; cv=none; b=e7+xWOdh2IQKQy1rzRBt1TT+3cT1rLkasrS750iDWhQQIW6uiYq37CdFSTzoq5yfbrtmvz1dsxmn/B/uE2KT/5+s6F8xgY0hj1j3OCl8IfZiVyaCofmIA3VllnJKfGI1SvIN90JDkVHdVs6KMqBkvVnMwXsSEtZ35ZgFYzWuexc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724373329; c=relaxed/simple;
	bh=hipaGu9uPUtumU9oNq5XNC6uYy+/WEfLLnO0SDomPvM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cdeOw/qPS/ndJqkzYSmQc3llCH7il/rCJPN8y3EENs9Fo1fJTXfNQYAQktqpsG+qxSi9dmHo+/6e2Vq4AFd5RYMP/2Pg3ohn7CLG6SEMqxnE8ZKtOZhmhtCdtEzU3Je33yrZ2pZVfrbDPHMpuFCwhVuu7QJIAFtjgBq5WJcLoUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=iPyIMDlN; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724373317; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=JZ+Jb+HK5jzvd/d+WSjQLa2+SibX5DcDHdq7Wfdl5ac=;
	b=iPyIMDlNZvyxPDuUKY5mme30MqtS+T2PTs5SRPQNcRLD8utAWrah+OnOrIoxdqCTQ7vKQj4dOGHdjjBLQLEuanyphxK3pZZfLuJ0MXsgOrY8ElJDTBjCyq/3fdC3JLyEF/G2uFhPN9qIq0mizAk12Af9XbdkoFMAAUJdszWPucY=
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0WDRYTIY_1724373316)
          by smtp.aliyun-inc.com;
          Fri, 23 Aug 2024 08:35:17 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: airlied@gmail.com,
	daniel@ffwll.ch,
	alexander.deucher@amd.com
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] drm/amd/display: Remove unnecessary semicolon after switch statement
Date: Fri, 23 Aug 2024 08:35:15 +0800
Message-Id: <20240823003515.57035-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit removes the unnecessary semicolon (`;`) following the
closing brace of the switch statement in the function
'dml2_core_utils_get_tile_block_size_bytes'.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9804
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 .../amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_utils.c   | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_utils.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_utils.c
index ab229e1598ae..695fe99e44d2 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_utils.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_utils.c
@@ -310,7 +310,7 @@ unsigned int dml2_core_utils_get_tile_block_size_bytes(enum dml2_swizzle_mode sw
 	default:
 		DML2_ASSERT(0);
 		return 256;
-	};
+	}
 }
 
 
-- 
2.32.0.3.g01195cf9f


