Return-Path: <linux-kernel+bounces-531782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C6CA444E2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB7E91677BA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5374156960;
	Tue, 25 Feb 2025 15:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JB8OjMCt"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C446D199B9;
	Tue, 25 Feb 2025 15:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740498389; cv=none; b=QmoY/w4KU15hzDmtMcoRvKmpFZPlHxQdB+0La2SurEfjymDyQaTNv5BuQvNrpW/k0KyE6NgKja3HLJ2GL9LcmJDusYO8OWC5O3r417Fdmny3UcloqrBdI0SxBNTZExHR6L85rgaNUUFPrT1Qr+z9mGukQqwxG0jyKRZf4tv0Nks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740498389; c=relaxed/simple;
	bh=MFvmP9LovArK9OERLzzbnLEOunRvxAUL0nHnW9lN2zc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Qe9utyhhaUZ/ErQtDb5OYCbL/FToo3dp6708ekrQnBeqEgbeDHvO75HPS9BkSQqpj1MtBV0RsZyG8FOZHkfkCu5xaynFOCIGFNftWRVBUIF5RAC3aT/DvtF6P0Ve7Im6Z2zUVqENgq5ftAtj9W/qeVjgMtqxuU0bzYkPxcgSqjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JB8OjMCt; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D59644429F;
	Tue, 25 Feb 2025 15:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740498385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0QMFPn7v0dvtqEnFRRWaHTTHu3sj+oRLzfepMtxanK8=;
	b=JB8OjMCtCzJ1YInn4tNfeR0v0PbEPGZGOGVlzbzrit48JNQTeiTdt+9vYx4sh+wmawS/6N
	CETWdosaxauFkwlusUa9edkiZgRA6Ds9BO18Zl/y2+e36l0G7BDMOGrYrL+wG0xPiz6kvh
	NdCEI9zw1kowE2dr151TWTPB2obKNZHjLQsEqqALDY4IBajPhsJh8KGxAekJtz2SszH+ra
	P9Cv91kFMMvIoKx0qeykfMlaoVZSoamphKkqkcGwSiatDie1PU6n+6jTGQN1TvfxkqrFaX
	2IbDUk+L0Evph8E7rEmZiInCnG2QeentPxoE4AE7iwU5AZ8q75g5aRQAGmX7Ew==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Tue, 25 Feb 2025 16:46:22 +0100
Subject: [PATCH] drm/vkms: Add "hardware limitation" emulation TODO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-vkms-update-todo-v1-1-afb1e6f7d714@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAM3lvWcC/zWMQQrCMBBFr1Jm7WAaGpVeRbpIk1EHSVIzaSmU3
 t1gcfffh/c2EMpMAn2zQaaFhVOs0J4acC8bn4TsK4NW2iitDS7vIDhP3hbCknxCo66q1d1ldP4
 GVZsyPXj9Je/DwZk+cy2X44TRCqFLIXDpG58DBhZ3/g+MtBYY9v0LdOQsTJwAAAA=
X-Change-ID: 20250225-vkms-update-todo-50701246bcd8
To: Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Melissa Wen <melissa.srw@gmail.com>, 
 David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: thomas.petazzoni@bootlin.com, dri-devel@lists.freedesktop.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1429;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=MFvmP9LovArK9OERLzzbnLEOunRvxAUL0nHnW9lN2zc=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBnveXPQ2q8V3VeN1NbMRQPdRMMaL4QjQAynIylm
 AUfAMv05wWJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZ73lzwAKCRAgrS7GWxAs
 4t5VEACUFayeAdbvJqZBoi1QRKlqceU3JOBr31o/wBKDiJ1qzS2UbREIJvAB+a1RFRfgaNByGFB
 qDaAN6Af8AbAkWVEu7MWzsUwelIPNlKCB9jm6GZCTiGBi21qUicgPWN/4jlAmx6BQ0Lpjg+ICBC
 sqzNO9Rg7oUx0zMnh8JquaWLKrqOf68L/mKA7auEA2eXmqOlxbdJFmsDWwLwCZPJ+9wgobGzjr8
 jETrvKjGZMIUIdJb1d5AjcLlqcWdb9Dn1rOUHDFfie+M5mRWSdk2w+1njLp1qTYjmefWF6Uqq8o
 xmkdirueb4RhqN09hCI9vREVFdBJGgwuTTDsoQx2g0JhMlVQlllWvtibZv47yzzh41a0wD9tVDp
 aT+7GEAXDHR3I3C+TY8rMm9plPimKKE9OwympO+6AWdAcOgtYK/HFYej+ilLmTZcgVgc7n7qLJJ
 qctsn8kr43fmptBxeWt6OMUtdE6eEj8+/llY20vqK25HY1hTonNusLSaJ6L2CQkTJl+qjWF6dkr
 DGMtcJ+Ieze+qYFErhzTDnwIpbOnYjiSAwd3CWyWgVfdT+MYD3yEJP1ShVpA/GXtK56Z+XQJ8ax
 YaP406FvqC6KPgq1XzlIMmmcp121MBO/+JFKlLXw9t+yVJ7FH2cOVXLHMCl/7y65RECPD7oktku
 ZYCZrvKztktDC7w==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekvddutdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkffvvefosehtjeertdertdejnecuhfhrohhmpefnohhuihhsucevhhgruhhvvghtuceolhhouhhishdrtghhrghuvhgvthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepueetjeeggeffvdegkeetudekjeevkeehheduledtgeejhfduvdeuleehleffgefgnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopegludejvddrudekrddtrddungdpmhgrihhlfhhrohhmpehlohhuihhsrdgthhgruhhvvghtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedufedprhgtphhtthhopehmrhhiphgrrhgusehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrihhrlhhivggusehgmhgrihhlrdgtohhmpdhrtghpthhtohephhgrmhhohhgrmhhmvggurdhsrgesghhmrghilhdrtghomhdprhgtphhtthhopegtohhrsggvtheslhifnhdrnhgvthdprhgtphhtthhopehlihhnuhigqdguohgtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhouhhis
 hdrtghhrghuvhgvthessghoohhtlhhinhdrtghomhdprhgtphhtthhopegurhhiqdguvghvvghlsehlihhsthhsrdhfrhgvvgguvghskhhtohhprdhorhhgpdhrtghpthhtohepshhimhhonhgrsehffhiflhhlrdgthh
X-GND-Sasl: louis.chauvet@bootlin.com

Add the hardware limitation todo.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 Documentation/gpu/vkms.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
index ba04ac7c2167..d5bc602547e7 100644
--- a/Documentation/gpu/vkms.rst
+++ b/Documentation/gpu/vkms.rst
@@ -147,6 +147,15 @@ module. Use/Test-cases:
 - Change output configuration: Plug/unplug screens, change EDID, allow changing
   the refresh rate.
 
+- Emulating Hardware Limitations with eBPF for MST and Atomic Checks
+  Hardware limitations can often prevent valid DRM configurations during
+  atomic checks. Examples of such limitations include bandwidth constraints in
+  MST and limited clock signals for multiple CRTCs.
+  These limitations are dynamic and require extensive checks, making them
+  difficult to describe statically. To address this, we propose creating an
+  eBPF interface for atomic checks. This interface will allow userspace applications
+  to simulate and enforce custom hardware limitations.
+
 The currently proposed solution is to expose vkms configuration through
 configfs. All existing module options should be supported through configfs
 too.

---
base-commit: acf3256160bdabcb5c07032f3bf6eb5a21f5b95f
change-id: 20250225-vkms-update-todo-50701246bcd8

Best regards,
-- 
Louis Chauvet <louis.chauvet@bootlin.com>


