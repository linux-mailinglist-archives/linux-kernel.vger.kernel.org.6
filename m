Return-Path: <linux-kernel+bounces-540249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B22A4AF99
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 555743B54D8
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 06:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5724A1F03C0;
	Sun,  2 Mar 2025 06:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="g/yCMqeA"
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09DE21C07F6
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740897867; cv=none; b=J2fwsuruSlsy7fitqrR+rfb+21d0RujihY/Ef3BkljsrTddWd0CW+hOT8LBOlPJhu/kr2N2UR0RyNHqCNhjS3Ir1whIhoCk/RKEKsNkZUCPrvf5AWAtQmvLIPlBS5ISWFqzajC6WF2aeTRuHblTi7cYr6hJBHWG2f0No+P4BhUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740897867; c=relaxed/simple;
	bh=PfixNPQ/uTp/hFvZCGY1TVY84A7zL5WAfQIAbeeaQe8=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=k3pHKL14hk9rxdXTBDcsXl/LDUJhHODv3PeUkxKlUI3j5GfR0XCIJcOsvwO03eWgAVXKf8MsbIi17LX5u+LVqCDCsVsoinE70au7y1VGHvjmvrvuTyeZRlNtr8n0XnNu/VTBzwD3/+p9J5TFHBou4kpjlyMtB+Dhutgq9wDIb3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=g/yCMqeA; arc=none smtp.client-ip=117.135.210.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=PfixNPQ/uTp/hFvZCGY1TVY84A7zL5WAfQIAbeeaQe8=; b=g/yCMqe
	ACNDqRt3jJjp+Wx6oPlQfUM+StXjmE4n7tTc5Ch7zdz6uj+JF3uAk1DIOgfxY9ai
	FbR5hBdNn9MsnUY/VqC8zGxloZutxB6pW6OXdkk3k2rabrDgMpZqMqiQZMnjfYi1
	je7705SIIGNCWUkDcLxZbQFXo8oXHWCPjqQw=
Received: from localhost (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSkvCgDXX7dF_sNnG0hhBQ--.9763S2;
	Sun, 02 Mar 2025 14:44:21 +0800 (CST)
From: adam_smystery@126.com
To: linux-kernel@vger.kernel.org
Cc: 
Subject: Hello! Rust is better than Python
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-CM-TRANSID:PSkvCgDXX7dF_sNnG0hhBQ--.9763S2
Message-Id:<67C3FE45.0B5A72.19577@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUgjNKUUUUU
Date: Sun, 2 Mar 2025 14:44:21 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbiOgcEumfD7Anz2wAAsq

Hello! Rust is better than Python


