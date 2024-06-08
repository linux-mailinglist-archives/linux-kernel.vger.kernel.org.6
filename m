Return-Path: <linux-kernel+bounces-207045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E4D9011AF
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 15:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92A231F21E0F
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 13:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95077178391;
	Sat,  8 Jun 2024 13:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="TCBD6F3e"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FD3156220
	for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2024 13:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717853606; cv=none; b=scCKykdGMWGZXLfotbBSJqY71a3XyHU/bSYyCjgBIHqk3+zcAVjvhTMRhh7Zz3HF6zPHnagtIQsCg4fCN/MPZi+rrVyzgTedBM9f198YiYJVB8K7qkpoRzc7B3ws8EVS7FN9ywrpyHWXBXsB0H8/U/VkLzI3RRBTlzRodHdSx60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717853606; c=relaxed/simple;
	bh=2ybfFLVMGLQtZT8gY07xGd6Jr2VmK1ipCNOwcUZnlLs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mRE+ThWfFmcgDVw3n9+Ws1ZIpGP4RlObV0c+8gDW6spUBYUD64AEgPApLK6qXWdCA3YLnwn88n0J/dualq54knpaRQOIArOs4hOQYgbDtzVqhWsJHw5ZjRWnaJ0RDGDbrq2AOOKETF6fSn/THdx3wj06sDII8g2YzI3g9oNH8Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org; spf=none smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=TCBD6F3e; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yoseli.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id DE8F31C0004;
	Sat,  8 Jun 2024 13:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1717853596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=F9RUbVGykbnpeafXzmCWcdAJle5I8sUbSC36sWYm8D0=;
	b=TCBD6F3e1YZCpB8fzicny8fQQ7jig/qBp7QRgf+yh/8NVfiZG3rlvA8eabL5mauAoeiBjc
	iKP4W7+9S1sb42ZCp+soIcmNB+JeK9bDruaKMa8kzj01kwyk90cMtcAdV1FBACSy0Tc+7D
	FpX2fN7SoGqMafXgfVqPJQvmGGfqyfeNmI18NhcUd4JrqHdog+LuiHEZUAmeG6dgHrCNOu
	x4+/Tc54j+V8hgXxuqBlnGbSR29nh2qaZUuN5pVWq7OFai35vGjdA2Y7DPsGqeAoVC2gw1
	cEXb23/j4QloSNdZJkzf/2lkwZzEMJZtC/lB5zDF1TmFQnFUlSDlUAwxlgBzwA==
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Date: Sat, 08 Jun 2024 15:33:11 +0200
Subject: [PATCH] mailmap: add entry for Jean-Michel Hautbois
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240608-jmh-mailmap-v1-1-6cd6b71f4fed@yoseli.org>
X-B4-Tracking: v=1; b=H4sIAJZdZGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDMwML3azcDN3cxMyc3MQCXZM0Y4sUS0NDYzNDIyWgjoKi1LTMCrBp0bG
 1tQCju0W6XQAAAA==
To: linux-kernel@vger.kernel.org
Cc: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717853595; l=1061;
 i=jeanmichel.hautbois@yoseli.org; s=20240608; h=from:subject:message-id;
 bh=2ybfFLVMGLQtZT8gY07xGd6Jr2VmK1ipCNOwcUZnlLs=;
 b=hjtomw5mH/YoDl4SPjr0rydcc1bYSayyMvDuTOZJa4KsDtaH9KPSlgNUdNvbKjooM1Tlm6tzX
 eMQnkE6fUnkA7z6UFUp0zxxhSijpd8PE3/1/lfj48PlRjxY78siPQ5J
X-Developer-Key: i=jeanmichel.hautbois@yoseli.org; a=ed25519;
 pk=oMZuYhJzT0j5MI73RlNUVYaA8VdWpFR/Sao0JKz1D2I=
X-GND-Sasl: jeanmichel.hautbois@yoseli.org

As recent contributions where made with the @ideasonboard.com email, any
reply would fail. Add the proper address to map this old one.

Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index efd9fa867a8e..dd8ff4a02cca 100644
--- a/.mailmap
+++ b/.mailmap
@@ -284,6 +284,7 @@ Jeff Layton <jlayton@kernel.org> <jlayton@poochiereds.net>
 Jeff Layton <jlayton@kernel.org> <jlayton@primarydata.com>
 Jeff Layton <jlayton@kernel.org> <jlayton@redhat.com>
 Jeffrey Hugo <quic_jhugo@quicinc.com> <jhugo@codeaurora.org>
+Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org> <jeanmichel.hautbois@ideasonboard.com>
 Jens Axboe <axboe@kernel.dk> <axboe@suse.de>
 Jens Axboe <axboe@kernel.dk> <jens.axboe@oracle.com>
 Jens Axboe <axboe@kernel.dk> <axboe@fb.com>

---
base-commit: dc772f8237f9b0c9ea3f34d0dc4a57d1f6a5070d
change-id: 20240608-jmh-mailmap-4f38d9113612

Best regards,
-- 
Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>


