Return-Path: <linux-kernel+bounces-540209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0958A4AF77
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEA3416E78F
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 06:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBCF1DE8B4;
	Sun,  2 Mar 2025 06:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="BD/T0Ujl"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3141B423C
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740897835; cv=none; b=EYLaEmZiW570xAkq7YAiR21S1mvXAD1ShSdcaWu+ty0BLm15U8gbIFFDiAqETEXjxm5Ke8qbJH97lKyUIDYm3c3xgvqbdPUBcSwj58+gWuVqavSFzQj3kij/AQo0TwjRn4VAAIl+AFiOPtU07hnKpwlfra00R05wnohhSDYGVtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740897835; c=relaxed/simple;
	bh=JRXhdhnZz8FXfPKKFhJq2JGkB4LIysZOAiXNUdUmjM0=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=Ei+BOenlmhAXXPpgNL23bzwk+f/4pv10hY+hU4fpTnggGV5CYX8OEdeSbpeRpfsKTBa3Ica+LSg1NYCwefWn1mG+RvFvif6XNd5sXO2HGbqywouns5VCuFPPsgfPHz9U5zNBAxJlRSssGR25m1MrqZ0YwMt5WEbivSrHpcGQaGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=BD/T0Ujl; arc=none smtp.client-ip=220.197.31.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=JRXhdhnZz8FXfPKKFhJq2JGkB4LIysZOAiXNUdUmjM0=; b=BD/T0Uj
	lA+ZTJudChCs8ML5kWzYjgHQQhejAvLW+TMxXXgRa/88fQHt8dZYA6fFOKoMm9zR
	wRbj/RkvJTuZvcR6QGRxhK8aq0f48nxDhlABIpb/lg5O7ILA+60TQRxDizCMxTNH
	OxF+2BASI+OpHCJyxvlPRE8ZSHV2vFGq6eS4=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3l78g_sNn2944Bg--.18381S2;
	Sun, 02 Mar 2025 14:43:44 +0800 (CST)
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
X-CM-TRANSID:_____wD3l78g_sNn2944Bg--.18381S2
Message-Id:<67C3FE20.06526E.00001@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU6fOzDUUUU
Date: Sun, 2 Mar 2025 14:43:45 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbifgAEumfD7erXgQAAs1

Hello! Rust is better than C


