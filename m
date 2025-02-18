Return-Path: <linux-kernel+bounces-518715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF8BA393AD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5A7618899E8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 07:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6D11B21AA;
	Tue, 18 Feb 2025 07:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5usjKHv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E58819;
	Tue, 18 Feb 2025 07:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739862538; cv=none; b=YqiRsCB8eR0Zv95LbkjRTrfpCy87hOuv1eBbW4PweQ2+107mV6DACBO3Msd9f0Io32fO2c6v6k+0ljFogMRD1QD52BLzd5d32FbZpyELlb3v+fGq9QvMtcRgjSoQ1bVyx8zMhYOZs7b3onw4Mnu8DuTuGyPwv2Ilqfg7b3JxCeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739862538; c=relaxed/simple;
	bh=k5HFhzNiEJZ0uA2O8RbT8DQaw2SaLejBZUOGTHGrU9I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=upI8aXSZbk/XLWqMasBznlR2Cb4HAI8L5jGfPgvW88A8mdiIyLkocD2Lf7dWo3zmh7ddPTx/RH79g2M/np+SnlQvcrzyjMCTcfCaeexCIC9gmtwKMq4cUFP70YBm8D5Svo/INR6ql0qzFLmEYSHraxOemEG19NVeWnlqrKVh4I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k5usjKHv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC56DC4CEE2;
	Tue, 18 Feb 2025 07:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739862537;
	bh=k5HFhzNiEJZ0uA2O8RbT8DQaw2SaLejBZUOGTHGrU9I=;
	h=From:To:Cc:Subject:Date:From;
	b=k5usjKHvTegCL031cPHM5I4mr60sWx2pLfswL3xyxx7kfo8DUROnl4EUwx3XjG2S8
	 VJKJPoipTyfuK78F5i0GBoSsp7Ec9gJajuYTYeDyFnAeEEj0M9lz7mSGFQzmlu36ge
	 QIoPtUd4UCxC8qTcEyORnrLrsSPvPaqIHFygIrqxvXhXRYUPMNc+YxqCKup9X5x2n/
	 9FKr1OTxvawB4Be1ntk8x1Wa7rTVhKd4efIbnwCo5RKs3iVP8I9Y4KoDBsugUm/a6Z
	 mHX5K8WBcpHPRZE6k/iv8LqUN/5NWPEtXd7mYNFHL5jPCEgGAIkMPZsnwkGLFg4rWD
	 u6w8jAXpRYeXg==
From: Mike Rapoport <rppt@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Mike Rapoport <rppt@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation/kernel-parameters: fix typo in description of reserve_mem
Date: Tue, 18 Feb 2025 09:08:45 +0200
Message-ID: <20250218070845.3769520-1-rppt@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

The format description of reserve_mem uses [KNG] as units, rather than
[KMG].

Fix it.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index fb8752b42ec8..bf00552908bc 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6082,7 +6082,7 @@
 			is assumed to be I/O ports; otherwise it is memory.
 
 	reserve_mem=	[RAM]
-			Format: nn[KNG]:<align>:<label>
+			Format: nn[KMG]:<align>:<label>
 			Reserve physical memory and label it with a name that
 			other subsystems can use to access it. This is typically
 			used for systems that do not wipe the RAM, and this command
-- 
2.47.2


