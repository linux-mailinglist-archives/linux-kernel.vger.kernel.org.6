Return-Path: <linux-kernel+bounces-539947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5A2A4AB32
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 14:26:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3846169C5F
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 13:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9A21DF26F;
	Sat,  1 Mar 2025 13:26:31 +0000 (UTC)
Received: from smtpgw-2-2.nogo.comp.nus.edu.sg (84-20.comp.nus.edu.sg [137.132.84.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DC41C5D67;
	Sat,  1 Mar 2025 13:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=137.132.84.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740835590; cv=none; b=fgNZOjmc9s8v/qgHoaOM7W48OmeYLZQ3rcpvOG7lkhksf3pxsjVeo+2i+CKgcDkZgp2kbw52DP0XYIEgbFQexx/ospQm5I9e8NcyrLcvrAbcMpjur2Dsj9H8gQPLoLoQ1LlaoxQNRvuuojttubXdQ4pJg37FFCGKwydvoqrX7SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740835590; c=relaxed/simple;
	bh=oUjnzuhEao4BzN4TSkRJH53moXLBMpaiWrg4HzhM5hk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=C1yeRcudLDrIP8Cadn70J3Qv7TBOe9dOqnTlDn5ZexyF91zbJEDK1W33Ab8EZR/iBOec8Az9aiNFwMsJR67R/iy7US5P7sBksfc4IFPUK8ds9qU55DSGFoB8Orco/cNG7U2AvmqDQQfX4bUPztul8dUqEBOubuvHyfGvulU/X38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=comp.nus.edu.sg; spf=pass smtp.mailfrom=comp.nus.edu.sg; arc=none smtp.client-ip=137.132.84.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=comp.nus.edu.sg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=comp.nus.edu.sg
Received: from localhost (localhost [127.0.0.1])
	by smtpgw-2-2.nogo.comp.nus.edu.sg (Postfix) with ESMTP id 154198D021;
	Sat,  1 Mar 2025 21:19:51 +0800 (+08)
X-Virus-Scanned: Debian amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -102.909
X-Spam-Level:
Received: from smtpgw-2-2.nogo.comp.nus.edu.sg ([127.0.0.1])
	by localhost (smtpgw-2-2.comp.nus.edu.sg [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 12u8i_Io-vVj; Sat,  1 Mar 2025 21:19:50 +0800 (+08)
Received: from smtpauth-2-1.comp.nus.edu.sg (smtpauth-2-1.comp.nus.edu.sg [192.168.21.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtpgw-2-2.nogo.comp.nus.edu.sg (Postfix) with ESMTPS;
	Sat,  1 Mar 2025 21:19:50 +0800 (+08)
Received: from localhost.localdomain (unknown [202.73.41.222])
	(using TLSv1.3 with cipher TLS_CHACHA20_POLY1305_SHA256 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	(Authenticated sender: e0446373)
	by smtpauth-2-1.comp.nus.edu.sg (Postfix) with ESMTPSA id 740CA120875;
	Sat,  1 Mar 2025 21:19:50 +0800 (+08)
From: Shen Jiamin <shen_jiamin@comp.nus.edu.sg>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Shen Jiamin <shen_jiamin@comp.nus.edu.sg>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH] docs: fix incorrect header file reference
Date: Sat,  1 Mar 2025 21:19:33 +0800
Message-Id: <20250301131933.90467-1-shen_jiamin@comp.nus.edu.sg>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The paragraph describing /proc/PID/maps
incorrectly referred to "linus/fs.h", which should
be "linux/fs.h".

Signed-off-by: Shen Jiamin <shen_jiamin@comp.nus.edu.sg>
---
 Documentation/filesystems/proc.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 09f0aed5a..64ece8c75 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -449,7 +449,7 @@ ioctl()-based API that gives ability to flexibly and efficiently query and
 filter individual VMAs. This interface is binary and is meant for more
 efficient and easy programmatic use. `struct procmap_query`, defined in
 linux/fs.h UAPI header, serves as an input/output argument to the
-`PROCMAP_QUERY` ioctl() command. See comments in linus/fs.h UAPI header for
+`PROCMAP_QUERY` ioctl() command. See comments in linux/fs.h UAPI header for
 details on query semantics, supported flags, data returned, and general API
 usage information.

--
2.43.0

