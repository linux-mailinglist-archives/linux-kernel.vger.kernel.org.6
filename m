Return-Path: <linux-kernel+bounces-269366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83761943213
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 16:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A415B20F21
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 14:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B0C1BBBC1;
	Wed, 31 Jul 2024 14:34:48 +0000 (UTC)
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA13D1B14FF
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 14:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722436487; cv=none; b=Wrjz4Ngcpn9HjbUfdyrG7U1/o3Luo90FkKy7y7R4fcFT+lvCFOM2fGzb2arwHRSjzEVAcDAHdIDS7d+4+8LQBsJmnWgZyZAQuFLBCwAOLQuwAOmUkYLA4JbwTC1RrlWK3kXU0Usi6tnvj4clXHlZ7g4HC3qGPF3bPPW2+y2U820=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722436487; c=relaxed/simple;
	bh=WkvxrXPefTtG5XQXwsJM0bzYPLImtaxazIwI1lyCocI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OC7kz4JrHsCwRAUyPQ9yEtyoI0cbQtJzLVkqwklXNM2I0M9AMoaUivSHsUUULjMmpw6xU5nAYCoopGiJKUPGjt5+bVo/6dFLa4UWYKvgKF/YvY7q6K9j1VktEstz6o2rkuSkEpqrhmUQyaxdEUB8iBIUHE4TO2vQtwcTMI0Cc20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
X-QQ-mid: bizesmtpsz12t1722436369tdub3n
X-QQ-Originating-IP: nlDW+JflpgvVOoz5Cpa3YnzZo+s9nlaZD/t8jyQyPA0=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 31 Jul 2024 22:32:47 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 15301098886600835381
From: WangYuli <wangyuli@uniontech.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	sashal@kernel.org,
	dominique.martinet@atmark-techno.com,
	tsbogend@alpha.franken.de
Cc: leesongyang@outlook.com,
	bhelgaas@google.com,
	rdunlap@infradead.org,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	guanwentao@uniontech.com,
	WangYuli <wangyuli@uniontech.com>
Subject: [PATCH 4.19+] MIPS: Octeron: remove source file executable bit
Date: Wed, 31 Jul 2024 22:32:45 +0800
Message-ID: <1F49853AED366C76+20240731143245.204547-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.43.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1

From: Dominique Martinet <dominique.martinet@atmark-techno.com>

commit 89c7f5078935872cf47a713a645affb5037be694 upstream

This does not matter the least, but there is no other .[ch] file in the
repo that is executable, so clean this up.

Fixes: 29b83a64df3b ("MIPS: Octeon: Add PCIe link status check")
Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 arch/mips/pci/pcie-octeon.c | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 mode change 100755 => 100644 arch/mips/pci/pcie-octeon.c

diff --git a/arch/mips/pci/pcie-octeon.c b/arch/mips/pci/pcie-octeon.c
old mode 100755
new mode 100644
-- 
2.43.4


