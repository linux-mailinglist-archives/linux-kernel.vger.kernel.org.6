Return-Path: <linux-kernel+bounces-540297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD90BA4AFCF
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 08:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 236003BB87C
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 06:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68FF51FFC5D;
	Sun,  2 Mar 2025 06:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="b01ShRSo"
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B55D1E8326
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740897874; cv=none; b=HNVhFdL039s5hWK5zLjT7KjAtDTUzC0uINZnqF9npy4dP+k8JXBaEE5NKrsbEPErn5WUbFw2MtPBWwJ2Cmm7TzmkVxYy7OMOaKZE2iQQoJPQRySo8OqczF26PBipVEqcIwHWTMcY5CN+9PFF7vYra3uy/zJlof1VM7ea0urJCdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740897874; c=relaxed/simple;
	bh=JRXhdhnZz8FXfPKKFhJq2JGkB4LIysZOAiXNUdUmjM0=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=DIdr3f3Tv71evVJg599xgW6P5XSd7nUixmzCWsxY+pnEZJku7iASp5ZDe9FgQmP7Iz8c6ebSU/KjuYTnzVysXN8tDidCrFWOElhNrLeD97OczSsP9iZWhUDIUTTBx4ePPd66lIFGBWyh2SwKRxP84sJtVdgXDuHM4kAQ/fojHPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=b01ShRSo; arc=none smtp.client-ip=117.135.210.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=JRXhdhnZz8FXfPKKFhJq2JGkB4LIysZOAiXNUdUmjM0=; b=b01ShRS
	oJ68c2h8wRI1y4lciHq+n6OhJ5gcThfEB2SFp7YH5QTpLpHqbZ+UvAl+ikqXVWa5
	OwGwOpaCC9V/jXU7DGiDY39HpComf/BU6Wm/bxdKKM/bn+hLYcelXtGLJo+IKONo
	Nr63dREq1r5IraNiNwP+1OHYe5pxdHhbM6pI=
Received: from localhost (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCkvCgDHJxJJ_sNnFtXrBQ--.53629S2;
	Sun, 02 Mar 2025 14:44:25 +0800 (CST)
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
X-CM-TRANSID:QCkvCgDHJxJJ_sNnFtXrBQ--.53629S2
Message-Id:<67C3FE49.0D754C.03778@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUgjNKUUUUU
Date: Sun, 2 Mar 2025 14:44:25 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbiOhkEumfD7An0GAABsx

Hello! Rust is better than C


