Return-Path: <linux-kernel+bounces-243175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBF09292BD
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 13:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02B791F22507
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 11:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E89A12B143;
	Sat,  6 Jul 2024 11:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="M6NaJutp"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CD6757EA
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 11:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720264453; cv=none; b=vBWASXfK2WwBaKyGlAf3WAvYe6HHkrO7bVQcY5Mb71qYzMr/HlBSnp8HU30MlEbSjUzvhz56kceT8NR5sfOqFG8JetVU/MXIat8KwHO2MODuKhArzyeIz2oqv7B+w9pl+N059jrjj8x6ZAoIF6PMvDSnHozDVOPHZjAkm1gweHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720264453; c=relaxed/simple;
	bh=7oUfmIlyICsEhSeVttn1V0qSlweLMe1SSx1p/tQIYes=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gsbTOCT9Sw6eHerANyrFiqI16E1n8JXbBpfQAyfEmohxTqO+hO6dXY/LXW0XefE46bBzT7HLKUhcAAsCkbCpNyU9hy3F3oC4IDQMiUe8ic/vVPPyZfygVmZ64uNW6bWvew5OyJnXuPrpltZ3Ztg7LjnFBy1A5O+kM8FjXXjcxRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=M6NaJutp; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1720264448;
	bh=7oUfmIlyICsEhSeVttn1V0qSlweLMe1SSx1p/tQIYes=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=M6NaJutpomXvOQehpsflCrtc47Ye4kMiv09V8SrFTRYJC1QZwEpuPxtgCdlDgdiYm
	 A0JOYw4O5IKU2pqRUqqUiDa1Bo1KNgP1CtA6ugikAQS3CcNLqqdFFS1ahTCayPMsyn
	 5IppmWjOtNNIcbWEt/EIg3yBGrEC9Nf9f9VgazRA=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 06 Jul 2024 13:13:41 +0200
Subject: [PATCH 1/2] const_structs.checkpatch: add regmap structs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240706-regmap-const-structs-v1-1-d08c776da787@weissschuh.net>
References: <20240706-regmap-const-structs-v1-0-d08c776da787@weissschuh.net>
In-Reply-To: <20240706-regmap-const-structs-v1-0-d08c776da787@weissschuh.net>
To: Mark Brown <broonie@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720264447; l=811;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=7oUfmIlyICsEhSeVttn1V0qSlweLMe1SSx1p/tQIYes=;
 b=1OxMOvwWFc/WJoOmU4oemey64SxfiEP+l3Pupab9Yl27MC577eHtawnDwlMsXPxVnFLfiC1RY
 w8bmtJgnF4/Ar5YGyQmTFEjnTpxoD37moygoT3EArQQfHkNNYwFojxR
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Many structs used by regmap should be const by default.
Add entries to const_structs.checkpatch for them for checkpatch.pl to
warn on new non-const additions.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 scripts/const_structs.checkpatch | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/scripts/const_structs.checkpatch b/scripts/const_structs.checkpatch
index 52e5bfb61fd0..1bfbb3d7f2e0 100644
--- a/scripts/const_structs.checkpatch
+++ b/scripts/const_structs.checkpatch
@@ -64,7 +64,16 @@ platform_suspend_ops
 proc_ops
 proto_ops
 pwm_ops
+reg_default
+reg_field
+reg_sequence
 regmap_access_table
+regmap_bus
+regmap_config
+regmap_irq
+regmap_irq_chip
+regmap_range
+regmap_range_cfg
 regulator_ops
 reset_control_ops
 rpc_pipe_ops

-- 
2.45.2


