Return-Path: <linux-kernel+bounces-564767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78944A65A86
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D563C885770
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143101B4F3D;
	Mon, 17 Mar 2025 17:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="UR9YdW8n"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAD51A5BAA
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 17:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742231613; cv=none; b=iXCjjA5U3nssnuq1qVXwZygofc2KDaV/2ddoAtNczPj3SiocJPSwA7zUgN1akUla/ZLRh/SJureJySZhGt7WEXw8lKfuvTGkpAFvimnkE7eEhck5FUUsBiH3a8U4Ysl9axRpvUbh1KX/KzVnVHLAG2UXryy94kgMAoPJWKTJS10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742231613; c=relaxed/simple;
	bh=Mu72DTQClvjRd4YMwPJ595wB6wx+Buh6/FlDiUmEFek=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bLlbmh3Sl8Fzj8cIx4+L84JkcLVVPbKTWvoOSqlVVhRTMnOqzXmOWFO75zpO/fgwf6mSbQ8xAvrDgM9CFqcq/7aBV0Ws5D3SN3raw169fxt4/ZyESORNCAwBNhgcMEM9vB2BAhF99vrpA5witktrxKChAJQAAyPnNd9xvvJf04A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=UR9YdW8n; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43cf05f0c3eso17393575e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 10:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1742231609; x=1742836409; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=af2T+qqFETVFhIunkgGHt3W8f1G68St4IjKGS7VLtuA=;
        b=UR9YdW8nIyZIfJXeUPymyyDwGD6ntv2jq89hJaPTsyNp/+Xk89KCgQuO3fLV6bMMLV
         J5MJlO5CUXF0QGCSebknaHU6BeK6yJiLS5BqRxVcNN9VA2ltBBfTKdxsKcqhDMsHAn30
         RAj9/QQAuGRftPlUsBnEDVUcSBoX5XV5W2k8NqiEKzVfVTzeZu5YIw/CgeEg6gjRM4yJ
         C5Md6q2MWJYf2sE4ZNTiKHI0Lzkk0dxjlkX0rUBs+2AwX9JHBYSCgB/i/2Y+fyuvzTI1
         0PMxoQPWHUXi1tm1ZjRCmM7TqTqqfxLpSiNSonNBckeWLMkmsEp1w77otqLSI22SmeLc
         dIug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742231609; x=1742836409;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=af2T+qqFETVFhIunkgGHt3W8f1G68St4IjKGS7VLtuA=;
        b=ZhZais8fx+kM5R0ha8JlooWkNX5qBJK1PB9663nU8BsGxoYUa4l2pMcRoJDE+jXmqV
         9n4lW0ghrOr9aNeqlEeo422DsRBGAktFHhZjCL3XIfwAEYtR2tovoIdHVTpNJtmwifLH
         815CEbc9un8rkgCFktRXw/ntORkaVFvh4//zbfZ5XEHcdCSQ2Y9vS4zJTrYlE0wqIxvr
         N5jcOSo7m0BymvV01FyVN8fFhF2Id4/2aqTk0snvp3o144Pj9CCu1w1q1cptQMD4XGkx
         ojP0nRy9GZkNzm8E4ikTB1n2WvBSXFklHCoGjqduDvT1NS8EahbeG1IO/H1It9MfZtJX
         zJZg==
X-Forwarded-Encrypted: i=1; AJvYcCXUKlqhUBe9AR+mmjUPiIJewZ7cNQR/dFkmhYWErwtgWxlDdesAYplKLhkcy0HXSuvhy6ff8Abfh4CrLIw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4QM1jyyF6HIXCDUGNZB4J+SyKqwp4ugiapEl5QazwcSFzH2qR
	VqfEkrGiRyuuPAF+Fs/iAK87+bQYT8We6/QLr3G/t/fC+hgx2SDIIZHDd3QZ92o=
