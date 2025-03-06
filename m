Return-Path: <linux-kernel+bounces-549446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 583C5A552B9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 18:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90941163A69
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 17:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558BA2566D5;
	Thu,  6 Mar 2025 17:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qXfD3GW7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51C31922ED;
	Thu,  6 Mar 2025 17:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741281449; cv=none; b=FLAc9X03BXIjXFj74ViWiO3RR94KGhITxoF2EcMYrqOLvUpWzmzkBcaCKbzewoyvzdBPQI1iHG55Iitf1e8/pmotRLfgZo7wt3Ja2YR9wWB4Y1G2z6ppoZiA8SLked9v5/3nKN0ZbBMSjcXbf1w4IvYMn4c0xhOuJxH39j3tl8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741281449; c=relaxed/simple;
	bh=wE8fq9Xqj1ipKusjlJNDPVDEqeo82zu7GP8fRPCWKr4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lHFSpeXcP/ie/CIvYrGtRT7UaaAVrU36h0uToHf44aWJkELvGMc0ovdQtVMLWt/5dOhECLI9aINq4W4A8Pz2iywe5KeZSC81DthvVT6AY721VU4d0H982JJ41gMERN41/u+BzTZKyaaCCNa/Ps1tto558F5T/fugTcXo86wzDi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qXfD3GW7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8BD1C4CEE0;
	Thu,  6 Mar 2025 17:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741281449;
	bh=wE8fq9Xqj1ipKusjlJNDPVDEqeo82zu7GP8fRPCWKr4=;
	h=From:Subject:Date:To:Cc:From;
	b=qXfD3GW7mCtmQg6GAXeGiRb4G400UXfB3zA01WSs0aYLyO77Tf4brftJPzbLyYwYt
	 Scmq01JJELOGdFJG0Iteuc7ti9kTuuTxTBA+9/y6mWkItpz2HkqvMC6XvI1T96QgrW
	 PIJxEui5Nf6YTON9vll7+XW7bMyOQaRbMLkOV5gnaAZPOLOyDhUJrIJf4SK6RnpUc8
	 lA6QJxSXivpWwHGlvDAXbiUvb2BX3Fw5OP4FfCzXS22TpWSXWUoCJlBn/I+OtehDnn
	 P5d8edHsIlui/PcxNXfcLTYmyRV5e5oqN7IQggARZo9uZgTTRMXPfUp+sxPkVf+FWa
	 4N7wo0kSLgKWQ==
From: Maxime Ripard <mripard@kernel.org>
Subject: [PATCH 0/2] drm/display: HDMI documentation improvements
Date: Thu, 06 Mar 2025 18:17:22 +0100
Message-Id: <20250306-drm-hdmi-state-docs-v1-0-56a19d3805a1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKLYyWcC/x3MSQqAMAxA0atI1gZqnb2KuLBt1CwcaIoIxbtbX
 L7F/xGEPJPAkEXwdLPweSQUeQZ2m4+VkF0yaKVrVaoGnd9xczujhDkQutMKdn2rSlPoypgFUnl
 5Wvj5r+P0vh8hF1FRZQAAAA==
X-Change-ID: 20250306-drm-hdmi-state-docs-89703b124bbf
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Jonathan Corbet <corbet@lwn.net>
Cc: dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>, 
 Hans Verkuil <hverkuil@xs4all.nl>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=750; i=mripard@kernel.org;
 h=from:subject:message-id; bh=wE8fq9Xqj1ipKusjlJNDPVDEqeo82zu7GP8fRPCWKr4=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDOknbyxhu3Fpq+W6s39mn38pGuypUSCW9WxKb6bHxDkz1
 0a8Dr7q0FHKwiDGxSArpsgSI2y+JO7UrNedbHzzYOawMoEMYeDiFICJ9OUwMjzKqk9uu3JdKynJ
 YNrUJyttbzYtTAx45hVi/iJPxOLFDjZGhmsdt7mrRaXdy66eEUmoOuSV93NP0ufN8ecUCw6c+aj
 PygwA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

Hi,

These patches improve the HDMI infrastructure documentation, in
particular to mention that edid-decode can help debug and check
infoframes issues.

Let me know what you think,
Maxime

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Maxime Ripard (2):
      drm/display: hdmi: Create documentation section
      drm/display: hdmi: Mention Infoframes testing with edid-decode

 Documentation/gpu/drm-kms-helpers.rst           |  15 ++
 drivers/gpu/drm/display/drm_hdmi_state_helper.c | 261 ++++++++++++++++++++++++
 2 files changed, 276 insertions(+)
---
base-commit: 7eb172143d5508b4da468ed59ee857c6e5e01da6
change-id: 20250306-drm-hdmi-state-docs-89703b124bbf

Best regards,
-- 
Maxime Ripard <mripard@kernel.org>


