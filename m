Return-Path: <linux-kernel+bounces-190414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6636F8CFDFC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 12:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BDB02837BF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 10:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2277313AD2F;
	Mon, 27 May 2024 10:19:26 +0000 (UTC)
Received: from riemann.telenet-ops.be (riemann.telenet-ops.be [195.130.137.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CAEE572
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 10:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716805165; cv=none; b=tD8Uon9pvjqxNg9IaJh4Gygz2lazIWgOTH1xGttFIiNAwhEdJAcwbgZSC1Q5tDVtHeZpar/dOEmflbElxu3zLgwNK513O+Vggnbow7QiKPgeQaxufLbgGVwPCS9pRTX+Gk/zuxnOVcc5tOU5REz97f3pGwoKRtFRr9gPuQgfMjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716805165; c=relaxed/simple;
	bh=ONllOLvG5TdTKG+wmgO7VsjWhkbq6hAn63ZtVkMqjvg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=po0vo2FBsDircUE5lYRS3SxN+Uc/0bGIyjYxyiuE4Y5V/GJCnaXgPG9uhv8EBAATf8tQTFUeZbVhsGjUvibEunEUb4ein8h2nnOHXfw/J/xbJ08PyZhFwnQBI/MCdfGOsbC2uSXZKm9R1nQ7zE1VbXGED7HbNWc47vC3LIasbUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
	by riemann.telenet-ops.be (Postfix) with ESMTPS id 4Vns7r6Y0zz4x06Z
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 12:19:20 +0200 (CEST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:c993:5573:f894:7353])
	by xavier.telenet-ops.be with bizsmtp
	id UAKD2C0052nC7mg01AKDky; Mon, 27 May 2024 12:19:13 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sBXQl-00CNbS-8X;
	Mon, 27 May 2024 12:19:13 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sBXRg-003fnk-Ve;
	Mon, 27 May 2024 12:19:13 +0200
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: linux-m68k@lists.linux-m68k.org
Cc: linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] m68k: defconfig: Update defconfigs for v6.10-rc1
Date: Mon, 27 May 2024 12:19:11 +0200
Message-Id: <442176a8cd763e366ab9199b297919486c7f75f4.1716805119.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

  - Enable modular build of the new Packet Forwarding Control Protocol
    (PFCP).

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
To be queued in the m68k for-v6.11 branch.
---
 arch/m68k/configs/amiga_defconfig    | 1 +
 arch/m68k/configs/apollo_defconfig   | 1 +
 arch/m68k/configs/atari_defconfig    | 1 +
 arch/m68k/configs/bvme6000_defconfig | 1 +
 arch/m68k/configs/hp300_defconfig    | 1 +
 arch/m68k/configs/mac_defconfig      | 1 +
 arch/m68k/configs/multi_defconfig    | 1 +
 arch/m68k/configs/mvme147_defconfig  | 1 +
 arch/m68k/configs/mvme16x_defconfig  | 1 +
 arch/m68k/configs/q40_defconfig      | 1 +
 arch/m68k/configs/sun3_defconfig     | 1 +
 arch/m68k/configs/sun3x_defconfig    | 1 +
 12 files changed, 12 insertions(+)

diff --git a/arch/m68k/configs/amiga_defconfig b/arch/m68k/configs/amiga_defconfig
index 6bb202d03d340ae0..9a084943a68a4bbf 100644
--- a/arch/m68k/configs/amiga_defconfig
+++ b/arch/m68k/configs/amiga_defconfig
@@ -373,6 +373,7 @@ CONFIG_VXLAN=m
 CONFIG_GENEVE=m
 CONFIG_BAREUDP=m
 CONFIG_GTP=m
+CONFIG_PFCP=m
 CONFIG_MACSEC=m
 CONFIG_NETCONSOLE=m
 CONFIG_NETCONSOLE_DYNAMIC=y
diff --git a/arch/m68k/configs/apollo_defconfig b/arch/m68k/configs/apollo_defconfig
index 3598e0cc66b0ee23..58ec725bf392f140 100644
--- a/arch/m68k/configs/apollo_defconfig
+++ b/arch/m68k/configs/apollo_defconfig
@@ -353,6 +353,7 @@ CONFIG_VXLAN=m
 CONFIG_GENEVE=m
 CONFIG_BAREUDP=m
 CONFIG_GTP=m
+CONFIG_PFCP=m
 CONFIG_MACSEC=m
 CONFIG_NETCONSOLE=m
 CONFIG_NETCONSOLE_DYNAMIC=y
diff --git a/arch/m68k/configs/atari_defconfig b/arch/m68k/configs/atari_defconfig
index f9010433613f3896..9b4784b9c873cdfc 100644
--- a/arch/m68k/configs/atari_defconfig
+++ b/arch/m68k/configs/atari_defconfig
@@ -368,6 +368,7 @@ CONFIG_VXLAN=m
 CONFIG_GENEVE=m
 CONFIG_BAREUDP=m
 CONFIG_GTP=m
+CONFIG_PFCP=m
 CONFIG_MACSEC=m
 CONFIG_NETCONSOLE=m
 CONFIG_NETCONSOLE_DYNAMIC=y
diff --git a/arch/m68k/configs/bvme6000_defconfig b/arch/m68k/configs/bvme6000_defconfig
index 9a2b0c7871cec73f..ca40744eec60000a 100644
--- a/arch/m68k/configs/bvme6000_defconfig
+++ b/arch/m68k/configs/bvme6000_defconfig
@@ -351,6 +351,7 @@ CONFIG_VXLAN=m
 CONFIG_GENEVE=m
 CONFIG_BAREUDP=m
 CONFIG_GTP=m