X-Gm-Gg: ASbGnctMrQ+6nFokwpudvRQr+SVyH44lk9Adx47aJvujD3Yc4hP53cfzUAJI/LCku26
	rt7p5f23mB7wW34QiKQ0FTg9fNhtTHv5+AMCnjTSQQKXWLS04V+Aiby8eo0HjxEtVOJIrVQPIaf
	S56otcGZQPUWxXQZEyfaFv7wACD1JvejCLP8LBH9OcubpUb7anBwqkv0zi6FYGbPkITNbbKt9o0
	USGvlYc0LXiNqLaBrY3zb3NnDUBUFiIIffxxv5ZdiMCxpn18oLWFtJ23HzW7UuNzWAen0J6Mr78
	GvXU5vFAjmhxAza35EIZwU4VikUy9KqipA==
X-Google-Smtp-Source: AGHT+IFdezCTwV9D+zOpoxc2EiaNyS0kLnwCmYcKwtf9X+v1Hkb6NAmZ4F0XRIdGnVLakH5Iz/jHWw==
X-Received: by 2002:a05:600c:150a:b0:43d:2313:7b4a with SMTP id 5b1f17b1804b1-43d23137bd4mr111445655e9.3.1742231609415;
        Mon, 17 Mar 2025 10:13:29 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:1098:3142:e::8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1fdda15dsm112003365e9.3.2025.03.17.10.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 10:13:27 -0700 (PDT)
From: David Turner <david.turner@raspberrypi.com>
Subject: [PATCH v4 0/3] drm/vc4: hdmi: Add jack detection to HDMI audio
 driver
Date: Mon, 17 Mar 2025 17:12:21 +0000
Message-Id: <20250317-vc4_hotplug-v4-0-2af625629186@raspberrypi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPVX2GcC/23MQQrCMBCF4auUWRuJTWqCq95DisR0bAe0CZMaL
 KV3N3bt8n/wvhUSMmGCS7UCY6ZEYSqhDxX40U0DCupLQy3rRqpTLbLXtzHM8fkehHKo0VilrXZ
 QHpHxQZ9du3alR0pz4GXHs/qt/52shBS9aayxZ2N6tC27FO/IvEQ6+vCCbtu2L0p89wWsAAAA
X-Change-ID: 20250312-vc4_hotplug-3ae4e783484a
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 David Turner <david.turner@raspberrypi.com>, 
 Stefan Wahren <wahrenst@gmx.net>
X-Mailer: b4 0.14.2

This series enables jack detection for HDMI audio on vc4 devices.  This
means that userspace audio applications can detect when HDMI devices are
connected or disconnected, for example to play/pause or switch to
another audio device.

Changes in v4:
- Split the update of the comment on
  drm_atomic_helper_connector_hdmi_hotplug() into a separate patch
- Update the wording of the comment
- Add Reviewed-by tags
- Link to v3:
  https://lore.kernel.org/r/20250312-vc4_hotplug-v3-0-d75878677de8@raspberrypi.com

Changes in V3:
- Update comment on drm_atomic_helper_connector_hdmi_hotplug() to
  clarify that it must be called for disconnets too

Changes in V2:
- split initial patch into fix and jack detection feature as
  suggested by Dmitry

Signed-off-by: David Turner <david.turner@raspberrypi.com>
---
David Turner (2):
      drm/display: Update comment on hdmi hotplug helper
      drm/vc4: hdmi: Add jack detection to HDMI audio driver

Stefan Wahren (1):
      drm/vc4: hdmi: Call HDMI hotplug helper on disconnect

 drivers/gpu/drm/display/drm_hdmi_state_helper.c |  2 +-
 drivers/gpu/drm/vc4/vc4_hdmi.c                  | 22 ++++++++++++++++++++--
 drivers/gpu/drm/vc4/vc4_hdmi.h                  |  7 +++++++
 3 files changed, 28 insertions(+), 3 deletions(-)
---
base-commit: eff0347e7c228335e9ff64aaf02c66957803af6a
change-id: 20250312-vc4_hotplug-3ae4e783484a

Best regards,
-- 
David Turner <david.turner@raspberrypi.com>


