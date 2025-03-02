Return-Path: <linux-kernel+bounces-540283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE03A4AFC0
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA51E3BAE97
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 06:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE4E1FC0F5;
	Sun,  2 Mar 2025 06:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="P2t84RPp"
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921261D86FF
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740897872; cv=none; b=HmGXuUtExlBbL+jdxxzLOHfgN5sJbzX8md7k1uVKsFECM4hvklNT8ECIj9bG9F2g3vr2DZlyPSVd2tGSUdmqx5yoySI45mOBR6HcWO4aMhi/KciMjarkcVhjeNVGBu4KVL4iKcvyKAm6ER9QPopfpFO/H4TaxWvDQZ+SdWnpXv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740897872; c=relaxed/simple;
	bh=PfixNPQ/uTp/hFvZCGY1TVY84A7zL5WAfQIAbeeaQe8=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=P9XDZQBIFucXAaoDdvV2fYMtIGneUDqBKUkfzQ0dOYB6PP9Iojs98r2P5s/5ZQbk3usndYWn7N0XA++MhYAiZ13febsiJiw5gDwJK8Hv5l8yePDaq1bV3QO3aavQu7CivYHA2qv+cWMeph259VlaZp7W97uJPets0i/vbLqU3O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=P2t84RPp; arc=none smtp.client-ip=117.135.210.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=PfixNPQ/uTp/hFvZCGY1TVY84A7zL5WAfQIAbeeaQe8=; b=P2t84RP
	pR2c3IGdWszUZMDLLXQIrgUOOkgnv0ZhTqb5824niZe9SEaBt8UVvQ0+iZ502Cfn
	h6s9bKdEVQvt6sHWKAaPcFg/Y0qg8uKXVtsfLBcsYvRtTIbb3QQ7nemIOHQlCMqP
	1kDjyMcKuWjZk5GxNb8p6/431PpMov7AiuuY=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3X69H_sNnn0LeBQ--.12417S2;
	Sun, 02 Mar 2025 14:44:24 +0800 (CST)
From: adam_smystery@126.com
To: linux-kernel@vger.kernel.org
Cc: 
Subject: Hello! Rust is better than Python
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-CM-TRANSID:_____wD3X69H_sNnn0LeBQ--.12417S2
Message-Id:<67C3FE48.059B41.00001@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUgjNKUUUUU
Date: Sun, 2 Mar 2025 14:44:24 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbifg4EumfD7erZ3wAAsr

Hello! Rust is better than Python


