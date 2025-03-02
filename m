Return-Path: <linux-kernel+bounces-540380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 497B5A4B01D
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 08:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B85E7A0540
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2880224291C;
	Sun,  2 Mar 2025 06:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="XGkFGTf4"
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A231EDA22
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740898746; cv=none; b=jKIZ2u+HDaqmw6TEHQFiG0G5oDaCO0bRIMO+nYznY2Sp/NzWmMW8fRD/IbY/05oVpt4bDSASMcO6h0G69UbFVPeTJ1JRhDwTDOzBWg1kkC6SCHSejtDOk84BjMrdEbmIhPvXSUZ+HcoCq01BlYJoWGGEnfG5R9+jXJz0O/TMJHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740898746; c=relaxed/simple;
	bh=PchpREbeVuSu33VarUHMnUKVR1nscKOKnSIs1Y8iilo=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=nv42J2kMpd2XOIhpAFU2hhdPkSVk4O7TXed1vybrm0PMHf7fnk1fKjCzzGtWs1vMxntqfjnewcXfpdDGJH4Rzu4pIB3JoIRgxIrcm/+w1f178hZuDKTWEq3Xmmm7e+JdFYvF1690Xa2GEr7HLG+KDvDm8kbUPQg8SZHQJd+9mKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=XGkFGTf4; arc=none smtp.client-ip=117.135.210.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=PchpREbeVuSu33VarUHMnUKVR1nscKOKnSIs1Y8iilo=; b=XGkFGTf
	4sGDkoqX+va05cK7921v7Tm/d/gJSVtVO0T4Efq1yBqXgoHX0xP10P5xizPDkJeb
	xNWzYqLF8PqhuKovK6gACjRjLjODhRCBbzC+1RkaMM8ShrjdRdxGcG/k7mCQL/HE
	3q/FwakiJyn24u37QoaFN2tSitJZbmjqJmVM=
Received: from localhost (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PikvCgDnL3sj_sNnEWkBBg--.20431S2;
	Sun, 02 Mar 2025 14:43:47 +0800 (CST)
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
X-CM-TRANSID:PikvCgDnL3sj_sNnEWkBBg--.20431S2
Message-Id:<67C3FE23.0D9DBE.10732@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUq5fHDUUUU
Date: Sun, 2 Mar 2025 14:58:56 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbiihkEumfD7fHXswAAsx

Hello! Rust is better than Javascript


