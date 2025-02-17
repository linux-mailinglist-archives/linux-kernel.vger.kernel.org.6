Return-Path: <linux-kernel+bounces-517691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E90A3844F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 14:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC8067A1DEC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 13:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0A72222D1;
	Mon, 17 Feb 2025 13:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZNEOQQQN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A0221CC63;
	Mon, 17 Feb 2025 13:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739798054; cv=none; b=g74rUHhxv7Kss244l66wl5eGFqIhajsPJ8C+AcnjHfPNkraDZjZTLJ8ZtNf7WFrOka7d9H/8bN7sz2oS1KZ4+JCYRDx9s4SNHzFWhaIlIyeBPXCLZ72TC4QEjAJ2phg72KBNnxAmP2tQbUZTEpoyLXdFji/Ve35fqJe4Ca8nTk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739798054; c=relaxed/simple;
	bh=ySqiz0pjBVTXrwnEWcMGf3+QUDYTSHcCYNOVUDsh4CA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HyulnYv1qT1TJtkbWq5sujU1lCro1DvvPS/1GKSKS4Qoo59Kmaol0WkETKnYt1DpHHk6C8I2uBhxDao1KcnY0mqDYF39E++Isd4bGfY3k1BZgsGGBpr/GI5AE4OvF77KyRayXk0OZvJDphlzmyyd/ZcmJ9GWLOv6AS+JsQ3a99Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZNEOQQQN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FF74C4CEE2;
	Mon, 17 Feb 2025 13:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739798053;
	bh=ySqiz0pjBVTXrwnEWcMGf3+QUDYTSHcCYNOVUDsh4CA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZNEOQQQN4Z94Xe+g+xxcrlNGxcPvJGgF7c2BIhXRdGEMWDQYT+XNCnN9dJrSMgKi9
	 0QzGryUCtGeygMS7sASgyjgTNCz1OwrlVSmhORJki57jxwSMlMbz1OAyYNUXQeVsjC
	 yLRLE6qCksg72TAGGfb878xfvtLpUmC4R0lgIptGDNQVhFqpNkl6NQSU51ATinprz4
	 91hY71WHL2CQmudWVxTelWNFGxJ7RwsdocHJFTbIthFQfk2irOrDikCHtk5SfjF+Fu
	 zMS5I5v9Sjj8E3r46oiutMt7/FaJa3bd5lOigRjD8zJpHqj8Oyw6p5JY5KuXVfOMGs
	 6g0Qg+fzZnRbA==
From: Arnd Bergmann <arnd@kernel.org>
To: Dave Penkler <dpenkler@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Nihar Chaithanya <niharchaithanya@gmail.com>,
	Rohit Chavan <roheetchavan@gmail.com>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] [v2] staging: gpib: comment out pnp_device_id tables
Date: Mon, 17 Feb 2025 14:13:36 +0100
Message-Id: <20250217131356.3759347-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250217131356.3759347-1-arnd@kernel.org>
References: <20250217131356.3759347-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

This variable is not referenced in either of these two drivers driver,
causing a warning when they are built-in and W=1 warnings are enabled
with gcc:

drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1507:35: error: 'tnt4882_pnp_table' defined but not used [-Werror=unused-const-variable=]
 1507 | static const struct pnp_device_id tnt4882_pnp_table[] = {
      |                                   ^~~~~~~~~~~~~~~~~
drivers/staging/gpib/hp_82341/hp_82341.c:811:35: error: 'hp_82341_pnp_table' defined but not used [-Werror=unused-const-variable=]
  811 | static const struct pnp_device_id hp_82341_pnp_table[] = {

The MODULE_DEVICE_TABLE() entry does have the effect of loading
the module when the PNP device is detected, so it is still needed
for the modular case.

Ideally the drivers should be converted to pnp_register_driver(),
which would lead to the ID table actually being used.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/staging/gpib/hp_82341/hp_82341.c    | 3 +++
 drivers/staging/gpib/tnt4882/tnt4882_gpib.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/staging/gpib/hp_82341/hp_82341.c b/drivers/staging/gpib/hp_82341/hp_82341.c
index cf5cd1edc41d..72a91228ea36 100644
--- a/drivers/staging/gpib/hp_82341/hp_82341.c
+++ b/drivers/staging/gpib/hp_82341/hp_82341.c
@@ -809,11 +809,14 @@ static void hp_82341_detach(gpib_board_t *board)
 	hp_82341_free_private(board);
 }
 
+#if 0
+/* unused, will be needed when the driver is turned into a pnp_driver */
 static const struct pnp_device_id hp_82341_pnp_table[] = {
 	{.id = "HWP1411"},
 	{.id = ""}
 };
 MODULE_DEVICE_TABLE(pnp, hp_82341_pnp_table);
+#endif
 
 static int __init hp_82341_init_module(void)
 {
diff --git a/drivers/staging/gpib/tnt4882/tnt4882_gpib.c b/drivers/staging/gpib/tnt4882/tnt4882_gpib.c
index 2e1c3cbebaca..df92e9959fe1 100644
--- a/drivers/staging/gpib/tnt4882/tnt4882_gpib.c
+++ b/drivers/staging/gpib/tnt4882/tnt4882_gpib.c
@@ -1390,11 +1390,14 @@ static struct pci_driver tnt4882_pci_driver = {
 	.probe = &tnt4882_pci_probe
 };
 
+#if 0
+/* unused, will be needed when the driver is turned into a pnp_driver */
 static const struct pnp_device_id tnt4882_pnp_table[] = {
 	{.id = "NICC601"},
 	{.id = ""}
 };
 MODULE_DEVICE_TABLE(pnp, tnt4882_pnp_table);
+#endif
 
 #ifdef GPIB_PCMCIA
 static gpib_interface_t ni_pcmcia_interface;
-- 
2.39.5


