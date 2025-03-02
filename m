Return-Path: <linux-kernel+bounces-540371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C764A4B026
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 08:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B7138A0F77
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF7A23A58E;
	Sun,  2 Mar 2025 06:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="j82bw4xL"
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B061EBFE3
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740898743; cv=none; b=O6X7RmKLd0nwpEavSmSpy3WzyZ9FoLX2Qmoh9iRPHB7fXsRJGtEZoMhZFHoYCaEO5gWKqtmUaWA3zGcLnhq2Xe9oQBGto6+6aCxASAHQt1NJgA5J0hqYKr4UdK7yNq3bt2PFC1Im7ha5/PM6LJfBZQpT0sOgKteDoZcCHE0t5bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740898743; c=relaxed/simple;
	bh=jOTe+0xUMEm8LLQEkXE6MviC3n7NMHX44e0k2GAwts0=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=RQ/Mt/+AlDxKGoHDpAGhNAFaAnDQFZcj8kWBnh7m8iEiF6BJAdatnNW1FDlQE5SNu06NOXqTanUnsgPtoKbNm3HYCLjp9kam4MQNu3SNGeE21sN03LRfIP5T018Pbdv6pjUiM/K4meTcRqL5+qpgiC7IhcR7tcwgJ+SLKX/JLeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=j82bw4xL; arc=none smtp.client-ip=117.135.210.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=jOTe+0xUMEm8LLQEkXE6MviC3n7NMHX44e0k2GAwts0=; b=j82bw4x
	L/czHNja+Rv1SuIqM7ViwxoWTC36XV2Mbkce8dMRsWukV+okPwN6re3PK07+OYe+
	kIblEqBzB8waea6WssjLVfQk6nAs+i1wQz1ie/gZmRrnbj1HlCVKzmNQjZ/3aNbN
	33NjejbvHHZr0YoM8PKxlAhybTj/Rlox+wls=
Received: from localhost (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PykvCgDHz2Qk_sNntB4JBg--.59375S2;
	Sun, 02 Mar 2025 14:43:48 +0800 (CST)
From: adam_smystery@126.com
To: linux-kernel@vger.kernel.org
Cc: 
Subject: Hello! Rust is better than PHP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-CM-TRANSID:PykvCgDHz2Qk_sNntB4JBg--.59375S2
Message-Id:<67C3FE24.0D904D.12474@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUgbAzUUUUU
Date: Sun, 2 Mar 2025 14:58:56 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbiigUEumfD7fHXuwAAsl

Hello! Rust is better than PHP


