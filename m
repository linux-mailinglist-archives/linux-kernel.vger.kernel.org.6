Return-Path: <linux-kernel+bounces-540396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83102A4B043
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 08:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F48B884285
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E0D24BD03;
	Sun,  2 Mar 2025 06:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="IWS0a1B+"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8997C1EEA3E
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740898747; cv=none; b=m4KRUw21ZphjB9F8OCrGeJhdVZQ939dIK2/IZ9ZHNURYrJmv+dsjUTMpR0FwWKcAjSuXUdzH+VbU07eH1vc0Q7tK1NnQNDnjoAo9RtRpFlJkWdlYjdg0VSE9Y/NaIj/3Dj8wYXIiT5A8iRIjb9zpd32eDCUlskBGBG8WrQSm06w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740898747; c=relaxed/simple;
	bh=jOTe+0xUMEm8LLQEkXE6MviC3n7NMHX44e0k2GAwts0=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=dPOZQYGeRkI+ytCrepSXoiUfg6dzEIrWI7kQIeRPDunERhVprgZwpHy1k/lhLGhQq7KcOEV/B0qFXV5xmkIIoJDQRAZ2Fdjdoe6JeZ5/Fea3yZISMsGa+79aV/uiQHWpHMsKmNLEm/SymV0EXDSOk60v7mHxgbNS7iPX8HvPNDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=IWS0a1B+; arc=none smtp.client-ip=220.197.31.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=jOTe+0xUMEm8LLQEkXE6MviC3n7NMHX44e0k2GAwts0=; b=IWS0a1B
	+5rxbimA9jNasqARCPd0rbwZFQT5rFyY90VS/gCfT+M7bB/vKWdGoxaI9JMcFTiv
	u2sawmk0QjLjzNkq1KlNPPy9lssolfCwpUBgnjysQjUm3lRR7e/DOUY23CYWx48x
	iB6zvrzLjI9c3hj/lhDOFHDGadWGX4+k9oK4=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3tzUi_sNn+wAgBw--.29062S2;
	Sun, 02 Mar 2025 14:43:46 +0800 (CST)
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
X-CM-TRANSID:_____wD3tzUi_sNn+wAgBw--.29062S2
Message-Id:<67C3FE22.0684AC.00001@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUq5fHDUUUU
Date: Sun, 2 Mar 2025 14:58:58 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbifgwEumfD7erXrQAAsV

Hello! Rust is better than PHP


