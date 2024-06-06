Return-Path: <linux-kernel+bounces-204726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3178FF2D2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 18:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A0671F25AA8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 16:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24379198A3D;
	Thu,  6 Jun 2024 16:48:58 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B0A198A2C
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 16:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717692537; cv=none; b=J9ieVUzLAydWz58F3oWuADN/Ernu1w2ARa1cqn3BW8YmknyK4agHN8DgFsHilMrov3NZCNMRBBwFc6qWdD/7XgbcRbUH+sWoD//9On09m7lxtShCZ4dZkvW5vVx5oZTsqcDG65G1oD3x+nSjtGzUEughO4BR08JrQl38L62k78k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717692537; c=relaxed/simple;
	bh=NA592QpdHNILyqQw+YPUbhUgEevZwCv+wztjQVrzJ/0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=gqog7N4UsHywNA+EmsZ94nFJX4EtQ9NScU+e14xvnS0/VpeGYYcpLxH7KN5s1sl6n8SA7YZkwv0P3b3W6AFq+zPLObohlsLjk8nDjKjCwkVzmE1NmAEnIo6VRPmFCQb4LzsxPc5+y40XFIKa2+RzRmPOH3NU03rYv7P7INXGpUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66206C2BD10;
	Thu,  6 Jun 2024 16:48:56 +0000 (UTC)
Date: Thu, 6 Jun 2024 12:49:08 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [for-next][PATCH] function_graph: Rename BYTE_NUMBER to CHAR_NUMBER
 in selftests
Message-ID: <20240606124908.0d7b31e2@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
ftrace/for-next

Head SHA1: 1af19b7c01061172f943ac247409626af0ba0867


Steven Rostedt (Google) (1):
      function_graph: Rename BYTE_NUMBER to CHAR_NUMBER in selftests

----
 kernel/trace/trace_selftest.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
---------------------------
commit 1af19b7c01061172f943ac247409626af0ba0867
Author: Steven Rostedt (Google) <rostedt@goodmis.org>
Date:   Thu Jun 6 08:18:46 2024 -0400

    function_graph: Rename BYTE_NUMBER to CHAR_NUMBER in selftests
    
    The function_graph selftests checks various size variables to pass from
    the entry of the function to the exit. It tests 1, 2, 4 and 8 byte words.
    The 1 byte macro was called BYTE_NUMBER but that is used in the sh
    architecture: arch/sh/include/asm/bitops-op32.h
    
    Just rename the macro to CHAR_NUMBER.
    
    Link: https://lore.kernel.org/linux-trace-kernel/20240606081846.4cb82dc4@gandalf.local.home
    
    Cc: Masami Hiramatsu <mhiramat@kernel.org>
    Cc: Mark Rutland <mark.rutland@arm.com>
    Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
    Fixes: 47c3c70aa3697 ("function_graph: Add selftest for passing local variables")
    Reported-by: kernel test robot <lkp@intel.com>
    Closes: https://lore.kernel.org/oe-kbuild-all/202406061744.rZDXfRrG-lkp@intel.com/
    Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftest.c
index 369efc569238..adf0f436d84b 100644
--- a/kernel/trace/trace_selftest.c
+++ b/kernel/trace/trace_selftest.c
@@ -758,7 +758,7 @@ trace_selftest_startup_function(struct tracer *trace, struct trace_array *tr)
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 
-#define BYTE_NUMBER 123
+#define CHAR_NUMBER 123
 #define SHORT_NUMBER 12345
 #define WORD_NUMBER 1234567890
 #define LONG_NUMBER 1234567890123456789LL
@@ -789,7 +789,7 @@ static __init int store_entry(struct ftrace_graph_ent *trace,
 
 	switch (size) {
 	case 1:
-		*(char *)p = BYTE_NUMBER;
+		*(char *)p = CHAR_NUMBER;
 		break;
 	case 2:
 		*(short *)p = SHORT_NUMBER;
@@ -830,7 +830,7 @@ static __init void store_return(struct ftrace_graph_ret *trace,
 
 	switch (fixture->store_size) {
 	case 1:
-		expect = BYTE_NUMBER;
+		expect = CHAR_NUMBER;
 		found = *(char *)p;
 		break;
 	case 2:

