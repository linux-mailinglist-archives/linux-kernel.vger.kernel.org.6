Return-Path: <linux-kernel+bounces-540382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16022A4B028
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 08:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4DE7188A480
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CBBD245027;
	Sun,  2 Mar 2025 06:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="bjti63/5"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFB21EEA47
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740898746; cv=none; b=nZa1/io2d4TrLpBk2772+bbpm5dRIuQe9GY7W9fnI3Yp78w92VyvlWY5o2aEYk7D1y24dsqPjBMjpSkQk/FC71CN+kFqt6KiPPrMoVx8PQb7gEYcAxnyhkcSuz6MfFmMF2FloF+sUqnyx9H6HGPpxBdVWSZBZ5lChLQNZ4ikN6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740898746; c=relaxed/simple;
	bh=jOTe+0xUMEm8LLQEkXE6MviC3n7NMHX44e0k2GAwts0=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=raTio9Qll33m3/dBoBPS90MqMiU5iO1XDe9BHE6pHQIn+gyw46Jxf9I0iHKmz0sf8H25HKDjDrKqHONfSyB2JIcGzQohyP/R63BihRba5itGkf4icC7tvxr3LihBoE4N/1lm0R9oUzsAcHY1/TA0VHCRj29+5YZVDw/Q7y9xcg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=bjti63/5; arc=none smtp.client-ip=220.197.31.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=jOTe+0xUMEm8LLQEkXE6MviC3n7NMHX44e0k2GAwts0=; b=bjti63/
	5PZT3XCYsA94bAVdcWWLiWvNZcoUEnexGhOnaM7SbLsWZ7L+gVc8YVjdtXYhIF5C
	RyKFGDgoX0mIAL6zV6O1hNJ5xdLGh9z8ZxmC/l9iZzeYqDqfRJusI0zME+3gESvu
	F8riFkOGVBzhs04erAFIuobTL2olsFdJtooY=
Received: from localhost (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCkvCgBnb68j_sNnxXfdBA--.50108S2;
	Sun, 02 Mar 2025 14:43:47 +0800 (CST)
From: adam_smystery@126.com
To: linux-kernel@vger.kernel.org
Cc: 
Subject: Hello! Rust is better than PHP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-CM-TRANSID:PCkvCgBnb68j_sNnxXfdBA--.50108S2
Message-Id:<67C3FE23.0F01B2.16940@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUq5fHDUUUU
Date: Sun, 2 Mar 2025 14:58:58 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbiOgMEumfD7AnyAQAAs1

Hello! Rust is better than PHP


