Return-Path: <linux-kernel+bounces-210592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C08C9045F0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 22:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0187B1F23267
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 20:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C64153823;
	Tue, 11 Jun 2024 20:46:13 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9F615278E
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 20:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718138772; cv=none; b=X9XqT9CKGR3nOfGmJkh6XIz0q3nce3FA1L0bfxq7tmm2bLLc5+QaVE+XLkZmvd/PXNKznWq6nafwi7kUuIvtZVydyPRpwa4IjdltoKykX9NUC8KCSpG/pZR2Pb+goKerJR9Vy/eubMquo/HHEnC99lvD58JSCm1AB9SIY5jNlDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718138772; c=relaxed/simple;
	bh=mlfoC7wSjNFUGkvrNFnurpR22N9Qil8iNTgQKZPwB0s=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=uYvH7O8bVeRhVAR50RL4D+w1yBddTSlKrTrhuKUIHCKlrFEluJsI5VEeUUomIxqPQj8wKJm0fqRJcdrRjIEAZeLFC/plgheeBzMSzyu2QAIYP4WTmqGU+W9v9BERnGzvZtVC4gohPvBjMVQ7YBSoB0pCckwbVcSDXmZ4/sgyVa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D21EC4AF55;
	Tue, 11 Jun 2024 20:46:12 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sH8Nx-00000001V47-0RxS;
	Tue, 11 Jun 2024 16:46:29 -0400
Message-ID: <20240611204628.970422788@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 11 Jun 2024 16:45:58 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Marilene A Garcia <marilene.agarcia@gmail.com>
Subject: [for-next][PATCH 4/4] ftrace: Add missing kerneldoc parameters to
 unregister_ftrace_direct()
References: <20240611204554.092271761@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Marilene A Garcia <marilene.agarcia@gmail.com>

Add the description to the parameters addr and free_filters
of the function unregister_ftrace_direct().

Link: https://lore.kernel.org/linux-trace-kernel/20240606132520.1397567-1-marilene.agarcia@gmail.com

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Signed-off-by: Marilene A Garcia <marilene.agarcia@gmail.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 4aeb1183ea9f..f44229294e9d 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5988,6 +5988,8 @@ EXPORT_SYMBOL_GPL(register_ftrace_direct);
  * unregister_ftrace_direct - Remove calls to custom trampoline
  * previously registered by register_ftrace_direct for @ops object.
  * @ops: The address of the struct ftrace_ops object
+ * @addr: The address of the direct function that is called by the @ops functions
+ * @free_filters: Set to true to remove all filters for the ftrace_ops, false otherwise
  *
  * This is used to remove a direct calls to @addr from the nop locations
  * of the functions registered in @ops (with by ftrace_set_filter_ip
-- 
2.43.0



