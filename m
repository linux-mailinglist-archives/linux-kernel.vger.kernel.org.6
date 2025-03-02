Return-Path: <linux-kernel+bounces-540329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17EC8A4AFF6
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 08:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9062219C4010
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA9D1F1317;
	Sun,  2 Mar 2025 06:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="ICyHNcQ+"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B431E98E1
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740898737; cv=none; b=i+Z+J/8gW/VdE7+hwZUQ8CoJyxIMPrGkkWO2l4+/BwPvBKZGsDmwThlNa01JRzLxdA6PRPenVqM/UdUcho/0V7OxZWl2bO2gHU2yNGGe73448i/sxs55OU1jrkeTsxb8cOpps2dH+9V/TnHy8QS1eKboOQZa2aOe8zww+P/LvWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740898737; c=relaxed/simple;
	bh=JRXhdhnZz8FXfPKKFhJq2JGkB4LIysZOAiXNUdUmjM0=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=AyBVma87oE9cfwtNNZ0+GpPS3ungSi29N3vD1lzPgFbjX6OMeyRvFFyynnaTLGiSX1887+Ya7dZ/xLtzDdZEYyHfO/gM80AKKFJ+vbyLca+75hE6PxpTxC+8hk0/WSp1nn/WKTv2zT6YqKLF76y0lV6cRY9cvC36DieHV2v87A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=ICyHNcQ+; arc=none smtp.client-ip=220.197.31.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=JRXhdhnZz8FXfPKKFhJq2JGkB4LIysZOAiXNUdUmjM0=; b=ICyHNcQ
	+mhSD4y6gCpdP9kA1Ts2oqgtwKoiZPqpEbPIWkYIuGpiVMfkov2poSbZAa79eVJu
	CEzebFxMv93lbSIkAcaDJrakQnK0QEh8EGUcbEwhYRJAH0kYH5PFxD3oywLiffYf
	N7eQ2ZNZHpZL0364tnT/LRxZnohCgq9wFB9I=
Received: from localhost (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PykvCgD3t2Yf_sNn8R0JBg--.56882S2;
	Sun, 02 Mar 2025 14:43:43 +0800 (CST)
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
X-CM-TRANSID:PykvCgD3t2Yf_sNn8R0JBg--.56882S2
Message-Id:<67C3FE1F.0D9043.12474@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUTo7KDUUUU
Date: Sun, 2 Mar 2025 14:58:51 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbiOh8EumfD7AnxuAAAsT

Hello! Rust is better than C


