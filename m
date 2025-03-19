Return-Path: <linux-kernel+bounces-567636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E72E1A68882
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 527491686D5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E73253F3F;
	Wed, 19 Mar 2025 09:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="3TPKg3yr"
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172142528E6
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 09:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742376883; cv=none; b=h753dqijQc/CcSR155y481frYMaHE/gxT1ffIkHmznWwFi/jkZ8HVAVEiV/yl2W056ylIDPDuJHI3M2S7o4Gr8tK8b+y2wuDyxFcSucEBUdQGOalcJbkPn4z3z2NuHBdQgvkR4Q6JqhTDuI3ocfShtqHyA9QTrWiALxavSkhvYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742376883; c=relaxed/simple;
	bh=bLO6XOp8X8pawLmoD4gDaJghedPjUsU+TO9ppKoTi0I=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=WOK+jHirms5skZQTt4NmERmIX0NnrxSYWb1RkQYdGDdX64+S6uFOKxNsdc5fm/euful8SEHpccDtuH3IKjRkGlMOzGCkN/4VOszJrWhQb4aP4fMYBcNqAgMt0ns1mwVSXhY3dlTBURUyLPCHLozcXEG60Xp+UR5Jxtfw/2Xg7fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=3TPKg3yr; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 2B56C114012B;
	Wed, 19 Mar 2025 05:34:41 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 19 Mar 2025 05:34:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742376881; x=
	1742463281; bh=lGSaLW/V66TyHrIDzxOJWZo2UgRsz1f9XhClXGMzdJM=; b=3
	TPKg3yrwe6Vx3Mu77wwfP5CFEWCBkCstIIU4qMBKeEQykPhr+9mWGIlnWEtsVAEd
	cqWLk2/syU2ZKGpisMQ/Gi412m8FNF0z6P+5sCdi5oSIPCi9ILAcUUc9+Q/YUjr/
	gLfr16IFOLpCaj39jzo8X+EH7+7X7VVs5qOENMrq2b+aUgsSAyjPfACMxLVZK71U
	PtqA8hnPYY5PUc69E9KfzkUHGixpTZEtzS2zFe81ktrVn7oSyA/yCDirQ6foXad5
	NVmO1bbz4WdWogXjZQzRBfLBAb7h7sadOqgU4ygiVnPzrR/9LpVEHvnlBf+0OiNO
	gtfROcNkyAMoc8pWCdTnA==
X-ME-Sender: <xms:sI_aZw3tfrtNw6JCRdmSB7EQ8X-PamCfCKCVFXUlfszPC17SCLNW9Q>
    <xme:sI_aZ7G49vPgOn68pKeMijHHLErAUuRQ1S63Imfk7OuOG-lxhArluxC1I7dbwo0KA
    h5YiwTzLLbV9ZreJm8>
X-ME-Received: <xmr:sI_aZ44BiEJEBWFCSDCDr_0FDSW2IQwjF_5RQvx6zyvAmi1GWFpSk4xQrpGRswJuOmYvMU9Qn1SgS48xSSkaBpEmv8m-cu1tssk>
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
X-ME-Proxy: <xmx:sI_aZ52pGV3aRLFbMLzWBSyG9ZeU0I5x3AZl9cLGxm6cL5RJgY3vIw>
    <xmx:sI_aZzEKUHHiF51RkXHRXkvKa6uSPsKnmuKUpS6M4uqwvCD6XEVXhw>
    <xmx:sI_aZy_5ToyBDhPn1BIps4CxtnwwxITiWzwij8y-XVYb9jk12GsYNg>
    <xmx:sI_aZ4nkcZ1ZngtE9-Zyj5X4Kn4CnGqE0XVNfCWAJVtp-L4Dmv9ugQ>
    <xmx:sY_aZ4TMhfZ5uNGyWM1XzDcusNl41DF-xuC-XX2CFnARHiOtzyumZIlr>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Mar 2025 05:34:38 -0400 (EDT)
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <d3d11a43cb597936d325344e93defa0c1e80d6c7.1742376675.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1742376675.git.fthain@linux-m68k.org>
References: <cover.1742376675.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v2 2/3] m68k: Avoid pointless recursion in debug console
 rendering
Date: Wed, 19 Mar 2025 20:31:15 +1100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The recursive call to console_putc to effect a carriage return is
needlessly slow and complicated. Instead, just clear the column counter
directly. Setup %a0 earlier to avoid a repeated comparison.

Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 arch/m68k/kernel/head.S | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/m68k/kernel/head.S b/arch/m68k/kernel/head.S
index d0d77b1adbde..bf7fa344cd3a 100644
--- a/arch/m68k/kernel/head.S
+++ b/arch/m68k/kernel/head.S
@@ -3533,19 +3533,16 @@ func_start	console_putc,%a0/%a1/%d0-%d7
 	tstl	%pc@(L(console_font))
 	jeq	L(console_exit)
 
+	lea	%pc@(L(console_globals)),%a0
+
 	/* Output character in d7 on console.
 	 */
 	movel	ARG1,%d7
 	cmpib	#'\n',%d7
-	jbne	1f
+	jne	L(console_not_lf)
 
-	/* A little safe recursion is good for the soul */
-	console_putc	#'\r'
-1:
-	lea	%pc@(L(console_globals)),%a0
+	clrl	%a0@(Lconsole_struct_cur_column)	/* implicit \r */
 
-	cmpib	#10,%d7
-	jne	L(console_not_lf)
 	movel	%a0@(Lconsole_struct_cur_row),%d0
 	movel	%a0@(Lconsole_struct_num_rows),%d1
 	cmpl	%d1,%d0
-- 
2.45.3


