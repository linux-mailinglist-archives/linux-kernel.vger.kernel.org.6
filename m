Return-Path: <linux-kernel+bounces-560684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF16A60830
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 05:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C649460301
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 04:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DDD136E37;
	Fri, 14 Mar 2025 04:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="rHdYWJ38"
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A842F4A;
	Fri, 14 Mar 2025 04:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741928380; cv=none; b=M+ckIpVzQHhJZ4rOQqfBQmx2ZvtzcFIcKWTXJq5ezMfarhGCHv0Hd4voITItxxC2nym0NJA4GjSUJ5cFqj8tuTrN/QaQrZCgXNsazeQyksefTTFzjLB3CqsMx3ejvpo7IMjEspnqubRt4Q75wnkaGDCtur2/rCcBDzAz/Sa1u1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741928380; c=relaxed/simple;
	bh=UYUmzHpQPC49cvq4WdYiEm8pbfWLDv0j+f7aW5nEHAI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bLImJ0X1/V2r3QUFarPDChuEGVkinYi32QUsCajfWDBUR2QNLHBFahY1zfmocXWYBlb/MFaxfttzP8WupfEVnUuqCyAEXh0x5uJwJgSknQyc+hmd3zmUmfPhPtBtsve2kjqn3+EcRjwy3wTVNffc/NfRZaIESNIu4G+uMGgc6kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=rHdYWJ38; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from canonical.com (1.general.ikepanhc.us.vpn [10.172.69.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id DCCA03F20C;
	Fri, 14 Mar 2025 04:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1741928375;
	bh=8YqgKwgmox7oiRp6NpIj7XUW4CjPJGFQwaPSEeWrA7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:Reply-To:MIME-Version;
	b=rHdYWJ38oLCZYfjBZ+jEVQrliTBeYYHIPMza5KguhH6iZNWgni7ekClHY5KS4+ves
	 Ily9Gj8F7zSdW+XOSKp2wbazJxkl/+uBPE0oTH/A4Ziz3TeVYi2NgbW0vhF/nkKCzO
	 I2dk5s834yML73XtAnlguQe0sqzLEEvwLuaLG2HMabygg+3hT7346Kn48eonCIyfda
	 okPqqpbZiipsx3BNVcpig8A3rmcpGequn/ZY/UCJ47FSr0QuGBV4Al+3MrP90FF7Km
	 foTNHejM0cQpXp5tkWzml7V+ZDo2uRMw6EYsM9WFQDMks4OjcWL+Cu8hk9ceD2I3+s
	 QlPAnhLaVpb8g==
From: Ike Panhc <ike.pan@canonical.com>
To: linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Ike Panhc <ike.pan@canonical.com>
Subject: [PATCH] MAINTAINERS: Update Ike Panhc's email address
Date: Fri, 14 Mar 2025 12:57:32 +0800
Message-ID: <20250314045732.389973-1-ike.pan@canonical.com>
X-Mailer: git-send-email 2.43.0
Reply-To: Ike Panhc <ikepanhc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I am no longer at Canonical and update with my personal email address.

Signed-off-by: Ike Panhc <ike.pan@canonical.com>
---
 .mailmap    | 1 +
 MAINTAINERS | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 72bf830e1e588..be60c13d2ee15 100644
--- a/.mailmap
+++ b/.mailmap
@@ -281,6 +281,7 @@ Henrik Rydberg <rydberg@bitmath.org>
 Herbert Xu <herbert@gondor.apana.org.au>
 Huacai Chen <chenhuacai@kernel.org> <chenhc@lemote.com>
 Huacai Chen <chenhuacai@kernel.org> <chenhuacai@loongson.cn>
+Ike Panhc <ikepanhc@gmail.com> <ike.pan@canonical.com>
 J. Bruce Fields <bfields@fieldses.org> <bfields@redhat.com>
 J. Bruce Fields <bfields@fieldses.org> <bfields@citi.umich.edu>
 Jacob Shin <Jacob.Shin@amd.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index 625f3758c8800..b71945082a0d6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11141,7 +11141,7 @@ S:	Maintained
 F:	drivers/i2c/busses/i2c-icy.c
 
 IDEAPAD LAPTOP EXTRAS DRIVER
-M:	Ike Panhc <ike.pan@canonical.com>
+M:	Ike Panhc <ikepanhc@gmail.com>
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 W:	http://launchpad.net/ideapad-laptop
-- 
2.43.0


