Return-Path: <linux-kernel+bounces-180670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0215A8C719B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 08:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D54D1C20E4E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 06:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA98922EE8;
	Thu, 16 May 2024 06:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="UKvXF/DX";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="sVPj6oH5"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C36A10A23
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 06:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715840715; cv=none; b=OupoRY3IdmKTH4ejqstfRlKCsmbV2fiNDUTpO1eWVJsbomP8hFu0SzipJFHKPZrWPsiui3PuyodU9UusHPDLKn1JI4v0ZpQoZLL6Mf9BBHoE9cT8N0zK+MhWpfLXzCbdk8twIkRCmioi0UmppQOGuYlKgdCsygXeWm2XwZ51EtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715840715; c=relaxed/simple;
	bh=jc9pljNs6yXUpizbFtT2OPDX1AfNSJmKQS2QOa84T5c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k8x9DB6E495dHzs7WH9Y05fhbYFUmOi6dxpHd8KZA1m2+mnUvy6a0PEcQQxUYgE/6DNZPWjhisAeJdvKAMlaTIhSDn9VQEr2070z6RUJyM7PKhzp+6SdCqHhWlewnClPCl2GBliv4zG9zIbSNXUIxUAnhtWH474Urd6df8WgmR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=UKvXF/DX; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=sVPj6oH5 reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1715840711; x=1747376711;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FnBWymedJjKyiLa7wqfQJM2clRoi20uCvIeRkE4sZxI=;
  b=UKvXF/DXXc+cQMAKD//CzP/fXtEN1+PhT7ZhOJ/vkEchYRJcC9W+ozn7
   rgE3nhD3W+/CYHFiGoU6bfl85JAL5+chuzptr24AbViWlf4wFea4bXTVZ
   nZvD1S7HdAh/agtxa9UuFTyGmXbLbfrUd4jiwEY0ZGDZEwFBBC0+HlMGR
   i9EQxMXHs3k03F3r3B7KinfGdl24pAtFip1rMXo/VYkEt0BZVvd25LEJ/
   n0CldolpSf8SkFGHN7YH+2qmh0dB+Iw/u/jymsHZ3GbnwNBHxtmKyfx5Z
   kFDS+bHc2rcseJnQYhFYF8qHny9xCYMNhvel02DFS4dJQ8vwLKTrKMfc4
   w==;
X-CSE-ConnectionGUID: BhAH7Qd5Truskt5wD/Deaw==
X-CSE-MsgGUID: Xcc14FPeSu6hl/qb4Ys6ew==
X-IronPort-AV: E=Sophos;i="6.08,163,1712613600"; 
   d="scan'208";a="36926958"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 16 May 2024 08:25:01 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E2F65170DD3;
	Thu, 16 May 2024 08:24:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1715840697; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=FnBWymedJjKyiLa7wqfQJM2clRoi20uCvIeRkE4sZxI=;
	b=sVPj6oH5+DaTlWrKy0zFjGMSnkzkVp+abKxZez/0FBj26fcBDq0exQh6E+67RF2QdcRfbc
	wvDp37wQJW1Q9n2yHv1KnwGlEAFNE07NvHHXaylguU/QP0g2PU9XAaLfF7RG98cN+w0ebP
	GDWUhoPXiyLYimzhj8RWneMv7mCyomVFJaFc/EKq8IHn1nsFHVHNrt1ei+KyXAuqnPsSc9
	eDWfvGBYC16Cy/YDs6bAij/NUds/rvo8U1UDPSfgQkqrS3NB1oQ3zEkk6EQOFu6UiqSiHF
	5bVlHN06WSgIEK3iSuSNmzurSEDk405Huu7+e49pT/9TdtZzq3fg0/lnrF8o0A==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] Improve tc358767 debugging
Date: Thu, 16 May 2024 08:24:52 +0200
Message-Id: <20240516062455.106266-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

this small series improves debugging the tc358767 driver by using
dev_err_probe for additional information (patch 1) and print IRQ
debug output only if hotplug status actually changed.

Changes in v2:
* Added patch for supporting write-only registers

Best regards,
Alexander

Alexander Stein (3):
  drm/bridge: tc358767: Use dev_err_probe
  drm/bridge: tc358767: Only print GPIO debug output if they actually
    occur
  drm/bridge: tc358767: Support write-only registers

 drivers/gpu/drm/bridge/tc358767.c | 56 +++++++++++++++++++------------
 1 file changed, 35 insertions(+), 21 deletions(-)

-- 
2.34.1


