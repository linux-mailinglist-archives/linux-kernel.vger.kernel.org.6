Return-Path: <linux-kernel+bounces-540261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7E2A4AFA9
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7836A3BBE49
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 06:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4742D1F4627;
	Sun,  2 Mar 2025 06:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="TFh14tR9"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0071D63C4
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740897869; cv=none; b=Ex98ttiKAQUYMLzzs/WE0tEfUaT9YhjZ27ekORqAbmIwLSRkdTRHU85ScHavQcNsUTT03eOjrXTP1Ooh/KOj3on6g8Kt4zGhZyCIEb9H11XiULHMwYQ9/M8Lv6wlFmRpV+lkk7LcEnbg/3qdUvmpM9hH0sevw2qgyfzGZcY4i2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740897869; c=relaxed/simple;
	bh=cftqaDB8AEPz09qm4a8a9qxUPytrv8Vr6D6ryPJtm4g=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=NsbKJZEIRRCfDX7+rv3sIPsKnS3fxvSSw2yPwi0LHDMkBstSL7zHbgpeHBkjBelT6acnREt+YcqjNsalLm2a86et0ZI8j8hbaUxlrnO5yarkxHon3xL+1u9ukx60gA0iE2LewDk+g5MYG9Ul+IE6LumPGNU3Bg/EaPfS5Vfz8j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=TFh14tR9; arc=none smtp.client-ip=220.197.31.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=cftqaDB8AEPz09qm4a8a9qxUPytrv8Vr6D6ryPJtm4g=; b=TFh14tR
	9asTrQ1wHwq/jce/+Wrd1NEJiAcBI6eDnWIJj7+7AcIQ1/QlyEisIgdRJQXpXH5x
	Xh/d+4tFhX8p1NwR0eEQXCq4E04XytRE42tLhF1/Y29KZPp727UO86vMDY7QX2l8
	X5x57GEQlArGjzkNXl94gGcA2iuv2xUlofHM=
Received: from localhost (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PykvCgDnb2tG_sNnOCQJBg--.63426S2;
	Sun, 02 Mar 2025 14:44:22 +0800 (CST)
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
X-CM-TRANSID:PykvCgDnb2tG_sNnOCQJBg--.63426S2
Message-Id:<67C3FE46.0D9057.12474@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUgjNKUUUUU
Date: Sun, 2 Mar 2025 14:44:22 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbiihgEumfD7fHZiQAAsE

Hello! Rust is better than Java


