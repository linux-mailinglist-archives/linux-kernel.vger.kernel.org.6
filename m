Return-Path: <linux-kernel+bounces-540326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7411DA4AFF7
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 08:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65BF819C16BB
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221591F131C;
	Sun,  2 Mar 2025 06:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="ceQS48qE"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C771E835C
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740898737; cv=none; b=C4p7q1yV5KMAKFuLPc84Cssgvk32rmxmALTh0qqRh1K39MEwOMRodEUkleEmJz56LYeeZeUYpTiDvrNvZKCEFXMUyp0qTOZF99febIKx0yu6h6vjOGoSt7tabAdLuqyrxFpWH7mqhHe0kywrRP12VoEpbD9jgyycAOI4H9UU1f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740898737; c=relaxed/simple;
	bh=PpuV9J8+n9bZO9SKZkLSiMjR/byLHXwmtdk5TtpXbDo=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=NoD9tgXIOtPwAeTyK1sOgzq0fd3LR1Yvk7MmNrTZ/cLflOaOuguiDuSMSxr4P8Eg3oBB5iTau8JE+HL8Bt5AlzWwoCMsaPLoi91+TLmTnPa7FEtKHB1nRAKqp3IgvFoCeFh5IXyTlKpvVJkhaujWpiA/4k7SvvwQCj3M6r5Tef8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=ceQS48qE; arc=none smtp.client-ip=220.197.31.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=PpuV9J8+n9bZO9SKZkLSiMjR/byLHXwmtdk5TtpXbDo=; b=ceQS48q
	E3FmjTXtjhWCCcS5onyxiV9QyLIJuWW2LKFlFpvhXu5vRLyTkfO/6UPIh01IrnDE
	7oRfVhUfmigV935om1GRAktnVjE5lfBlR+Ol9hB/8pSxn46h7gQPjIThbc8Q50xn
	15parr2qqMgsT0gz+9zOOof33sk68qu4QTZM=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wDnPywg_sNnjTZkBg--.41433S2;
	Sun, 02 Mar 2025 14:43:44 +0800 (CST)
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
X-CM-TRANSID:_____wDnPywg_sNnjTZkBg--.41433S2
Message-Id:<67C3FE20.06E752.00001@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUfRpBDUUUU
Date: Sun, 2 Mar 2025 14:58:52 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbiOhgEumfD7AnxxgAAsq

Hello! Rust is better than CSS


