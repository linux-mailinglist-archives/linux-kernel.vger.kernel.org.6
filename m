Return-Path: <linux-kernel+bounces-187977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 718748CDB75
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 22:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0743B1F225F0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 20:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6102884DFA;
	Thu, 23 May 2024 20:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="ItRfJ9GC"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABF484DE8
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 20:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716496675; cv=none; b=qn0nFvJ+GDQojCIwbKIVSWxZPVihlcQ30FziYPtnT+ftXnkyus0wuMxtOYZUg647b/AC7IrkV0DdpbZqbklI5xcYNz6OhztR0XAJnjyxfiE6MFxKQr4H0hEd3UgF+2SnAXKKUCXGCbpvCGT3612YPfO6sxfBjHRQW9YdFdo5lKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716496675; c=relaxed/simple;
	bh=pzc8/clks3JsXSaf2nMX9yaBPfLBf7AeGzcTvHnmxJk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VbXh0yDhEusU28eaqpLHIqweG0f03XKjkFUwK/fa6hScEoiCyjSF1fO0cIexAQYIIyLbEiRfLyJWbG0b3rI6fUIKS0mnAWuAqeuHwJKO093f3bhcpLVD+uq7nKwT0w52dHtKqZ5qqJJP30olEYGlLzMy4Zccsisx9v75lX3pBKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=ItRfJ9GC; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=R7pqFNXI9oD5ybxaNxIqxjqsGjSGeJWlI3Z9oMgMs5s=; b=ItRfJ9GC95YDBSAA
	wfpfGsx00cvS71u7cpAYZTFPDWFYpPgcJ6MF6ezkB8eKp8MrO83Na3CYlEFrrgql6JkV36Unr8pNK
	TpBFZ6/pfqSuXCMDPYBzpAxXyaQcAW+8K5IuC9imII52lQ+HlNBJPtUDR5br2VNboueAlO6IjofFp
	rEyLzXZU4RH1wfLaM1cuDrmO9WRmxNdp8oyrKObcjLQABtKfs2JaoTR2p3k2mt5trEZXTsoIym3+P
	Gspp6Zlkxnp5jRGVmVOgtXfkKrfuEB8FE94DpaJNspbsDdDvERF1yePzGaPdqlA864rI8oAZpbiI4
	4Y7gwoS8UZjl6aLJ5A==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1sAFC3-002IAW-16;
	Thu, 23 May 2024 20:37:43 +0000
From: linux@treblig.org
To: jassisinghbrar@gmail.com,
	rrice@broadcom.com
Cc: linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] mailbox: bcm-pdc: remove unused struct 'pdc_dma_map'
Date: Thu, 23 May 2024 21:37:41 +0100
Message-ID: <20240523203741.201099-1-linux@treblig.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

'pdf_dma_map' has been unused since the original
commit a24532f8d17b ("mailbox: Add Broadcom PDC mailbox driver").

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/mailbox/bcm-pdc-mailbox.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/mailbox/bcm-pdc-mailbox.c b/drivers/mailbox/bcm-pdc-mailbox.c
index 242e7504a628..a873672a9082 100644
--- a/drivers/mailbox/bcm-pdc-mailbox.c
+++ b/drivers/mailbox/bcm-pdc-mailbox.c
@@ -158,10 +158,6 @@ enum pdc_hw {
 	PDC_HW		/* PDC/MDE hardware (i.e. Northstar 2, Pegasus) */
 };
 
-struct pdc_dma_map {
-	void *ctx;          /* opaque context associated with frame */
-};
-
 /* dma descriptor */
 struct dma64dd {
 	u32 ctrl1;      /* misc control bits */
-- 
2.45.1


