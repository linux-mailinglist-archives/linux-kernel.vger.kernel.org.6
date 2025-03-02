Return-Path: <linux-kernel+bounces-540311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B19A4AFDB
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 08:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2527188BE34
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 06:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875F420102E;
	Sun,  2 Mar 2025 06:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="MXnJUN7M"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F23B1E98F4
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740897876; cv=none; b=e3D6OSPvLWmWLVO7PlAzxHO4LFyTTiCP08a1RtQke4M7vEs9+w+KjHM7Ij81L+EKvf49g3rWAs8MTB6+o9J9Asm4QxonFp8JGOQLnAk6MabnxmA4V6BsfydWX728+KNy5hRyWFz2qUgK3Fi8QdaJzjS22CgSGFw0mm5WfOmf2Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740897876; c=relaxed/simple;
	bh=jOTe+0xUMEm8LLQEkXE6MviC3n7NMHX44e0k2GAwts0=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=cv82y2chYnhmspYM60sWzn6I1V1FsrhL+vlfS2Bt1Kc7icPvSMugbvZcsM6MoBkZ6QDRHZziH7hZPl5BhSF5BNe86Z9mQ8CDi5mOx8eIn+pVNwvxTaDue6eHoLD+CNQRVnfS3ZVQ88H89mN/4FBtcpdSCz2VIQ1a+vPaWtqQbp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=MXnJUN7M; arc=none smtp.client-ip=220.197.31.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=jOTe+0xUMEm8LLQEkXE6MviC3n7NMHX44e0k2GAwts0=; b=MXnJUN7
	MKOkMzeWzDvmA/44bqgavHt1GsgpmApvTq+Gzn3LNHQLoQufM+MnL22ZT+gjOyNt
	5jFHdcVvCQ4yYhq4FC9ZYP5bxEvZ8QkmF7ZAfRwTaIPByR756WO6pw1guzXw9FuL
	aReSAo/wNF665ePFXHQDF74jDn7BBdBjg+o0=
Received: from localhost (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PykvCgD3t2ZI_sNniCQJBg--.56911S2;
	Sun, 02 Mar 2025 14:44:24 +0800 (CST)
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
X-CM-TRANSID:PykvCgD3t2ZI_sNniCQJBg--.56911S2
Message-Id:<67C3FE48.0D905B.12474@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUkmFCUUUUU
Date: Sun, 2 Mar 2025 14:44:24 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbiOg0EumfD7An0DgABsz

Hello! Rust is better than PHP


