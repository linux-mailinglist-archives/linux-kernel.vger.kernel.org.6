Return-Path: <linux-kernel+bounces-540370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93722A4B018
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 08:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ED1342260F
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3FA23A98A;
	Sun,  2 Mar 2025 06:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="JAB8FfOH"
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.7])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51AB81EBFE2
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740898743; cv=none; b=XB2lOWeU959XpFzfcQMzRaTuJZhSs9ZKkSnZTNPz7ZGsnzMC328O0yTAcxEmBCeKSWWJr+u8qqq2xGxnZ06GeRcwiqHoHSpsqP9jpwNlyBGslyIURBb8A1W9vKBspoGeL0oSWB2iWRveCYgTSLmzoVzbR42Jy3DalR/pq9iRy8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740898743; c=relaxed/simple;
	bh=jOTe+0xUMEm8LLQEkXE6MviC3n7NMHX44e0k2GAwts0=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=TgGqlaGQ9KB1Hdmn3yRbT1xKZ03a2xBAfACTxypFXVBZR9OjkEJwEKQZ0lHqt2MCUJn9/pLqbKW3ypJeLPcBmFZUDGXtvRWdjvEtHnJX8UTHRnEjgBP4ir5uDCQlggIkh0yuYsSOQ2imYa9x8wgt1scZp5eLCwsppGpJu2vI9uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=JAB8FfOH; arc=none smtp.client-ip=117.135.210.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=jOTe+0xUMEm8LLQEkXE6MviC3n7NMHX44e0k2GAwts0=; b=JAB8FfO
	HtwjAlFxQVeGe3HDFM33N2AaSIoeqDoKNhIxWa1sF/zlbdUVIWxMjwa2wiyn3Bfa
	WH6GJCje5mWW/RzHMGJUYb9xpuBjLrGoD9LCJ5O8fAIrXMesuaCkxg5wpXMUggEx
	fBN1rflaxS0PgQQiDJT0N8AI8drfEZnNpgaI=
Received: from localhost (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCkvCgDHf3Yh_sNn687rBQ--.58990S2;
	Sun, 02 Mar 2025 14:43:45 +0800 (CST)
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
X-CM-TRANSID:QCkvCgDHf3Yh_sNn687rBQ--.58990S2
Message-Id:<67C3FE21.0D753C.03778@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU63C7UUUUU
Date: Sun, 2 Mar 2025 14:58:55 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbifhUEumfD7erXgwAGsk

Hello! Rust is better than PHP


