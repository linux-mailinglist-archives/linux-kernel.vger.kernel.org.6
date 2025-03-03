Return-Path: <linux-kernel+bounces-540842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 045B1A4B5B1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 02:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BD011890901
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 01:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8224E7D07D;
	Mon,  3 Mar 2025 01:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="X3kFEqTy"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17964C85
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 01:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740963690; cv=none; b=Cnb+8jjaChsRDRvLI1KqQv1986Mu/EvSxhiLHpSGSVkBWrjUnLSdROue1TlunoXsfNA+tMDVIdFykwVWDcRgjxCxDNi0FSLGNB0vEZlYIg6+j59UXsAn9eoKhwSGTWTeiUFgfZjC6pmS5A6wjvdiVsSeif7hSy1ZkZBGA+YFHKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740963690; c=relaxed/simple;
	bh=YCWiH4a9wz7YH7HsSP4ivcejxGQRvpLZmw5UwsT7TxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sOGn/2wzPSXbD+a4rRjRoNiGeHknXkw+FuBdd/1Lhup/7SIF6qoRJjyDUTU5H3oV5Xv1N4A+6xFFCSRvFTW8Iq9hia7GsRBFwYYrhGsxO0jiKccUqFePphUvBn7D/QVenH6aYK/DfCyUR6i56eY/9AZoUSp/b1/DKGpQxGkJWqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=X3kFEqTy; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=beLmT+Q0XpSHofJbl8JA0ZWYQMSdvEACj+BeRMgvR9M=; b=X3kFEqTy7EVttmF1
	BjiSg8NPEKtGqBNDbYY88aELRFM2HzSs8c7o7F2zfAdAyZIgVG9piF/6laRRcaa2wocRnyLv5BKP3
	OKHTEbXyrSollwfdACV1k4Ba0wmNfkatxcCWbviU3TuX+w25Kj0e0a7Tz0OAIQluDXjRiwtkjC6gf
	mmyFs02JqAUARlrPOcPNgmtkHv6gdFJFwm59RuYt+G/uU7vIGTMe6s8erFNBtNDoIU/tHKBFEzc/O
	eBrBJKn7iwUFyGPlgBeYFhHQlb7MYmMACwkp0ZU9xhnfumL30EfXc7xhhNUrnMm4kbyHnnxdcCKLU
	NRXOpAmxUnPt4GGKYw==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1touBS-001zdD-1T;
	Mon, 03 Mar 2025 01:01:26 +0000
From: linux@treblig.org
To: linux@dominikbrodowski.net,
	linux-kernel@vger.kernel.org
Cc: "Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] pcmcia: cs: Remove unused pcmcia_get_socket_by_nr
Date: Mon,  3 Mar 2025 01:01:25 +0000
Message-ID: <20250303010125.254587-1-linux@treblig.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

The last use of pcmcia_get_socket_by_nr() was removed in 2010 by
commit 5716d415f8c5 ("pcmcia: remove obsolete ioctl")

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/pcmcia/cs.c          | 17 -----------------
 drivers/pcmcia/cs_internal.h |  1 -
 2 files changed, 18 deletions(-)

diff --git a/drivers/pcmcia/cs.c b/drivers/pcmcia/cs.c
index c75f55e1250a..adbc486af2ea 100644
--- a/drivers/pcmcia/cs.c
+++ b/drivers/pcmcia/cs.c
@@ -229,23 +229,6 @@ void pcmcia_unregister_socket(struct pcmcia_socket *socket)
 EXPORT_SYMBOL(pcmcia_unregister_socket);
 
 
-struct pcmcia_socket *pcmcia_get_socket_by_nr(unsigned int nr)
-{
-	struct pcmcia_socket *s;
-
-	down_read(&pcmcia_socket_list_rwsem);
-	list_for_each_entry(s, &pcmcia_socket_list, socket_list)
-		if (s->sock == nr) {
-			up_read(&pcmcia_socket_list_rwsem);
-			return s;
-		}
-	up_read(&pcmcia_socket_list_rwsem);
-
-	return NULL;
-
-}
-EXPORT_SYMBOL(pcmcia_get_socket_by_nr);
-
 static int socket_reset(struct pcmcia_socket *skt)
 {
 	int status, i;
diff --git a/drivers/pcmcia/cs_internal.h b/drivers/pcmcia/cs_internal.h
index 02a83ca44e77..5ac810ffda31 100644
--- a/drivers/pcmcia/cs_internal.h
+++ b/drivers/pcmcia/cs_internal.h
@@ -116,7 +116,6 @@ extern struct list_head pcmcia_socket_list;
 extern const struct class pcmcia_socket_class;
 
 int pccard_register_pcmcia(struct pcmcia_socket *s, struct pcmcia_callback *c);
-struct pcmcia_socket *pcmcia_get_socket_by_nr(unsigned int nr);
 
 void pcmcia_parse_uevents(struct pcmcia_socket *socket, unsigned int events);
 #define PCMCIA_UEVENT_EJECT	0x0001
-- 
2.48.1


