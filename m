Return-Path: <linux-kernel+bounces-540321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C374AA4AFEB
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 08:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE6483BE975
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7357A1EBFF0;
	Sun,  2 Mar 2025 06:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="DBwj0sBZ"
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E40A1E32D6
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740898735; cv=none; b=GY5msgrlSpx+8is0d+ES9tIOhM6AYhjM3KUxP02j7Tf75UgTAtO1SdEPPVY22lblGaVzxzxnrNE4lSl2DP5Ith98Y+Nd7Yzxh35czWF4cffKfyiUSzegN5Z8fQb09kvMDVDPa9xHdh17C6W8GjQXlJ5qgNVIxKdz4ws7BTOSQrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740898735; c=relaxed/simple;
	bh=ImIq5E+yzSMuk5VQu4015FnEeU4ZkIfZhZtOrHrX2Ew=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=fuUD386rPJZ4aWiNB/MMSLclBCjU/Oyx8Xdps+UnI5eQeNwMkcIzgR7VxrxwYNNACSKbVbn74W/EQoJBrK6yb9qhyfvwbk/cQreL59vQae9D6WE5RsvbrpcKfZyHh8OovSerb8w5BOuHt8+SHyRznAw1xcDE0BMiup+ymvKIma8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=DBwj0sBZ; arc=none smtp.client-ip=117.135.210.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=ImIq5E+yzSMuk5VQu4015FnEeU4ZkIfZhZtOrHrX2Ew=; b=DBwj0sB
	Ze1LKscaeAHokWuuhkMHK0AJPrwBDhcHnU2iUSxYw+SD2WDoZGrfMBrrXj9YaHhi
	XlClYp0OpuKsyOfpSk7xKStLy2D225jzN+HpZ4bHqafzXi6IhICoAuD4DerSNkZt
	8hP5mky9bVFXE2D+I1uaoTcwfCqHw0hE6k0U=
Received: from localhost (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCkvCgD3_xQe_sNnd87rBQ--.51535S2;
	Sun, 02 Mar 2025 14:43:42 +0800 (CST)
From: adam_smystery@126.com
To: linux-kernel@vger.kernel.org
Cc: 
Subject: Hello! Rust is better than Typescript
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-CM-TRANSID:QCkvCgD3_xQe_sNnd87rBQ--.51535S2
Message-Id:<67C3FE1E.0D7536.03778@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU-1xRDUUUU
Date: Sun, 2 Mar 2025 14:58:50 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbiihcEumfD7fHXYwAAsv

Hello! Rust is better than Typescript


