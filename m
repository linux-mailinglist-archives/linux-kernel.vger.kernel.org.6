Return-Path: <linux-kernel+bounces-540289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63148A4AFC8
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70E10189F494
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 06:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55901D5146;
	Sun,  2 Mar 2025 06:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="R2rvNYKL"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1AA1D79A3
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740897872; cv=none; b=b0wuf0ifvoeDmuR0M67o4jP6cZcwO2bD2fu81cvb+uD2SxyIY07ETXh5DH+RKRH6xNAwos/1wi+hzJFQlb0UQnot6gRp91BAs0YcQ8j3y6H3Y18Hn6gj1FCD5ljxty7q+UDX4EdrjGZ6tcIuyLhgql0XimKIf0Ih+P2CSoTAmrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740897872; c=relaxed/simple;
	bh=U/wIYARQ7kbvgXqE7DzmguflZ6ifai48GUe3iGqWynM=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=JUNBsEbe+Xzv9sA8ZQ1yn9RcC4SnUge+tAZsttvKe09KzISMfDqSweyzVznLwGTt+Rvo+xeaVpZ1H9NqMS9AJowITBzBgTARWZ4QYjJiY1beQAiyNIOFFXw9Th1qoNIDRgKAELBC4mGk/sR++JGx2xQqTZ8xH56lIOV2YkwuPkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=R2rvNYKL; arc=none smtp.client-ip=220.197.31.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=U/wIYARQ7kbvgXqE7DzmguflZ6ifai48GUe3iGqWynM=; b=R2rvNYK
	LCf7UWg6ciABGkLWVkjCbEmeG7dOrV+ELB2jwBvYCJnMIySuYXxjFvHPSxYTjGeE
	cuYZWIdb8BRGtgwsV75piumytYkEFsk4oykLy4SPfZ8NwkD26u3SSttEd3bGnr8q
	1UwZZ9QulbdDhwi78HiTN04qxAAe285fjkwU=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3xxNI_sNnskLeBQ--.56797S2;
	Sun, 02 Mar 2025 14:44:24 +0800 (CST)
From: adam_smystery@126.com
To: linux-kernel@vger.kernel.org
Cc: 
Subject: Hello! Rust is better than Swift
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-CM-TRANSID:_____wD3xxNI_sNnskLeBQ--.56797S2
Message-Id:<67C3FE48.059B42.00001@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUgjNKUUUUU
Date: Sun, 2 Mar 2025 14:44:25 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbiOgAEumfD7An0EQAAsg

Hello! Rust is better than Swift


