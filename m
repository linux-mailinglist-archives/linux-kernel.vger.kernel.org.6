Return-Path: <linux-kernel+bounces-413475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BBF9D1981
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 21:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E9B8282902
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 20:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C971E7643;
	Mon, 18 Nov 2024 20:14:27 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9391E5734
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 20:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731960867; cv=none; b=WkNNWFPJKi5Qz7SzMDXJFJe5E1ldYAuXQ+UQyLp+3VNhafSwaUUeFsU8pA8blrYamsi4oIuSZRTlLBTTnk0yDgV+izgw7N9cKxWYUg0OciwJeTExVvSLQwC1hFSvg8zLm0PMD+Mn8AuCJg6uTOJ3mUX62XN0wZ5k09XI+mXzhLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731960867; c=relaxed/simple;
	bh=9vh/n3TLJf6SPuh2A+56vcj5XMn/yl800FwblNP07pY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=EJJIVknqomD9LbihD8FsjIaMCpSDacriY7/HM5s9sDfiQfa01eYVLdfbIGFCPZd4cLN10701WxDePfYKBJSW0SwPNlN2bQkWgZPxEMOhwyiv4zIlUSaemp3g3IJZfn0xp8HUR3WknktlNlpcBo5nkVu9oaUyIoE1bc/3Gr2cI1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 381AAC4CED6;
	Mon, 18 Nov 2024 20:14:27 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tD89D-0000000D8xe-19mI;
	Mon, 18 Nov 2024 15:14:59 -0500
Message-ID: <20241118201459.127808078@goodmis.org>
User-Agent: quilt/0.68
Date: Mon, 18 Nov 2024 15:14:33 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 "lgoncalv@redhat.com" <lgoncalv@redhat.com>,
 Furkan Onder <furkanonder@protonmail.com>
Subject: [for-next][PATCH 2/4] tools/rtla: Improve code readability in timerlat_load.py
References: <20241118201431.871648641@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: furkanonder <furkanonder@protonmail.com>

The enhancements made to timerlat_load.py are intended to improve the
script's robustness and readability.

Summary of the changes:
- Unnecessary semicolons at the end of lines have been removed.
- Parentheses surrounding the if statement checking args.prio have been
eliminated.
- String concatenation for constructing timerlat_path has been replaced
with an f-string.
- Spacing in a multiplication expression has been adjusted for improved
clarity.

Cc: "jkacur@redhat.com" <jkacur@redhat.com>
Cc: "lgoncalv@redhat.com" <lgoncalv@redhat.com>
Link: https://lore.kernel.org/j2B-ted7pv3TaldTyqfIHrMmjq2fVyBFgnu3TskiQJsyRzy9loPTVVJoqHnrCWu5T88MDIFc612jUglH6Sxkdg9LN-I1XuITmoL70uECmus=@protonmail.com
Signed-off-by: Furkan Onder <furkanonder@protonmail.com>
Reviewed-by: Tomas Glozar <tglozar@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/tracing/rtla/sample/timerlat_load.py | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/tracing/rtla/sample/timerlat_load.py b/tools/tracing/rtla/sample/timerlat_load.py
index 8cc5eb2d2e69..785e9a83539a 100644
--- a/tools/tracing/rtla/sample/timerlat_load.py
+++ b/tools/tracing/rtla/sample/timerlat_load.py
@@ -37,12 +37,12 @@ except:
     exit(1)
 
 try:
-    os.sched_setaffinity(0, affinity_mask);
+    os.sched_setaffinity(0, affinity_mask)
 except:
     print("Error setting affinity")
     exit(1)
 
-if (args.prio):
+if args.prio:
     try:
         param = os.sched_param(int(args.prio))
         os.sched_setscheduler(0, os.SCHED_FIFO, param)
@@ -51,21 +51,21 @@ if (args.prio):
         exit(1)
 
 try:
-    timerlat_path = "/sys/kernel/tracing/osnoise/per_cpu/cpu" + args.cpu + "/timerlat_fd"
+    timerlat_path = f"/sys/kernel/tracing/osnoise/per_cpu/cpu{args.cpu}/timerlat_fd"
     timerlat_fd = open(timerlat_path, 'r')
 except:
     print("Error opening timerlat fd, did you run timerlat -U?")
     exit(1)
 
 try:
-    data_fd = open("/dev/full", 'r');
+    data_fd = open("/dev/full", 'r')
 except:
     print("Error opening data fd")
 
 while True:
     try:
         timerlat_fd.read(1)
-        data_fd.read(20*1024*1024)
+        data_fd.read(20 * 1024 * 1024)
     except:
         print("Leaving")
         break
-- 
2.45.2



