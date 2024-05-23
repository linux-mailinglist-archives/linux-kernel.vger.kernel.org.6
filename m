Return-Path: <linux-kernel+bounces-187987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8209B8CDB8F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 22:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26A0AB22B8C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 20:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C946885289;
	Thu, 23 May 2024 20:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="ntyXqSEp"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9835B84FB1
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 20:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716497368; cv=none; b=spcPYJXDGqlZUlCPJctF8pDDjCr6qst9w8epKnziZNdNyLJwzF+gP0p1cyaE59TiikxAqMKH3k5ac1MnhhMjZwD+EdaB53XExqUQktsp9G7Cyo5djW24+Y6hQq0JTSIh5O1TiLVQzwMHuuMscbhTuXaaYqZdM/cLi2XqEXQH5f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716497368; c=relaxed/simple;
	bh=rbeNStjq8ZvVvsplsNJqXS7R2MbmDyLPsKIoiXvOtfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U4ulhEFCIhHvTX7yOr4fB763EtXbNaxSJhAKpW5MfYbjCTsneI1hotU3RG/ru+rJZgJpeN/9dnbuL6M78sqTQ3v7slYvChLejEU4nR5VgSKzekANQPtHlcX37gTLq5tHzuEyfo5KZ+FxnqxLB8v+MwWId54fsrU1DxvBSZtZUcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=ntyXqSEp; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=1M5svfgzLuARE6FrrTH0CdVr6zKhpnG/OhiYJueLczs=; b=ntyXqSEpzXLHjolE
	nc5O47VLTS1KYDglITgNukeeiNoo8NpbPV26U6f5NIrRunKJffSjuKGJiwK5QeEoljfF60hSQdAfc
	CemLAOZyqmZFgwN3IGJ4BGu3trdyvZfgOCLdsDUk5nONHeSws9WparFwdwJhBL7NQxYwX76dkM5Nm
	kFi6xZfqvV7fIlk0sISHPJi+YBnmCV3pzARBGhb92HifbVNM/fNLtaQqpqXDmdhrEj3JX6hApJkvD
	fuqhlrXW334Uw0xktPimFu6Ufkl5BPk0uclSc+xDseijHS/X6qpIs2uzxeVPNjHC++J032rEVindQ
	IduPGyQ8JSYd9nG0Ew==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1sAFNL-002IFF-2W;
	Thu, 23 May 2024 20:49:24 +0000
From: linux@treblig.org
To: morbidrsa@gmail.com
Cc: linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] mcb: remove unused struct 'mcb_parse_priv'
Date: Thu, 23 May 2024 21:49:21 +0100
Message-ID: <20240523204921.235746-1-linux@treblig.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

'mcb_parse_priv' has been unused since the initial
commit 3764e82e5150 ("drivers: Introduce MEN Chameleon Bus").

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/mcb/mcb-parse.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/mcb/mcb-parse.c b/drivers/mcb/mcb-parse.c
index 1ae37e693de0..a5f8ab9a0910 100644
--- a/drivers/mcb/mcb-parse.c
+++ b/drivers/mcb/mcb-parse.c
@@ -8,11 +8,6 @@
 
 #include "mcb-internal.h"
 
-struct mcb_parse_priv {
-	phys_addr_t mapbase;
-	void __iomem *base;
-};
-
 #define for_each_chameleon_cell(dtype, p)	\
 	for ((dtype) = get_next_dtype((p));	\
 	     (dtype) != CHAMELEON_DTYPE_END;	\
-- 
2.45.1


