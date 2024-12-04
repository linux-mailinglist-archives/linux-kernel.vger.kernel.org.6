Return-Path: <linux-kernel+bounces-431500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D829E3E25
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 16:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C64A281B83
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 15:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E0420C47C;
	Wed,  4 Dec 2024 15:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H0C9QH50"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A662A20C02E
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 15:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733325772; cv=none; b=S39k3jBW2TxW1a0NlwXh1N3lD7EHDsMr73SyPR2mV26THSbVmKJZltHW4XxSJvMwDGR58zt9hkkbY081Yukx1B+ee/sRXXh0hrtabPJ2DBss0k+f7NVQ8kPlJ7nct1iBs9DCePe1aopHLaVB8sbkeMDhylYw+/fik5m2JH/NHY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733325772; c=relaxed/simple;
	bh=JuYMExwy4yA4YV+0Wu/JJWD2KR90bmeFYr0UeYodTU0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AdJdb/qocLX/sZFOe4oR96ShwLP+lMLqC4G2cwOG3S6hXsS9pusTl7q/CampcXEFtAImEBcsrVd0wGetumCGG6WuvKbMBuW4A6YO8ZvgIpHkISwTB18EEz1SP7MZgX/l6Vumtr2zwgJzu1U0rxkPRmAuzKUlWvdaYLRBOtuNjZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H0C9QH50; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B4ADC4CECD;
	Wed,  4 Dec 2024 15:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733325772;
	bh=JuYMExwy4yA4YV+0Wu/JJWD2KR90bmeFYr0UeYodTU0=;
	h=From:To:Cc:Subject:Date:From;
	b=H0C9QH50INv9ByLZbiwWG3bb8rVS+5YJU+DC6YPGSFdfmdw7qYJ5OJyhT0yjpet70
	 vv8M4d4Jd0VdalXnSSxuE3DXcR1YwYrqXNN3IVxbmleZ3OqX+lvEZI/dVi1OMXCPSn
	 q+FeHabkoH471kPvsZbW1e6HQoC1c4IZzvb81NIn4Anppy3/UJLi067pGIwZqWPB5X
	 4Lz7qM4Tbki3wtDvo6lxzvsdR4L9oNTdWT6tm/LszvMzxT5xEX12Ke0n1cxr9l5XyB
	 e/kjxszEz/9vNAPNR9tyLazNzGM/zotO6MPMiJUu6E1YlsAp/qCqZPEEi2OLxwoX6U
	 xNhTMaKbacCIQ==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org,
	airlied@redhat.com
Cc: linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH] MAINTAINERS: align Danilo's maintainer entries
Date: Wed,  4 Dec 2024 16:22:47 +0100
Message-ID: <20241204152248.8644-1-dakr@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some entries use my kernel.org address, while others use my Red Hat one.

Since this is a bit of an inconvinience for me, align them to all use the
same (kernel.org) address.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1e930c7a58b1..c669c5bd61e7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7345,7 +7345,7 @@ F:	drivers/gpu/drm/panel/panel-novatek-nt36672a.c
 DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS
 M:	Karol Herbst <kherbst@redhat.com>
 M:	Lyude Paul <lyude@redhat.com>
-M:	Danilo Krummrich <dakr@redhat.com>
+M:	Danilo Krummrich <dakr@kernel.org>
 L:	dri-devel@lists.freedesktop.org
 L:	nouveau@lists.freedesktop.org
 S:	Supported
@@ -8922,7 +8922,7 @@ F:	include/linux/arm_ffa.h
 FIRMWARE LOADER (request_firmware)
 M:	Luis Chamberlain <mcgrof@kernel.org>
 M:	Russ Weight <russ.weight@linux.dev>
-M:	Danilo Krummrich <dakr@redhat.com>
+M:	Danilo Krummrich <dakr@kernel.org>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	Documentation/firmware_class/
-- 
2.47.0


