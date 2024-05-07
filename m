Return-Path: <linux-kernel+bounces-171879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC228BE9CE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 18:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EACB028B80E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA44200D3;
	Tue,  7 May 2024 16:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QoUqMrT8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D691854BEA
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 16:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715100841; cv=none; b=YVoJ9dTqfQvtHS2finE+dfw42AQwcom/+5HIifRhq0nUeDrDsRKMx1lXGNLqgWGJE8etiX/CACkOToYUcVaMss2aQmaa8+cV0/raVAohHs6Fi0d/7n+MR3Zzw0NNZXBpb44CFnTBCW21phIl23v7APmoEdbBiFxJ2AnITeiA2jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715100841; c=relaxed/simple;
	bh=eUXXlN5WmbzUqPc3MNXUPvyWjAsiVrCHuEnIwmmE8aA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=WfmUo02Dr9FYprhQaiFHAXDiwqzG8E00cA8T3ul522V/XBn7C3MDkgXk4Rx00HT7sgb1p181D1QD2apkA33Yx9okFoMyTyE6Y1dyKF4aL5suLqJT4rlJ/2pettYq/Y8WHyCsLy+KvHkaiGKkNbcsrqm46MAjzDDNKVpjAajpHmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QoUqMrT8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 326CBC2BBFC;
	Tue,  7 May 2024 16:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715100841;
	bh=eUXXlN5WmbzUqPc3MNXUPvyWjAsiVrCHuEnIwmmE8aA=;
	h=From:Date:Subject:To:Cc:From;
	b=QoUqMrT81/7Exykpl+/tofkBTn+amyXCCotBtgwtwMQa+sN97AH7FlfCy+7gyeLKz
	 nJB4XXJX1YPz+ZZ5rENu4LyeqQcO2Zw/OBOo4HMMfoJW5QzwSmlzXvpvQCZeE4OOtk
	 dtfCtckwsoRKWQ5/o/e2eqqwzv0G0E0VV1Oad8qme+xsDzsJMf+YZLh47O/rqdJF90
	 GUXYIt1YUmlBqZFi1AlRu6fUULAuS/m04eC0ya7pKiwpFWBkYGFDE4B4pn8mq4//LX
	 PyhUGjXPz1+tg4DBMQgv2WxJ32HRtW/Wm2v02unD7PODRIwq8LX1cQ9cR1o2ZMnoWB
	 fNOows3B5WugQ==
From: Simon Horman <horms@kernel.org>
Date: Tue, 07 May 2024 17:53:56 +0100
Subject: [PATCH v2] mfd: idt8a340_reg: Start comments with '/*'
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240507-clockmatrix-kernel-doc-v2-1-3138d74192dd@kernel.org>
X-B4-Tracking: v=1; b=H4sIAKNcOmYC/4WNQQqDMBBFryKz7pQkKkpXvUdxEZOpDlojExGLe
 Pem9gBdvv/57+8QSZgi3LIdhFaOHKYE5pKB6+3UEbJPDEaZQpWqQDcGN7zsIrzhQDLRiD44rAp
 balfnvvQ1pPEs9OTtFD+axD3HJcj7/Fn1N/2rXDVqtK5Vlc3zttXV/Vdeg3TQHMfxAVa1nTK9A
 AAA
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org
X-Mailer: b4 0.12.3

Several comments in idt8a340_reg.h start with '/**', which denotes the
start of a Kernel doc, but are otherwise not Kernel docs.

Resolve this conflict by starting these comments with '/*' instead.

Flagged by ./scripts/kernel-doc -none

Signed-off-by: Simon Horman <horms@kernel.org>
---
Changes in v2:
- As suggested by Lee Jones
  + Update patch prefix to "mfd: idt8a340_reg:"
  + Update line-wrapping in patch description
- Link to v1: https://lore.kernel.org/r/20240504-clockmatrix-kernel-doc-v1-1-acb07a33bb17@kernel.org
---
 include/linux/mfd/idt8a340_reg.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/mfd/idt8a340_reg.h b/include/linux/mfd/idt8a340_reg.h
index 0c706085c205..53a222605526 100644
--- a/include/linux/mfd/idt8a340_reg.h
+++ b/include/linux/mfd/idt8a340_reg.h
@@ -61,7 +61,7 @@
 #define HW_Q8_CTRL_SPARE  (0xa7d4)
 #define HW_Q11_CTRL_SPARE (0xa7ec)
 
-/**
+/*
  * Select FOD5 as sync_trigger for Q8 divider.
  * Transition from logic zero to one
  * sets trigger to sync Q8 divider.
@@ -70,7 +70,7 @@
  */
 #define Q9_TO_Q8_SYNC_TRIG  BIT(1)
 
-/**
+/*
  * Enable FOD5 as driver for clock and sync for Q8 divider.
  * Enable fanout buffer for FOD5.
  *
@@ -78,7 +78,7 @@
  */
 #define Q9_TO_Q8_FANOUT_AND_CLOCK_SYNC_ENABLE_MASK  (BIT(0) | BIT(2))
 
-/**
+/*
  * Select FOD6 as sync_trigger for Q11 divider.
  * Transition from logic zero to one
  * sets trigger to sync Q11 divider.
@@ -87,7 +87,7 @@
  */
 #define Q10_TO_Q11_SYNC_TRIG  BIT(1)
 
-/**
+/*
  * Enable FOD6 as driver for clock and sync for Q11 divider.
  * Enable fanout buffer for FOD6.
  *


