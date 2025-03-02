Return-Path: <linux-kernel+bounces-540256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE66FA4AFA5
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0506D189D47A
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 06:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2890A1F4617;
	Sun,  2 Mar 2025 06:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="afBiB+WE"
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E779C1D63E2
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740897868; cv=none; b=eSHpQ9Zfv0b5oaAbNqr0fooW2OwP7id7ng4pQOR2HDHzCtroEU3+rcQUzD7+eZsx/lF4xRKvpMBH9nWB6t93zixES/wYT8pkrilit+syyYC7ohSd/qZMb1ym+HwaL26hPg/MO97M/Gm8O3X3apYEVcJDbhjkhKa8ACFcGDj52ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740897868; c=relaxed/simple;
	bh=m3WWx7WaxOLxHF4l3ehA7ZpOfcH46DacagbXvgNtOUU=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=mWreY+7Z+zlWORfgqbCQAC3h1IU/cQAc7R38Uefy0tZWaECU9SjoSfcda3uBN2cPVFpftpJ2vTENUazocGNbM317d6tJ1hRdeKb4yKqsNhns+ij639wdezFfxHhBDD7TT+nBx6T26ba6NaKNBtSqIZ1Y9SwWygLtlaB7D9LmaVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=afBiB+WE; arc=none smtp.client-ip=117.135.210.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=m3WWx7WaxOLxHF4l3ehA7ZpOfcH46DacagbXvgNtOUU=; b=afBiB+W
	EbdcjaEadhcd+fa7A2K7NT1WeYT3mLavA3YE5lg+oTvGg459w/aBtVRrY6/1KG0K
	UBQ/ygQCzeykhiMX3kT4YN2loBlZFv8rg792zKAPzL7kw+abzZmH3d7QA0LFmFkl
	Ml8A8vNcvetdZbvkJ+th3IGxYLjRUBflTFto=
Received: from localhost (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCkvCgDnRxJG_sNny9TrBQ--.51671S2;
	Sun, 02 Mar 2025 14:44:23 +0800 (CST)
From: adam_smystery@126.com
To: linux-kernel@vger.kernel.org
Cc: 
Subject: Hello! Rust is better than Golang
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-CM-TRANSID:QCkvCgDnRxJG_sNny9TrBQ--.51671S2
Message-Id:<67C3FE47.0D754A.03778@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUgjNKUUUUU
Date: Sun, 2 Mar 2025 14:44:23 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbifgoEumfD7erZxgACs0

Hello! Rust is better than Golang


