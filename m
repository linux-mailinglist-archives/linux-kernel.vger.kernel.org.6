Return-Path: <linux-kernel+bounces-356207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0888995DE4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 04:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 628301F25CDF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 02:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E32C126BFF;
	Wed,  9 Oct 2024 02:39:19 +0000 (UTC)
Received: from wxsgout05.xfusion.com (wxsgout05.xfusion.com [43.157.99.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00E21C6BE
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 02:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.157.99.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728441559; cv=none; b=PLHWeLB/RYGKAszUVtMK5cRWLX+JDkm6v1gX7sXCuDigF/e4W2bsxdSWvskhubOsngRb6DzYc8e9WZs8mkZPwY3XC3ycBjRG1qnaE/zjwBvOkATfDtdcblF9Qz/+PgVM9BhwdeKTIW4blIVCkLZGeZPhijwhdpbC65ad5tGWHIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728441559; c=relaxed/simple;
	bh=u/HW4d/FyJTNeElDKVZQeNAu7bqM3kVBrGJeKNH63UM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kpyPJz7wAqJH5BWz7JIMXo1owE4zXC5MdXsFI+jjQDzFHdH1fTbQ0wKoFUNwhnrQH3Ix2zwfl5QmsASuxjYNckPX9JbcgaTVK6M7O/Ic3vnpaIE0ypt7p13wu2S8hhYsN381gsusoVdkIYBA4Xfeh24t5/ncGw09Trd2nrsdQ/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xfusion.com; spf=pass smtp.mailfrom=xfusion.com; arc=none smtp.client-ip=43.157.99.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xfusion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xfusion.com
Received: from wxsgout04.xfusion.com (unknown [172.16.64.126])
	by wxsgout05.xfusion.com (SkyGuard) with ESMTPS id 4XNc6w4ZFrz9xrDD
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 10:20:24 +0800 (CST)
Received: from wuxshcsitd00600.xfusion.com (unknown [10.32.133.213])
	by wxsgout04.xfusion.com (SkyGuard) with ESMTPS id 4XNc4b50wlzB660j;
	Wed,  9 Oct 2024 10:18:23 +0800 (CST)
Received: from wsip-70-182-158-199.br.br.cox.net (10.81.22.2) by
 wuxshcsitd00600.xfusion.com (10.32.133.213) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 9 Oct 2024 10:23:17 +0800
From: Wang Jinchao <wangjinchao@xfusion.com>
To: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>
CC: <wangjinchao@xfusion.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] time: fix comment error, change %0 to 0
Date: Wed, 9 Oct 2024 10:21:35 +0800
Message-ID: <20241009022135.92400-2-wangjinchao@xfusion.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: wuxshcsitd00600.xfusion.com (10.32.133.213) To
 wuxshcsitd00600.xfusion.com (10.32.133.213)

Change %0 to 0 in kernel-doc comments.

Signed-off-by: Wang Jinchao <wangjinchao@xfusion.com>
---
 kernel/time/time.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/time/time.c b/kernel/time/time.c
index 642647f5046b..5984d4a5639b 100644
--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -866,7 +866,7 @@ struct timespec64 timespec64_add_safe(const struct timespec64 lhs,
  *
  * Handles compat or 32-bit modes.
  *
- * Return: %0 on success or negative errno on error
+ * Return: 0 on success or negative errno on error
  */
 int get_timespec64(struct timespec64 *ts,
 		   const struct __kernel_timespec __user *uts)
@@ -897,7 +897,7 @@ EXPORT_SYMBOL_GPL(get_timespec64);
  * @ts: input &struct timespec64
  * @uts: user's &struct __kernel_timespec
  *
- * Return: %0 on success or negative errno on error
+ * Return: 0 on success or negative errno on error
  */
 int put_timespec64(const struct timespec64 *ts,
 		   struct __kernel_timespec __user *uts)
@@ -944,7 +944,7 @@ static int __put_old_timespec32(const struct timespec64 *ts64,
  *
  * Handles X86_X32_ABI compatibility conversion.
  *
- * Return: %0 on success or negative errno on error
+ * Return: 0 on success or negative errno on error
  */
 int get_old_timespec32(struct timespec64 *ts, const void __user *uts)
 {
@@ -963,7 +963,7 @@ EXPORT_SYMBOL_GPL(get_old_timespec32);
  *
  * Handles X86_X32_ABI compatibility conversion.
  *
- * Return: %0 on success or negative errno on error
+ * Return: 0 on success or negative errno on error
  */
 int put_old_timespec32(const struct timespec64 *ts, void __user *uts)
 {
@@ -979,7 +979,7 @@ EXPORT_SYMBOL_GPL(put_old_timespec32);
  * @it: destination &struct itimerspec64
  * @uit: user's &struct __kernel_itimerspec
  *
- * Return: %0 on success or negative errno on error
+ * Return: 0 on success or negative errno on error
  */
 int get_itimerspec64(struct itimerspec64 *it,
 			const struct __kernel_itimerspec __user *uit)
@@ -1002,7 +1002,7 @@ EXPORT_SYMBOL_GPL(get_itimerspec64);
  * @it: input &struct itimerspec64
  * @uit: user's &struct __kernel_itimerspec
  *
- * Return: %0 on success or negative errno on error
+ * Return: 0 on success or negative errno on error
  */
 int put_itimerspec64(const struct itimerspec64 *it,
 			struct __kernel_itimerspec __user *uit)
@@ -1024,7 +1024,7 @@ EXPORT_SYMBOL_GPL(put_itimerspec64);
  * @its: destination &struct itimerspec64
  * @uits: user's &struct old_itimerspec32
  *
- * Return: %0 on success or negative errno on error
+ * Return: 0 on success or negative errno on error
  */
 int get_old_itimerspec32(struct itimerspec64 *its,
 			const struct old_itimerspec32 __user *uits)
@@ -1043,7 +1043,7 @@ EXPORT_SYMBOL_GPL(get_old_itimerspec32);
  * @its: input &struct itimerspec64
  * @uits: user's &struct old_itimerspec32
  *
- * Return: %0 on success or negative errno on error
+ * Return: 0 on success or negative errno on error
  */
 int put_old_itimerspec32(const struct itimerspec64 *its,
 			struct old_itimerspec32 __user *uits)
-- 
2.45.0


