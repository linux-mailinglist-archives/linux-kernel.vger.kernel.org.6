Return-Path: <linux-kernel+bounces-201450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC318FBEBB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 00:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FAFFB26408
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 22:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08CE614D29E;
	Tue,  4 Jun 2024 22:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M1Mqu/zt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463091420B6;
	Tue,  4 Jun 2024 22:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717539448; cv=none; b=ACRx7QWcrBTf+WioILb7rk3tVrZtrEN7A9DuAF6DbH4ra3jjrdcevKFZgmr6lKUtZh/yYTBTPeJ0Me5Vy3lz+BcLTo6HF8a4+6X8TTF0i8us7cd/H3jIzzcrIPbiScQVBcErFNFf7fn/Jr4OLTAqjW+xyJllK80HLE8m2Oj+8NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717539448; c=relaxed/simple;
	bh=Vi8HqCh8WHg21Oo7Mmbu3aO2UMHdVZ0GE8yU6FjmFPw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D0cMjDrLHnHwDrcBlaHGK5NgHs+ZNt7Wnjxhbacq951Qj3ffCDicSzvn1fiQM8VQ3eXFZki9W0LR88HNb4fahdgvnf0wsWhsjMbj1lFRZv9oQNRf7ydE4HwcBL7in+xmb8lG+IT0AsueikFiux6jTF9kOUt4S13gmdJrQ6+iP5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M1Mqu/zt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5944C2BBFC;
	Tue,  4 Jun 2024 22:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717539447;
	bh=Vi8HqCh8WHg21Oo7Mmbu3aO2UMHdVZ0GE8yU6FjmFPw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M1Mqu/ztUaHKlJ9wCY8gzkz0+10N8qWH65sgovNY1AAYnv1ollse2xkHtF5UPzsM7
	 kN/kiDTHtihcUBHkH1r2oqM4JPvsb72gJfjo2kZoRsbRPUluQ7DfAJTlbEfWF+o9iM
	 kJlxvvADRxr27mqwRIAXY8yisjjNzF8HpWO6uu8BNaBOIFsEQSSmhombeJwRTLhMku
	 Tv6BgCTjWYrzegyFtP8rGYyhuW0GcFBcPz7C6TCN+09osGEYyurnc/XUaMUbzZ0ceC
	 RdTr0iEc2ELg9NtYT3X0hGv0HboANq2VWjkGj0ar5XSOLcxr2bvQfx+vuXkWw26QQ+
	 t42We+hOh+LrQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8E061CE3ED6; Tue,  4 Jun 2024 15:17:27 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH torture 1/4] torture: Add MODULE_DESCRIPTION()
Date: Tue,  4 Jun 2024 15:17:23 -0700
Message-Id: <20240604221726.2370316-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <0b6e7177-5620-4bb4-832e-908f871b081d@paulmck-laptop>
References: <0b6e7177-5620-4bb4-832e-908f871b081d@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Johnson <quic_jjohnson@quicinc.com>

Fix the 'make W=1' warning:

WARNING: modpost: missing MODULE_DESCRIPTION() in kernel/torture.o

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/torture.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/torture.c b/kernel/torture.c
index c72ab2d251f4f..dede150aef011 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -40,6 +40,7 @@
 #include <linux/sched/rt.h>
 #include "rcu/rcu.h"
 
+MODULE_DESCRIPTION("Common functions for in-kernel torture tests");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Paul E. McKenney <paulmck@linux.ibm.com>");
 
-- 
2.40.1


