Return-Path: <linux-kernel+bounces-540259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBA5A4AFA8
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 700E13BBD83
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 06:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F121F461E;
	Sun,  2 Mar 2025 06:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="crrOui3E"
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4CAF1D618C
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740897868; cv=none; b=AMCP5++NlkBuKV9cLqrFiMuk6jNIwuDh/B03IytjpZNrPUzEfhNih8X78ZPVOXaDVjNxDwE91zd0RayCkXgasvqf/5/aZDc7dSLFp2jrDx76B5wnu2/vOflf4VwZsfNOikFgw9kH5mFt8uYMA+SoIbgZvialStDFDn+SYWV6Njk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740897868; c=relaxed/simple;
	bh=JRXhdhnZz8FXfPKKFhJq2JGkB4LIysZOAiXNUdUmjM0=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=Thsba1cRqJYG5MN9xKXweJkJCL1i1Hwg4Y3adrFep6ukG/wL5pBiK3LHB0SXF1iFj900aN+iO2xQ1j7E452vC2cAb5v23qRodPdImoWEx+zQ7EqhP5rKgCqknroRSsSfRwwjtKMZ9eRa5q5DH4Jf0cqo4eePjYXZVE4/iym6qMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=crrOui3E; arc=none smtp.client-ip=117.135.210.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=JRXhdhnZz8FXfPKKFhJq2JGkB4LIysZOAiXNUdUmjM0=; b=crrOui3
	Er+7Cn8Dqh6DjJe2kshK+iQ9Ku41C6Nn/M5EFHvZJSk54/ZoE4GwxO9S+PcRorlU
	bilK/OxZbJg+kMYbPFPaaacZgAdhEPtlkgBdmOMBx20Pux1ktEVJEMRiEUkuit6G
	WOIXIuPmm1IL4bMpqObmgt/ZjWqV+t/u0XDU=
Received: from localhost (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PikvCgDX_01G_sNn6G4BBg--.13686S2;
	Sun, 02 Mar 2025 14:44:22 +0800 (CST)
From: adam_smystery@126.com
To: linux-kernel@vger.kernel.org
Cc: 
Subject: Hello! Rust is better than C
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-CM-TRANSID:PikvCgDX_01G_sNn6G4BBg--.13686S2
Message-Id:<67C3FE46.0D9DCA.10732@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUgjNKUUUUU
Date: Sun, 2 Mar 2025 14:44:22 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbiihwEumfD7fHZigAAsD

Hello! Rust is better than C


