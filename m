Return-Path: <linux-kernel+bounces-393431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA979BA089
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 14:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42664B20F03
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 13:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B143D18A931;
	Sat,  2 Nov 2024 13:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OXoVX7zV"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAC71E515
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 13:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730554144; cv=none; b=JRmcmTzAxS8Fxt9m3D2f1K/UgC96+675v8iy3zrNo6cqqpgzL5eYB6qbpKrDkDV2gerxC/U7dBkfuFPZbnzMjm+PvPmCqZVwDyW9dNPRCSWtRNsOJ8pm/LuPtA9jXT8PIK9L9XZZUH1XmE3tcVqcSkwxyU7snPnGtR0j0uR1/Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730554144; c=relaxed/simple;
	bh=v29yCIdmGT8NeNp+SPirbTUQLfK6haECY0VL26l0MWw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pSWGM0R2VjYdwdbssG9pVNnsUXINEL7+bawTULCBxAIKFD8LT45wHGi/LQRzzqq96xVDIp8N8RVCUxp9aCqYEG0Xeo590IhbPWqABJUJ8dJ/N5Y9af8UG02UNfTPwwisc+2yIYVJuq92GmbCkaL3C3tPvFoVPT8PXbO6Jlj4cOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OXoVX7zV; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6F8FC60002;
	Sat,  2 Nov 2024 13:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730554134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jFPxv4TFcb0xcjLdoJXvXlS5cVkkmSvweU1eSCPIPRc=;
	b=OXoVX7zVuH1FrYOS7yaAMPQqWy0GHZALHFuzYs98iw/JAYE21Nm9iJUZik7qrQ9RW98eFY
	yLnolfg8CELUrsxd6siXsawWXElztVfZDR2GNB96hoSv8IExdtzd767eugHl7Gl3kp6H/s
	gIv/Jln47dYvKZGxhQP2dx+k85FsIw+3prRATLcXmv/+HaHh+tMA9Pipt13HA2aHv1bBzF
	p2mHYjjTiLmATiDWX++i4vF4CJBWQ6VsBqx2vYpmwESSj4OjIqK+0IWofXZ+mZPLZkW4sN
	fp+MQd6vLveJQsOiDBjKPJ7KxOxIeIm9wM1m630KGdk+ucOKJt5R3n061JqmQA==
From: alexandre.belloni@bootlin.com
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] i3c: Document I3C_ADDR_SLOT_EXT_STATUS_MASK
Date: Sat,  2 Nov 2024 14:28:41 +0100
Message-ID: <20241102132841.2446176-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexandre.belloni@bootlin.com

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

As the mask is part of the enum, document it.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 include/linux/i3c/master.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index 6e5328c6c6af..12d532b012c5 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -298,6 +298,7 @@ enum i3c_open_drain_speed {
  * @I3C_ADDR_SLOT_I2C_DEV: address is assigned to an I2C device
  * @I3C_ADDR_SLOT_I3C_DEV: address is assigned to an I3C device
  * @I3C_ADDR_SLOT_STATUS_MASK: address slot mask
+ * @I3C_ADDR_SLOT_EXT_STATUS_MASK: address slot mask with extended information
  * @I3C_ADDR_SLOT_EXT_DESIRED: the bitmask represents addresses that are preferred by some devices,
  *			       such as the "assigned-address" property in a device tree source.
  * On an I3C bus, addresses are assigned dynamically, and we need to know which
-- 
2.47.0


