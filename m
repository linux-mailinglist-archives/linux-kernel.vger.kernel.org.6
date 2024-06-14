Return-Path: <linux-kernel+bounces-215489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E36DA909394
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 23:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A7731F2301D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 21:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A38178CE2;
	Fri, 14 Jun 2024 21:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="c7RwiNFj"
Received: from smtp.smtpout.orange.fr (smtp-14.smtpout.orange.fr [80.12.242.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B478817C72;
	Fri, 14 Jun 2024 21:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718399215; cv=none; b=HA4JHa39MHJxxYMz1dqhBxij+vSj/pvq//QTyEambWGqG5GFB/qXQv4kAtYY6M5NNJxNQmDDD6dnccVXURmFV2Hlte4V7GZj02HTlQqjYw0f1eLWCfX0IMgsGBnscm4B7gqZkg/WU/Q3YIl3fpP0ydR2AJeLP9P39f0zeE5TKsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718399215; c=relaxed/simple;
	bh=KMO7Zfugy9M15xMn9DWM7ExCCPIjAnsh8V/2u166Wjk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I9xWoC9sRYCSRNQg8CTzF4VlQmOBkCb6HSjWx4WP1KYm7rPic+82J6LHgrBi66obxR7DpFaTP3YVBaBW7Ce9CgK6k6qfB0735qOv3mpMazosXwU6rAXC5FF4Orx0wjxhOdS7jyqljo8nqrca2+pcuiTaUS4mzTGLgLO6c6ftIDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=c7RwiNFj; arc=none smtp.client-ip=80.12.242.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([86.243.222.230])
	by smtp.orange.fr with ESMTPA
	id IDz0sVzold4AbIDz0shQqo; Fri, 14 Jun 2024 22:57:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1718398641;
	bh=0gqOmh8tdr4J+MkHrhErZNEY+dxRqhfQP+7M6D3WdV0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=c7RwiNFjjLHdqSblMkJBWPJfoTE6MCtHwN7i+OaI4OZa6UlluTrA+5uRTcpd34uS3
	 U4mdmvU/04dh4Sn6aHNgHbaQn0B28XF/pi9hZIl3S8DVwxQmyDL9Sp+0s6wMtk6aVU
	 xubrZyUSzfvHM4O1wZH6PVY6wVR3b0oF4JzdRyzqTDuKM0abKgxuWvOdv+sXg7nGr9
	 Xvp5WeG5DoI6b+iONI4HyFCrOOF990Af8cednrtrIuAGXDa4La5mO0h5nEqlkd/VIb
	 iI0wTGpOszyubW8KXjjCC7YdpZelgqMIttaAnsJnQUuG2+1KZT1SkdK/v4anT5Kwiz
	 mb3ZTiGR/9xhg==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 14 Jun 2024 22:57:21 +0200
X-ME-IP: 86.243.222.230
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	ocfs2-devel@lists.linux.dev
Subject: [PATCH] ocfs2: Constify struct ocfs2_stack_operations
Date: Fri, 14 Jun 2024 22:57:09 +0200
Message-ID: <f52dab89ee0049ec6271de29183a781efbb275ab.1718398605.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"struct ocfs2_stack_operations" are not modified in this driver.

Constifying this structure moves some data to a read-only section, so
increase overall security.

In order to do it, "struct ocfs2_stack_plugin" also needs to be adjusted to
this new const qualifier.

On a x86_64, with allmodconfig:
Before:
======
   text	   data	    bss	    dec	    hex	filename
   6241	    644	      0	   6885	   1ae5	fs/ocfs2/stack_o2cb.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
   6337	    548	      0	   6885	   1ae5	fs/ocfs2/stack_o2cb.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 fs/ocfs2/stack_o2cb.c | 2 +-
 fs/ocfs2/stack_user.c | 2 +-
 fs/ocfs2/stackglue.h  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ocfs2/stack_o2cb.c b/fs/ocfs2/stack_o2cb.c
index c973c03f6fd8..10157d9d7a9c 100644
--- a/fs/ocfs2/stack_o2cb.c
+++ b/fs/ocfs2/stack_o2cb.c
@@ -404,7 +404,7 @@ static int o2cb_cluster_this_node(struct ocfs2_cluster_connection *conn,
 	return 0;
 }
 
-static struct ocfs2_stack_operations o2cb_stack_ops = {
+static const struct ocfs2_stack_operations o2cb_stack_ops = {
 	.connect	= o2cb_cluster_connect,
 	.disconnect	= o2cb_cluster_disconnect,
 	.this_node	= o2cb_cluster_this_node,
diff --git a/fs/ocfs2/stack_user.c b/fs/ocfs2/stack_user.c
index c11406cd87a8..77edcd70f72c 100644
--- a/fs/ocfs2/stack_user.c
+++ b/fs/ocfs2/stack_user.c
@@ -1065,7 +1065,7 @@ static int user_cluster_this_node(struct ocfs2_cluster_connection *conn,
 	return 0;
 }
 
-static struct ocfs2_stack_operations ocfs2_user_plugin_ops = {
+static const struct ocfs2_stack_operations ocfs2_user_plugin_ops = {
 	.connect	= user_cluster_connect,
 	.disconnect	= user_cluster_disconnect,
 	.this_node	= user_cluster_this_node,
diff --git a/fs/ocfs2/stackglue.h b/fs/ocfs2/stackglue.h
index 3636847fae19..02ab072c528a 100644
--- a/fs/ocfs2/stackglue.h
+++ b/fs/ocfs2/stackglue.h
@@ -223,7 +223,7 @@ struct ocfs2_stack_operations {
  */
 struct ocfs2_stack_plugin {
 	char *sp_name;
-	struct ocfs2_stack_operations *sp_ops;
+	const struct ocfs2_stack_operations *sp_ops;
 	struct module *sp_owner;
 
 	/* These are managed by the stackglue code. */
-- 
2.45.2


