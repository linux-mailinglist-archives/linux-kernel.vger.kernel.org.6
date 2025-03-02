Return-Path: <linux-kernel+bounces-540307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 795A7A4AFD7
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 08:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D54F880370
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 06:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE035200127;
	Sun,  2 Mar 2025 06:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="Mi/ZO3mb"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C611E9905
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740897876; cv=none; b=SbQaZm77KtqX3/ftHPObD/Js5fzhT+/GLdZ2ywa91ZO4Uf4tvCX6dq7U23RX3YxV6MtTxbTw3KA49Ktz0J+pUbUslzYhDGixBgcZqYmb5lqVAag9Rah0+BM9BPUgFlNVdU00OWwUD6DOStCfgoLam96jy1wQRL/g0gDSU1NYlhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740897876; c=relaxed/simple;
	bh=kuanHuw9J0++yX2NZUc3mDyVR4V4BIDbLbg7VpSpL+4=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=Ey6F8fgqgWGP9xWkglcZbaCOoDE6KlM62+80wCqmm1eac5gSR1lrstP1VruTsNx+OdbdStExOrEzWP8fmxBk+XCuAgq0RS3Ec7wDk2vehaSdEYJuxK7n8iMasKYxqwZAOwOB1W8Pb+AtNFw76mzxOwf4YWb0UkkR9MV0bG245RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=Mi/ZO3mb; arc=none smtp.client-ip=220.197.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=kuanHuw9J0++yX2NZUc3mDyVR4V4BIDbLbg7VpSpL+4=; b=Mi/ZO3m
	bULaTqT10sb+pXrU7RTtqiC4+QSx3pIznwQR6upjY5omohGrCf+jfjnfe2nRuFKO
	cJ7PHu9F55FCOqDH5DHj0ea4eDytGKTrE7w87lSIERrQeQTgwXRgzMKM86ipJaTv
	eFzmhluNLKrbGLLXZ6nvZ1xGTN+sfDe7S2Ws=
Received: from localhost (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PykvCgDXn2xJ_sNnqyQJBg--.60990S2;
	Sun, 02 Mar 2025 14:44:25 +0800 (CST)
From: adam_smystery@126.com
To: linux-kernel@vger.kernel.org
Cc: 
Subject: Hello! Rust is better than Cuda
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-CM-TRANSID:PykvCgDXn2xJ_sNnqyQJBg--.60990S2
Message-Id:<67C3FE49.0D905C.12474@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUgjNKUUUUU
Date: Sun, 2 Mar 2025 14:44:25 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbifgIEumfD7erZ7wAAsX

Hello! Rust is better than Cuda


