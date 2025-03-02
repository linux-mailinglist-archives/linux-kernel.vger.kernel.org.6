Return-Path: <linux-kernel+bounces-540288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 911A1A4AFC6
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 506E0189F21E
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 06:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758DA1FCF74;
	Sun,  2 Mar 2025 06:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="oY6Dv3bF"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946211E7C2B
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740897872; cv=none; b=AZJa6dXll8XxHd0rcMomRj/Ykn25/O2JXNnHSrfhOzpFd5P5ojWdJOpvKBty2ZA8yZowA9X4cHQp6asClQGBlnqO7lMzxhJcpxPTAb0mzDjNEltgFk39Cfgep4vrqIOAR5AujFmsWZjVWY2mN1OtPx6UjTK2PR7BuwMAnsYfb9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740897872; c=relaxed/simple;
	bh=jOTe+0xUMEm8LLQEkXE6MviC3n7NMHX44e0k2GAwts0=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=pWgH61Jbw/LaaikJgpREqmHlKe6O2hsj4bTatOCnnqvWJo2/YQ/gJTno00CPchl4thyHfCTF/IiTx3lJPqXnmcng768EqU5TzBphtK2shhdigJ8R7xPtohJfwff7m6kvjOnN+OMIu+So36FoDdiOiOeMen3XvsBAHGcVaGHUDUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=oY6Dv3bF; arc=none smtp.client-ip=220.197.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=jOTe+0xUMEm8LLQEkXE6MviC3n7NMHX44e0k2GAwts0=; b=oY6Dv3b
	F4WehjhfOVHkjsk0amx+L1zTYHNN9l28u4bIbBP4n8UF3PX2fxaBRxgvuHWLf96m
	x7ZAAURro+9tQ+RsjMvbZNRQR1tzQ6kgstaP+MqbqyjdNMPDZhY4op6oDb1uQStN
	u3jamtTQrgMHA0FXGDK9yD/PJSf4xbHOa0e4=
Received: from localhost (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCkvCgD33xBI_sNn+9TrBQ--.53204S2;
	Sun, 02 Mar 2025 14:44:24 +0800 (CST)
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
X-CM-TRANSID:QCkvCgD33xBI_sNn+9TrBQ--.53204S2
Message-Id:<67C3FE48.0D754B.03778@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUgjNKUUUUU
Date: Sun, 2 Mar 2025 14:44:24 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbiihQEumfD7fHZqgAAsr

Hello! Rust is better than PHP


