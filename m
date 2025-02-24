Return-Path: <linux-kernel+bounces-528498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE208A4186F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C5411897504
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35544252905;
	Mon, 24 Feb 2025 09:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bsOZrf5n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8764924503B;
	Mon, 24 Feb 2025 09:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740388143; cv=none; b=IT8IM52mvbuGeMKLqzWQ1S3E/ycOGrkkb4OFkwHCg5SA4KQSNbwtR+l4MyWr48/DyLoGyH9BJVM+LF43af2itdudyKkFoH5MalWcjNr+gJQUpl69cSqSCvDXnYcEpDQsSUh4ljIbGbnEZe0Z1ukdE9oIgO2IevJ1IFZFcD3AbmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740388143; c=relaxed/simple;
	bh=EuSV6D3szJ0VW+HjV2NwWusmhdj/JnS4ByP03OXscaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LIxCofcEr8FMnMIjLnJMndBwuZdElDNiTcGyi+pokhQIbAv7ErONtKXKND6+773/jBVeGzlhzdaRQheCgcuBsd23iOZUtBCjxAcJ19mRjr38pU3HyH1fJqUM1bgTS3yRGJZTbP6Z7r06yuAp0k2fjuBKjHAk7IDGMJv7Cv2wh6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bsOZrf5n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0054C4CEEE;
	Mon, 24 Feb 2025 09:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740388142;
	bh=EuSV6D3szJ0VW+HjV2NwWusmhdj/JnS4ByP03OXscaU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bsOZrf5nwEoDs4PAkYNZQTExuSUaayjHTC6H/oIgO/6PMkQD5GWDteUkRDrMDA7ti
	 sLWAdADhYmAzDLUvKbKdfufuVJ4TgM1a5Gehkwg9GR9FxtQFa7KUJC/e+bNopQdPn/
	 RA7OxnKnDxGADrYA9n4ufY2b7SMXQ0ydroUcnNIM6TZIBccVkYeMyPdPQ4ZRX89lz3
	 8gtuKy1z4fsBt4Sx7be61sX8hTBECfUhKjW3fwLTwuJYhGInb1UYl8Szec9uyJFYB6
	 ll/scl0iG7LEDAgI0ScFz4Ye9s2p0uchmZzO6FQxwTec6WISiUmW+wASWCvZPU8P+k
	 wFL37vt5In6TA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tmUSS-00000003p3c-3c3Y;
	Mon, 24 Feb 2025 10:09:00 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	linux-kernel@vger.kernel.org,
	linux1394-devel@lists.sourceforge.net
Subject: [PATCH v2 03/39] drivers: firewire: firewire-cdev.h: fix identation on a kernel-doc markup
Date: Mon, 24 Feb 2025 10:08:09 +0100
Message-ID: <8238bed1c0375e6b389a8cafe1ad99fdeb1cb1f2.1740387599.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740387599.git.mchehab+huawei@kernel.org>
References: <cover.1740387599.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

The description of @tstamp parameter has one line that starts at the
beginning. This moves such line to the description, which is not the
intent here.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 include/uapi/linux/firewire-cdev.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/firewire-cdev.h b/include/uapi/linux/firewire-cdev.h
index 1f2c9469f921..05e3aa8fa8bc 100644
--- a/include/uapi/linux/firewire-cdev.h
+++ b/include/uapi/linux/firewire-cdev.h
@@ -449,7 +449,8 @@ struct fw_cdev_event_phy_packet {
  *		which the packet arrived. For %FW_CDEV_EVENT_PHY_PACKET_SENT2 and non-ping packet,
  *		the time stamp of isochronous cycle at which the packet was sent. For ping packet,
  *		the tick count for round-trip time measured by 1394 OHCI controller.
- * The time stamp of isochronous cycle at which either the response was sent for
+ *
+ *		The time stamp of isochronous cycle at which either the response was sent for
  *		%FW_CDEV_EVENT_PHY_PACKET_SENT2 or the request arrived for
  *		%FW_CDEV_EVENT_PHY_PACKET_RECEIVED2.
  * @data:	Incoming data
-- 
2.48.1


