Return-Path: <linux-kernel+bounces-567640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA46DA6887C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7787C188FA1A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49BE5253320;
	Wed, 19 Mar 2025 09:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Zmq/6zbQ"
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B90E257444
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 09:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742376900; cv=none; b=uD92jQ6o1z9YIEIK4WdArz+V0bScHrQvayJp45st5tOMP0cpbtj8/nmJ7EJORZ+3aUOnroUy4c+k/xkAtkLirDU7wvnDVNQGKs41Uop/0pGWLNgJrDJ/PWIg7o6elnKX/oioV3IJrZmdRR1uGO8UEAO7xf/KbI5la4aUhEA/6fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742376900; c=relaxed/simple;
	bh=xxRiEguAyeGL9D+NNtgql1i2rcqNGXFBjQJxh1bi3rU=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=qL7NS8OXF57keGoCdg8RqKoqHYxpI+/eH0xzfCWZ6Wr0Lb2Xy+xBwXAcZpX2Y4VDiHJhK40irhqEHkkcXvGvXsDH6Gm/ikXZVjWI5DJOBleRUKlGFZknYxAMiLYvsIw+rXp5MuwXfnMBUli0A4Deqa6aatU1Sa3HEXq6oK5V+jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Zmq/6zbQ; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 2BF3911400D1;
	Wed, 19 Mar 2025 05:34:58 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 19 Mar 2025 05:34:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742376898; x=
	1742463298; bh=6vGTjqhrImDW99O46cZMgZcsLhmTGwXSWmZI+UM/MXc=; b=Z
	mq/6zbQe1Lks5FWz5nNgEQRZd1H9RoycpJgBUOACnOsIJPOjcNDWYzwwIsvgH8Vy
	RxjUgnHk/6S0//75Z3iDxt3XFyFicZwzi1QTjN6bW4vhUkU6NrTw3Rel+AI4F9c/
	mqzd8qPEZeVFPPaX038gyO33ketUDWbbjHFF+rv/sXXEW4dUtRYUFGebvZGMPhZK
	WAqFi1LSLSezQhZ2J7/wzpLXVnQb7EIdjhE1fL4ufh7sU8OUEKQFMKWStR94LvmS
	J6mA4ZJfHV26R9P+2sY/+uyeAKZ6Tc1Fy9zg6Aptks9dnx/qGGEQ81WFvr62Wemm
	HO8cU2PVzON0uTqUrESRA==
X-ME-Sender: <xms:wY_aZ86PDbRhlvmW_qcRP9Bw1ki4s-cOwpt8jWPyMD9WxY2x53DMTQ>
    <xme:wY_aZ95q11YYFQSjHpTIpDBZ_DlqbKycTLw169eaa_r64_Y5mrVxyO2hMSeoRLeBm
    iWHmaeaJ0oXeQ3FaS4>
X-ME-Received: <xmr:wY_aZ7dMxIOcJTJ-cE7FpZsAoeXrieWthf9leAE-2Heh_lUq9nOWqVfBhczL6GriSMTrkL-wwLc9tEcSqR2ZN2RCQWBk-Jk6qNw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeegleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepvfevkfgjfhfhufffsedttdertddttddtnecu
    hfhrohhmpefhihhnnhcuvfhhrghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrd
    horhhgqeenucggtffrrghtthgvrhhnpeelgefhvefgveduhefffeeuveehtdeigedukeef
    uddvhedvfefhkedugffffeetheenucffohhmrghinhephhgvrggurdhssgenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfthhhrghinheslhhi
    nhhugidqmheikehkrdhorhhgpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehgvggvrhhtsehlihhnuhigqdhmieekkhdrohhrghdprhgtphht
    thhopehlihhnuhigqdhmieekkheslhhishhtshdrlhhinhhugidqmheikehkrdhorhhgpd
    hrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:wY_aZxKAGCc6tFjexY4f34b2H4SIs1Ql8TyDyrHavBchg19edjr1-w>
    <xmx:wY_aZwJ4WpHBoAn6CdsQ7-GHV0omF_XQFu9MpIKGuFf_wMEHRvcPUA>
    <xmx:wY_aZyyBFQqr6ePkBmogijYUBmATHk7M9ZhlemJ4elQEFD_l3J2G8g>
    <xmx:wY_aZ0IZY0xcDvw1exKCMGtcpVNMR9kk-DyFvV-bdMVY9ddZkZVHCw>
    <xmx:wo_aZ3XDR0AgpLiQRzfEU8jjf-qoX6sUTRGaJpMxZngd5WDkiG-09Pol>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Mar 2025 05:34:55 -0400 (EDT)
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <1f27682893bba60572dfed728386a0f76044b17b.1742376675.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1742376675.git.fthain@linux-m68k.org>
References: <cover.1742376675.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v2 3/3] m68k: Remove unused "cursor home" code from debug
 console
Date: Wed, 19 Mar 2025 20:31:15 +1100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The cursor home operation is unused and seems undesirable for logging.
Remove it. The console_not_cr label actually means "not line feed and
not carriage return either" so take the opportunity to replace it with
something less confusing. Rectify some inconsistent whitespace while
we're here.

Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 arch/m68k/kernel/head.S | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/arch/m68k/kernel/head.S b/arch/m68k/kernel/head.S
index bf7fa344cd3a..48ef74e45535 100644
--- a/arch/m68k/kernel/head.S
+++ b/arch/m68k/kernel/head.S
@@ -3555,28 +3555,21 @@ func_start	console_putc,%a0/%a1/%d0-%d7
 	jra	L(console_exit)
 
 L(console_not_lf):
-	cmpib	#13,%d7
-	jne	L(console_not_cr)
+	cmpib	#'\r',%d7
+	jne	L(console_not_lf_not_cr)
 	clrl	%a0@(Lconsole_struct_cur_column)
 	jra	L(console_exit)
 
-L(console_not_cr):
-	cmpib	#1,%d7
-	jne	L(console_not_home)
-	clrl	%a0@(Lconsole_struct_cur_row)
-	clrl	%a0@(Lconsole_struct_cur_column)
-	jra	L(console_exit)
-
-/*
- *	At this point we know that the %d7 character is going to be
- *	rendered on the screen.  Register usage is -
- *		a0 = pointer to console globals
- *		a1 = font data
- *		d0 = cursor column
- *		d1 = cursor row to draw the character
- *		d7 = character number
- */
-L(console_not_home):
+	/*
+	 *	At this point we know that the %d7 character is going to be
+	 *	rendered on the screen.  Register usage is -
+	 *	a0 = pointer to console globals
+	 *	a1 = font data
+	 *	d0 = cursor column
+	 *	d1 = cursor row to draw the character
+	 *	d7 = character number
+	 */
+L(console_not_lf_not_cr):
 	movel	%a0@(Lconsole_struct_cur_column),%d0
 	movel	%a0@(Lconsole_struct_cur_row),%d1
 
-- 
2.45.3


