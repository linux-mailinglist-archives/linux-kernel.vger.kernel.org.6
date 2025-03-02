Return-Path: <linux-kernel+bounces-540348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 059CCA4B001
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 08:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4359918907F0
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D0720C039;
	Sun,  2 Mar 2025 06:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="WvIui82w"
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78921EBFFC
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740898740; cv=none; b=dv34OuLRcP76O0wrpdROwjmZ0UA3VI6lfK7RKClbHkDpXb478o/apAqV4+7eez3lFXaWqPxcpjnH76ycHn1b+6zQpKHN1bnGaWTWL/xk4521HXTViOpYq0StLNwuK9jV5edm8aECshVznOmtLTlzmctXC0LyA/LVblywcLPl5WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740898740; c=relaxed/simple;
	bh=cftqaDB8AEPz09qm4a8a9qxUPytrv8Vr6D6ryPJtm4g=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=jhddyglYY0Qoy3WdJUvs9w2Cw5oSXA4OIYu5XJ1ezU4352A4Zm9XD2vgct/AkqpwOHQk8RDer2y6cfoQL+f7ZoShLR0ndPW9QBbAfy0euDwsUHNar3CeGYTcRyHd7w7ASuBodnwdkpowaDcrGz8ET/a7rdOI9/HRmFk0NpVkJHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=WvIui82w; arc=none smtp.client-ip=117.135.210.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=cftqaDB8AEPz09qm4a8a9qxUPytrv8Vr6D6ryPJtm4g=; b=WvIui82
	wnVckz524XoTzHVRGMkZ8uQahZyuiCxPHR/T8nIXYAft3UFgElZJSOPN9v9WL2/I
	VLFBx7o2OFNjF03OarnaTPiRjbrH/Dy6zfynAns8cByJAlxikicNL39WfAi8tDdd
	pAAYyytZbQQ4+oaXwEqpaJ4/CslmCD1/dzUc=
Received: from localhost (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCkvCgD31_ke_sNnlM7rBQ--.46199S2;
	Sun, 02 Mar 2025 14:43:43 +0800 (CST)
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
X-CM-TRANSID:QCkvCgD31_ke_sNnlM7rBQ--.46199S2
Message-Id:<67C3FE1F.0D7538.03778@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUTo7KDUUUU
Date: Sun, 2 Mar 2025 14:58:55 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbiigsEumfD7fHXawAAs7

Hello! Rust is better than Java


