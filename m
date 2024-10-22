Return-Path: <linux-kernel+bounces-375463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CEDC9A963D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 04:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B3A61C21FB0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 02:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E3513A863;
	Tue, 22 Oct 2024 02:29:29 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AAE59B71
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 02:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729564169; cv=none; b=g5il4ho4PzQ21vCEotoqE4wXVs5TkMYLMDZdVt4/G5tANjpTnvljFmfO5gbmuVowZrjETe047GAyfd/97R8WfBBH+kkni1SD9rFL8VAlw+UNLZRCBxvNQvr93fPh3a0o/na5nxzyD41UW9t6VEjGIZxGvXN15OmroVK1bv2eMDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729564169; c=relaxed/simple;
	bh=H1zhztYWbtPhTqukjfe4XePvb1H+giuMfsJ3pS6xxAE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ud1mLyWctuyl8mdlxNr7uffX5PiWfZ5jm+7dYVuD5HJBwhv/FBhYbdT0MI6jlz/99yjzUIIp1KzYYaZyim+dJYVWbneS2qzxNTjrcTD+GjMQTKtbpZXCULChpvJ24UCEid1Ajt39ogylY84QFaC37WCwuDr9OWRmaudd1v0quAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B3CAC4CEC3;
	Tue, 22 Oct 2024 02:29:29 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1t34ep-00000004dyd-1uvD;
	Mon, 21 Oct 2024 22:30:03 -0400
Message-ID: <20241022023003.313493957@goodmis.org>
User-Agent: quilt/0.68
Date: Mon, 21 Oct 2024 22:29:21 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Julia Lawall <Julia.Lawall@inria.fr>
Subject: [for-next][PATCH v2 2/3] ring-buffer: Reorganize kerneldoc parameter names
References: <20241022022919.695045683@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Julia Lawall <Julia.Lawall@inria.fr>

Reorganize kerneldoc parameter names to match the parameter
order in the function header.

Problems identified using Coccinelle.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/20240930112121.95324-22-Julia.Lawall@inria.fr
Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index adde95400ab4..db3bf6a1b536 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2436,9 +2436,9 @@ EXPORT_SYMBOL_GPL(__ring_buffer_alloc);
  * __ring_buffer_alloc_range - allocate a new ring_buffer from existing memory
  * @size: the size in bytes per cpu that is needed.
  * @flags: attributes to set for the ring buffer.
+ * @order: sub-buffer order
  * @start: start of allocated range
  * @range_size: size of allocated range
- * @order: sub-buffer order
  * @key: ring buffer reader_lock_key.
  *
  * Currently the only flag that is available is the RB_FL_OVERWRITE
-- 
2.45.2



