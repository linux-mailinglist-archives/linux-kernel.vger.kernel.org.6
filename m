Return-Path: <linux-kernel+bounces-540351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3E9A4B006
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 08:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5B1619C3C5D
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F7C20CCD0;
	Sun,  2 Mar 2025 06:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="BrKD4YHY"
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.7])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B221EB5FE
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740898741; cv=none; b=pxwGASOi8R2bmtl9bG1Vym5iCMxU4f6tqvw2zlwvG/wlrqJh5GuKH1ZnuuNbH7OVhAU/7mLlSi6fhLQwC6oamdfE9BDpsR70UuxrqxD2604IDh0N5nPTqo1qo/mIPg5QJ8s9ZrZZIdd8YQgfR/GJk+suvJwi/a51p3tGQfbALeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740898741; c=relaxed/simple;
	bh=JRXhdhnZz8FXfPKKFhJq2JGkB4LIysZOAiXNUdUmjM0=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=S+Xi2bY40DUa/lwlRQLJE2mMFGSnR2u4FlUuNwA7O6IPuMZhMioWWc0G0AUg1Q2UMGFU+4ErmUFqDHwwA3YfcNAtWkpfgVESSRQr0e3i3GmkTZ7TJ6AWHboRAjhTP6N7zL+LvRT6udS/etpG7ERzmfkfo67TvzWRSeeVd5dTTxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=BrKD4YHY; arc=none smtp.client-ip=117.135.210.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=JRXhdhnZz8FXfPKKFhJq2JGkB4LIysZOAiXNUdUmjM0=; b=BrKD4YH
	Y4a+Q8xu/c0nChfnnAjWMNvZlKErgidDyOLMOz12McfuevpXQ+6vNbDCgIQi0WY/
	ta9l2zSwtF3E8Zi3Bqy9a0n72/RYYHoeh6T0cMazIV2SRpfSgH/KLaEdW1COFjVk
	eo3tfXeIqGIdsg0qZosIXqDKDikJSCPy0bnI=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3t78j_sNnN_exBg--.59744S2;
	Sun, 02 Mar 2025 14:43:47 +0800 (CST)
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
X-CM-TRANSID:_____wD3t78j_sNnN_exBg--.59744S2
Message-Id:<67C3FE23.07181B.00001@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUq5fHDUUUU
Date: Sun, 2 Mar 2025 14:58:55 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbiOhQEumfD7AnyDgAAst

Hello! Rust is better than C


