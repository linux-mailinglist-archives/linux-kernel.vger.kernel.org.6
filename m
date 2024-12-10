Return-Path: <linux-kernel+bounces-438952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5163A9EA8B2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 07:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 598F21887CA7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 06:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044B122CBFB;
	Tue, 10 Dec 2024 06:21:11 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.213])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 70D6522B5B2
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 06:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733811670; cv=none; b=MrptcI3TyhFjhX5Vu/ZNgh42vtH/kNCHgU9GSwie8vkB679Gypyupf+R+KvCGrEyfYwjKR7JB5VWFcmIapjJjwo1ukq1GwKs3/j1BwUWtmWiQEKtBRb5P9zubM/PLMOtMBRcwmJWiSCOKVPSj5dec+GS06Nth2aZFQ/jXwZ5BSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733811670; c=relaxed/simple;
	bh=vWtjnTKMHbx3q9HCYbAP4vfM23c9XJmkFWhGVSUipj8=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type; b=ZktXHH0TT3LtJp9+/LbHR8oN3X1U+wL9L3iLss/USc1pZnp2kdW8BTkRknTbqJLkgryKqao/EHW25/3C76MEgiVEw3eDd1czKwgN9NF6rrIWn39Ky5UpGHANoY4x+kBo1hDcZZYjI4npBuDKc8jTZ1gjHLkBxkK3Fnff8C9xdfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from 127.0.0.1 (unknown [40.50.50.41])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPA id 840C9606A5D50;
	Tue, 10 Dec 2024 14:20:40 +0800 (CST)
Date: Tue, 10 Dec 2024 14:20:40 +0800 (CST)
X-MD-Sfrom: zhanxin@nfschina.com
X-MD-SrcIP: 40.50.50.41
From: zhanxin <zhanxin@nfschina.com>
Reply-To: zhanxin@nfschina.com
To: kherbst <kherbst@redhat.com>, lyude <lyude@redhat.com>,
	dakr <dakr@redhat.com>, airlied <airlied@gmail.com>,
	simona <simona@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>,
	nouveau <nouveau@lists.freedesktop.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1722060220.392.1733811640530@127.0.0.1>
Subject: [PATCH] drm/nouveau: Fix memory leak in nvbios_iccsense_parse
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_390_769418950.1733811640517"
X-Priority: 3
X-NFS-GUID: PNrdZJdcGdfhQmGbW1mQ
X-ISRICH: 1
Content-ID: 53ed85b6-b98c-4938-a21f-5ff90b033fe9
X-Mail-src: 1291

------=_Part_390_769418950.1733811640517
Content-Type: multipart/alternative; 
	boundary="----=_Part_389_1713214656.1733811640517"

------=_Part_389_1713214656.1733811640517
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


------=_Part_389_1713214656.1733811640517
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit


------=_Part_389_1713214656.1733811640517--

------=_Part_390_769418950.1733811640517
Content-Type: application/octet-stream; 
	name=0001-drm-nouveau-Fix-memory-leak-in-nvbios_iccsense_parse.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; 
	filename=0001-drm-nouveau-Fix-memory-leak-in-nvbios_iccsense_parse.patch
Content-ID: <d136119c-4913-48be-9d47-02fc4529b2e7>
Content-uid: 1733811638148

From 895d436242c94c56a1d696c713016cc1504b9b83 Mon Sep 17 00:00:00 2001
From: Zhanxin Qi <zhanxin0@outlook.com>
Date: Tue, 10 Dec 2024 13:12:04 +0800
Subject: [PATCH] drm/nouveau: Fix memory leak in nvbios_iccsense_parse

The nvbios_iccsense_parse function allocates memory for sensor data
but fails to free it when the function exits, leading to a memory
leak. Add proper cleanup to free the allocated memory.

Signed-off-by: Zhanxin Qi <zhanxin0@outlook.com>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/iccsense/base.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/iccsense/base.c b/drivers/gpu/drm/nouveau/nvkm/subdev/iccsense/base.c
index 8f0ccd3664eb..502608d575f7 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/iccsense/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/iccsense/base.c
@@ -291,6 +291,9 @@ nvkm_iccsense_oneinit(struct nvkm_subdev *subdev)
 			list_add_tail(&rail->head, &iccsense->rails);
 		}
 	}
+
+	kfree(stbl.rail);
+
 	return 0;
 }
 
-- 
2.30.2


------=_Part_390_769418950.1733811640517--

