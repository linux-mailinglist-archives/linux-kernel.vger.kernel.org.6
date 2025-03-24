Return-Path: <linux-kernel+bounces-574145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B252FA6E13A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 18:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F8EF3B7680
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 17:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2218267B7F;
	Mon, 24 Mar 2025 17:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fW3Iej4G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA164268C6F;
	Mon, 24 Mar 2025 17:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742837608; cv=none; b=Tew1xdAetiMBZFkAHA2EP1XItq+x4k9BaVDIf5jWi30si7h8lpdJkJCVzTt6qaNaBBlw9rJpnk1lsT63hMZiGjIjEbWDAvvapb7MAyTgtHH4CxBk8JPKVezcF0EtyC77OPQdi4FpYpXqEXIUjUG30jrnd35MOjDZxB1rLzUtrMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742837608; c=relaxed/simple;
	bh=DUICbtNd4moyLWNgcOAKqia2Yzzt9DHdF5xhFC0LsPQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gtj7SAStrZbgPRApaNe+AjIGhkKKcdsx0qIA6jnYhnGbvVNqmV7TF3SINkGsSl3Us0bwZMpx5opBJC6UffxqzNSrMC6p1zxDZi84X0HtZ79M6vatCF7/KFy3CMa/ES5qz1Lwk4HOt52XdYUDjxgU2fAL2/G3ygKt77s9cDclLLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fW3Iej4G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 185CDC4CEEA;
	Mon, 24 Mar 2025 17:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742837607;
	bh=DUICbtNd4moyLWNgcOAKqia2Yzzt9DHdF5xhFC0LsPQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fW3Iej4GOZny+kGNyDUKrnsytFeZlGXSkWOoFCLUWGBEBBYedcakA+1VkzaVMWvdj
	 tQXfPtQZR5+NuB/stBouAEosQl5CBnacmcw1hYSwrgOlI0VEzmNoDmEaY9Y3e7Sny9
	 joXGBP3EoaW2tTXSs6lce0wbutlfq5HbPeqe4tsXQqca3byZJlax0PxbKeFFhQttLB
	 efrpQHyZnQBSjQbkZkPFjXonjWApDxlpyaBQNDBdmkdPNlXJa0bExaCKGclhj1bS+P
	 xe2/Klv18WY/jHrxvQFzu41gAb39dYcU9AXqiQuoDx1wBBKOPcYocuDHe7Y2Rdx49n
	 pBoIH78vfgYtw==
From: Arnd Bergmann <arnd@kernel.org>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-next@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	xen-devel@lists.xenproject.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 05/10] xenbus: add module description
Date: Mon, 24 Mar 2025 18:32:30 +0100
Message-Id: <20250324173242.1501003-5-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250324173242.1501003-1-arnd@kernel.org>
References: <20250324173242.1501003-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Modules without a description now cause a warning:

WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/xen/xenbus/xenbus_probe_frontend.o

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/xen/xenbus/xenbus_probe_frontend.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/xen/xenbus/xenbus_probe_frontend.c b/drivers/xen/xenbus/xenbus_probe_frontend.c
index fcb335bb7b18..8b75f8234baf 100644
--- a/drivers/xen/xenbus/xenbus_probe_frontend.c
+++ b/drivers/xen/xenbus/xenbus_probe_frontend.c
@@ -513,4 +513,5 @@ static int __init boot_wait_for_devices(void)
 late_initcall(boot_wait_for_devices);
 #endif
 
+MODULE_DESCRIPTION("Frontend for Xen bus probe");
 MODULE_LICENSE("GPL");
-- 
2.39.5


