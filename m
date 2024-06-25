Return-Path: <linux-kernel+bounces-228144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D7E915B6F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 03:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95343283D39
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 01:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9D47344F;
	Tue, 25 Jun 2024 00:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cUo/vEeX"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1C06BB5C
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 00:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719277199; cv=none; b=cW0YMU6jBgVuCyKxPv2wZoz89PXS51zH1DkIREt/GdWp+eI1kvid41wsnYJDg0Xb2xHV3ds8fesLEQOocB1YNtGn/7tbYxcM2s+iU2K/2ZKXHTLpeeneYGaBMiJO+p6CEgIEEMKqrYddbQP68TXCwNw3m6UrzvSegvnLKNPanB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719277199; c=relaxed/simple;
	bh=XjGRooweZTz6QDvQKDiYt7nyI4M7WsUbBxp6B2Rm0GA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jQX8YhOuMn7TZ3tYqUwNChDXir4I3OjasNrLIY2Vj9Nv7a7MCSzFwLdajm/j8gyvcz0aMNWqoglMRzyME3D7qvTHKn3vUmt5Q7jVellCL7tnigFrCa7K/PMR9TwoKCaE2Xlim8Qi+pC/vZfhe0uXuJaVeQELxd5kCOe/YAo8Cbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cUo/vEeX; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: akpm@linux-foundation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719277196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IUWh34mKvDA5ZX4ELdIfwkO9YFkJ3Clj/+3O87GvqhQ=;
	b=cUo/vEeXYjeXJIY2wMDo5RPQ1Z5aqrE///lMqhQ/e22bOBg2cLi6CMQ29cSj37a4yT3qEg
	DL2MBC7H/y1neuQrubwTKXQ6XXXymtTO5RkYGmrEqVJC7icFj4khgDg89CwZfQ2yUNBiF6
	cpLXh1XL96ClOj+cqZSLEtHEHkRQoCk=
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: shakeel.butt@linux.dev
X-Envelope-To: muchun.song@linux.dev
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: cgroups@vger.kernel.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: roman.gushchin@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH v2 14/14] MAINTAINERS: add mm/memcontrol-v1.c/h to the list of maintained files
Date: Mon, 24 Jun 2024 17:59:06 -0700
Message-ID: <20240625005906.106920-15-roman.gushchin@linux.dev>
In-Reply-To: <20240625005906.106920-1-roman.gushchin@linux.dev>
References: <20240625005906.106920-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7ad96cbb9f28..52a4089746b3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5582,6 +5582,8 @@ L:	linux-mm@kvack.org
 S:	Maintained
 F:	include/linux/memcontrol.h
 F:	mm/memcontrol.c
+F:	mm/memcontrol-v1.c
+F:	mm/memcontrol-v1.h
 F:	mm/swap_cgroup.c
 F:	samples/cgroup/*
 F:	tools/testing/selftests/cgroup/memcg_protection.m
-- 
2.45.2


