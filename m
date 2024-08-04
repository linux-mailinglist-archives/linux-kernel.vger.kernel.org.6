Return-Path: <linux-kernel+bounces-273695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F33946C90
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 07:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6753AB2190E
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 05:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66648AD59;
	Sun,  4 Aug 2024 05:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b="Q+7qsEz1"
Received: from ixit.cz (ip-89-177-23-149.bb.vodafone.cz [89.177.23.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD21EDB
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 05:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.177.23.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722750934; cv=none; b=fTmRlig287CClQpIoika4F1lqMGCj++fiiL8l0DecxPeTj3VpCdl2v5jh6RsoSGce6TbE3aDgNDCQujkGqhTVvohoRvoCZGCPO40ncnstqPND9A4E0ICOvBBRMU5gVVBUPr12eBUXRiO9evMREQrmwrzoPx+wsWTbajlXIsriqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722750934; c=relaxed/simple;
	bh=LaUr5jmpNkxM0+0xOl+MvnDjjvsWKy+9sfb+ovhI1tM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gUoW5olmo6wfldg/Bkj5+IRSBbny11jfzf/pY3HwacUeFIKfvsh2QCQvu2ywluXdATFJi1Jb5g35plHt/LE+ZG7U17PPw/MSkm3qod1Ly9UngnUWsIW5wupnzM0X1QrSFXrXbPdoXdKCmV7CzrLAJsn+BpRchAGxpPsDi0rrzTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ixit.cz; spf=pass smtp.mailfrom=ixit.cz; dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b=Q+7qsEz1; arc=none smtp.client-ip=89.177.23.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ixit.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ixit.cz
Received: from newone.debconf24.debconf.org (unknown [116.89.172.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ixit.cz (Postfix) with ESMTPSA id D92A61655D4;
	Sun,  4 Aug 2024 07:47:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
	t=1722750435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YG3PozLdEKpr64Bofty37AWfM8NSumKRFyU1RGZLSDE=;
	b=Q+7qsEz1PWi3XMk3CR04o3de/fO8FKU3+5XkPKmpew9PCzuorcVRVg+XDjB0jv05/HCKCV
	r8wDM6vUtqBUj2bSKHjmUYF5R6kDthENv36swaQ6zT87M/5h+iiJk/yqJCVMaa+nn1ghvs
	fq8l6we8lxXXLiojoqgJAKOZE4QxTqk=
From: David Heidelberg <david@ixit.cz>
To: linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Jiri Kosina <jikos@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: David Heidelberg <david@ixit.cz>
Subject: [PATCH] mailmap: update entry for David Heidelberg
Date: Sun,  4 Aug 2024 14:45:54 +0900
Message-ID: <20240804054704.859503-1-david@ixit.cz>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Link my old gmail address to my active email.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git ./.mailmap ./.mailmap
index a6c619e22efc..a70b930bc93d 100644
--- ./.mailmap
+++ ./.mailmap
@@ -166,6 +166,7 @@ Daniel Borkmann <daniel@iogearbox.net> <dborkman@redhat.com>
 Daniel Borkmann <daniel@iogearbox.net> <dxchgb@gmail.com>
 David Brownell <david-b@pacbell.net>
 David Collins <quic_collinsd@quicinc.com> <collinsd@codeaurora.org>
+David Heidelberg <david@ixit.cz> <d.okias@gmail.com>
 David Rheinsberg <david@readahead.eu> <dh.herrmann@gmail.com>
 David Rheinsberg <david@readahead.eu> <dh.herrmann@googlemail.com>
 David Rheinsberg <david@readahead.eu> <david.rheinsberg@gmail.com>
-- 
2.45.2


