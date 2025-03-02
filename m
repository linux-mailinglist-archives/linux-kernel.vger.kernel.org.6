Return-Path: <linux-kernel+bounces-540233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD7AA4AF92
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44BC63B5FAC
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 06:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEED61EF0BB;
	Sun,  2 Mar 2025 06:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="GTdWHp5g"
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F2D1D54D8
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740897866; cv=none; b=N8wzPzXWRRGX3ca0cq6EWn4WKJw5Ihj61Nwkacz0jTsBQI+5mG/aR15BZp7emwlfFsH2L37DDk1uwahp5qFhuC7yMa6xtAUH+Z/770CcM1vPWBxkXZhPvujjcXN3mcsrXJGg7n8pocLX1OYlrsTxGcLCgEkfGRWwi/TRttnQE8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740897866; c=relaxed/simple;
	bh=PpuV9J8+n9bZO9SKZkLSiMjR/byLHXwmtdk5TtpXbDo=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=h/ot5qoasa53bwtRgV4BCaIQS9Yck11BuzIB31uReqgxZF7LPr/wvdimk4XMtgv/nB2OJwxauG9WDyZCUGEethDGuqCEy1dMkISpoRyFhBMIhbKHOcziDfYvloaPxphVtUPYrkYzGMQYLTEhlfFx9s7TXKev9/D3RKL5K8fc1lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=GTdWHp5g; arc=none smtp.client-ip=117.135.210.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=PpuV9J8+n9bZO9SKZkLSiMjR/byLHXwmtdk5TtpXbDo=; b=GTdWHp5
	gEJ6WarLtTGE4dnM3dVaQxNb1bGp8M7nVb+GvziSsDO5PKMxycnFVCSre8M6blxo
	IopZbGVdyEbmmpZi1zLK7U9njINvoqRfbmDblvrCoAKmlYFUPQMLO40jg9ls9EsT
	9+gICOFqZZsz4HjhbBRNDjPz9iR0uRir9OdQ=
Received: from localhost (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PikvCgD3_3xE_sNnpW4BBg--.22209S2;
	Sun, 02 Mar 2025 14:44:21 +0800 (CST)
From: adam_smystery@126.com
To: linux-kernel@vger.kernel.org
Cc: 
Subject: Hello! Rust is better than CSS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-CM-TRANSID:PikvCgD3_3xE_sNnpW4BBg--.22209S2
Message-Id:<67C3FE45.0D9DC8.10732@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUq5x6UUUUU
Date: Sun, 2 Mar 2025 14:44:21 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbiihEEumfD7fHZdAAAsw

Hello! Rust is better than CSS


