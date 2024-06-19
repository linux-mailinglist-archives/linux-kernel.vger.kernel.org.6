Return-Path: <linux-kernel+bounces-220550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D28B90E38E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 08:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BCEA1F24AFE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 06:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA1F1E529;
	Wed, 19 Jun 2024 06:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=habana.ai header.i=@habana.ai header.b="GOSAHsTl"
Received: from mail02.habana.ai (habanamailrelay02.habana.ai [62.90.112.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4D56F2FA
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 06:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.90.112.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718778901; cv=none; b=ihLBSR4b9GB2zXjk7mVLqLW7LIjm4nhlZGwei36ZBqr/Gex3o7x/A8q930n7sig2bdZPgZqnFnCmYz7zUxRlfay0HA93k4TUV7qGWR2xlVFn3v9azDXgNS4M55aij/mNR0pp+0ZHvEsblJuHc2huMXBUcx3fYUsi6tCgajN+1EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718778901; c=relaxed/simple;
	bh=qoJqzIBgnbAnMYwE3UnTc3QEPRz4TplW8Gl8EJKReTI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BJf61xU2ShYsz2X6NzVnZyA0xYWC1zAFPpvhUnrFgjPwRs6bVB39HTV7k91kYCrU+7ndZ75goJH4s8nXevt2XB8JuLWCgPXJCV25rDjwfvzZdhiw8se5VrTXTBuh26iUKWhQj6JxHy3Ku773nBeTFzhihwIOEiExoFNnzhUbBr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=habana.ai; spf=pass smtp.mailfrom=habana.ai; dkim=pass (2048-bit key) header.d=habana.ai header.i=@habana.ai header.b=GOSAHsTl; arc=none smtp.client-ip=62.90.112.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=habana.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=habana.ai
Received: internal info suppressed
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=habana.ai; s=default;
	t=1718778883; bh=qoJqzIBgnbAnMYwE3UnTc3QEPRz4TplW8Gl8EJKReTI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GOSAHsTldYDQFBKElaoR0Xea8jsPwQPLlhtutY7IxGZsYVZD68Xin63t6iRPy3yGQ
	 lNXk/3SRC/iEL2CG22n212fyuFOLROYJEfHS7fhOdAbcNKRFy4BiEGptbwBeREEEt9
	 c0MQVxTG2hA+d/uo7hWbqAFdjNn2bHeTXK9NEuAUUFsx48jFPSLw+P5y7yJjpBULXU
	 oE/++HFSwLH5GOmJmiFD1sYl2lRA7ycx0brHFnI/FwZnC3hBwTUsRok28Ocl4mhNE5
	 CKsyPmvyi+IPnTZL7v//UcQ3qmHzg2/0iBGfZqK3YXCGf+oIZB7DtmJtubzU22pl+1
	 l+uYu2nzA6nfA==
Received: from obitton-vm-u22.habana-labs.com (localhost [127.0.0.1])
	by obitton-vm-u22.habana-labs.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id 45J6YQB21377354;
	Wed, 19 Jun 2024 09:34:31 +0300
From: Ofir Bitton <obitton@habana.ai>
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Oded Gabbay <ogabbay@kernel.org>, Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH 2/9] MAINTAINERS: Change habanalabs maintainer and git repo path
Date: Wed, 19 Jun 2024 09:34:18 +0300
Message-Id: <20240619063425.1377327-2-obitton@habana.ai>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240619063425.1377327-1-obitton@habana.ai>
References: <20240619063425.1377327-1-obitton@habana.ai>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Oded Gabbay <ogabbay@kernel.org>

Because I left habana, Ofir Bitton is now the habanalabs driver
maintainer.

The git repo also changed location to the Habana GitHub website.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d7cfe9895a44..0f645095d22f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9449,11 +9449,11 @@ S:	Maintained
 F:	block/partitions/efi.*
 
 HABANALABS PCI DRIVER
-M:	Oded Gabbay <ogabbay@kernel.org>
+M:	Ofir Bitton <obitton@habana.ai>
 L:	dri-devel@lists.freedesktop.org
 S:	Supported
 C:	irc://irc.oftc.net/dri-devel
-T:	git https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git
+T:	git https://github.com/HabanaAI/drivers.accel.habanalabs.kernel.git
 F:	Documentation/ABI/testing/debugfs-driver-habanalabs
 F:	Documentation/ABI/testing/sysfs-driver-habanalabs
 F:	drivers/accel/habanalabs/
-- 
2.34.1


