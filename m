Return-Path: <linux-kernel+bounces-366091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1307B99F0BB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 17:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC5B32834B9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 15:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC6D157494;
	Tue, 15 Oct 2024 15:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gq76I6ZW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BTGeIvTK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F051CB9FE
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 15:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729005097; cv=none; b=SDKVjGsinaMH4TBr17kO6LB6nXaVwXA/5s3PqPteEt7R9N70s339lPDWQyMtiW815yoc9MSE71QvplKyIJbBNUl272vbZXYzjZkB4y7R+/IH3J1+D1NowHSYqnw5ifGv2Q5UlacG1OyiJNs+dtdSnLsvn4mE5vkKotMC/kpDrbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729005097; c=relaxed/simple;
	bh=h3IDuutdans6FJkhit/jWNEbsThjTFbI3JNngFyapZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h3fIzxoAPlSI0u2cYWN1Tg5afsdumRVpapfT6Q7eOfu3SynS9+139TkIH4X0OzNlEw2LzpD4i0y2WCb/REdQtMciqwxw1yGCdpcBNShRQd39YYvEHuEvVfa8vLAHK0Gxs6IFrR/bt67tliX3JbtEObXw2pIsxYkXyyfjEC3nhg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gq76I6ZW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BTGeIvTK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 15 Oct 2024 17:11:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729005094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KH+qQMF7rOFjXpz03XT2YPZOGuvYkYLCqruf/24KOa8=;
	b=gq76I6ZWqA8Je+qG7qVx+QouvSIFUoa73VKPYnc/BrBDF1CRt+ND5q9ESRnQUfWO5YF5Ox
	6gQ9dB4WKYagL8ZIwK2uuEyDNd5JvsJ6rIZ+PYo1xwFUOwSjsI4iIfGVKPLFQO1APaiPxR
	CUCpS0mP/q0Ym9UBehZCHyMDRTjCbBl3xX0l4tb5+umLcSMGtDMgyd+OyGk7GxgMbE4ZQa
	ARWX5gkDagKWlT8JX+ROz+nVSEHCRURIK6tYmyjbpzH1icUQTWZ+uHEaRMHzxMzIA56EmQ
	DGlZ62PDeH97PNYRwPLFn0wCTmfZXD3rAQFsKCdLh3zq1thT1GxuzHlF9vMZTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729005094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KH+qQMF7rOFjXpz03XT2YPZOGuvYkYLCqruf/24KOa8=;
	b=BTGeIvTKrXavJ4Vm/yTvWUqMcd/tQjVDEI1cHe/VkfgVLju1YeG8YbX+KjulosHjift5T8
	78fSPgev4Rd4dwDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>
Subject: [PATCH v2] MAINTAINERS: Add an entry for PREEMPT_RT.
Message-ID: <20241015151132.Erx81G9f@linutronix.de>
References: <20241002154639.89wWS_OU@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241002154639.89wWS_OU@linutronix.de>

Add a maintainers entry now that the PREEMPT_RT bits are merged. Steven
volunteered and asked for the list.
There are no files associated with this entry since it is spread over
the kernel. It serves as entry for people knowing what they look for.
There is a keyword added so if PREEMPT_RT is mentioned somewhere, then
the entry will be picked up.

Acked-by: Pavel Machek <pavel@denx.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
v1=E2=80=A6v2:
  - Add Clark
  - Add Pavel's Ack.

 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7ad507f49324a..856723985a768 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19523,6 +19523,14 @@ S:	Maintained
 F:	Documentation/tools/rtla/
 F:	tools/tracing/rtla/
=20
+Real-time Linux (PREEMPT_RT)
+M:	Clark Williams <clrkwllms@kernel.org>
+M:	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
+M:	Steven Rostedt <rostedt@goodmis.org>
+L:	linux-rt-devel@lists.linux.dev
+S:	Supported
+K:	PREEMPT_RT
+
 REALTEK AUDIO CODECS
 M:	Oder Chiou <oder_chiou@realtek.com>
 S:	Maintained
--=20
2.45.2


