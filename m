Return-Path: <linux-kernel+bounces-540234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F47FA4AF89
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F1D31896801
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 06:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABECC1EF0B9;
	Sun,  2 Mar 2025 06:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="LhKcrKsw"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C554D1D54C2
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740897866; cv=none; b=e4YJuFdWQO0ENLjHTOd2DwJmFKWIAs2fBDHoYpPrZ1Ft05dfefn2gmAPDZB8qHy7TEt6ad2BzCSlDXtpxUJD4qOjDn3imX99zJrf0lgeaD+4NXmJIXwmLj6Ht8KAET9MqJvAWfKcluQrLM0NEgkjG7IaLI+E1oyN4p9COXTUHfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740897866; c=relaxed/simple;
	bh=PchpREbeVuSu33VarUHMnUKVR1nscKOKnSIs1Y8iilo=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=sPZwnfYq7nuNgvgOWPMujlsULW5Hubqq7GAGXdnFxJo4AzB9uWTTvabdf57a/l2kuerPUnV6Zr4mGFUd5Hs6P5f14oMol1PjUWvcBoAwnjH1e6aeoRT7gPZlMQ6W1NYGpZZpB2DBalJ+hPRbqOGuAT1ygORQuyvsAqzDgjGbVnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=LhKcrKsw; arc=none smtp.client-ip=220.197.31.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=PchpREbeVuSu33VarUHMnUKVR1nscKOKnSIs1Y8iilo=; b=LhKcrKs
	wNjcLf/jBYiPVizdwvlo/gn0C0THQfe0GHnVZN9/2umoRCBK2L5MPa5v1Bqsm174
	P9d/V3eIlYd0WzxEmsRsSvuBTnCXQPWg5CeDLu/HYLXJGfS5LxlA++2+Hgk3ceIk
	9jgE50hS9dOjvdmQ8vjxoP17rGRoxEmH/IAo=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wDnr7lE_sNnTtMgBg--.23836S2;
	Sun, 02 Mar 2025 14:44:21 +0800 (CST)
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
X-CM-TRANSID:_____wDnr7lE_sNnTtMgBg--.23836S2
Message-Id:<67C3FE45.066DC9.00001@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUq5x6UUUUU
Date: Sun, 2 Mar 2025 14:44:21 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbiOhQEumfD7Anz0gAAsw

Hello! Rust is better than Javascript


