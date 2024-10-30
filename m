Return-Path: <linux-kernel+bounces-388443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B809B5FBF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 11:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A042A1F21FE5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 10:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444E31E260C;
	Wed, 30 Oct 2024 10:10:43 +0000 (UTC)
Received: from gauss.telenet-ops.be (gauss.telenet-ops.be [195.130.132.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0300194151
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 10:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730283042; cv=none; b=frrvVlhdiFI2hly3rDAy3Zzd7DYzBcp7t3mKAujPWNC+xlWMOvcNitKNArGzAXSkMwrNscrtpsvSV/oRmYK3G4OwR2GKig6SKOEwUizyD7vM9kDCyVcdVRQDu+vguUJaczxHszpf8rUneWOmgsimsofmI/jEJub47zyaImaMleg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730283042; c=relaxed/simple;
	bh=0fmuAQK2yswMKUsQDSChND7wQl3uHaskzph+iucktoM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=u+G/E5L4Vhka23Np5aBrhJcCinX4rhYQKFUJEHYACd2mfhQq0uFf+kWD5/5DBcw6lBlmVTtJVrkptk3q8lFW83kx7TO95cGaCKSp1NFjl6EHUlmJ6CtAL6QetNtSPKf9GiWV1r/mVp6Q1E5zq/Qs2IEpt5wyC5Q8P6M9enYmwQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
	by gauss.telenet-ops.be (Postfix) with ESMTPS id 4XdjYh2L04z4x4pt
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 11:10:32 +0100 (CET)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:ceb8:3fda:3601:820f])
	by laurent.telenet-ops.be with cmsmtp
	id WaAP2D00D4BbGPD01aAPUS; Wed, 30 Oct 2024 11:10:25 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1t65eP-005zQD-1o;
	Wed, 30 Oct 2024 11:10:23 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1t65eh-006Qar-Di;
	Wed, 30 Oct 2024 11:10:23 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dave Ertman <david.m.ertman@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Leon Romanovsky <leon@kernel.org>,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	Kiran Patil <kiran.patil@intel.com>,
	Martin Habets <mhabets@solarflare.com>
Cc: linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] driver core: auxiliary bus: Spelling s/pecific/specific/
Date: Wed, 30 Oct 2024 11:10:22 +0100
Message-Id: <f232a09c377cbe11c81b4ab69d4e7bf016e746c8.1730282860.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a misspelling of the word "specific".

Fixes: 7de3697e9cbd4bd3 ("Add auxiliary bus support")
Fixes: e1b5186810cc7d4e ("Documentation/auxiliary_bus: Move the text into the code")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
The documentation was moved and reformatted, so I used two Fixes tags.
---
 drivers/base/auxiliary.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/auxiliary.c b/drivers/base/auxiliary.c
index 69b7c93613d6dc00..afa4df4c5a3f371b 100644
--- a/drivers/base/auxiliary.c
+++ b/drivers/base/auxiliary.c
@@ -92,7 +92,7 @@
  * Auxiliary devices are created and registered by a subsystem-level core
  * device that needs to break up its functionality into smaller fragments. One
  * way to extend the scope of an auxiliary_device is to encapsulate it within a
- * domain- pecific structure defined by the parent device. This structure
+ * domain-specific structure defined by the parent device. This structure
  * contains the auxiliary_device and any associated shared data/callbacks
  * needed to establish the connection with the parent.
  *
-- 
2.34.1


