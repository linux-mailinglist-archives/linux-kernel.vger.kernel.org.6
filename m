Return-Path: <linux-kernel+bounces-540286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B00A4AFB9
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4A9C7A94D2
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 06:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D591FC7FF;
	Sun,  2 Mar 2025 06:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="WYqZ3x4g"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784EC1D7984
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740897872; cv=none; b=VgDZsSnigBarljbvOFKcAy6qe8ZHKm2L/FstQWPS1SZ5VxH39jArkIOgf2HIHLYDmK7FPeKK9f7ETZ78TFryEPVUBaEV8u4Dlhv0CJssjmmtJknww++s24t5vqLBzKER3a7yFcq+AJqv0XnsLsk3HyMnWnzx7YRj2GIkbb5ZeN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740897872; c=relaxed/simple;
	bh=PpuV9J8+n9bZO9SKZkLSiMjR/byLHXwmtdk5TtpXbDo=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=ta8TMdCoUps9ebjYgqnlREq07o9VohMtjUrzARsR6RDsUHAqrKZcxuXCNdxgmghfjE4pPuCoWIUZ5PvrEcVMF7t5AWcrQEilaC8LNf5Hh6rIgN2oJtYkYosltWjBnO9B5I5HhO/Ry4o9PKDcNq4nTMJbksfzs1+9FMUlWBh3eYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=WYqZ3x4g; arc=none smtp.client-ip=220.197.31.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=PpuV9J8+n9bZO9SKZkLSiMjR/byLHXwmtdk5TtpXbDo=; b=WYqZ3x4
	gW0qLJ5uGtQ9a9pMI5OB3ay81F4XaClWGRHDDyiq572gbPN9CBc/vh6/a8WFLifh
	QnBgzic0e4/+5u6/Ejz8ICwPIj+xq63MNX0/hIpPGv9lGR+eY11GwWJYRpsGo4VW
	Ke+lw0sUmEdBV+jIu65EphPpdEgi3wFD6DBA=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3FxFH_sNnBxsYBw--.25530S2;
	Sun, 02 Mar 2025 14:44:23 +0800 (CST)
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
X-CM-TRANSID:_____wD3FxFH_sNnBxsYBw--.25530S2
Message-Id:<67C3FE47.06FBDA.00001@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUgjNKUUUUU
Date: Sun, 2 Mar 2025 14:44:23 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbiihIEumfD7fHZkAAAsX

Hello! Rust is better than CSS


