Return-Path: <linux-kernel+bounces-540214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7076CA4AF7A
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA592188F8E0
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 06:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33121DED5C;
	Sun,  2 Mar 2025 06:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="JZP3vGQR"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D2E1CAA8F
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740897837; cv=none; b=DPY3KrnjIz5r82AxtSsOa0/4gPyx9lq6CdSxEJ58nx72tDk7wnTpbvc+Rr9DDC3H0jbpabbkdcYgxNSRdC5AMwhP1ut19CqdZQnS/HyFPW/XZH/U9mexgJg89wd6bBKXc4I41ltqmZzKgVFgfFL8ocwl0vCiZLIOe6eICRENt6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740897837; c=relaxed/simple;
	bh=PpuV9J8+n9bZO9SKZkLSiMjR/byLHXwmtdk5TtpXbDo=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=CPzcLP+AiHBO7f5LebELAjL+Om5VqvXmxRnZmAOOGKPRKT1gbMxXZ+JxIjxHglVTn1PQqpfPjg1tN04dJU+N5L/BGFBD88G4FtZSHXmbFTHMEsvbpnGlXYQ/2FoH0VfDxH12P/9tClnfPvugMjQ2VTEp6xm1qmIL1GIY5rLxlNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=JZP3vGQR; arc=none smtp.client-ip=220.197.31.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=PpuV9J8+n9bZO9SKZkLSiMjR/byLHXwmtdk5TtpXbDo=; b=JZP3vGQ
	RZUEh52zAKl53pSadt4k7GCNkV7IYIOcqW7xPA1SFkRqqT1DEvaVvm0AZVI7Z+F+
	c1O9i6QV631E1xx3zolkYvDbIEa7LtUqdjlhUZtTHXZdeIJ0rk2km354Z7bIuxd+
	65pD/wPX1JOMgqyWL1DKzWg9rQsr3tR8EEw4=
Received: from localhost (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCkvCgDnRxIj_sNnMM_rBQ--.51651S2;
	Sun, 02 Mar 2025 14:43:47 +0800 (CST)
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
X-CM-TRANSID:QCkvCgDnRxIj_sNnMM_rBQ--.51651S2
Message-Id:<67C3FE23.0D7541.03778@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUq5fHDUUUU
Date: Sun, 2 Mar 2025 14:43:47 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbiOhgEumfD7AnyBAABsq

Hello! Rust is better than CSS