+CONFIG_PFCP=m
 CONFIG_MACSEC=m
 CONFIG_NETCONSOLE=m
 CONFIG_NETCONSOLE_DYNAMIC=y
diff --git a/arch/m68k/configs/hp300_defconfig b/arch/m68k/configs/hp300_defconfig
index 2408785e0e48909b..77bcc6faf468cdbf 100644
--- a/arch/m68k/configs/hp300_defconfig
+++ b/arch/m68k/configs/hp300_defconfig
@@ -352,6 +352,7 @@ CONFIG_VXLAN=m
 CONFIG_GENEVE=m
 CONFIG_BAREUDP=m
 CONFIG_GTP=m
+CONFIG_PFCP=m
 CONFIG_MACSEC=m
 CONFIG_NETCONSOLE=m
 CONFIG_NETCONSOLE_DYNAMIC=y
diff --git a/arch/m68k/configs/mac_defconfig b/arch/m68k/configs/mac_defconfig
index 6789d03b7b528fa4..e73d4032b659197a 100644
--- a/arch/m68k/configs/mac_defconfig
+++ b/arch/m68k/configs/mac_defconfig
@@ -364,6 +364,7 @@ CONFIG_VXLAN=m
 CONFIG_GENEVE=m
 CONFIG_BAREUDP=m
 CONFIG_GTP=m
+CONFIG_PFCP=m
 CONFIG_MACSEC=m
 CONFIG_NETCONSOLE=m
 CONFIG_NETCONSOLE_DYNAMIC=y
diff --git a/arch/m68k/configs/multi_defconfig b/arch/m68k/configs/multi_defconfig
index b57af39db3b4cb89..638df8442c988637 100644
--- a/arch/m68k/configs/multi_defconfig
+++ b/arch/m68k/configs/multi_defconfig
@@ -407,6 +407,7 @@ CONFIG_VXLAN=m
 CONFIG_GENEVE=m
 CONFIG_BAREUDP=m
 CONFIG_GTP=m
+CONFIG_PFCP=m
 CONFIG_MACSEC=m
 CONFIG_NETCONSOLE=m
 CONFIG_NETCONSOLE_DYNAMIC=y
diff --git a/arch/m68k/configs/mvme147_defconfig b/arch/m68k/configs/mvme147_defconfig
index 29b70f27aedd4caa..2248db4260816b5b 100644
--- a/arch/m68k/configs/mvme147_defconfig
+++ b/arch/m68k/configs/mvme147_defconfig
@@ -350,6 +350,7 @@ CONFIG_VXLAN=m
 CONFIG_GENEVE=m
 CONFIG_BAREUDP=m
 CONFIG_GTP=m
+CONFIG_PFCP=m
 CONFIG_MACSEC=m
 CONFIG_NETCONSOLE=m
 CONFIG_NETCONSOLE_DYNAMIC=y
diff --git a/arch/m68k/configs/mvme16x_defconfig b/arch/m68k/configs/mvme16x_defconfig
index 757c582ffe84fbb1..2975b66521f6e3e9 100644
--- a/arch/m68k/configs/mvme16x_defconfig
+++ b/arch/m68k/configs/mvme16x_defconfig
@@ -351,6 +351,7 @@ CONFIG_VXLAN=m
 CONFIG_GENEVE=m
 CONFIG_BAREUDP=m
 CONFIG_GTP=m
+CONFIG_PFCP=m
 CONFIG_MACSEC=m
 CONFIG_NETCONSOLE=m
 CONFIG_NETCONSOLE_DYNAMIC=y
diff --git a/arch/m68k/configs/q40_defconfig b/arch/m68k/configs/q40_defconfig
index f15d1009108a3459..0a0e32344033bffb 100644
--- a/arch/m68k/configs/q40_defconfig
+++ b/arch/m68k/configs/q40_defconfig
@@ -357,6 +357,7 @@ CONFIG_VXLAN=m
 CONFIG_GENEVE=m
 CONFIG_BAREUDP=m
 CONFIG_GTP=m
+CONFIG_PFCP=m
 CONFIG_MACSEC=m
 CONFIG_NETCONSOLE=m
 CONFIG_NETCONSOLE_DYNAMIC=y
diff --git a/arch/m68k/configs/sun3_defconfig b/arch/m68k/configs/sun3_defconfig
index 5218c1e614b5a51e..f16f1a99c2badb70 100644
--- a/arch/m68k/configs/sun3_defconfig
+++ b/arch/m68k/configs/sun3_defconfig
@@ -347,6 +347,7 @@ CONFIG_VXLAN=m
 CONFIG_GENEVE=m
 CONFIG_BAREUDP=m
 CONFIG_GTP=m
+CONFIG_PFCP=m
 CONFIG_MACSEC=m
 CONFIG_NETCONSOLE=m
 CONFIG_NETCONSOLE_DYNAMIC=y
diff --git a/arch/m68k/configs/sun3x_defconfig b/arch/m68k/configs/sun3x_defconfig
index acdf4eb7af2872e3..667bd61ae9b39537 100644
--- a/arch/m68k/configs/sun3x_defconfig
+++ b/arch/m68k/configs/sun3x_defconfig
@@ -348,6 +348,7 @@ CONFIG_VXLAN=m
 CONFIG_GENEVE=m
 CONFIG_BAREUDP=m
 CONFIG_GTP=m
+CONFIG_PFCP=m
 CONFIG_MACSEC=m
 CONFIG_NETCONSOLE=m
 CONFIG_NETCONSOLE_DYNAMIC=y
-- 
2.34.1


