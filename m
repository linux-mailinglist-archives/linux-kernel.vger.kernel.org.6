Return-Path: <linux-kernel+bounces-302692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2999601F7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 08:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B001F1C22019
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 06:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F677192599;
	Tue, 27 Aug 2024 06:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="qflEZINF"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BC7156665
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 06:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724740626; cv=none; b=tNemst7lwszYicSaXr4Gs9dPb7On2sL3McgLok2PNct8N/mhJ6elX3aI6netZGyy7j7HJnt5IX11AZGGNk4jY2+XnFfcMWPuiwkF6sQXFHDI9ODbMpeB3FDuodTPlyDBsUl8h/bSjoNkBqEizmJOPQFdmUc7L3+jkugbAuGSQ9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724740626; c=relaxed/simple;
	bh=Jz2DYN4GgoIl2xhz48zN+es66+xV+eZBkJuLfa5mYl0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s8Nenag2TGufu3Kjk7uuOZlS6mHfV4I/MQp/G+tHc3oviNc4A5GeViLeD8gjiINZxCy9Qpuw1PAmKcH0gCKoq9Ges2FsguSSTXwpXohdhSbK9O1hN+NI+A7RMxwAQ8jRwXkQAVI3eqyn6bryevDT+7I/msUo77I+y+D2AbaF07M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=qflEZINF; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1724740622;
	bh=YtXQ1b+AHiYzvhi9lLvKVXsirFFKMPBoc0aah+APMNA=;
	h=From:To:Cc:Subject:Date:From;
	b=qflEZINFFfc4eT24aWEhVpuHbI/WjUWgY8ltXDApgzjEKIQy+hyXdvq1CArIIMwm5
	 HV1g45slwrWEZp5juzWB5k33zoQTfDxkalHD12d7shDFEaqvnlWOzUWXmHGldfqk0h
	 O5JP0P3s77f+AY1XcKlQGajmQVwauD8AGvhiPVBmzQX/TMxE6Ly0sy5UWYJAP29FoS
	 aMjUOh2T0oOlVCYF0/tO4A0TlVKMZy2+XlRhZg+81DFoUZzLqUnJNB7gR/+WW94llE
	 6qtjqLGvehe9Zn+CG+8hW3/S0A+W2Dg/x65qi2twHMvyu+eCQ8xVUmkoP+rbY2c7Xf
	 6dTvq0giv5fzQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WtHrt4Chxz4wnx;
	Tue, 27 Aug 2024 16:37:02 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@lists.ozlabs.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] MAINTAINERS: powerpc: Add Maddy
Date: Tue, 27 Aug 2024 16:36:51 +1000
Message-ID: <20240827063651.28985-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Maddy will be helping out with upstream maintenance, add him as a
reviewer.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 878dcd23b331..0ee724dcc05a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12912,6 +12912,7 @@ M:	Michael Ellerman <mpe@ellerman.id.au>
 R:	Nicholas Piggin <npiggin@gmail.com>
 R:	Christophe Leroy <christophe.leroy@csgroup.eu>
 R:	Naveen N Rao <naveen@kernel.org>
+R:	Madhavan Srinivasan <maddy@linux.ibm.com>
 L:	linuxppc-dev@lists.ozlabs.org
 S:	Supported
 W:	https://github.com/linuxppc/wiki/wiki
-- 
2.46.0


