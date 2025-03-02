Return-Path: <linux-kernel+bounces-540271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D717CA4AFA1
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD4A57AA030
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 06:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24DF1F5429;
	Sun,  2 Mar 2025 06:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="qUB4zIbW"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88101D63DD
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740897870; cv=none; b=N+FZQzY7CCO6f+ENADGaGsJ4M2LO4DHVg3ptBNFGD/FvGWzSdA1BTiy8FtcAI6x98k+iDe48NeDx7USuRZUsyMO6WpdCYldYp3yqBxT2e9tH+PD+QJCU2UJFxv2cN2srbGakcHdL+Q8gqd02cWUmFnaQe19Gv9ODFyP86TTmWVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740897870; c=relaxed/simple;
	bh=cftqaDB8AEPz09qm4a8a9qxUPytrv8Vr6D6ryPJtm4g=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=HznEeud+rKNzbIwygr0AlDI+nvVD2NN302Ov0iycR6v7/K6RpDpTGvEpPMVNyYM/HInuJaS/pYFsEQANUIfq+tbqBamfEvOAFSxu1yED5UuxL0yXKOvT5gGZ8MOcPgmJD4sEi70I2U81YGlK+Wjp+CSFBywx+IInGKwMR49TIM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=qUB4zIbW; arc=none smtp.client-ip=220.197.31.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=cftqaDB8AEPz09qm4a8a9qxUPytrv8Vr6D6ryPJtm4g=; b=qUB4zIb
	Wy4vofScfSBDEMrUR66+n2VbY/OuxDj4Ms9z13JPtCqSNIH9nzuhZNKKhqoG9n7r
	H1iRZNVegIaXs6YVYy9nn2iTDF6nSEA5Dcb924Qs3LNW8/9txuKuKocK/A0f9FVg
	UC3PomC/21ydpqSCFvTZA63VUUU4XJ+29Yk0=
Received: from localhost (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSkvCgAnH_ZG_sNnVUhhBQ--.6573S2;
	Sun, 02 Mar 2025 14:44:23 +0800 (CST)
From: adam_smystery@126.com
To: linux-kernel@vger.kernel.org
Cc: 
Subject: Hello! Rust is better than Java
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-CM-TRANSID:PSkvCgAnH_ZG_sNnVUhhBQ--.6573S2
Message-Id:<67C3FE47.0B5A74.19577@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUgjNKUUUUU
Date: Sun, 2 Mar 2025 14:44:23 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbiigsEumfD7fHZkgAAsM

Hello! Rust is better than Java


