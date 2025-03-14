Return-Path: <linux-kernel+bounces-560834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F697A609F6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 08:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A93018925BC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 07:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196851DB34E;
	Fri, 14 Mar 2025 07:15:16 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.213])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 260A4193062;
	Fri, 14 Mar 2025 07:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741936515; cv=none; b=tRK5oSrGfsPaCmOHipCErdW8Voawm4GaaYMn+1uHOQI6hURip5KE/884fpHmK81YPcJQfELN+jBDcQo65Ijn0gV7Ff5IkWNtqFD3dbEfbld/ydPEiZFczvm8Zvyw5hwhUK8hhef/rylT+lJEzR1xwto7BgH3SHc9QiF0DKsqluA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741936515; c=relaxed/simple;
	bh=s0mmNox3jAK5QVrE4AMY1kLiVWM6e6Jd1XDMUyY7jH4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version; b=ALNCwRvd3ZIvq5qF+Z5pNb4FEipTn5t2Bow1E4Lqnx5AA37MrjSaL0MN1Ra5bm54rpvFz1dh+TxbfZwoByirthBJQYgJt93IUr/hvt8/84o46OysYWJFRUINDH3Nl1MXIEec7ZIqMa2IRNADmccErttgG09GMgBs7PI5jLHyg2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from longsh.shanghai.nfschina.local (unknown [180.167.10.98])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id 5520860680974;
	Fri, 14 Mar 2025 15:15:10 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
To: zfigura@codeweavers.com,
	corbet@lwn.net
Cc: Su Hui <suhui@nfschina.com>,
	wine-devel@winehq.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH 4/4] docs: ntsync: update NTSYNC_IOC_*
Date: Fri, 14 Mar 2025 15:14:54 +0800
Message-Id: <20250314071454.201697-5-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20250314071454.201697-1-suhui@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some macros in the document do not match the code and the header files,
correct these macros according to the definitions in the code.

Signed-off-by: Su Hui <suhui@nfschina.com>
---
 Documentation/userspace-api/ntsync.rst | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/userspace-api/ntsync.rst b/Documentation/userspace-api/ntsync.rst
index 25e7c4aef968..969774bf4c60 100644
--- a/Documentation/userspace-api/ntsync.rst
+++ b/Documentation/userspace-api/ntsync.rst
@@ -152,9 +152,9 @@ The ioctls on the device file are as follows:
 
 The ioctls on the individual objects are as follows:
 
-.. c:macro:: NTSYNC_IOC_SEM_POST
+.. c:macro:: NTSYNC_IOC_SEM_RELEASE
 
-  Post to a semaphore object. Takes a pointer to a 32-bit integer,
+  Release a semaphore object. Takes a pointer to a 32-bit integer,
   which on input holds the count to be added to the semaphore, and on
   output contains its previous count.
 
@@ -186,7 +186,7 @@ The ioctls on the individual objects are as follows:
   unowned and signaled, and eligible threads waiting on it will be
   woken as appropriate.
 
-.. c:macro:: NTSYNC_IOC_SET_EVENT
+.. c:macro:: NTSYNC_IOC_EVENT_SET
 
   Signal an event object. Takes a pointer to a 32-bit integer, which on
   output contains the previous state of the event.
@@ -194,12 +194,12 @@ The ioctls on the individual objects are as follows:
   Eligible threads will be woken, and auto-reset events will be
   designaled appropriately.
 
-.. c:macro:: NTSYNC_IOC_RESET_EVENT
+.. c:macro:: NTSYNC_IOC_EVENT_RESET
 
   Designal an event object. Takes a pointer to a 32-bit integer, which
   on output contains the previous state of the event.
 
-.. c:macro:: NTSYNC_IOC_PULSE_EVENT
+.. c:macro:: NTSYNC_IOC_EVENT_PULSE
 
   Wake threads waiting on an event object while leaving it in an
   unsignaled state. Takes a pointer to a 32-bit integer, which on
@@ -213,7 +213,7 @@ The ioctls on the individual objects are as follows:
   afterwards, and a simultaneous read operation will always report the
   event as unsignaled.
 
-.. c:macro:: NTSYNC_IOC_READ_SEM
+.. c:macro:: NTSYNC_IOC_SEM_READ
 
   Read the current state of a semaphore object. Takes a pointer to
   struct :c:type:`ntsync_sem_args`, which is used as follows:
@@ -225,7 +225,7 @@ The ioctls on the individual objects are as follows:
      * - ``max``
        - On output, contains the maximum count of the semaphore.
 
-.. c:macro:: NTSYNC_IOC_READ_MUTEX
+.. c:macro:: NTSYNC_IOC_MUTEX_READ
 
   Read the current state of a mutex object. Takes a pointer to struct
   :c:type:`ntsync_mutex_args`, which is used as follows:
@@ -242,7 +242,7 @@ The ioctls on the individual objects are as follows:
   ``EOWNERDEAD``. In this case, ``count`` and ``owner`` are set to
   zero.
 
-.. c:macro:: NTSYNC_IOC_READ_EVENT
+.. c:macro:: NTSYNC_IOC_EVENT_READ
 
   Read the current state of an event object. Takes a pointer to struct
   :c:type:`ntsync_event_args`, which is used as follows:
@@ -255,7 +255,7 @@ The ioctls on the individual objects are as follows:
        - On output, contains 1 if the event is a manual-reset event,
          and 0 otherwise.
 
-.. c:macro:: NTSYNC_IOC_KILL_OWNER
+.. c:macro:: NTSYNC_IOC_MUTEX_KILL
 
   Mark a mutex as unowned and abandoned if it is owned by the given
   owner. Takes an input-only pointer to a 32-bit integer denoting the
-- 
2.30.2


