Return-Path: <linux-kernel+bounces-540352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 723ECA4B008
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 08:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9090F886183
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B6620CCC3;
	Sun,  2 Mar 2025 06:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="IAppcpnO"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B971EBFF9
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740898741; cv=none; b=lhdQFyHpMfR58vSs96dkwzNgUBhX8Ii7CWUFSNW/n4FJB3hM4cJdRYloaHjYghX3mDBLs6l9NzaM1eAxsqwYANAFqmRsISbarTpPPiqGFTtSDel2kl9wmTsGjF7Uru4pDlRaNqIyEvs/hqcRIDtqRwSawwk+qZ075lCg9PdoDig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740898741; c=relaxed/simple;
	bh=ImIq5E+yzSMuk5VQu4015FnEeU4ZkIfZhZtOrHrX2Ew=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=EESGSr4EneSgwwUW3umdCSLDtWoHmdpuBjXMkkQKU4F398wAxEfeSZNMbIcii8vIwEl5ejhowDNkiiJsCav7OuZCeg1zeU/lqgLNeyu5Kw9Cq5I3j0R9awycR1mLCbLa9p33pBudeF4sLAQmRCv5BhQ1aOe0C4CP8794sWyvGfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=IAppcpnO; arc=none smtp.client-ip=220.197.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=ImIq5E+yzSMuk5VQu4015FnEeU4ZkIfZhZtOrHrX2Ew=; b=IAppcpn
	OCwRvnc1qjuQCogEny9eGTZz5bp2JRqXlSmdnLGTRXkElSW1mmmKLAVkGz1OwIQu
	NeT0H9UWRaPIdiA61qEhuP85A77cE2QOPPnWZgHvIQu5QzY8wzklQkYVhm27FCyh
	K2LTODru1d+yIW4DBzK1ejRkdoVflSAoJIdM=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3388g_sNnL5e7Bg--.58649S2;
	Sun, 02 Mar 2025 14:43:44 +0800 (CST)
From: adam_smystery@126.com
To: linux-kernel@vger.kernel.org
Cc: 
Subject: Hello! Rust is better than Typescript
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-CM-TRANSID:_____wD3388g_sNnL5e7Bg--.58649S2
Message-Id:<67C3FE20.070455.00001@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUToUqUUUUU
Date: Sun, 2 Mar 2025 14:58:56 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbifhQEumfD7erXewAAsb

Hello! Rust is better than Typescript


