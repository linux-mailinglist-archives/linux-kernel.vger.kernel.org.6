Return-Path: <linux-kernel+bounces-271108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D879449A7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 12:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92399286A5B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 10:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D445183CC4;
	Thu,  1 Aug 2024 10:46:47 +0000 (UTC)
Received: from mail78-59.sinamail.sina.com.cn (mail78-59.sinamail.sina.com.cn [219.142.78.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B13170A32
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 10:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.142.78.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722509207; cv=none; b=Nnz2LaUrJzRr1UmGgKEB/OUb7wK2hitwQTAdcVTrQ6zZOYyRncdM0mOwM6QetJmLQq/l0R07K4IZ4oWbXfhsFbBd67MJ6EdA/gUUYp20bLdvruqYPN0mNcsA0QtQejrkAxCsYrkrZi1jLpiQv3ok/gFeyjbWhkJ28vcI/k9H6sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722509207; c=relaxed/simple;
	bh=SMF4GpAWvqM7jjOnDV18CS82I3uuCdBzjY/QozGLIX4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hqahU8V9THZncwVvspZZqlkODNAMsrOBJf8m+UwTjhRMIWKAu0YCR1E7ZAKMApantg/9fuKWxkFkcRHVlVL5ylgOLQuusmOsKvFGF0T+wQdCDNl6eD8vKunz1Gfla1ZcApNabWJOTkglsCP/PFlqgEpGuyFXx7VtViFYNeo5mu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=219.142.78.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.64.72])
	by sina.com (10.185.250.24) with ESMTP
	id 66AB654800003730; Thu, 1 Aug 2024 18:36:58 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 69488110748372
X-SMAIL-UIID: 0949200B840345B2AC416BC36058EF96-20240801-183658-1
From: Hillf Danton <hdanton@sina.com>
To: Liju-clr Chen <liju-clr.chen@mediatek.com>
Cc: Will Deacon <will@kernel.org>,
	Yingshiuan Pan <Yingshiuan.Pan@mediatek.com>,
	linux-kernel@vger.kernel.org,
	Ze-yu Wang <Ze-yu.Wang@mediatek.com>
Subject: Re: [PATCH v12 03/24] dt-bindings: hypervisor: Add MediaTek GenieZone hypervisor
Date: Thu,  1 Aug 2024 18:36:47 +0800
Message-Id: <20240801103647.2480-1-hdanton@sina.com>
In-Reply-To: <20240730082436.9151-4-liju-clr.chen@mediatek.com>
References: <20240730082436.9151-1-liju-clr.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 30 Jul 2024 16:24:15 +0800 Liju-clr Chen <liju-clr.chen@mediatek.com>
> +description:
> +  GenieZone is a proprietary type-II hypervisor firmware developed by MediaTek,

Given type-I [1], confused by type-II. Which one is correct?

> +  providing an isolated execution environment for mTEE (MediaTek Trusted
> +  Execution Environment) and AVF (Android Virtualization Framework) virtual
> +  machines. This binding facilitates the integration of GenieZone into the
> +  Android Virtualization Framework (AVF) with Crosvm as the VMM. The driver
> +  exposes hypervisor control interfaces to the VMM for managing virtual
> +  machine lifecycles and assisting virtual device emulation.

[1] https://lore.kernel.org/lkml/20240730082436.9151-3-liju-clr.chen@mediatek.com/
+++ b/Documentation/virt/geniezone/introduction.rst
@@ -0,0 +1,87 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+======================
+GenieZone Introduction
+======================
+
+Overview
+========
+GenieZone hypervisor (gzvm) is a type-1 hypervisor that supports various virtual
+machine types and provides security features such as TEE-like scenarios and
+secure boot.

