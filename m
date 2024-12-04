Return-Path: <linux-kernel+bounces-432009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A41E39E44AC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 20:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1AE8B67FA0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 18:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F461C3BF0;
	Wed,  4 Dec 2024 18:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="SIWj1okh"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CD61F5404
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 18:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733338251; cv=pass; b=qc5alyOq7m2JmD1Yh6hK4i6Lc5x11a2eWU/lskgE9lqydLFE/oDC/45JipuluTpOqoGMOWL9nedSbpiYvUOVnWoNn7zfvP0mK1uBi5pHjykXvE4ymlqK+qJ0MqO08rNMtmP08WKku2PICGV+AuhsWfjpY9aOX1EOm+IxCWSAy/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733338251; c=relaxed/simple;
	bh=I4kn7o3dQA7UNq5U/VE1rUhvDUHzxgWFvHathwXuJwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K4lw6DZj3zE/d9EvwnlqPwc8S722aJAAGB1eAU0Zn5ON6Hi2do/n2tJHIbHhN5nj0APmKmlS/locYmKD7rLLICNxz+O1o9bMo1aHz2LgIGAcLbHL6uoXgQavqnZ/RU3+krKszw5RLfuQYC8hgrRT4jRXvVk4ZYf3YqNhjPL8y8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=SIWj1okh; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1733338230; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=UiUW6u+kUHBO95VyEtPTPdyOUyn2ffyH22dNOqn5sktuN4bAYzhSuj5OXGNIO99n+CRw52K8H+Sqhuthe+hVElmYFlnr0GEy0F5Y0e9rBVL1FNhZ1A8dBbEC59uRp/gwC6wtH+Gqbprjp+QGhDC9Edfpzm/gnaUxUtAeIJYP3v0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1733338230; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Z4cnhxf/c5ioQPu9CgEC8xnKTrDLFOWLMVaDiNAiR6I=; 
	b=VzG4GZ3i1T+UKRcCZGNDCW8oOEtC819jLFUe0Rh2IDkpU2En9ydGQEVh8FJighpIs6yQv/mEifGnouT384ltgpQOcm58UixfBZf4dZzqzjZgtGNUOcJiC3/CUjNokhrBCqWtHdtnSGAnquOv+9wMcyzA863lN0XBUx99r6HCtrY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1733338230;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Z4cnhxf/c5ioQPu9CgEC8xnKTrDLFOWLMVaDiNAiR6I=;
	b=SIWj1okh95+sbf9A34d0rPAnPKHiONLi4/6skD0XXgzWx/HoW8PAR93gu/9bDoSZ
	NcXCOD2OjasIovj64Nh7Fg19D8BLyv3fMorW5ixJ1IaIcH0mrIPa2IfsObjQaSUqDIG
	4AJDKFq/9iE2b6BMOPsfbmClgAhjjsZVQAQkDdA0=
Received: by mx.zohomail.com with SMTPS id 1733338228692326.96738407483633;
	Wed, 4 Dec 2024 10:50:28 -0800 (PST)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: kernel@collabora.com,
	=?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 8/9] drm/panfrost: Add forward declaration and types header
Date: Wed,  4 Dec 2024 18:49:37 +0000
Message-ID: <20241204184945.1477677-9-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241204184945.1477677-1-adrian.larumbe@collabora.com>
References: <20241204184945.1477677-1-adrian.larumbe@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is to make LLVM syntactic analysers happy.

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_mmu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.h b/drivers/gpu/drm/panfrost/panfrost_mmu.h
index e6e6966a0cca..27c3c65ed074 100644
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.h
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.h
@@ -4,6 +4,7 @@
 #ifndef __PANFROST_MMU_H__
 #define __PANFROST_MMU_H__
 
+struct panfrost_device;
 struct panfrost_gem_mapping;
 struct panfrost_file_priv;
 struct panfrost_mmu;
-- 
2.47.0


