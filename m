Return-Path: <linux-kernel+bounces-372483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A65F99A4913
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 23:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 359AEB260F9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 21:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A7818E352;
	Fri, 18 Oct 2024 21:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="C+iDkVGi"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3087814C5BA
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 21:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729287736; cv=none; b=OAnznY56bnkpi4dlO5KnzJxgGRgJZ6E4P4/UQ7e616ahIbdIUc4SxLlqhU8s3O5QqeNbXSilxntFS1f1mSeDPpvdPp3Fs3kuS/r708dM3xRzQHNHXsINZ67x0hlkoMUqsOZrIMerY9RM9RZZfPw3SHrCxSqg4OmGYndNWafGd5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729287736; c=relaxed/simple;
	bh=4eLz8Jgbz5a48CeyB/rTm/lRqPKjyXMUHycaiAPcLeM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sCwN+4OiGT7byTPFLqtP0tlF2OCj7pCvw4inhHWiSZQ9g8hNlH9ZcB4NDoYOX1MIq1TMgirM/oBoi3Kw5pqSIZmr/fwKWUsDKGFtTBxG/Dgk1cBJxNmzIuzB0l9JeTJmuSRTmdSmMHCyFoTE7mEMitT3NjSmfHMDn7zRHY4aYZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=C+iDkVGi; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729287731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7EScYlRb8xeUL4sQWu5BTVxE5ql4FkcuPVnEW/yEe/8=;
	b=C+iDkVGitSB9uDsFryudjQ3x4k/PK6pQqou0h50mtwYGHMEHN3lRHIumQwwnxzeOYKesVf
	QfL/xrhCdww031zJJJhyAan7g4DS9xPg3N4Vo+qmGFzt0fanuHVaHSjMfh2zXmHAHMG5mB
	0JerjWVGtJpSzY3QFmixstZxfxFY4KI=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Tyler Hicks <code@tyhicks.com>,
	Brian Kubisiak <brian@kubisiak.com>,
	Christian Brauner <brauner@kernel.org>,
	Thorsten Blum <thorsten.blum@linux.dev>
Cc: ecryptfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] ecryptfs: Fix packet format comment in parse_tag_67_packet()
Date: Fri, 18 Oct 2024 23:41:42 +0200
Message-ID: <20241018214144.163036-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

s/TAG 65/TAG 67/

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 fs/ecryptfs/keystore.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
index 7f9f68c00ef6..7266fc1a5fc4 100644
--- a/fs/ecryptfs/keystore.c
+++ b/fs/ecryptfs/keystore.c
@@ -355,7 +355,7 @@ parse_tag_67_packet(struct ecryptfs_key_record *key_rec,
 	int rc;
 
 	/*
-	 *              ***** TAG 65 Packet Format *****
+	 *              ***** TAG 67 Packet Format *****
 	 *    | Content Type                       | 1 byte       |
 	 *    | Status Indicator                   | 1 byte       |
 	 *    | Encrypted File Encryption Key Size | 1 or 2 bytes |
-- 
2.47.0


