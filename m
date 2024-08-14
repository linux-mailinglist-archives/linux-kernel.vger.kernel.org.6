Return-Path: <linux-kernel+bounces-287227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E3D952502
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 23:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0481B1F22FFE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 21:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728B41C8FA6;
	Wed, 14 Aug 2024 21:56:51 +0000 (UTC)
Received: from cloudsdale.the-delta.net.eu.org (cloudsdale.the-delta.net.eu.org [138.201.117.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C617346D
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 21:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.201.117.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723672609; cv=none; b=pGs/Xrr4jBPirUleGPlrhbX2LeVvzrOXxf7sEy5Wq0DPZEb/DeMfHt8Pxx/bnq7BXojGBQ2MkZzb3CN/6/j7r6frMWR4cUdnTkt3ZyydtO5JKCMZ3yCLDJ7mDUGTe03JUN/aLZ9rAnC1B36+ubu7LM8xPtRlA3GmGyTbVktBXrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723672609; c=relaxed/simple;
	bh=F9OGsCthHMsW4TvwSn686+0hOKVxx9anVwXLY3McOwg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d12shnNbgO3HNWS+0FJvkE+7PZpYmqqX203S7Uf49Kbpvz3RIwFBeMZYZMrzTQTl9VDcZOHaz3PZk2n5NBmWf8rO+N9f9+cuxCAXj7hHtDQE/PaINiLDDUruRpE4Ho22HvMhrp/mq0Ei/5N9VGpP9IjtdCHu3zy+VZlhYrhQvDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hacktivis.me; spf=pass smtp.mailfrom=hacktivis.me; arc=none smtp.client-ip=138.201.117.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hacktivis.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hacktivis.me
Received: 
	by cloudsdale.the-delta.net.eu.org (OpenSMTPD) with ESMTP id 99c70166
	for <linux-kernel@vger.kernel.org>;
	Wed, 14 Aug 2024 21:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=hacktivis.me; h=from:to
	:cc:date:message-id:mime-version:content-transfer-encoding; s=
	20240308_115322; bh=F9OGsCthHMsW4TvwSn686+0hOKVxx9anVwXLY3McOwg=; b=
	MH5JUGHHgOuVd8XA2CkMYQ9N3f4S+HXwZNRBZkVKPFHQ7GaTszsQ52Llb4iywleV
	nyxb+I9c9IWJh+DOW6MOzZvajWXMdOCVfk1KLnxRPaOUHtQoSCCudzg9UxKJ6qQB
	13yqbLFpPwkahT+0Bqzvi9X98pWm2sgDZeIp+NE9SupOff7DdgNN+WGd+FqDcabD
	1sSVaQDSNCpb/69y7lZcdO4XLkEcu2Hzs+bRxR6H336Nczz78qATWU8LNpq4rpAr
	sX/ZsEVo9GUVVuUW4IZK081+2QpJ6I0913xbbd5qIj19sbz8nmGnfsZ+1i3bg+kR
	uNDOUi+nBzxznljGJceBWi/6vnfC+yNhzlALV1zG/QN4071Xklpv4ler+vzlpjdw
	zUgP8qg3spPi7MOVMVJm2Mc5ITtSG1Rh3zL2Zfnq+Pw/TmJZM+L7yY231oC7+jLS
	xyY0u2RL6uML0vgId8RpZHjuYRbTaIhY5Y29M8hsJy4lPbKmkPPPtZwBK3DCqo01
	tPmCUM3XUYmthQKx+QLuNhUwosxZ0Y8xcdhrxrDsYA08Vqno0yGuGon2/RcVfJIr
	6XKXxCaM5IgnFmanaQuN+58mtI8cbOKH0a7pL9+0vjIEn/bhBXL3cl79MZ1AiwNV
	chKYQK0jt81yMG7MhCeWSG1rSLBFu+qzeFXnHDypK+s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=hacktivis.me; h=from:to:cc
	:date:message-id:mime-version:content-transfer-encoding; q=dns;
	 s=20240308_115322; b=AVI/cz+lPIsH0eA0ojqEv0czhQ0VNnr4/joaoO+Uz3
	NXdyLenXzS7kDhIJloFzxzD5u2XF7cQSN7ibl99GfGNVa+o8pr5VO32OPXcobPSC
	qESpV9oilgbezWqpsixIUaOB8et8l71F+JlK/6sGXVZ8zSifDcpNgm5Qa4Nj6saj
	MXCDEKYsTwPwLacWWgcaJrENYZj7IfRKSONaKFqEvo7gH30JxVIoq6cLXT+jsosy
	hpTDdCVi8/YTsUGhCAvhH7awEbNcSoQcFmbOOjQdaC3ccYu1OmNS76YQDcT6zdZu
	1TlIu696+0OK28QcIrhyM+pJSofE2hndih6bI0rh8O+VajlGs3yVaBJbexVPryRh
	vtvMKlrxcXCwXeWB3siPjKsBx+MgJy8alpWpZuYG3hRqfIpviea4nTLo2C/nki9y
	aHZNl0hJFMM4RFwqK8OaMi8NgFAK8Gue0kKWsuOgpXfZAois8jcnDJB9gXN8XpH2
	uBUTQiNMdWBeduCwBr8IPECJIVHe9/ncsAm6j42UnfSSRcogJBxPCBv9nvH3BOrN
	GcHVBkE4SYBIUtEE2yaSCGkawfLVNGVP5Vao0DvU+nXztNZo0OUjBqdJpo72Ic0G
	rs4aH5GNAfxOIG6YZxNP9N6o4Oes142SfgDChP2CxZNWsE5dmaXUwACN6pRFst28
	g=
Authentication-Results: cloudsdale.lanodan.eu;
	dkim=none;
	dmarc=pass (policy=none) header.from=hacktivis.me;
	spf=pass (cloudsdale.lanodan.eu: domain of contact@hacktivis.me designates 82.64.66.195 as permitted sender) smtp.mailfrom=contact@hacktivis.me
Received: from minion.the-delta.net.eu.org (minion.the-delta.net.eu.org [82.64.66.195])
	by cloudsdale.lanodan.eu (OpenSMTPD) with ESMTPS id 438c9490 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Aug 2024 21:49:43 +0000 (UTC)
Received: from localhost (NightmareMoon.the-delta.net.eu.org [local])
	by NightmareMoon.the-delta.net.eu.org (OpenSMTPD) with ESMTPA id be0ae07b;
	Wed, 14 Aug 2024 21:49:43 +0000 (UTC)
From: "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>
To: linux-kernel@vger.kernel.org
Cc: "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>
Subject: [PATCH] subcmd: pass -m as first argument to install
Date: Wed, 14 Aug 2024 23:49:41 +0200
Message-ID: <20240814214942.15590-1-contact@hacktivis.me>
X-Mailer: git-send-email 2.44.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Otherwise it gets parsed as a file when a non-GNU getopt(3) is used.

Signed-off-by: Haelwenn (lanodan) Monnier <contact@hacktivis.me>
---
 tools/lib/subcmd/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/subcmd/Makefile b/tools/lib/subcmd/Makefile
index b87213263..138bfdf05 100644
--- a/tools/lib/subcmd/Makefile
+++ b/tools/lib/subcmd/Makefile
@@ -92,7 +92,7 @@ define do_install
 	if [ ! -d '$2' ]; then             \
 		$(INSTALL) -d -m 755 '$2'; \
 	fi;                                             \
-	$(INSTALL) $1 $(if $3,-m $3,) '$2'
+	$(INSTALL) $(if $3,-m $3,) $1 '$2'
 endef
 
 install_lib: $(LIBFILE)
-- 
2.44.2


