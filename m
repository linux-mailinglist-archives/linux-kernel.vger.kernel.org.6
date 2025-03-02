Return-Path: <linux-kernel+bounces-540388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB04FA4B02A
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 08:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9289D1882141
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8B62459FD;
	Sun,  2 Mar 2025 06:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="VTBgFgr1"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0123F1EE7A3
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740898746; cv=none; b=eS3/sFxtNIkL1D1qaOYURYqfB91uBasLSXSqB1u1kW1SBcw7F1ZrNyH9xiwtjfREntDSS0JLlE/XpiMeqnTA6mpMTnROldRRYJAaaOHH0r5I6Izt+47VkCOgaIlxJ450Lz2b2884J0jOiFVc1YHrnSB7SUSYSzI+MFTRjbTAwmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740898746; c=relaxed/simple;
	bh=cftqaDB8AEPz09qm4a8a9qxUPytrv8Vr6D6ryPJtm4g=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=qCaKl3MuEo+8E1/myQev3aMuCSk5qGTSoDodoSss+cPuOCEKYBtPGG7jE8oo7Hq1AqWooArfUROv46Yu5jzmxJlyWX9M1DB8wD3okB7FvtLCWfQ84M1NiH9TqUAIG/WA/FkyjDbydcAsMZfQ6i4X9yLQnOq6AGGBln9ZV8fx5vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=VTBgFgr1; arc=none smtp.client-ip=220.197.31.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=cftqaDB8AEPz09qm4a8a9qxUPytrv8Vr6D6ryPJtm4g=; b=VTBgFgr
	1wTfir+jv4T7YQydvrYr2lgfRCxgM7kPIDqPaSurw/pkl+SLjOvvyT7SbLW2bYqD
	CxaMUaZzOwRS35puZiXQVBvqRXBqlH84+zKaAXHoYAMVUjFnupQm0+UKRXAKmVYv
	oMFJJgRp2gWJuV+YryYlszpvEpc9bdVLlz0o=
Received: from localhost (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PikvCgDnb3gj_sNn_mgBBg--.18915S2;
	Sun, 02 Mar 2025 14:43:47 +0800 (CST)
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
X-CM-TRANSID:PikvCgDnb3gj_sNn_mgBBg--.18915S2
Message-Id:<67C3FE23.0D9DBD.10732@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUgbAzUUUUU
Date: Sun, 2 Mar 2025 14:58:56 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbiOhgEumfD7AnyBAAAsr

Hello! Rust is better than Java


