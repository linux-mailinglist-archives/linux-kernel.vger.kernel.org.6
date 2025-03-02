Return-Path: <linux-kernel+bounces-540384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DAEBA4B030
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 08:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1728217EFF2
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95962459E4;
	Sun,  2 Mar 2025 06:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="mrQDFwQ0"
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284271EE032
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740898746; cv=none; b=nyPIXSOiXD3gjlpSmnJ8my9ILvBHkpNnTlX2SEYDweNQ3xqkpDJSf/Ov10QdGK+02taK0b6W7dOdpYPC5fK5Q2yabsCw9EDvaRoE1z1k+wYXBCt6J0EGwVTawyHHJInJlHEU3IpaPJpm+BZ9eEMboyP47ejt1mLMewtkPE+A59I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740898746; c=relaxed/simple;
	bh=PchpREbeVuSu33VarUHMnUKVR1nscKOKnSIs1Y8iilo=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=MBuE4deL5n/tCBnBttdEzWlkKwMHNImqgKjyUMN1UbTKt+pQ0iTkpWgckLQolFn42/pHL/s2wJlttTiSxK9t8MQA6yPGRIjRkyQ3RtE0uU4m7+0nb9cWsjGSvw2LpgxjAkvwkuGpd4Q4BrwX5icyZB5TFQzekPLhl15AdU7rrYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=mrQDFwQ0; arc=none smtp.client-ip=117.135.210.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=PchpREbeVuSu33VarUHMnUKVR1nscKOKnSIs1Y8iilo=; b=mrQDFwQ
	0U2/f5/z6k9Ozt9ZnflvENIP1OkjRsVb6AKfBZBIN7hWDV0nrh51mmhCRchNu/Fo
	uxoB4Em48csss77ozqwp479/0OVwgHBMPuh191gOJyzJdpI0tShMmpsQCejXY5OD
	xvh4s1D3dR2fUlXCNiuM4NJ8TDdU9rNasrGA=
Received: from localhost (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PykvCgBXP8Ak_sNnsx4JBg--.16092S2;
	Sun, 02 Mar 2025 14:43:48 +0800 (CST)
From: adam_smystery@126.com
To: linux-kernel@vger.kernel.org
Cc: 
Subject: Hello! Rust is better than Javascript
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-CM-TRANSID:PykvCgBXP8Ak_sNnsx4JBg--.16092S2
Message-Id:<67C3FE24.0D904C.12474@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUq5fHDUUUU
Date: Sun, 2 Mar 2025 14:58:56 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbiOgMEumfD7AnyFgAAsi

Hello! Rust is better than Javascript


