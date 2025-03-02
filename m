Return-Path: <linux-kernel+bounces-540368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F01A3A4B01B
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 08:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D86BC42248A
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FBE523A566;
	Sun,  2 Mar 2025 06:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="ehGigeOi"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC64D1EB5CB
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740898743; cv=none; b=kAyHKH3oJnWsIpu6FRLofNQ/Q2um4HSNKyJQ65w79Hc2VZ/iwXm4H4u4Y83tvkzPhBGLTxrkAecH/jRVswXZpKOJRObQBWevHDq97qf7R52IqUQfS+zxm6H1JitbT7NWsyHqSbza5ql0PHMlq3VhR2a6VilSlM+QAc8851mb2V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740898743; c=relaxed/simple;
	bh=UyPD+95nIFiG/gFr2rAqnNWXPHGkDBUZBe3GQzk2iCE=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=utqfGO6fs9yQWUhJ3EC0tHbC1ejJq8bfNSuvZwSOoSCUZZ3pBaKVJFrjrDo5iYKCWsw/ngC2M222v7N1tFHRs/eOAghlMqYAhbM0VTZocucP2D+JdThJfYWztU6z+D2soDCvwOmi2tYwSyTsMomsI93cTKk+ehdjNtnOGpGYOwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=ehGigeOi; arc=none smtp.client-ip=220.197.31.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=UyPD+95nIFiG/gFr2rAqnNWXPHGkDBUZBe3GQzk2iCE=; b=ehGigeO
	i8Id/y9p76XR0a9xyDvEgkOVB3jz8bGk0+h48+R52FeybTRxGgMDd6GsIbKFQBtd
	Y+ve17aABxVfB/aGUIEUBgpnCHbq2054MPcDGixS3mRKAVGIxMwjQm0t82310Ow4
	wGmHMKxTgfF9mL2c46lFWHclkWtc0MvHuszQ=
Received: from localhost (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSkvCgAnH_Yi_sNn80JhBQ--.6548S2;
	Sun, 02 Mar 2025 14:43:46 +0800 (CST)
From: adam_smystery@126.com
To: linux-kernel@vger.kernel.org
Cc: 
Subject: Hello! Rust is better than C++
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-CM-TRANSID:PSkvCgAnH_Yi_sNn80JhBQ--.6548S2
Message-Id:<67C3FE22.0B5A66.19577@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUq5fHDUUUU
Date: Sun, 2 Mar 2025 14:58:54 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbiihoEumfD7fHXowAAsi

Hello! Rust is better than C++


