Return-Path: <linux-kernel+bounces-193135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CFBE8D2740
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 23:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39B952825E9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 21:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE67113DDC5;
	Tue, 28 May 2024 21:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wg6mHbFw"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A135C13D8BF
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 21:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716932708; cv=none; b=CODiYSvACUy87JLqvlSpKJD5S4UVxvIXIn+GFUtndtyV1hZjt2NtS/pljbKqyG4yEEARj0HKKcz8sgm4dG2MzTILHSCRZ9zQUZ1CHB7JBD3/sH5j9HdnvhTJetGWTqZInkVEiv5rEq8tj2n3zd+Cl4IKdEshsFyozjMrylE6w1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716932708; c=relaxed/simple;
	bh=z5ChwGBGOUdmpsoWobAtBFD0n6OIyh3CeZqyDF+KAN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hh10iUxXYDLt5+MhTM/SZkA5jYS5GRgXFh2/OjSyDpzekjiPhGudBdYqIMJnAwBbdAzyua2ApGiKPJ7JzpFrv1iT50nac5aaZ0zYbNyFaVBXo8BcUs5JzEW5o10/+DPdrcb1AdqpZaSaCdUijOeXlSkREPy96xoN9tOByzZ4ptE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wg6mHbFw; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: akpm@linux-foundation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716932704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Go08MgcoZFqIURxZ4j9Ru1G8PiEnIRyffZErr6eYIZU=;
	b=wg6mHbFw/Xr3q1hV392+fUiUTmQFKkNz0r67UJvbRYO+WAM0XjtUpE8IaJX4nEDdQrhogz
	oxvNZbxdtz2XLB9kBf499yA4zFcMAhNdiwjpKw9XTJPOW+tgiXDxAqX1aMlf1vz+aT2gzy
	kPBFhLFm7Xfxea+eQgVI5aUOJlBRIo0=
X-Envelope-To: muchun.song@linux.dev
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: shakeel.butt@linux.dev
X-Envelope-To: willy@infradead.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: roman.gushchin@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Muchun Song <muchun.song@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Matthew Wilcox <willy@infradead.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH v1 14/14] MAINTAINERS: add mm/memcontrol-v1.c/h to the list of maintained files
Date: Tue, 28 May 2024 14:44:35 -0700
Message-ID: <20240528214435.3125304-5-roman.gushchin@linux.dev>
In-Reply-To: <20240528214435.3125304-1-roman.gushchin@linux.dev>
References: <20240528202101.3099300-1-roman.gushchin@linux.dev>
 <20240528214435.3125304-1-roman.gushchin@linux.dev>
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
index 7af431daf77bc..cccaf2bcedecd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5584,6 +5584,8 @@ L:	linux-mm@kvack.org
 S:	Maintained
 F:	include/linux/memcontrol.h
 F:	mm/memcontrol.c
+F:	mm/memcontrol-v1.c
+F:	mm/memcontrol-v1.h
 F:	mm/swap_cgroup.c
 F:	samples/cgroup/*
 F:	tools/testing/selftests/cgroup/memcg_protection.m
-- 
2.45.1


