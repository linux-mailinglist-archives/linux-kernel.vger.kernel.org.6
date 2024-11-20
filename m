Return-Path: <linux-kernel+bounces-416382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DE39D4400
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 23:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FCE41F22A0A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 22:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93A81BDA80;
	Wed, 20 Nov 2024 22:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=nerdbynature.de header.i=@nerdbynature.de header.b="XERx9oDw";
	dkim=permerror (0-bit key) header.d=nerdbynature.de header.i=@nerdbynature.de header.b="4NdoRxLl";
	dkim=pass (2048-bit key) header.d=nerdbynature.de header.i=@nerdbynature.de header.b="X1DOf1+Q"
Received: from trent.utfs.org (trent.utfs.org [94.185.90.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CF01BD9F1
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 22:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.185.90.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732142388; cv=none; b=ZdxL+47oJoZl1T3H5bou9PPqRM4U0tQp4MVwolJlU1zVx5D8+3Dia8O3pWWgMXig/HAX1h9L/vXT8cA9UmTMxhn5DHT+WVlkV7sM9eI9Rf1eFI/LPow0mU1rFCGr3r11W37miumk/j1zwc/S1tXP0Fna64LFD0+C2CBlvlWcojI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732142388; c=relaxed/simple;
	bh=4Fb48p7sNTcJp/KinmFYSONXA39+Z+qHelvsOfFzLYg=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=ncQrXHLfThfzGKjgja+m6nz4r7IlWoTbVTiVbzV9D96CXSE3zA3ypfuc9tQKmT8uWXgousW69pmMhmeco7/Cq7HKRWSycOj3fv/ClDHBEfcvGvw9jkACm8CfU32s30XQr6BMi4ftpCkRR6hvNwr7lczGhYiDJXlln092PH5ty0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nerdbynature.de; spf=pass smtp.mailfrom=nerdbynature.de; dkim=permerror (0-bit key) header.d=nerdbynature.de header.i=@nerdbynature.de header.b=XERx9oDw; dkim=permerror (0-bit key) header.d=nerdbynature.de header.i=@nerdbynature.de header.b=4NdoRxLl; dkim=pass (2048-bit key) header.d=nerdbynature.de header.i=@nerdbynature.de header.b=X1DOf1+Q; arc=none smtp.client-ip=94.185.90.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nerdbynature.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nerdbynature.de
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple;
 d=nerdbynature.de; i=@nerdbynature.de; q=dns/txt; s=key1;
 t=1732141908; h=date : from : to : cc : subject : message-id :
 mime-version : content-type : from;
 bh=4Fb48p7sNTcJp/KinmFYSONXA39+Z+qHelvsOfFzLYg=;
 b=XERx9oDwIYGL9/ZdFUQPKsVdyXwCVSG9Fu/SBvq68b1YYrJgEmExd6q4p+zw9rqsfa6jw
 gh+qQVxskVGUzw/Dw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=nerdbynature.de;
	s=dkim; t=1732141908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=Yt+ssbzSDnfOC5r8ngOzdIASr+ertzByXTP/emHNFYA=;
	b=4NdoRxLlOJ6P+P7AO3qaRId2GcjYG1I1qWQwKZN3bA5suG2Rsma+fy1bJK6qVSwA5w8Krp
	BAsJt9h0T73/VpBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nerdbynature.de;
 i=@nerdbynature.de; q=dns/txt; s=key0; t=1732141908; h=date : from :
 to : cc : subject : message-id : mime-version : content-type : from;
 bh=4Fb48p7sNTcJp/KinmFYSONXA39+Z+qHelvsOfFzLYg=;
 b=X1DOf1+QirNtTEeVcy+xzzjVLVuoP5T3jL3f1nwLkMRcbl9J9nqxCRR2wyzPihHnzPU9b
 g3rv/x6VJrwyBjqQzcTB+X1S3FaIehl5uerwZDwlH8ngRJuU90UcdbZlgZJSeDEGK/nAi1k
 j7agxZmrCyJBtvHYTMUdKOFV+EPyba2Z3UYWpUi/pq+zvKy8cuZP90gR06ouR4000CcHFLk
 De4d0Y2sRE30klbwhbZh2cM+OGE6mAU3KGpdVrJ07CcgeFnvzlgoKsojMQVWQDuCbmKOC/m
 T2IelkCz0YajPG0byxUcx8ik36m63R6RjHebLnJWsg+6euZp7WuHFMEmgdKQ==
Received: from localhost (localhost [IPv6:::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by trent.utfs.org (Postfix) with ESMTPS id 38D3E5F957;
	Wed, 20 Nov 2024 23:31:48 +0100 (CET)
Date: Wed, 20 Nov 2024 23:31:48 +0100 (CET)
From: Christian Kujau <lists@nerdbynature.de>
To: Hans de Goede <hdegoede@redhat.com>, Arnd Bergmann <arnd@arndb.de>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH] arm64 support for vboxguest
Message-ID: <f088e1da-8fae-2acb-6f7a-e414708d8e67@nerdbynature.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

Hello,

now that VirtualBox able to run as a host on arm64 (e.g. the Apple M3 
processors) I was wondering if there are any plans to port the vboxguest 
driver to that platform? I added ARM64 to the Kconfig files (see below) on 
vboxguest and vboxsf, and also for vboxvideo, and it compiled just like 
that and at least vboxsf appears to work just fine.

I don't know how to test vboxvideo yet (the module loads just fine), but 
if we at least enable to option in the Kconfig file at least people would 
be able to test it :-)

Comments?

Thanks,
Christian.

Signed-off-by: Christian Kujau <lists@nerdbynature.de>

diff --git a/drivers/gpu/drm/vboxvideo/Kconfig b/drivers/gpu/drm/vboxvideo/Kconfig
index 45fe135d6e43..a68708da3853 100644
--- a/drivers/gpu/drm/vboxvideo/Kconfig
+++ b/drivers/gpu/drm/vboxvideo/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 config DRM_VBOXVIDEO
 	tristate "Virtual Box Graphics Card"
-	depends on DRM && X86 && PCI
+	depends on DRM && (ARM64 || X86) && PCI
 	select DRM_KMS_HELPER
 	select DRM_VRAM_HELPER
 	select DRM_TTM
diff --git a/drivers/virt/vboxguest/Kconfig b/drivers/virt/vboxguest/Kconfig
index cc329887bfae..11b153e7454e 100644
--- a/drivers/virt/vboxguest/Kconfig
+++ b/drivers/virt/vboxguest/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config VBOXGUEST
 	tristate "Virtual Box Guest integration support"
-	depends on X86 && PCI && INPUT
+	depends on (ARM64 || X86) && PCI && INPUT
 	help
 	  This is a driver for the Virtual Box Guest PCI device used in
 	  Virtual Box virtual machines. Enabling this driver will add
diff --git a/fs/vboxsf/Kconfig b/fs/vboxsf/Kconfig
index b84586ae08b3..d4694026db8b 100644
--- a/fs/vboxsf/Kconfig
+++ b/fs/vboxsf/Kconfig
@@ -1,6 +1,6 @@
 config VBOXSF_FS
 	tristate "VirtualBox guest shared folder (vboxsf) support"
-	depends on X86 && VBOXGUEST
+	depends on (ARM64 || X86) && VBOXGUEST
 	select NLS
 	help
 	  VirtualBox hosts can share folders with guests, this driver
-- 
BOFH excuse #326:

We need a licensed electrician to replace the light bulbs in the computer room.

