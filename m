Return-Path: <linux-kernel+bounces-521093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 853FBA3B420
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 09:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63AE53AF6F8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 08:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74891DE2C4;
	Wed, 19 Feb 2025 08:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f3dqcQX7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFF31BE23E;
	Wed, 19 Feb 2025 08:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739953972; cv=none; b=XEdypR2vBQ92Zw7E+hOBLGo2jiWpkbC5f6jRFcDIA8qHeF3VEqMwvJqzllDxTayNnAR/wAeiJoDV71pZjs2stml+sJ8/XzSTr2ksztwyxhVACLTe5bqG/6sKOitYM1wfhunnLmdPd021wMKvF0gL5tD57IYafS462s1R/Z5XcNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739953972; c=relaxed/simple;
	bh=EuSV6D3szJ0VW+HjV2NwWusmhdj/JnS4ByP03OXscaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VZ6J+cY7GXRsWNKhzXb2/hsjl6H33oqSnQR77fb7ITE5KdSSFtIm2I8ZPNQqD3yYeV8x77Cv4xOh8uUiWuLh0XhaaEqQgTlx+tKKAnQA/HEpam9hEE44+7h6QYiIt6u0f9vng+uC8JXZR6ILLJ9tDImD4EScPsN9CuFGp1wkRec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f3dqcQX7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4DCEC4CEE6;
	Wed, 19 Feb 2025 08:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739953971;
	bh=EuSV6D3szJ0VW+HjV2NwWusmhdj/JnS4ByP03OXscaU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f3dqcQX7HKpLOq9UuAsVZvG+1e7cu8jhCTyw9qStK3Wy1gxr24aRyzVIKPYlcY5ZM
	 aESzNHJ7xm6eZhH0VvbF6V9wXUuD467jQ2s4s4uaK+iOac1u8UU6vXefyVuDZhSUqT
	 oq9YYi25VP5AdaD/8KbdEe95Zq6OPpDfRS8yACo5bmv6SDv4pr4mIrMflST9xNAdak
	 Rmt7ooaGXd6dqXpa59SftHFKYcpc/Itd/gILJVTgv8ah9VmNiPS33QSsLphBrkUhff
	 OMKxot/N3Zfnm+idHoXRLOuGSr9Z/PXRkf0Z5P3C7P68GD+71rTivCCxhv8Fdi9iff
	 M2S1l/tQQTfJQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tkfVi-0000000Gv4T-02dM;
	Wed, 19 Feb 2025 09:32:50 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	linux-kernel@vger.kernel.org,
	linux1394-devel@lists.sourceforge.net
Subject: [PATCH 03/27] drivers: firewire: firewire-cdev.h: fix identation on a kernel-doc markup
Date: Wed, 19 Feb 2025 09:32:19 +0100
Message-ID: <56d88f897214cbfc4593b4bb4b2a04d0168865d7.1739952783.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1739952783.git.mchehab+huawei@kernel.org>
References: <cover.1739952783.git.mchehab+huawei@kernel.org>
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


