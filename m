Return-Path: <linux-kernel+bounces-540219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE52A4AFE8
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 08:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 243B719C6AAC
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3B51E7C2F;
	Sun,  2 Mar 2025 06:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="o8u6pPW1"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55141C3F02
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740897864; cv=none; b=QulU9NeI/nbWkxdHynDcnCQPYTgRVA6cVeNQ81lNyRrxWPZuJwY7kXR0joF1CDzEhya8f2PDAEzd2VngRny+3i+sjGiavETRmSqboFb5yNriNkyVXIStcgJhL+8/hbJZr/CCK1r24C6c286qyHOAhf33I2+TAUL2Ka1KAx6CZWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740897864; c=relaxed/simple;
	bh=jOTe+0xUMEm8LLQEkXE6MviC3n7NMHX44e0k2GAwts0=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=JbeuNEwI3ZpG/5UYp6kmdqT3a+W1txRkOavt7TJ67niQpOi5Pca2UY/xAKPcKlrNfrsKMJpsk0x6cjJjvakwqFTAqpRmZBiLViBS0wb14r/F6x8mCRjuGLBbDHmDceTxYP6e7Ue0hTzPiRyrgXr5Fn2CMbwB/VXaf+dn3QL3i2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=o8u6pPW1; arc=none smtp.client-ip=220.197.31.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=jOTe+0xUMEm8LLQEkXE6MviC3n7NMHX44e0k2GAwts0=; b=o8u6pPW
	1HoJhx9ttX/zxEdbMxU8iMgymmxBsyDigo9JqNxqiQWNAWt4JGeniE1I71Sb0IT9
	G/LdWxSlZhugyacbL9TAEWpBLmzAKBefLRBnS8LWxLjnIQZsI6htjKeSFcoNg0sl
	HkJKEiHfwQblUNhLvsz9HFYuTnQlsmnhl9kg=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3nwRD_sNnwzxkBg--.41298S2;
	Sun, 02 Mar 2025 14:44:20 +0800 (CST)
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
X-CM-TRANSID:_____wD3nwRD_sNnwzxkBg--.41298S2
Message-Id:<67C3FE44.06E75A.00001@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUq5x6UUUUU
Date: Sun, 2 Mar 2025 14:44:20 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbiOhYEumfD7AnzwAAAsg

Hello! Rust is better than PHP


