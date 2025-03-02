Return-Path: <linux-kernel+bounces-540212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85438A4AF79
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:45:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA504188EB49
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 06:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0ED1DED56;
	Sun,  2 Mar 2025 06:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="Pikd4c11"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34391C54AA
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740897836; cv=none; b=LLCFeV6YE8gL2GV4FVwOGa96SnkM1gL2V9UjwjGUUrK263WbXyXeTk4Iw0BlpmoTZQbLGVzoF7bwctx37UHs9YoSpY2bsDg2QcR09hy3hsFoMuxga6F4YKG1jDklo3aofMhdYcEC7KZ23LZOdVjYflGDNxCu7dS3ZVgLrrLvEkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740897836; c=relaxed/simple;
	bh=kuanHuw9J0++yX2NZUc3mDyVR4V4BIDbLbg7VpSpL+4=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=ZGtlkfTc0cmDh0OMnmoLlC8DgYcs9D8Vk3wHHW6TVfk1Hx1F4RXMwkkEFXEOySALKK8JcbK2e0E2OseGBy8y+ky6Kxv42KYzFFb0SfXzKq0mJkfvedfNWI8Dj3/wHS7dTgA7WOExY785qh7yF3e8+Qs97/iA05+TThZ/VmX+4uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=Pikd4c11; arc=none smtp.client-ip=220.197.31.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=kuanHuw9J0++yX2NZUc3mDyVR4V4BIDbLbg7VpSpL+4=; b=Pikd4c1
	17ZSK5tCI42uei+emXMXHlDh05ukKs31gDQQl0HpwlFZxjMfx56iwD1SsRw4onXh
	kFLVmwPs2jKvfGFoKjkVOe+D+5yarIMKSWd4w/7uoQU1g28M45YzFERYp56edzv2
	IC/a+zEox50S9YFjo9A0y7EtJsTjZCpHyYHY=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3l78j_sNnXN84Bg--.18385S2;
	Sun, 02 Mar 2025 14:43:47 +0800 (CST)
From: adam_smystery@126.com
To: linux-kernel@vger.kernel.org
Cc: 
Subject: Hello! Rust is better than Cuda
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-CM-TRANSID:_____wD3l78j_sNnXN84Bg--.18385S2
Message-Id:<67C3FE23.065270.00001@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUq5fHDUUUU
Date: Sun, 2 Mar 2025 14:43:48 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbifhsEumfD7erXwgAAst

Hello! Rust is better than Cuda


