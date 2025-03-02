Return-Path: <linux-kernel+bounces-540210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E065A4AF76
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69E8C16EAF8
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 06:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9931DE8B3;
	Sun,  2 Mar 2025 06:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="gg1E5LD7"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11BB21C3F02
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740897836; cv=none; b=D38awXus77rpUGBfcsFUwrPReDGWWlnyLrivbjFLeRKhP1O4sgSSnsZjU34TJwXy+Qv1l0a6beEEskyceOef1Gww6ZyT8y3kgoqM/dhm6HOYUssVAbKS3B9NOruZfvpcYIvkgcpegMbXYmFY5FdYlGCkJ9aU2LpzR1+vxpXN3v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740897836; c=relaxed/simple;
	bh=JRXhdhnZz8FXfPKKFhJq2JGkB4LIysZOAiXNUdUmjM0=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=enoo8oGNkHt0J79tbP87F0yBhm3nth95WVkYd8mlpwJAX8MnrmZvirdczFZyiAcyPR3y2K3Ng4ezogPBFaKJHfMsG7DvoZb/JW+lEUWY69bv0uoLcW51vZQvU8D1QW03VsXK4S0jmpyfroGWUc/ufBEOh01fA/rza0hUSLHvgjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=gg1E5LD7; arc=none smtp.client-ip=220.197.31.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=JRXhdhnZz8FXfPKKFhJq2JGkB4LIysZOAiXNUdUmjM0=; b=gg1E5LD
	7ppyVEdcdU2vErkxoq4b5uG75vPeqi+BL7KYLqjtfuUePgohhChPSDuicz6VKa2O
	MXgBDiXPm7cAGnZJPojk0c475ktpWzNvo6hR496MC69OkoTthWXmkAW0vr/OzhBc
	wqpzHICp37osfpR7cDupflQfNDtHsamsHcUs=
Received: from localhost (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PikvCgDnb3ci_sNn72gBBg--.19942S2;
	Sun, 02 Mar 2025 14:43:46 +0800 (CST)
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
X-CM-TRANSID:PikvCgDnb3ci_sNn72gBBg--.19942S2
Message-Id:<67C3FE22.0D9DBB.10732@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUq5fHDUUUU
Date: Sun, 2 Mar 2025 14:43:46 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbiihYEumfD7fHXoQAAss

Hello! Rust is better than C


