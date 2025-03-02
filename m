Return-Path: <linux-kernel+bounces-540205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A90D1A4AF73
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E01D16E84D
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 06:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45B21D5CD4;
	Sun,  2 Mar 2025 06:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="a2hs1IBs"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC35C1B87EB
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740897835; cv=none; b=uIE3pOK47QCjuSjUep5hJRWMQ+utDvwKSlloLJ7KY3bSnKFjCm+5bbhjeGh7tFeokQkMLnhuva2kMGEFvzWGny8V5kFQtIcETMIAfykreFe96GDoZ1sPp/mTtsjPt1ylZCd6MFvOGEsvYBIAkwglQIJPBCLzd8OrG/JyeQNfYiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740897835; c=relaxed/simple;
	bh=UyPD+95nIFiG/gFr2rAqnNWXPHGkDBUZBe3GQzk2iCE=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=pPyeJ3jFVcapZOb+VwImsVSAMHpVTN+EEIAx6fe7NqM30/rZYZ+5Wb5IDDzdT7PcnkaDeNO73Zx8b9pkxduPAbLJ+m8pIGfiR5Edt0nNMUCbKaDjEA49scJhSoZM1sA8xGJALoYkRjPcWUI50+IZ733sYvb16WURuOpt3j74P5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=a2hs1IBs; arc=none smtp.client-ip=220.197.31.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=UyPD+95nIFiG/gFr2rAqnNWXPHGkDBUZBe3GQzk2iCE=; b=a2hs1IB
	sag4ddu8WcTOxJUv8uOD7wkPqhas4Xp3wO29k9KXKjVJndwcdfzCrOuwFhXSBWot
	lQSQinikNjMyPOWUbtxf/7kxk8cYvSNLAFRnyed9OUz0Tx0CGPNZWfVLIHMeoO9S
	axYToHmsh+rvvqPWEMVPgvp3zVPOu/HnLlH0=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3V6sg_sNnXM0gBg--.29436S2;
	Sun, 02 Mar 2025 14:43:44 +0800 (CST)
From: adam_smystery@126.com
To: linux-kernel@vger.kernel.org
Cc: 
Subject: Hello! Rust is better than C++
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-CM-TRANSID:_____wD3V6sg_sNnXM0gBg--.29436S2
Message-Id:<67C3FE20.066DBF.00001@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUDPfHUUUUU
Date: Sun, 2 Mar 2025 14:43:45 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbiigoEumfD7fHXhwAAsW

Hello! Rust is better than C++


