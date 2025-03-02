Return-Path: <linux-kernel+bounces-540374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7D3A4B015
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 08:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE9AC19C1969
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA3823A991;
	Sun,  2 Mar 2025 06:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="fX/rPBJ3"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1C41EEA42
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740898744; cv=none; b=n69DpYE0HI/XISWKBMUsNF0aHPPewWEQAMJku8zDynhZIe9ttjGwMHVa6Hz6EsGJh4xe0vhFY8G0n4uySRDDTHutFHSaEoUuWhrwASWx0BKId67avobMnWq/enWAnAJP0MkRlEvPYwl2L6lDLE54nlJ9drB81W+M1XS+YcJkO/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740898744; c=relaxed/simple;
	bh=m3WWx7WaxOLxHF4l3ehA7ZpOfcH46DacagbXvgNtOUU=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=I4vKcu2C1LjWygVdUx0+yd8j1RUFPN0MDfKrKKJdzZoRuqIn38LM0DEO6ETC6GSF2qE3GjuaHcLSrEQlM3z+6SOyqaB6sk1qf0fI54VPxSnddhSuPcaG23REXFyNGzBrdRo78W4SUa6ljGTYE4KQc6j5CJOCy56FHsiDxQh6Z/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=fX/rPBJ3; arc=none smtp.client-ip=220.197.31.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=m3WWx7WaxOLxHF4l3ehA7ZpOfcH46DacagbXvgNtOUU=; b=fX/rPBJ
	3msHG+G2uMDayCHwgVVay0WoP/3ihV6Kwqyifsy76BKaWXvQ6w8hfU7Jh4bO2sQZ
	PHG+p7IEyRVYNNZjpSp7It0zFPCpQrjmGDWyl6KtzrpaGs8g2d1g8oKB68wS1LJf
	2tUxaIim6XlERPiThMEOIMN9MJGMcwWdLmPQ=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDnfzsk_sNnSgEgBw--.29622S2;
	Sun, 02 Mar 2025 14:43:48 +0800 (CST)
From: adam_smystery@126.com
To: linux-kernel@vger.kernel.org
Cc: 
Subject: Hello! Rust is better than Golang
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-CM-TRANSID:_____wDnfzsk_sNnSgEgBw--.29622S2
Message-Id:<67C3FE24.0684AE.00001@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUq5fHDUUUU
Date: Sun, 2 Mar 2025 14:58:58 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbiOgcEumfD7AnyGAAAso

Hello! Rust is better than Golang


